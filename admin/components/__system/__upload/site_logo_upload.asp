<%
'sUpFolder = GlobalConfig("uploadFolder") & "/logo"
If Not FolderKontrol( GlobalConfig("logoPath") ) Then Call CreateFolder( GlobalConfig("logoPath") )
'sUpFolder = ""

'Call CreateFolder(sUpFolder)

imgPath = Server.MapPath(GlobalConfig("logoPath"))

Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.CodePage = 65001
Upload.OverwriteFiles = False
Upload.SetMaxSize 524288, True
Upload.IgnoreNoPost = True
Count = Upload.Save(imgPath & "/")

'// Gerekli işlemler için upload edilen dosyalarımızı döngüye sokalım
For Each File In Upload.Files

	FileExt = LCase(File.Ext)
	OrjFileName = Left(File.OriginalPath, Len(File.OriginalPath) - Len(File.Ext))
	Dosyaismi = SefUrl( OrjFileName ) & "-" & SifreUret(4) 'DateSqlFormat(Now(), "yymmdd", 2)
	ResimAdi = Dosyaismi & FileExt

	'// Dosyamız resim dosyasımı?
	If File.imageType = "UNKNOWN" Then
	'	TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece JPG, GIF ve PNG uzantılı dosyalar yükleyebilirsiniz.", "")

	Else

		'// Dosya uzantımız izin verilenin dışındaysa işlemi sonlandıralım
		If Not UzantiKabul(FileExt, ArrPictureExt) Then
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece JPG, GIF ve PNG uzantılı dosyalar yükleyebilirsiniz.", "")

		'// Dosya boyutu izin verilenden büyükse işlemi sonlandıralım
		ElseIf File.Size > 524288 Then
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. "& MaxBytes(524288) &" MB'tan büyük olmamalı.", "")

		'// Dosya ismi 50 karekterden büyükse işlemi sonlandırıp uyaralım
		ElseIf Len(File.OriginalPath) > 50 Then
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", Left(File.OriginalPath, 30) & "..." & Right(File.OriginalPath, 30), "", "", "error", "", "", "Dosya ismi çok uzun, Maksimun 50 karekter olmalı.", "")

		'// Dosya güvenlik önlemlerini başarıyla geçti şimdi biçimlendirme işlemlerini yapalım
		Else

			'// Upload edilen dosyanın ismini değiştirelim
			File.Move(imgPath & "/" & ResimAdi)

			addVitrinClass = ""
			If Err = 0 Then UploadDurum = "success" Else UploadDurum = "error"

			'// Veri tabanını kapatıp açalım
			CloseDatabase data
			OpenDatabase data

			'// Sunucuda varsa eski dosyayı silelim
			Call DeleteFile( GlobalConfig("logoPath") & "/" & sqlQuery("SELECT logo FROM #___ayarlar WHERE id = 1;", "") )

			'// Veri tabanına resim bilgilerini girelim
			sqlExeCute("UPDATE #___ayarlar Set logo = '"& ResimAdi &"' WHERE id = 1;")

			Call PictureJson( _
				"", _
				"", _
				1, _
				1, _
				GlobalConfig("logoPath") & "/", _
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
%>
