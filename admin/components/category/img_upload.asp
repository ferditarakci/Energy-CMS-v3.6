<%
'If (Request.TotalBytes > 10485761) Then _
'	Call PictureJson(CookieLang, "", 0, 0, "", "", "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. 10 MB'tan büyük olmamalı.", "") : arrUpload.Flush

'// Kayıtlı sayfa kontrol işlemi yapıyoruz yoksa yeni kayıt açıyoruz



intDurum = False
If FilesKontrol(kFolder("", -1) & "/" & GlobalConfig("LogoWrite")) Then
	GlobalConfig("LogoWrite") = Server.MapPath(GlobalConfig("hidden_folder") & kFolder("", -1)) & "/" & GlobalConfig("LogoWrite")
	intDurum = True
End If

OpenRs objRs, "SELECT id, durum FROM #___kategori WHERE id = "& id &";"
	If objRs.Eof Then
		objRs.AddNew
		objRs("durum") = 0
		'objRs("c_date") = DateSqlFormat(Now(), "yy-mm-dd", 1)
		objRs.Update
		'data.ExeCute(setQuery("INSERT INTO #___content (lang, parent, parent_id, title, short_title, text, short_text) VALUES ('"& CookieLang &"', '"& GlobalConfig("General_CategoriesPN") &"', "& objRs("id") &", '( Başlık yok )', '', '', '');"))
		Call RevisionDate(GlobalConfig("General_CategoriesPN"), objRs("id"), 1) '// 1 Insert -- 2 Revision
		sqlExeCute("INSERT INTO #___content (lang, parent, parent_id, title) VALUES ('"& CookieLang &"', "& GlobalConfig("General_CategoriesPN") &", "& objRs("id") &", '( Başlık yok )');")
	End If
	'objRs.Requery
	post_id = objRs("id")
	Session("pageid") = post_id
CloseRs objRs

'// Kayıtlı resim ve sira kontrolu yapıyoruz
TotalPic = Cdbl(sqlQuery("SELECT Count( id ) FROM #___files WHERE (file_type = 1 And lang = '"& CookieLang &"' And parent = "& GlobalConfig("General_CategoriesPN") &" And parent_id = "& post_id &");", 0))
intSiraNo = Cdbl(sqlQuery("SELECT Max( sira ) FROM #___files WHERE (file_type = 1 And lang = '"& CookieLang &"' And parent = "& GlobalConfig("General_CategoriesPN") &" And parent_id = "& post_id &");", 0))

sUpFolder = GlobalConfig("uploadFolder") & "/" & GlobalConfig("CategoriesUploadFolder")
If Not FolderKontrol( sUpFolder ) Then Call CreateFolder( sUpFolder )
sUpFolder = ""

'// fotoğrafların yükleneceği klasörümüzü oluşturuyoruz
Call CreateFolder(kFolder(post_id, 0))
Call CreateFolder(kFolder(post_id, 1))
Call CreateFolder(kFolder(post_id, 2))

imgPath = Server.MapPath(GlobalConfig("hidden_folder") & kFolder(post_id, 0))
imgPath2 = Server.MapPath(GlobalConfig("hidden_folder") & kFolder(post_id, 1))
imgPath3 = Server.MapPath(GlobalConfig("hidden_folder") & kFolder(post_id, 2))

'// Asp Jpeg nesnemizi oluşturuyoruz
Set Jpeg = Server.CreateObject("Persits.Jpeg")

'// Dosyalarımızı sunucuya yüklemek için Asp Upload nesnemizi oluşturuyoruz
Set Upload = Server.CreateObject("Persits.Upload.1")
Upload.CodePage = 65001

'// Aynı isimde dosya varsa üzerine yazmıyoruz
Upload.OverwriteFiles = False

'// Maksimun toplam dosya boyutunu 10 MB olarak belirliyoruz
'Upload.SetMaxSize 2097152, True
'Upload.SetMaxSize 10485761, True

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

