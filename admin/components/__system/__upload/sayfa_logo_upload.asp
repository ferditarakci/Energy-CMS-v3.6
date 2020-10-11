<%
sUpFolder = GlobalConfig("uploadFolder") & "/" & GlobalConfig("PageUploadFolder")
If Not FolderKontrol( sUpFolder ) Then Call CreateFolder( sUpFolder )
sUpFolder = ""

Call CreateFolder(sFolder("", -1))

imgPath = Server.MapPath(sFolder("", -1))

Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.CodePage = 65001
Upload.OverwriteFiles = False
Upload.SetMaxSize 2097152, True
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
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece PNG uzantılı dosyalar yükleyebilirsiniz.", "")

	Else

		'// Dosya uzantımız izin verilenin dışındaysa işlemi sonlandıralım
		If Not FileExt = ".png" Then
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece PNG uzantılı dosyalar yükleyebilirsiniz.", "")

		'// Dosya boyutu izin verilenden büyükse işlemi sonlandıralım
		ElseIf File.Size > 2097152 Then
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. "& MaxBytes(2097152) &" MB'tan büyük olmamalı.", "")

		'// Dosya ismi 50 karekterden büyükse işlemi sonlandırıp uyaralım
		ElseIf Len(File.OriginalPath) > 50 Then
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", Left(File.OriginalPath, 30) & "..." & Right(File.OriginalPath, 30), "", "", "error", "", "", "Dosya ismi çok uzun, Maksimun 50 karekter olmalı.", "")

		'// Dosya güvenlik önlemlerini başarıyla geçti şimdi biçimlendirme işlemlerini yapalım
		Else

			'// Upload edilen dosyanın ismini değiştirelim
			File.Move(imgPath & "/" & ResimAdi)

			If Err = 0 Then UploadDurum = "success" Else UploadDurum = "error"

			
			'// Veri tabanını kapatıp açalım
			CloseDatabase data
			OpenDatabase data

			'// Sunucuda varsa eski dosyayı silelim
			Call DeleteFile( sFolder("", -1) & "/" & sqlQuery("SELECT LogoWrite FROM #___settings WHERE parent = "& GlobalConfig("General_PagePN") &";", "") )

			'// Veri tabanına resim bilgilerini girelim
			sqlExeCute("UPDATE #___settings Set LogoWrite = '"& ResimAdi &"' WHERE parent = "& GlobalConfig("General_PagePN") &";")

			Call PictureJson( _
				"", _
				"", _
				0, _
				0, _
				sFolder("", -1), _
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
