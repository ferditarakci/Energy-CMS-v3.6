<%

'If (Request.TotalBytes > 10485761) Then _
'	Call PictureJson(CookieLang, "", 0, 0, "", "", "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. 10 MB'tan büyük olmamalı.", "") : arrUpload.Flush

'// Kayıtlı sayfa kontrol işlemi yapıyoruz yoksa yeni kayıt açıyoruz

OpenRs objRs, "SELECT id, durum FROM #___sayfa WHERE id = "& id &";"
	If objRs.Eof Then
		objRs.AddNew
		objRs("durum") = 0
		'objRs("c_date") = DateSqlFormat(Now(), "yy-mm-dd", 1)
		objRs.Update
		'data.ExeCute(setQuery("INSERT INTO #___content (lang, parent, parent_id, title, short_title, text, short_text) VALUES ('"& CookieLang &"', '"& GlobalConfig("General_PagePN") &"', "& objRs("id") &", '( Başlık yok )', '', '', '');"))
		Call RevisionDate(GlobalConfig("General_PagePN"), objRs("id"), 1) '// 1 Insert -- 2 Revision
		sqlExeCute("INSERT INTO #___content (lang, parent, parent_id, title) VALUES ('"& CookieLang &"', "& GlobalConfig("General_PagePN") &", "& objRs("id") &", '( Başlık yok )');")
	End If
	'objRs.Requery
	post_id = objRs("id")
	Session("pageid") = post_id
CloseRs objRs

'// Kayıtlı resim ve sira kontrolu yapıyoruz
TotalPic = Cdbl(sqlQuery("SELECT Count( id ) FROM #___files WHERE (file_type = 2 And lang = '"& CookieLang &"' And parent = "& GlobalConfig("General_PagePN") &" And parent_id = "& post_id &");", 0))
intSiraNo = Cdbl(sqlQuery("SELECT Max( sira ) FROM #___files WHERE (file_type = 2 And lang = '"& CookieLang &"' And parent = "& GlobalConfig("General_PagePN") &" And parent_id = "& post_id &");", 0))

sUpFolder = GlobalConfig("uploadFolder") & "/" & GlobalConfig("PageUploadFolder")
If Not FolderKontrol( sUpFolder ) Then Call CreateFolder( sUpFolder )
sUpFolder = ""

'// fotoğrafların yükleneceği klasörümüzü oluşturuyoruz
Call CreateFolder(sFolder(post_id, 0))
Call CreateFolder(sFolder(post_id, 3))

imgPath = Server.MapPath(GlobalConfig("hidden_folder") & sFolder(post_id, 3))
'imgPath2 = Server.MapPath(GlobalConfig("hidden_folder") & sFolder(post_id, 1))

'// Dosyalarımızı sunucuya yüklemek için Asp Upload nesnemizi oluşturuyoruz
Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.CodePage = 65001

'// Aynı isimde dosya varsa üzerine yazmıyoruz
Upload.OverwriteFiles = False

'// Maksimun toplam dosya boyutunu 10 MB olarak belirliyoruz
'Upload.SetMaxSize 2097152, True
'Upload.SetMaxSize 10485761, True

Upload.SetMaxSize GlobalConfig("MaxFileTotalSize"), True

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

