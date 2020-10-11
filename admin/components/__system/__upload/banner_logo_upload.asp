<%
'// Kayıtlı banner kontrol işlemi yapıyoruz yoksa yeni kayıt açıyoruz

'OpenRs objRs, "SELECT id FROM #___settings WHERE id = "& id &";"
'	If objRs.Eof Then
'		objRs.AddNew
'		objRs("durum") = 0
'		objRs("title") = "( Başlık yok )"
'		objRs("lang") = CookieLang
'		'objRs("c_date") = DateSqlFormat(Now(), "yy-mm-dd", 1)
'		objRs.Update
'		Call RevisionDate(GlobalConfig("General_BannerPN"), objRs("id"), 1) '// 1 Insert -- 2 Revision
'	End If
'	post_id = objRs("id")
'	Session("pageid") = post_id
'CloseRs objRs




If Not FolderKontrol( bFolder ) Then Call CreateFolder( bFolder )
imgPath = Server.MapPath( bFolder )

'// fotoğrafların yükleneceği klasörümüzü oluşturuyoruz
Call CreateFolder(bFolder)

imgPath = Server.MapPath(bFolder)

'// Asp Jpeg nesnemizi oluşturuyoruz
'Set Jpeg = Server.CreateObject("Persits.Jpeg")

'// Dosyamızı sunucuya yüklemek için Asp Upload nesnemizi oluşturuyoruz
Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.CodePage = 65001

'// Aynı isimde dosya varsa üzerine yazmıyoruz
Upload.OverwriteFiles = False

'// Maksimun toplam dosya boyutunu 10 MB olarak belirliyoruz
'Upload.SetMaxSize 3145728, True
Upload.SetMaxSize 2097152, True

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
	Dosyaismi = SefUrl( OrjFileName ) & "-" & SifreUret(4) ' DateSqlFormat(Now(), "yymmdd", 2)
	'Dosyaismi = Temizle(UrlDecode( Dosyaismi ), 1)

	'// Dosya ismine uzantıyı tekrar ekleyelim
	ResimAdi = Dosyaismi & FileExt

	'// Dosyamız resim dosyasımı?
	If File.imageType = "UNKNOWN" Then
	'	TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece PNG uzantılı dosyalar yükleyebilirsiniz.", "")

	Else

		'// Dosya uzantımız izin verilenin dışındaysa işlemi sonlandıralım
		If Not FileExt = ".png" Then
		'	TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece PNG uzantılı dosyalar yükleyebilirsiniz.", "")

		'// Dosya boyutu izin verilenden büyükse işlemi sonlandıralım
		ElseIf File.Size > 2097152 Then
		'	TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. "& MaxBytes(2097152) &" MB'tan büyük olmamalı.", "")

		'// Dosya ismi 150 karekterden büyükse işlemi sonlandırıp uyaralım
		ElseIf Len(File.OriginalPath) > 50 Then
		'	TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", Left(File.OriginalPath, 30) & "..." & Right(File.OriginalPath, 30), "", "", "error", "", "", "Dosya ismi çok uzun, Maksimun 50 karekter olmalı.", "")

		'// Dosya güvenlik önlemlerini başarıyla geçti şimdi biçimlendirme işlemlerini yapalım
		Else

			'// Upload edilen dosyanın ismini değiştirelim
			File.Move(imgPath & "/" & ResimAdi)
			'File.SaveAs(imgPath & "/" & ResimAdi)
			'File.SaveAs "c:\path\" & File.FileName
			'File.SaveAsVirtual(imgPath & "/" & ResimAdi)
			'Upload.DeleteFile
			'File.Delete

			'// Resmimizi açalım
			'Jpeg.Open(imgPath & "/" & ResimAdi)
			'Jpeg.ToRGB
			'If AspJpegVersiyon(Jpeg.Version) And FileExt = ".png" Then Jpeg.PNGOutput = True

			'// Çerçeve Oluştur
			'Jpeg.New BannerResimWidth, BannerResimHeight, &Hffffff

			'Set Img = Server.CreateObject("Persits.Jpeg")
			'Img.Open Path
			'Img.ToRGB
			'Resmimizi Boyutlandıralım
			'Img.PreserveAspectRatio = True
			'If (Img.OriginalWidth > BannerResimWidth or Img.OriginalHeight > BannerResimHeight) Then
			'	If (Img.OriginalWidth > Img.OriginalHeight) Then
			'		Img.Width  = BannerResimWidth
			'	Else
			'		Img.Height = BannerResimHeight
			'	End If
			'End If

			'// Çerçeve İçine Ortala
			'Jpeg.Canvas.DrawImage (BannerResimWidth - Img.Width) / 2, (BannerResimHeight - Img.Height) / 2, Img
			'// Kayıt
			'Jpeg.Quality = 100
			'Jpeg.Save(imgPath & "/" & ResimAdi)
			'Jpeg.Close

			addVitrinClass = ""
			If iDefault Then addVitrinClass = " checked"

			If Err = 0 Then UploadDurum = "success" Else UploadDurum = "error"

			'// Veri tabanına resim bilgilerini girelim

			CloseDatabase data
			OpenDatabase data

			'SQL = ""
			'SQL = SQL & "SELECT img FROM #___banner "
			'SQL = SQL & "WHERE (id = "& post_id &")"
			'SQL = SQL & ";"
			'SQL = setQuery( SQL )
			'objRs.Open( SQL ),data,1,3
			'Call DeleteFile( bFolder & "/" & objRs("img") )
			'objRs("img") = ResimAdi
			'objRs.Update
			'objRs.Close

			Call DeleteFile( bFolder & "/" & sqlQuery("SELECT LogoWrite FROM #___settings WHERE parent = "& GlobalConfig("General_BannerPN") &";", "") )
			sqlExeCute("UPDATE #___settings Set LogoWrite = '"& ResimAdi &"' WHERE parent = "& GlobalConfig("General_BannerPN") &";")

			'Call PictureJson("", post_id, post_id, bFolder, ResimAdi, OrjFileName, OrjFileName, UploadDurum, addVitrinClass, "")
			Call PictureJson( _
				"", _
				"", _
				0, _
				0, _
				bFolder, _
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