'Upload.TotalSeconds

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

	'// Dosyamız resim dosyasımı?
	If File.imageType = "UNKNOWN" Then
		TotalPic = TotalPic - 1
		File.Delete
		Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece JPG, GIF ve PNG uzantılı dosyalar yükleyebilirsiniz.", "")

	Else

		'// Dosya uzantımız izin verilenin dışındaysa işlemi sonlandıralım
		If Not UzantiKabul(FileExt, ArrPictureExt) Then
			TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Dosya türü hatalı, sadece JPG, GIF ve PNG uzantılı dosyalar yükleyebilirsiniz.", "")

		'// Dosya boyutu izin verilenden büyükse işlemi sonlandıralım
		ElseIf File.Size > GlobalConfig("MaxPictureSize") Then
			TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Yüklemek istediğin doysa boyutu maks. "& MaxBytes(GlobalConfig("MaxPictureSize")) &" MB'tan büyük olmamalı.", "")

		'// İzin verilen toplam dosya ekleme kontrolünü yapalım
		ElseIf TotalPic > GlobalConfig("MaxPicture") Then
			TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Bu kayıt için toplam ("& GlobalConfig("MaxPicture") &") resim ekleme hakkınızı doldurdunuz.", "")

		'// Dosya ismi 150 karekterden büyükse işlemi sonlandırıp uyaralım
		ElseIf Len(File.OriginalPath) > 150 Then
			TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", Left(File.OriginalPath, 30) & "..." & Right(File.OriginalPath, 30), "", "", "error", "", "", "Dosya ismi çok uzun, maksimun 150 karekter olmalı.", "")

		'// Dosya ismi 150 karekterden büyükse işlemi sonlandırıp uyaralım
		ElseIf (GlobalConfig("SmallLogoStatus") = 1 Or GlobalConfig("MediumLogoStatus") = 1 Or GlobalConfig("LargeLogoStatus") = 1) And GlobalConfig("LogoWrite") = "" Then
			TotalPic = TotalPic - 1
			File.Delete
			Call PictureJson(CookieLang, "", 0, 0, "", File.OriginalPath, "", "", "error", "", "", "Logo baskısı aktif edilmiş ancak logo yüklenmemiş, lütfen logonuzu yükleyin.", "")

		'// Dosya güvenlik önlemlerini başarıyla geçti şimdi biçimlendirme işlemlerini yapalım
		Else

			'// Upload edilen dosyanın ismini değiştirelim
			File.Move(imgPath & "/" & ResimAdi)
			'File.SaveAs(imgPath & "/" & ResimAdi)
			'File.SaveAs "c:\path\" & File.FileName
			'File.SaveAsVirtual(imgPath & "/" & ResimAdi)
			'Upload.DeleteFile
			'File.Delete


			If GlobalConfig("SmallSizeW") > 0 And GlobalConfig("SmallSizeH") > 0 Then
				'// Büyük resmimizi tekrar açalım
				Jpeg.Open(imgPath & "/" & ResimAdi)
				Jpeg.ToRGB
				If AspJpegVersiyon(Jpeg.Version) And FileExt = ".png" Then Jpeg.PNGOutput = True

				If GlobalConfig("SmallTextStatus") = 1 And GlobalConfig("imageText") <> "" Then
					Jpeg.Canvas.Font.Color = &HFFFFFF 'beyaz &H000000 'Black
					Jpeg.Canvas.Font.Align = 0 '0 (left), 1 (right), 2 (center) and 3 (justified)
					Jpeg.Canvas.Font.Width = Jpeg.Width - 10
					Jpeg.Canvas.Font.Size = 32
					Jpeg.Canvas.Font.Spacing = 2
					Jpeg.Canvas.Font.Quality = 10 'Yazı Kalitesi
					Jpeg.Canvas.Font.Opacity = 0.8
					'Jpeg.Canvas.PrintTextEx Duzenle( GlobalConfig("resim_yazi") ), 0, Jpeg.Height / 2, ttfFontFile
					Jpeg.Canvas.PrintTextEx Duzenle( GlobalConfig("imageText") ), Jpeg.Width - Jpeg.Canvas.GetTextExtent( Duzenle( GlobalConfig("imageText") ) ), Jpeg.Height - 20, ttfFontFile
				End If

				GlobalConfig("OriginalWidth") = Jpeg.OriginalWidth
				GlobalConfig("OriginalHeight") = Jpeg.OriginalWidth

				'// Resmin üzerine logo baskısı
				If GlobalConfig("SmallLogoStatus") = 1 And intDurum Then 
					With Server.CreateObject("Persits.Jpeg")
						.Open( GlobalConfig("LogoWrite") )

						If (.OriginalWidth > GlobalConfig("OriginalWidth") Or .OriginalHeight > GlobalConfig("OriginalHeight")) Then
							.PreserveAspectRatio = True
							If (.OriginalWidth > .OriginalHeight) Then
								.Width = GlobalConfig("OriginalWidth")
								.Height = .OriginalHeight * .Width / .OriginalWidth
							Else
								.Height = GlobalConfig("OriginalHeight")
								.Width = .OriginalWidth * .Height / .OriginalHeight
							End If
						End If

						Jpeg.Canvas.DrawPNG (Jpeg.Width - .OriginalWidth) \ 2, (Jpeg.Height - .OriginalHeight) \ 2, GlobalConfig("LogoWrite")
						.Close
					End With
				End If

				'// Büyük resmimizi boyutlandıralım
				If (Jpeg.OriginalWidth > GlobalConfig("SmallSizeW")) Then
					Jpeg.PreserveAspectRatio = True
					Jpeg.Width = GlobalConfig("SmallSizeW")
					Jpeg.Height = Jpeg.OriginalHeight * Jpeg.Width / Jpeg.OriginalWidth
				End If

				'// Resmin üzerine yazı ekleme
				'If GlobalConfig("resim_yazi_durum") = 1 Then
				'	Jpeg.Canvas.Font.Color = &Had0000 'Yazi rengi
				'	Jpeg.Canvas.Font.Family = "Courier New" 'Yazi karekteri
				'	Jpeg.Canvas.Font.Size = 24 'Yazi boyutu
				'	Jpeg.Canvas.Font.Bold = True 'Yazi kalın ise
				'	Jpeg.Canvas.Font.Quality = 100 'Yazi kalitesi
				'	Jpeg.Canvas.Font.BkMode = &HFFFFFF 'Yazi arkaplan rengi
				'	Jpeg.Canvas.Print 0, 0, Duzenle( GlobalConfig("resim_yazi") )
				'End If

				'// Çerçeve Çiz
				'Jpeg.Canvas.Pen.Color = &H000000 ' Siyah
				'Jpeg.Canvas.Pen.Width = 2
				'Jpeg.Canvas.Brush.Solid = False  ' Arka Planı Boş Yap
				'Jpeg.Canvas.DrawBar 0.5, 0.5, BuyukResimWidth, BuyukResimHeight

				'// Resmin kalitesini belirleyelim ve kaydedelim
				Jpeg.Quality = 80
				'Jpeg.Interpolation = 1
				Jpeg.Save(imgPath2 & "/" & ResimAdi)
				Jpeg.Close
			End If






			If GlobalConfig("MediumSizeW") > 0 And GlobalConfig("MediumSizeH") > 0 Then
				'// Büyük resmimizi tekrar açalım
				Jpeg.Open(imgPath & "/" & ResimAdi)
				Jpeg.ToRGB
				If AspJpegVersiyon(Jpeg.Version) And FileExt = ".png" Then Jpeg.PNGOutput = True


				If GlobalConfig("MediumTextStatus") = 1 And GlobalConfig("imageText") <> "" Then
					Jpeg.Canvas.Font.Color = &HFFFFFF 'beyaz &H000000 'Black
					Jpeg.Canvas.Font.Align = 0 '0 (left), 1 (right), 2 (center) and 3 (justified)
					Jpeg.Canvas.Font.Width = Jpeg.Width - 10
					Jpeg.Canvas.Font.Size = 32
					Jpeg.Canvas.Font.Spacing = 2
					Jpeg.Canvas.Font.Quality = 10 'Yazı Kalitesi
					Jpeg.Canvas.Font.Opacity = 0.8
					'Jpeg.Canvas.PrintTextEx Duzenle( GlobalConfig("resim_yazi") ), 0, Jpeg.Height / 2, ttfFontFile
					Jpeg.Canvas.PrintTextEx Duzenle( GlobalConfig("imageText") ), Jpeg.Width - Jpeg.Canvas.GetTextExtent( Duzenle( GlobalConfig("imageText") ) ), Jpeg.Height - 20, ttfFontFile
				End If

				GlobalConfig("OriginalWidth") = Jpeg.OriginalWidth
				GlobalConfig("OriginalHeight") = Jpeg.OriginalWidth

				'// Resmin üzerine logo baskısı
				If GlobalConfig("MediumLogoStatus") = 1 And intDurum Then 
					With Server.CreateObject("Persits.Jpeg")
						.Open( GlobalConfig("LogoWrite") )

						If (.OriginalWidth > GlobalConfig("OriginalWidth") Or .OriginalHeight > GlobalConfig("OriginalHeight")) Then
							.PreserveAspectRatio = True
							If (.OriginalWidth > .OriginalHeight) Then
								.Width = GlobalConfig("OriginalWidth")
								.Height = .OriginalHeight * .Width / .OriginalWidth
							Else
								.Height = GlobalConfig("OriginalHeight")
								.Width = .OriginalWidth * .Height / .OriginalHeight
							End If
						End If

						Jpeg.Canvas.DrawPNG (Jpeg.Width - .OriginalWidth) \ 2, (Jpeg.Height - .OriginalHeight) \ 2, GlobalConfig("LogoWrite")
						.Close
					End With
				End If

				'// Büyük resmimizi boyutlandıralım
				If (Jpeg.OriginalWidth > GlobalConfig("MediumSizeW")) Then
					Jpeg.PreserveAspectRatio = True
					Jpeg.Width = GlobalConfig("MediumSizeW")
					Jpeg.Height = Jpeg.OriginalHeight * Jpeg.Width / Jpeg.OriginalWidth
				End If

				'// Resmin üzerine yazı ekleme
				'If GlobalConfig("resim_yazi_durum") = 1 Then
				'	Jpeg.Canvas.Font.Color = &Had0000 'Yazi rengi
				'	Jpeg.Canvas.Font.Family = "Courier New" 'Yazi karekteri
				'	Jpeg.Canvas.Font.Size = 24 'Yazi boyutu
				'	Jpeg.Canvas.Font.Bold = True 'Yazi kalın ise
				'	Jpeg.Canvas.Font.Quality = 100 'Yazi kalitesi
				'	Jpeg.Canvas.Font.BkMode = &HFFFFFF 'Yazi arkaplan rengi
				'	Jpeg.Canvas.Print 0, 0, Duzenle( GlobalConfig("resim_yazi") )
				'End If

				'// Çerçeve Çiz
				'Jpeg.Canvas.Pen.Color = &H000000 ' Siyah
				'Jpeg.Canvas.Pen.Width = 2
				'Jpeg.Canvas.Brush.Solid = False  ' Arka Planı Boş Yap
				'Jpeg.Canvas.DrawBar 0.5, 0.5, BuyukResimWidth, BuyukResimHeight

				'// Resmin kalitesini belirleyelim ve kaydedelim
				Jpeg.Quality = 80
				'Jpeg.Interpolation = 1
				Jpeg.Save(imgPath3 & "/" & ResimAdi)
				Jpeg.Close
			End If











			If GlobalConfig("LargeSizeW") > 0 And GlobalConfig("LargeSizeH") > 0 Then
				'// Büyük resmimizi tekrar açalım
				Jpeg.Open(imgPath & "/" & ResimAdi)
				Jpeg.ToRGB
				If AspJpegVersiyon(Jpeg.Version) And FileExt = ".png" Then Jpeg.PNGOutput = True

				'varPX = 22 * int(Jpeg.Width)

				If GlobalConfig("LargeTextStatus") = 1 And GlobalConfig("imageText") <> "" Then
					Jpeg.Canvas.Font.Color = &HFFFFFF 'beyaz &H000000 'Black
					Jpeg.Canvas.Font.Align = 0 '0 (left), 1 (right), 2 (center) and 3 (justified)
					Jpeg.Canvas.Font.Width = Jpeg.Width - 10
					Jpeg.Canvas.Font.Size = 22
					Jpeg.Canvas.Font.Bold = False
					Jpeg.Canvas.Font.Spacing = 2
					Jpeg.Canvas.Font.Quality = 10 'Yazı Kalitesi
					Jpeg.Canvas.Font.Opacity = 0.8
					'Jpeg.Canvas.PrintTextEx Duzenle( GlobalConfig("resim_yazi") ), 0, Jpeg.Height / 2, ttfFontFile
					Jpeg.Canvas.PrintTextEx Duzenle( GlobalConfig("imageText") ), (Jpeg.Width - Jpeg.Canvas.GetTextExtent( Duzenle( GlobalConfig("imageText") ) )) / 2, (Jpeg.Height - Jpeg.Canvas.GetTextExtent( Duzenle( GlobalConfig("imageText") ) )) / 2, ttfFontFile
				End If

				GlobalConfig("OriginalWidth") = Jpeg.OriginalWidth
				GlobalConfig("OriginalHeight") = Jpeg.OriginalWidth

				'// Resmin üzerine logo baskısı
				If GlobalConfig("LargeLogoStatus") = 1 And intDurum Then 
					With Server.CreateObject("Persits.Jpeg")
						.Open( GlobalConfig("LogoWrite") )

						If (.OriginalWidth > GlobalConfig("OriginalWidth") Or .OriginalHeight > GlobalConfig("OriginalHeight")) Then
							.PreserveAspectRatio = True
							If (.OriginalWidth > .OriginalHeight) Then
								.Width = GlobalConfig("OriginalWidth")
								.Height = .OriginalHeight * .Width / .OriginalWidth
							Else
								.Height = GlobalConfig("OriginalHeight")
								.Width = .OriginalWidth * .Height / .OriginalHeight
							End If
						End If

						Jpeg.Canvas.DrawPNG (Jpeg.Width - .OriginalWidth) \ 2, (Jpeg.Height - .OriginalHeight) \ 2, GlobalConfig("LogoWrite")
						.Close
					End With
				End If


				'// Büyük resmimizi boyutlandıralım
				If (Jpeg.OriginalWidth > GlobalConfig("LargeSizeW")) Then
					Jpeg.PreserveAspectRatio = True
					Jpeg.Width = GlobalConfig("LargeSizeW")
					Jpeg.Height = Jpeg.OriginalHeight * Jpeg.Width / Jpeg.OriginalWidth
				End If

				'// Resmin üzerine yazı ekleme
				'If GlobalConfig("resim_yazi_durum") = 1 Then
				'	Jpeg.Canvas.Font.Color = &Had0000 'Yazi rengi
				'	Jpeg.Canvas.Font.Family = "Courier New" 'Yazi karekteri
				'	Jpeg.Canvas.Font.Size = 24 'Yazi boyutu
				'	Jpeg.Canvas.Font.Bold = True 'Yazi kalın ise
				'	Jpeg.Canvas.Font.Quality = 100 'Yazi kalitesi
				'	Jpeg.Canvas.Font.BkMode = &HFFFFFF 'Yazi arkaplan rengi
				'	Jpeg.Canvas.Print 0, 0, Duzenle( GlobalConfig("resim_yazi") )
				'End If


				'// Çerçeve Çiz
				'Jpeg.Canvas.Pen.Color = &H000000 ' Siyah
				'Jpeg.Canvas.Pen.Width = 2
				'Jpeg.Canvas.Brush.Solid = False  ' Arka Planı Boş Yap
				'Jpeg.Canvas.DrawBar 0.5, 0.5, BuyukResimWidth, BuyukResimHeight

				'// Resmin kalitesini belirleyelim ve kaydedelim
				Jpeg.Quality = 80
				'Jpeg.Interpolation = 1
				Jpeg.Save(imgPath & "/" & ResimAdi)
				Jpeg.Close
			End If


			intSiraNo = intSiraNo + 1
			'ResimAdi = Err & " " & Err.Description
			iDefault = 0 : If intSiraNo = 1 Then iDefault = 1
			
			addVitrinClass = "" : If iDefault Then addVitrinClass = " checked"
			UploadDurum = "success" : If Err <> 0 Then UploadDurum = "error"

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
			'	objRs("nerde") = GlobalConfig("General_CategoriesPN")
			'	objRs.Update
			'	files_id = objRs("id")
			'CloseRs objRs

			SQL = ""
			SQL = SQL & "INSERT INTO #___files (lang, title, alt, tarih, resim, file_type, mime_type, sira, anaresim, parent, parent_id, url, text) "
			SQL = SQL & "VALUES ('"& CookieLang &"', '"& Temizle(OrjFileName, 1) &"', '"& Temizle(OrjFileName, 1) &"', '"& dateTime &"', "
			SQL = SQL & "'"& Temizle(ResimAdi, 1) &"', 1, '"& DosyaTuru &"', "& intSiraNo &", "& iDefault &", "& GlobalConfig("General_CategoriesPN") &", "& post_id &", '', '');"
			sqlExeCute( SQL )
			'If data.Errors.Count > 0 Then
			'	Call OpenDatabase(data)
			'	data.ExeCute SQL
			'End If
			files_id = sqlQuery("SELECT id FROM #___files WHERE file_type = 1 And lang = '"& CookieLang &"' And parent = "& GlobalConfig("General_CategoriesPN") &" And parent_id = "& post_id &" ORDER BY id DESC Limit 1;", 0)

			'File.DecryptAndSendBinary imgPath & "/" & ResimAdi & ".ferdi", True, "application/octet-stream", Key, True, True
			'// JSON Array olarak resim bilgilerini çıkartalım
			Call PictureJson( _
				CookieLang, _
				DosyaTuru, _
				post_id, _
				files_id, _
				kFolder(post_id, 1), _
				ResimAdi, _
				OrjFileName, _
				OrjFileName, _
				UploadDurum, _
				addVitrinClass, _
				imgAlign(kFolder(post_id, 1) & "/" & ResimAdi, 110, 90, 110, 90), _
				"", _
				TarihFormatla(dateTime) _
			)
		End If
	End If
Next

Set Upload = Nothing
Set Jpeg = Nothing
%>