'// Gerekli işlemler için upload edilen dosyalarımızı döngüye sokalım
For Each File In Upload.Files

	'// Toplam eklenebilir dosyamızı sayalım
	TotalPic = TotalPic + 1

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

	'// Dosya uzantımız izin verilenin dışındaysa işlemi sonlandıralım
	If Not UzantiKabul(FileExt, ArrFileExt) Then
		TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Bu dosyayı yükleme yetkiniz bulunmuyor.", "")

	'// Dosya boyutu izin verilenden büyükse işlemi sonlandıralım
	ElseIf File.Size > GlobalConfig("MaxFileSize") Then
		TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. "& MaxBytes(GlobalConfig("MaxFileSize")) &" MB'tan büyük olmamalı.", "")

	'// İzin verilen toplam dosya ekleme kontrolünü yapalım
	ElseIf TotalPic > GlobalConfig("MaxFile") Then
		TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Bu kayıt için toplam ("& GlobalConfig("MaxFile") &") doysa ekleme hakkınızı doldurdunuz.", "")

	'// Dosya ismi 150 karekterden büyükse işlemi sonlandırıp uyaralım
	ElseIf Len(File.OriginalPath) > 150 Then
		TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", Left(File.OriginalPath, 30) & "..." & Right(File.OriginalPath, 30), "", "", "error", "", "", "Dosya ismi çok uzun, maksimun 150 karekter olmalı.", "")

	'// Dosya güvenlik önlemlerini başarıyla geçti şimdi biçimlendirme işlemlerini yapalım
	Else

		'// Upload edilen dosyanın ismini değiştirelim
		File.Move(imgPath & "/" & ResimAdi)
		'File.SaveAs(imgPath & "/" & ResimAdi)
		'File.SaveAs "c:\path\" & File.FileName
		'File.SaveAsVirtual(imgPath & "/" & ResimAdi)
		'Upload.DeleteFile
		'File.Delete

		intSiraNo = intSiraNo + 1

		iDefault = 0 : If intSiraNo = 1 Then iDefault = 1

		addVitrinClass = "" : If iDefault Then addVitrinClass = " checked"

		If Err = 0 Then UploadDurum = "success" Else UploadDurum = "error"
		dateTime = DateSqlFormat(Now(), "yy-mm-dd", 1)
		DosyaTuru = File.ContentType 'MimeType( FileExt )

		'// Veri tabanına resim bilgilerini girelim

		CloseDatabase data
		OpenDatabase data

		'OpenRs objRs, "SELECT * FROM #___files;"
		'	objRs.AddNew()
		'	objRs("lang") = CookieLang
		'	objRs("title") = OrjFileName
		'	objRs("alt") = OrjFileName
		'	objRs("tarih") = dateTime
		'	objRs("resim") = ResimAdi
		'	objRs("mime_type") = DosyaTuru
		'	objRs("anaid") = post_id
		'	objRs("sira_no") = intSiraNo
		'	objRs("anaresim") = iDefault
		'	objRs("nerde") = GlobalConfig("General_PagePN")
		'	objRs.Update
		'	files_id = objRs("id")
		'CloseRs objRs

		SQL = ""
		SQL = SQL & "INSERT INTO #___files (lang, title, alt, tarih, resim, file_type, mime_type, sira, anaresim, parent, parent_id, url, text) "
		SQL = SQL & "VALUES ('"& CookieLang &"', '"& Temizle(OrjFileName, 1) &"', '"& Temizle(OrjFileName, 1) &"', '"& dateTime &"', "
		SQL = SQL & "'"& Temizle(ResimAdi, 1) &"', 2, '"& DosyaTuru &"', "& intSiraNo &", "& iDefault &", "& GlobalConfig("General_PagePN") &", "& post_id &", '', '');"
		sqlExeCute( SQL )
		'If data.Errors.Count > 0 Then
		'	Call OpenDatabase(data)
		'	data.ExeCute SQL
		'End If
		files_id = sqlQuery("SELECT id FROM #___files WHERE file_type = 2 And lang = '"& CookieLang &"' And parent = "& GlobalConfig("General_PagePN") &" And parent_id = "& post_id &" ORDER BY id DESC Limit 1;", 0)

		'File.DecryptAndSendBinary imgPath & "/" & ResimAdi & ".ferdi", True, "application/octet-stream", Key, True, True
		'// JSON Array olarak resim bilgilerini çıkartalım
		Call PictureJson( _
			CookieLang, _
			DosyaTuru, _
			post_id, _
			files_id, _
			sFolder(post_id, 3), _
			ResimAdi, _
			OrjFileName, _
			OrjFileName, _
			UploadDurum, _
			addVitrinClass, _
			FileAddClass(FileExt), _
			"", _
			TarihFormatla(dateTime) _
		)
	End If
Next
Set Upload = Nothing
%>
