<%
'// Kayıtlı banner kontrol işlemi yapıyoruz yoksa yeni kayıt açıyoruz

OpenRs objRs, "SELECT id, title, durum, lang, url, text FROM #___banner WHERE id = "& id &";"
	If objRs.Eof Then
		objRs.AddNew
		objRs("durum") = 0
		objRs("title") = "( Başlık yok )"
		objRs("lang") = CookieLang
		objRs("url") = ""
		objRs("text") = ""
		objRs.Update
		Call RevisionDate(GlobalConfig("General_BannerPN"), objRs("id"), 1) '// 1 Insert -- 2 Revision
	End If
	post_id = objRs("id")
	Session("pageid") = post_id
CloseRs objRs


If Not FolderKontrol( bFolder ) Then Call CreateFolder( bFolder )
imgPath = Server.MapPath( bFolder )

'// Asp Jpeg nesnemizi oluşturuyoruz
'Set Jpeg = Server.CreateObject("Persits.Jpeg")

'// Dosyamızı sunucuya yüklemek için Asp Upload nesnemizi oluşturuyoruz
Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.CodePage = 65001

'// Aynı isimde dosya varsa üzerine yazmıyoruz
Upload.OverwriteFiles = False

'// Maksimun toplam dosya boyutunu 10 MB olarak belirliyoruz
'Upload.SetMaxSize 3145728, True
Upload.SetMaxSize GlobalConfig("MaxPictureTotalSize"), True

'// ilerleme çubuğu işlemlerinde kullanılıyor
'Upload.ProgressID = id

'// Get yöntemiyle bir istek geldiğinde hata vermesin
Upload.IgnoreNoPost = True

'// Persist'in klasör oluşturma Komutu
'Upload.CreateDirectory FolderPath, True
'Upload.CreateDirectory FolderPath & "/thumb", True

'// Dosyalarımızı kaydedelim
Count = Upload.Save(imgPath & "/")
'Upload.SaveToMemory

'If (Upload.TotalBytes > BannerMaxSize) Then
'	Upload.Delete
'	Call PictureJson(CookieLang, "", 0, 0, "", "", "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. "& MaxBytes(BannerMaxSize) &" MB'tan büyük olmamalı.", "")
'	Call JsonFlush(arrUpload)
'	Response.End
'End If
'Upload.TotalSeconds

'// Gerekli işlemler için upload edilen dosyalarımızı döngüye sokalım
For Each File In Upload.Files

	'// Toplam eklenebilir dosyamızı sayalım
	'TotalPic = TotalPic + 1

	'// Dosya uzantımızı alalım ve küçük harf yapalım
	FileExt = LCase(File.Ext)

	'// Dosya uzantısını silelim
	'OrjFileName = Replace(File.OriginalPath, FileExt, "", 1, -1, 1)
	OrjFileName = Left(File.OriginalPath, Len(File.OriginalPath) - Len(File.Ext))

	'// Dosya ismine tarih ekleyelim
	'Dosyaismi = SefUrl( OrjFileName ) & "-" & DateSqlFormat(Now(), "yymmdd", 2)
	Dosyaismi = SefUrl( OrjFileName ) & "-" & SifreUret(4)
	Dosyaismi = Temizle(UrlDecode( Dosyaismi ), 1)

	'// Dosya ismine uzantıyı tekrar ekleyelim
	ResimAdi = Dosyaismi & FileExt

	'// Dosyamız resim dosyasımı?
	If File.imageType = "UNKNOWN" Then
	'	TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece JPG, GIF ve PNG uzantılı dosyalar yükleyebilirsiniz.", "")

	Else

		'// Dosya uzantımız izin verilenin dışındaysa işlemi sonlandıralım
		If Not UzantiKabul(FileExt, ArrPictureExt) Then
		'	TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece JPG, GIF ve PNG uzantılı dosyalar yükleyebilirsiniz.", "")

		'// Dosya boyutu izin verilenden büyükse işlemi sonlandıralım
		ElseIf File.Size > GlobalConfig("MaxPictureSize") Then
		'	TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. "& MaxBytes(GlobalConfig("MaxPictureSize")) &" MB'tan büyük olmamalı.", "")

		'// İzin verilen toplam dosya ekleme kontrolünü yapalım
		'ElseIf (TotalPic > BannerMaxResim) Then
		'	TotalPic = TotalPic - 1
		'	File.Delete
		'	Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Bu kayıt için toplam ("& BannerMaxResim &") resim ekleme hakkınızı doldurdunuz.", "")

		'// Dosya ismi 150 karekterden büyükse işlemi sonlandırıp uyaralım
		ElseIf Len(File.OriginalPath) > 150 Then
		'	TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", Left(File.OriginalPath, 30) & "..." & Right(File.OriginalPath, 30), "", "", "error", "", "", "Dosya ismi çok uzun, Maksimun 150 karekter olmalı.", "")

		'// Dosya güvenlik önlemlerini başarıyla geçti şimdi biçimlendirme işlemlerini yapalım
		Else

			'// Upload edilen dosyanın ismini değiştirelim
			File.Move(imgPath & "/" & ResimAdi)

			addVitrinClass = ""

			If Err = 0 Then UploadDurum = "success" Else UploadDurum = "error"

			'// Veri tabanına resim bilgilerini girelim

			CloseDatabase data
			OpenDatabase data

			Call DeleteFile( bFolder & "/" & sqlQuery("SELECT img FROM #___banner WHERE id = "& post_id &";", "") )
			sqlExeCute("UPDATE #___banner Set img = '"& ResimAdi &"' WHERE id = "& post_id &";")

			Call PictureJson( _
				"", _
				"", _
				post_id, _
				post_id, _
				bFolder & "/", _
				ResimAdi, _
				"", _
				"", _
				UploadDurum, _
				addVitrinClass, _
				"", _
				"", _
				"" _
			)
		End If
	End If

Next

Set Upload = Nothing
'Set Jpeg = Nothing
%>
