<%

'// Boş sayfaya string yazdırmak
Sub Clearfix(ByVal str)
	'Response.ContentType = "text/plain"
	str = str & ""
	If str = "" Then str = "Boş İçerik Yazdırıldı!"
	Response.Clear
	Response.Write str
	Response.Flush
	Response.End
End Sub



'Private Sub Sleep(ByVal nSan)
'    Dim s1 : s1 = Timer()
'    While Not (CDbl(Timer()-s1) >= nSan) : Wend
'End Sub
'For i = 1 To 3
'	Response.Write i& "<br />"
'	Response.Flush
'	Sleep(0.5)
'Next



Private Function imgAlign(ByVal imgPath, ByVal cW, ByVal cH, ByVal mW, ByVal mH)
	'// cW = Çerçeve Width
	'// cH = Çerçeve Height
	'// mW = Image Min Width
	'// mH = Image Min Height
	If Not FilesKontrol(imgPath) Then Exit Function
	imgPath = Server.MapPath( GlobalConfig("hidden_folder") & imgPath )
	With Server.CreateObject("Persits.Jpeg")
		.Open imgPath
			If (.OriginalWidth > mW Or .OriginalHeight > mH) Then
				.PreserveAspectRatio = True
				If (.OriginalWidth > mW) Then
					.Width = mW
					.Height = (.OriginalHeight * .Width) / .OriginalWidth
				Else
					.Height = mH
					.Width = (.OriginalWidth * .Height) / .OriginalHeight
				End If

				If (.Height > mH) Then
					.Height = mH
					.Width = (.Width * .Height) / .Height
				End If

				If (.Width > mW) Then
					.Width = mW
					.Height = (.Height * .Width) / .Width
				End If
			End If

			'JpegWidth = .Width
			'JpegHeight = .Height
			'width: "& .Width &"px; height: "& .Height &"px; 
			imgAlign = ""
			imgAlign = imgAlign & "width:"& Cint(.Width) &"px; "
			imgAlign = imgAlign & "height:"& Cint(.Height) &"px; "
			imgAlign = imgAlign & "margin-left:"& Cint((cW - .Width) / 2) &"px; "
			imgAlign = imgAlign & "margin-top:"& Cint((cH - .Height) / 2) &"px;"
			imgAlign = " style="""& imgAlign &""""
			imgAlign = imgAlign & " width="""& Cint(.Width) &""""
			imgAlign = imgAlign & " height="""& Cint(.Height) &""""
		.Close
	End With
End Function
'Clearfix imgAlign("/demo2/upload/sayfa/s_57211/thumb/Untitled-1.jpg", 210, 150, 190, 140)







Private Function sqlQuery(ByVal sSorgu, ByVal sDefault)
	Dim objSubRs, Sonuc
	Set objSubRs = setExecute( sSorgu )
		If Not objSubRs.Eof Then
			Sonuc = objSubRs.Fields.Item(0).Value
		End If
	Set objSubRs = Nothing

	Sonuc = Sonuc & ""
	If Sonuc = "" Then Sonuc = sDefault
	If isNumeric(Sonuc) Then Sonuc = Cdbl(Sonuc) Else Sonuc = Cstr(Sonuc)

	sqlQuery = Sonuc
End Function
'sqlQuery("SELECT ...")






Private Sub sqlExecute(ByVal sqlSorgu)
	sqlSorgu = setQuery( sqlSorgu )
	data.Execute sqlSorgu
End Sub
'setExecute("INSERT INTO ...")











Private Function setExecute(ByVal sqlSorgu)
	sqlSorgu = setQuery( sqlSorgu )
	Set setExecute = data.Execute( sqlSorgu )
End Function
'Set objRs = setExecute("SELECT ...")





Private Sub OpenRs(ByRef N, ByVal sqlSorgu)
	sqlSorgu = setQuery( sqlSorgu )
	Set N = Server.CreateObject("ADODB.Recordset")
	N.Open( sqlSorgu ), data, 1, 3
End Sub
'OpenRs objRs, "SELECT ..."



Private Sub CloseRs(ByRef N)
	N.Close : Set N = Nothing
End Sub
'CloseRs objRs




Private Function sqlGetRows(ByVal sqlSorgu)
	Dim objRows
	Set objRows = setExecute( sqlSorgu )
		If Not objRows.Eof Then sqlGetRows = objRows.GetRows() Else sqlGetRows = False
	Set objRows = Nothing
End Function
'Clearfix sqlGetRows("SELECT lng, title, orj_title, durum FROM #___languages WHERE (durum = 0) ORDER BY default_lng ASC, sira ASC;")









Private Function intYap(ByVal iVal, ByVal iDefault)
	iVal = iVal & ""

	If isNumeric(iVal) = False Or iVal = "" Then
		iVal = iDefault

	ElseIf isNumeric(iVal) Then
		If Cdbl(iVal) < 0 Then iVal = iDefault

	End If

	intYap = Cdbl(Abs(Fix(iVal)))
End Function
'Clearfix intYap("2", 1)







'// Languages
Private Sub Languages(ByVal ActiveLang)
	If UBound(ActiveLanguages) = 0 Then Exit Sub
	Dim objRs, sSQL, strLangTitle, strLangOrjTitle, strLangCode, strLangUrl, addClass
	sSQL = ""
	sSQL = sSQL & "SELECT title, orj_title, lng" & vbCrLf
	sSQL = sSQL & "FROM #___languages WHERE durum = 1" & vbCrLf
	sSQL = sSQL & "ORDER BY default_lng DESC, sira ASC;" & vbCrLf
	OpenRs objRs, sSQL
		Do While Not objRs.Eof
			strLangTitle = objRs("title") & ""
			strLangOrjTitle = objRs("orj_title") & ""
			strLangCode = objRs("lng") & ""
			strLangUrl = UrlWrite(GlobalConfig("sDomain"), strLangCode, GlobalConfig("General_Home"), "", "", "", "", "")
			addClass = "" : If ActiveLang = strLangCode Then addClass = " active"
			Response.Write( vbCrLf & "				<li class="""& LCase(strLangCode) & addClass &"""><a href="""& strLangUrl &""" title="""& strLangOrjTitle &"""><span>"& strLangTitle &"</span></a></li>")
		objRs.MoveNext() : Loop
	CloseRs objRs
End Sub
'Call Languages(GlobalConfig("site_lang"))







'// Tümünü Büyük Harf Yap Fonksiyonu
Private Function UCase2(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	varText = Duzenle(varText)
	If UCase(GlobalConfig("site_lang")) = "TR" Then
		varText = Replace(varText, Chr(105), ChrW(304), 1, -1, 0) ' i to İ
		varText = Replace(varText, ChrW(305), Chr(73), 1, -1, 0) ' ı to I
	End If
		varText = UCase(varText)
		varText = Temizle(varText, -1)
		varText = Replace(varText, "DOMAİN", "DOMAIN", 1, -1, 0)
		varText = Replace(varText, "HOSTİNG", "HOSTING", 1, -1, 0)
		varText = Replace(varText, "ACTİVE", "ACTIVE", 1, -1, 0)
		varText = Replace(varText, "DESİGN", "DESIGN", 1, -1, 0)
		varText = Replace(varText, "ANTİVİRUS", "ANTIVIRUS", 1, -1, 0)
		varText = Replace(varText, "ANTİ", "ANTI", 1, -1, 0)
		varText = Replace(varText, "VİRUS", "VIRUS", 1, -1, 0)
		varText = Replace(varText, "MAİL", "MAIL", 1, -1, 0)
		varText = Replace(varText, "FİLE", "FILE", 1, -1, 0)
		varText = Replace(varText, "FİREWALL", "FIREWALL", 1, -1, 0)
		varText = Replace(varText, "İNTERNET", "INTERNET", 1, -1, 0)
		varText = Replace(varText, "İNTRANET", "INTRANET", 1, -1, 0)
		varText = Replace(varText, "PRİNT", "PRINT", 1, -1, 0)
		varText = Replace(varText, "SİTE", "SITE", 1, -1, 0)
		varText = Replace(varText, "WİRELESS", "WIRELESS", 1, -1, 0)
	UCase2 = varText
End Function
'Clearfix UCase2("Sayfa Yönetimi - Energy İçerik Yönetim Sistemi - &copy; 2008 - 2011")







'// Tümünü Küçük Harf Yap Fonksiyonu
Private Function LCase2(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	varText = Duzenle(varText)
	If UCase(GlobalConfig("site_lang")) = "TR" Then
		varText = Replace(varText, ChrW(304), Chr(105), 1, -1, 0) ' İ to i
		varText = Replace(varText, Chr(73), ChrW(305), 1, -1, 0) ' I to ı
	End If
	varText = LCase(varText)
	varText = Temizle(varText, -1)
	varText = Replace(varText, "domaın", "domain", 1, -1, 0)
	varText = Replace(varText, "hostıng", "hosting", 1, -1, 0)
	varText = Replace(varText, "actıve", "active", 1, -1, 0)
	varText = Replace(varText, "desıgn", "design", 1, -1, 0)
	varText = Replace(varText, "antıvırus", "antivirus", 1, -1, 0)
	varText = Replace(varText, "antı", "anti", 1, -1, 0)
	varText = Replace(varText, "vırus", "virus", 1, -1, 0)
	varText = Replace(varText, "maıl", "mail", 1, -1, 0)
	varText = Replace(varText, "fıle", "file", 1, -1, 0)
	varText = Replace(varText, "fırewall", "firewall", 1, -1, 0)
	varText = Replace(varText, "ınternet", "internet", 1, -1, 0)
	varText = Replace(varText, "ıntranet", "intranet", 1, -1, 0)
	varText = Replace(varText, "prınt", "print", 1, -1, 0)
	varText = Replace(varText, "sıte", "site", 1, -1, 0)
	varText = Replace(varText, "wıreless", "wireless", 1, -1, 0)
	LCase2 = varText
End Function
'Clearfix LCase2("Sayfa Yönetimi - Energy İçerik Yönetim Sistemi - &copy; 2008 - 2011")
'Clearfix UCase2("á í ó ú Á É Í Ó Ú ñ Ñ ¿ ¡")







'// Kelimedeki İlk Harfi Büyük Yap Fonksiyonu
Private Function BasHarfBuyuk(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	Dim strVeri, strilkHarf, strKelime, item, ArrSon
	ArrSon = Join(Array("and", "or", "ve", "veya", "yada", "da", "de", "ki", "mi", "mı", "mü", "mu", "ile", "ne", "vb", "vs", "yi", "yı"), " - ")
	strVeri = Trim(Duzenle(LCase2(varText)))
	strVeri = Split(strVeri, " ")
	strKelime = ""
	For Each item in strVeri
		item = Trim(item)
		If Not item = "" Then
			strilkHarf = Left(item, 1)
			If inStr(1, ArrSon, Replace(Replace(Replace(item, "?", ""), "!", ""), ".", ""), 1) > 0 Then
				strKelime = strKelime & " " & strilkHarf & Right(item, intYap(Len(item) -1, 0))

			ElseIf inStr(1, "{}[]()&$€¨~´`#^'""%=-_/\*+.,;?!<|>0123456789", strilkHarf, 1) > 0 Or item = "jquery" Or item = "jcarousel" Then
				strKelime = strKelime & " " & Ucase2(Left(item, 2)) & Right(item, intYap(Len(item) -2, 0))

			Else

				strKelime = strKelime & " " & Ucase2(strilkHarf) & Right(item, intYap(Len(item) -1, 0))
			End If
		End If
	Next
	strKelime = Replace(strKelime, "Tl ", "TL ", 1, -1, 0)
	strKelime = Replace(strKelime, "(Tl)", "(TL)", 1, -1, 0)
	BasHarfBuyuk = Temizle(strKelime, -1)
End Function
'Clearfix BasHarfBuyuk("onlardan damı?")







'// Cümledeki İlk Harfi Büyük Yap Fonksiyonu
Private Function ilkHarfBuyuk(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	Dim strVeri, strilk, strKalan
	strVeri = Trim(varText)
	strilk = Left(strVeri, 1)
	strKalan = Right(strVeri, Len(strVeri) -1)
	ilkHarfBuyuk = Temizle(UCase2( strilk ) & LCase2(strKalan), -1)
End Function
'Clearfix ilkHarfBuyuk("sayfa yönetimi - energy içerik yönetim sistemi - &copy; 2008 - 2011")







Function isTableExists(ExcelConn, sTableName)
	Dim Cat
	Set Cat = Server.CreateObject("ADOX.Catalog")
	Set Cat.ActiveConnection = ExcelConn
	Dim Table
	For Each Table In Cat.Tables
		isTableExists = Table.Name = sTableName
		'isTableExists = LCase(Table.Name) = LCase(sTableName)
		'isTableExists = isTableExists & Table.Name & "<br>"
		If isTableExists Then Exit For
	Next
	Set Cat.ActiveConnection = Nothing
	Set Cat = Nothing
End Function
'Clearfix isTableExists(ExcelConn, "'Core Details$'")







Private Function strPost(ByVal val)
	If val = "" Then
		strPost = Request.Form( )
	Else
		strPost = Request.Form( val )
	End If
End Function
'objRs = strpost("param")

Private Function strGet(ByVal val)
	If val = "" Then
		strGet = Request.QueryString( )
	Else
		strGet = Request.QueryString( val )
	End If
End Function
'objRs = strpost("param")





'// Uzun Yazıları Kısaltma Fonksiyonu
Private Function KacKarekter(ByVal varText, ByVal strLen)
	varText = varText & ""
	If varText = "" Then Exit Function
	varText = Trim(Duzenle(ClearHtml(varText)))
	If Len(varText) > strLen Then varText = Left(varText, strLen -3) & "..."
	varText = Temizle(varText, -1)
	KacKarekter = varText
End Function








'// HTML Kodlarını Temizleme Fonksiyonu
Private Function ClearHtml(ByVal varHtml)
	varHtml = varHtml & ""
	If varHtml = "" Then Exit Function
	With New RegExp
		.Global = True
		.IgnoreCase = True
		.Pattern = "<[^>]*>"
		varHtml = .Replace(varHtml, "")
	End With
	ClearHtml = Temizle(varHtml, -1)
End Function
'Clearfix  ClearHtml("application/vnd.openxmlformats-officedocument.wordprocessingml.document")








Sub FileRemoved()
	'On Error Resume Next
	Dim objFSO, objFSOfolder, objFSOsubFolder, objFSOsubFolder2, objFSOfile, strFolder
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

	Set objFSOfolder = objFSO.GetFolder(Server.MapPath(GlobalConfig("hidden_folder") & GlobalConfig("uploadFolder") & "/" & GlobalConfig("PageUploadFolder")))
	For Each objFSOsubFolder in objFSOfolder.SubFolders
		'Response.Write objFSOsubFolder.Name & vbCrLf & "<br />"
		For Each objFSOfile in objFSOsubFolder.Files
			If Not sqlQuery("SELECT Count(*) FROM #___files WHERE resim = '"& objFSOfile.Name &"'", 0) > 0 Then
				strFolder = GlobalConfig("uploadFolder") & "/" & GlobalConfig("PageUploadFolder") & "/" & objFSOsubFolder.Name
				Response.Write strFolder & "/" & objFSOfile.Name & vbCrLf & "<br />"
				DeleteFile strFolder & "/" & objFSOfile.Name
			End If
		Next

		Set objFSOfolder = objFSO.GetFolder(Server.MapPath(GlobalConfig("hidden_folder") & GlobalConfig("uploadFolder") & "/" & GlobalConfig("PageUploadFolder") & "/" & objFSOsubFolder.Name))
		For Each objFSOsubFolder2 in objFSOfolder.SubFolders
			'Response.Write objFSOsubFolder.Name & "/" & objFSOsubFolder2.Name & vbCrLf & "<br />"
			For Each objFSOfile in objFSOsubFolder2.Files
				If Not sqlQuery("SELECT Count(*) FROM #___files WHERE resim = '"& objFSOfile.Name &"'", 0) > 0 Then
					strFolder = GlobalConfig("uploadFolder") & "/" & GlobalConfig("PageUploadFolder") & "/" & objFSOsubFolder.Name & "/" & objFSOsubFolder2.Name
					Response.Write strFolder & "/" & objFSOfile.Name & vbCrLf & "<br />"
					Response.Write vbCrLf & vbCrLf & "<br />" & "<br />"
					DeleteFile strFolder & "/" & objFSOfile.Name
				End If
			Next
		Next
	Next
	On Error Goto 0
End Sub


Private Function FolderKontrol(ByVal varPath)
	varPath = varPath & ""
	If varPath = "" Then Exit Function
	varPath = Server.MapPath(GlobalConfig("hidden_folder") & varPath)
	FolderKontrol = Server.CreateObject("Scripting.FileSystemObject").FolderExists(varPath) ' True veya False Döndürür
End Function
'If FolderKontrol("/images/") Then Response.Write("/images/")
'Clearfix FolderKontrol("/images/")






Private Function FilesKontrol(ByVal varPath)
	varPath = varPath & ""
	If varPath = "" Then Exit Function
	varPath = Server.MapPath(GlobalConfig("hidden_folder") & varPath)
	FilesKontrol = Server.CreateObject("Scripting.FileSystemObject").FileExists(varPath)
End Function
'If FilesKontrol("/images/ali_veli.jpg") Then Response.Write("<img src=""/images/ali_veli.jpg"" />")
'Clearfix FilesKontrol("/upload/sayfa/s_57219/thumb/web-yazilim-20110918-062845.jpg")








'// Dosya Oluşturma Fonksiyonu
Private Sub CreateFile(ByVal varPath, ByVal varText)
	varPath = varPath & ""
	If varPath = "" Then Exit Sub
	varPath = Server.MapPath(GlobalConfig("hidden_folder") & varPath)
	With Server.CreateObject("Scripting.FileSystemObject")
		'If .FileExists(varPath) Then Exit Sub
		.CreateTextFile varPath
		.OpenTextFile(varPath, 2, 0).Write varText
	End With
End Sub
'CreateFile "/asss.html", "Ferdi Tarakcı"







'// Klasör Oluşturma Fonksiyonu
Private Sub CreateFolder(ByVal varPath)
	varPath = varPath & ""
	If varPath = "" Then Exit Sub
	varPath = Server.MapPath(GlobalConfig("hidden_folder") & varPath)
	With Server.CreateObject("Scripting.FileSystemObject")
		If .FolderExists(varPath) Then Exit Sub
		.CreateFolder(varPath)
	End With
End Sub
'Call CreateFolder("/upload/")





'// Dosya Silme Fonksiyonu
Private Sub DeleteFile(ByVal varPath)
	varPath = varPath & ""
	If varPath = "" Then Exit Sub
	varPath = Server.MapPath(GlobalConfig("hidden_folder") & varPath)
	With Server.CreateObject("Scripting.FileSystemObject")
		If Not .FileExists(varPath) Then Exit Sub
		.DeleteFile(varPath)

		'Set getFolder = .GetFolder(Server.MapPath("test"))
		'getFolder.Move(Server.MapPath("asp/test"))
		'Set getFolder = Nothing

	End With
End Sub
'Call DeleteFile("../upload/urun/product_23/p_23_C9ova.JPG")






'// Klasör Silme Fonksiyonu
Private Sub DeleteFolder(ByVal varPath)
	varPath = varPath & ""
	If varPath = "" Then Exit Sub
	varPath = Server.MapPath(GlobalConfig("hidden_folder") & varPath)
	With Server.CreateObject("Scripting.FileSystemObject")
		If Not .FolderExists(varPath) Then Exit Sub
		.DeleteFolder(varPath)
	End With
End Sub
'Call DeleteFolder("../upload/urun/product_25")








Private Function iPath(ByVal iDelete)
	Dim str_Path, iCount
	'str_Path = Request.ServerVariables("REQUEST_URI")

	'If Not str_Path <> "" Then _
	'	str_Path = Request.ServerVariables("HTTP_X_ORIGINAL_URL")

	'If Not str_Path <> "" Then _
		str_Path = Replace(Request.ServerVariables("PATH_INFO"), GlobalConfig("hidden_folder"), "")

	iCount = inStrRev(str_Path, "/")
	iPath = Left(str_Path, iCount)
	If iDelete <> "" Then iPath = Replace(iPath, iDelete, "", 1, -1, 1)
End Function








'// Arama İçin Türkçe Karekter Fonksiyonu
'Private Function KucukBuyuk(ByVal strSorgu)
'	If (dataBaseName = "MsACCESS") Then
'		'strSorgu = Replace(strSorgu, Chr(253), "%", 1, -1, 1) 'Küçük ı
'		'strSorgu = Replace(strSorgu, Chr(105), "%", 1, -1, 1) 'Küçük i
'		'strSorgu = Replace(strSorgu, Chr(73), "%", 1, -1, 1) 'Büyük I
'		'strSorgu = Replace(strSorgu, Chr(221), "%", 1, -1, 1) 'Büyük İ
'		strSorgu = Replace(strSorgu, Chr(253), "_", 1, -1, 1) 'Küçük ı
'		strSorgu = Replace(strSorgu, Chr(105), "_", 1, -1, 1) 'Küçük i
'		strSorgu = Replace(strSorgu, Chr(73), "_", 1, -1, 1) 'Büyük I
'		strSorgu = Replace(strSorgu, Chr(221), "_", 1, -1, 1) 'Büyük İ
'	End If
'	KucukBuyuk = strSorgu
'End Function








'// Alt Satıra Geçme Fonksiyonu HTML
Private Function TextBR(ByVal Str)
	Str = Str & ""
	If Str = "" Then Exit Function
	Str = Replace(Str, vbCrLf, " <br />")
	Str = Replace(Str, "{ENERGYBR}", " <br />")
	Str = Replace(Str, "&amp;lt;br&amp;gt;", " <br />")
	Str = Replace(Str, "&lt;br&gt;", " <br />")
	Str = Replace(Str, "&amp;lt;br /&amp;gt;", " <br />")
	Str = Replace(Str, "&lt;br /&gt;", " <br />")
	Str = Replace(Str, "\n", " <br />")
	Str = Replace(Str, "%0A", " <br />")
	TextBR = Str
End Function








'// Alt Satıra Geçme Fonksiyonu
Private Function TextNewLine(ByVal Str)
	If Str = "" Then Exit Function
	Str = Replace(Str, "<br>", vbCrLf)
	Str = Replace(Str, "<br />", vbCrLf)
	TextNewLine = Str
End Function







'// Domain Kontrolü Fonksiyonu
Private Function isValidDomain(ByVal strDomain)
	With New RegExp
		.Pattern = "^(([a-z0-9.-]+\.)+[a-z0-9.-]{2,4})$"
		isValidDomain = .Test(strDomain)
	End With
End Function
'Clearfix isValidDomain("webdizayni.orgssss")







'// E-Mail Adresi Kontrolü Fonksiyonu
Private Function isValidEMail(ByVal strMail)
	With New RegExp
		.IgnoreCase = True
		'.Pattern = "^([\w\d\-.]+)@{1}(([\w\d\-]{1,67})|([\w\d\-]+\.[\w\d\-]{1,67}))\.(([a-zA-Z\d]{2,4})(\.[a-zA-Z\d]{2})?)$"
		.Pattern = "^([a-z0-9._-]+@([a-z0-9.-]+\.)+[a-z0-9.-]{2,4})$"
		isValidEMail = .Test(strMail)
	End With
End Function







'// E-Mail Adresi Kontrolü Fonksiyonu
Private Function isValidUserName(ByVal strUser)
	With New RegExp
		.IgnoreCase = True
		'.Pattern = "^([\w\d\-.]+)@{1}(([\w\d\-]{1,67})|([\w\d\-]+\.[\w\d\-]{1,67}))\.(([a-zA-Z\d]{2,4})(\.[a-zA-Z\d]{2})?)$"
		.Pattern = "^([a-z0-9._-]{4,16})$"
		isValidUserName = .Test(strUser)
	End With
End Function
'Response.write isValidUserName("adminfff, ")







'// Tarih Format Fonksiyonu
Private Function TarihFormatla(ByVal iDate)
	If Not isDate(iDate) Then Exit Function
	Dim blnSaat, Gunler, Aylar, Saniye, Dakika, Saat, Gun, Gun_Adi, Ay, Yil

	blnSaat = True
	Gunler = Array("", "Pazar", "Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi")
	Aylar = Array("", "Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık")

	Gun = Day(iDate) : Gun_Adi = Weekday(iDate) : Ay = Month(iDate) : Yil = Year(iDate)

	Saniye = Second(iDate) : Dakika = Minute(iDate) : Saat = Hour(iDate)

	If Ay < 10 Then Ay = "0" & Ay
	If Gun < 10 Then Gun = "0" & Gun
	If Saat < 10 Then Saat = "0" & Saat
	If Dakika < 10 Then Dakika = "0" & Dakika
	If Saniye < 10 Then Saniye = "0" & Saniye

	'// Tarihte Saat Yoksa Saat Kısmı Kaldırılıyor
	If Saniye = "00" And Dakika = "00" And Saat = "00" Then blnSaat = False

	TarihFormatla = Gun & " " & Aylar(Ay) & " " & Yil & " " & Gunler(Gun_Adi)

	If blnSaat Then TarihFormatla = TarihFormatla & ", " & Saat & ":" & Dakika '& ":" & Saniye
End Function
'Clearfix TarihFormatla(Now())






Private Function TarihFormatla2(ByVal iDate)
	If Not isDate(iDate) Then Exit Function
	Dim Saniye
	Saniye = Second(iDate) : If Saniye < 10 Then Saniye = "0" & Saniye
	TarihFormatla2 = TarihFormatla(iDate) & ":" & Saniye & " +0000"
End Function






'// Veri İçindeki Linkleri Tıklanabilir Hale Getiren Fonksiyon
'Private Function LinkURLs(ByVal asContent)
'	Dim Rgxpxp
'	If isNull(asContent) Or isEmpty(asContent) Or asContent = "" Then Exit Function
'		Set Rgxpxp = New RegExp
'			Rgxpxp.Global = True
'			Rgxpxp.IgnoreCase = True
'			Rgxpxp.Pattern = "((((ht|f)tps?://)|www\.)\S+[^\.*](\s)?)"
'			LinkURLs = Rgxpxp.Replace(asContent, "<a href=""$1"" title=""$1"" target=""_blank"">$1</a>")
'			'LinkURLs = Replace(LinkURLs, "href=""www.""", "href=""http://www.""", 1, -1, 1)
'			Rgxpxp.Pattern = "(\S+@\S+.\.\S\S\S?)"
'			'Rgxpxp.Pattern = "^([a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,4})$"
'			LinkURLs = Rgxpxp.Replace(LinkURLs, "<a href=""mailto:$1"" title=""$1"">$1</a>")
'		Set Rgxpxp = Nothing
'End Function
'Clearfix LinkURLs("deneme deneme http://www.webtasarimx.net ftp://webdizayni.org deneme ferdi@webdiayni.org")







'// Rastgele ŞIfre Üretme Fonksiyonu
Private Function SifreUret(ByVal Uzunluk)
	Dim strCharSet, strCharSetLen, RandomCode, intCharLength, say
	strCharSet = "0123456789abcdefghijklmnoprqstuvyzABCDEFGHIJKLMNOPRQSTUVYZ"
	strCharSetLen = Len(strCharSet)
	Randomize()
	RandomCode = ""
	For say = 1 To Uzunluk
		intCharLength = intYap((strCharSetLen * Rnd) + 1, 1)
		RandomCode = RandomCode & Mid(strCharSet, intCharLength, 1)
	Next
	SifreUret = RandomCode

End Function
'Clearfix SifreUret(100)






Private Sub iller(ByVal ilid)
	Dim objSubRs, strSelected, strOptionWrite, strSelectedNone
	strOptionWrite = ""
	ilid = intYap(ilid, 0)

	Set objSubRs = setExecute("SELECT il_id, il_ad FROM #___iller ORDER BY il_id ASC;")
		While Not objSubRs.Eof
			strOptionWrite = strOptionWrite & "<option"& eSelected(ilid = Cdbl(objSubRs("il_id"))) &" value="""& objSubRs("il_id") &""">"& Cstr(objSubRs("il_ad")) &"</option>" & vbCrLf
		objSubRs.MoveNext() : Wend
	Set objSubRs = Nothing

	If inStr(1, strOptionWrite, "selected=""selected""") = 0 Then strSelectedNone = " selected=""selected"""
	strOptionWrite = "<option"& strSelectedNone &" value="""">Seçiniz</option>" & vbCrLf & strOptionWrite
	Response.Write( strOptionWrite )
	strOptionWrite = ""
End Sub


Private Sub ilceler(ByVal ilid, ByVal ilceid)
	Dim objSubRs, strSelected, strOptionWrite, strSelectedNone
	strOptionWrite = ""
	ilid = intYap(ilid, 0)
	ilceid = intYap(ilceid, 0)

	Set objSubRs = setExecute("SELECT ilce_id, ilce_ad FROM #___ilceler WHERE il_id = "& ilid &" ORDER BY ilce_ad ASC;")
		While Not objSubRs.Eof
			strOptionWrite = strOptionWrite & "<option"& eSelected(ilceid = objSubRs("ilce_id")) &" value="""& objSubRs("ilce_id") &""">"& objSubRs("ilce_ad") &"</option>" & vbCrLf
		objSubRs.MoveNext() : Wend
	Set objSubRs = Nothing

	If inStr(1, strOptionWrite, "selected=""selected""") = 0 Then strSelectedNone = " selected=""selected"""
	strOptionWrite = "<option"& strSelectedNone &" value="""">Seçiniz</option>" & vbCrLf & strOptionWrite
	Response.Write( strOptionWrite )
	strOptionWrite = ""
End Sub



Private Sub Semtler(ByVal ilceid, ByVal semtid)
	Dim objSubRs, strSelected, strOptionWrite, strSelectedNone
	strOptionWrite = ""
	ilceid = intYap(ilceid, 0)
	semtid = intYap(semtid, 0)

	Set objSubRs = setExecute("SELECT semt_id, semt_ad FROM #___semtler WHERE ilce_id = "& ilceid &" ORDER BY semt_ad ASC;")
		While Not objSubRs.Eof
			strOptionWrite = strOptionWrite & "<option"& eSelected(ilceid = objSubRs("semt_id")) &" value="""& objSubRs("semt_id") &""">"& objSubRs("semt_ad") &"</option>" & vbCrLf
		objSubRs.MoveNext() : Wend
	Set objSubRs = Nothing

	If inStr(1, strOptionWrite, "selected=""selected""") = 0 Then strSelectedNone = " selected=""selected"""
	strOptionWrite = "<option"& strSelectedNone &" value="""">Seçiniz</option>" & vbCrLf & strOptionWrite
	Response.Write( strOptionWrite )
	strOptionWrite = ""
End Sub


'// TC No Kontrol Fonksiyonu
'Private Function TcNoKontrol(tc)
'	TcTopla = int(mid(tc,1,1)) + int(mid(tc,2,1)) + int(mid(tc,3,1)) + int(mid(tc,4,1)) + int(mid(tc,5,1)) + int(mid(tc,6,1)) + int(mid(tc,7,1)) + int(mid(tc,8,1)) + int(mid(tc,9,1)) + int(mid(tc,10,1))
'	If Right(TcTopla,1) = Mid(tc,11,1) Then
'		TcNoKontrol = True
'	Else
'		TcNoKontrol = False
'	End If
	'Response.Write(TcNoKontrol(17111774638))
'End Function


Private Function eSelected(ByVal ifKosul)
	eSelected = "" : If ifKosul Then eSelected = " selected=""selected"""
End Function

Private Function eDisabled(ByVal ifKosul)
	eDisabled = "" : If ifKosul Then eDisabled = " disabled=""disabled"""
End Function

Private Function eChecked(ByVal ifKosul)
	eChecked = "" : If ifKosul Then eChecked = " checked=""checked"""
End Function

Private Function eReadonly(ByVal ifKosul)
	eReadonly = "" : If ifKosul Then eReadonly = " readonly=""readonly"""
End Function


'Clearfix NumberSortDesc(Array(502, 101, 84, 31, 160, 87, 01, 99, 19990, 08, 201, 110, 81, 1, 8))
Private Function NumberSortDesc(ByVal arrSayi)
	If Not isArray(arrSayi) Then NumberSortDesc = arrSayi : Exit Function
	Dim yedek, say, say2
	Dim Boyut : Boyut = Ubound(arrSayi)
	For say = 0 To Boyut
		For say2 = 0 To Boyut
			If (arrSayi(say) > arrSayi(say2)) Then
				yedek = arrSayi(say2)
				arrSayi(say2) = arrSayi(say)
				arrSayi(say) = yedek
			End If
		Next
	Next
	For say = 0 To Boyut
		NumberSortDesc = NumberSortDesc &  arrSayi(say) & "<br>"
	Next
End Function



'Clearfix NumberSortAsc(Array(502, 101, 84, 31, 160, 87, 01, 99, 19990, 08, 201, 110, 81, 1, 8))
Private Function NumberSortAsc(ByVal arrSayi)
	If Not isArray(arrSayi) Then NumberSortAsc = arrSayi : Exit Function
	Dim yedek, say, say2
	Dim Boyut : Boyut = Ubound(arrSayi)
	For say = 0 To Boyut
		For say2 = 0 To Boyut
			If (arrSayi(say) < arrSayi(say2)) Then
				yedek = arrSayi(say2)
				arrSayi(say2) = arrSayi(say)
				arrSayi(say) = yedek
			End If
		Next
	Next
	For say = 0 To Boyut
		NumberSortAsc = NumberSortAsc &  arrSayi(say) & "<br>"
	Next
End Function





'Private Sub ThumbImage()
'	Dim imgPath, intWidth, intHeight, objRs, Jpeg
'	imgPath = GlobalConfig("sRoot") & "images/blank.gif"
'	intWidth  = intYap(Request.QueryString("w"), 100)
'	intHeight = intYap(Request.QueryString("h"), 100)
'	Set objRs = data.ExeCute(setQuery("SELECT anaid, resim FROM #___images WHERE (id = "& GlobalConfig("request_sayfaid") &" And nerde = '"& GlobalConfig("General_Page") &"');"))
'	If Not objRs.Eof Then imgPath = sFolder(objRs("anaid"), 1) & "/" & objRs("resim")
'	Set objRs = Nothing
'
'	Set Jpeg = Server.CreateObject("Persits.Jpeg")
'	Jpeg.Open( Server.MapPath( imgPath ) )
'		If (Jpeg.OriginalWidth > intWidth or Jpeg.OriginalHeight > intHeight) Then
'			Jpeg.PreserveAspectRatio = True
'			If (Jpeg.OriginalWidth > Jpeg.OriginalHeight) Then
'				Jpeg.Width = intWidth
'				Jpeg.Height = jpeg.OriginalHeight * Jpeg.Width / Jpeg.OriginalWidth
'			Else
'				Jpeg.Height = intHeight
'				Jpeg.Width = Jpeg.OriginalWidth * Jpeg.Height / Jpeg.OriginalHeight
'			End If
'		End If
'	Jpeg.Quality = 100
'	Jpeg.SendBinary
'	Jpeg.Close : Set Jpeg = Nothing
'
'	With Response
'		'.Clear()
'		'.ContentType = "image/jpeg"
'		.CacheControl = "no-cache"
'		'.AddHeader "title", imgTitle
'		'.AddHeader "Content-Disposition", "inline; filename=ENERGY-CMS"
'		.AddHeader "Pragma", "no-cache"
'		.Expires = 0
'		'.Flush()
'		'.End()
'	End With
'
'Clearfix imgPath
'
'End Sub


Private Function Search(ByVal strAranan, ByVal strText)
	strAranan = strAranan & "" : strText = strText & ""
	If strAranan = "" Or strText = "" Then Exit Function
	strAranan = TrimFix( strAranan )

'	If inStr(1, strAranan, "design", 1) > 0 Or _
'	inStr(1, strAranan, "designer", 1) > 0 Then strAranan = strAranan & " tasarımcı tasarımı tasarım dizaynı dizayn"

'	If inStr(1, strAranan, "dizayn", 1) > 0 Or _
'	inStr(1, strAranan, "dizaynı", 1) > 0 Or _
'	inStr(1, strAranan, "dizayni", 1) > 0 Then strAranan = strAranan & " tasarımcı tasarımı tasarım designer design"

	If inStr(1, strAranan, "design", 1) > 0 Or _
	inStr(1, strAranan, "dizayn", 1) > 0 Or _
	inStr(1, strAranan, "dızayn", 1) > 0 Or _
	inStr(1, strAranan, "tasarım", 1) > 0 Or _
	inStr(1, strAranan, "tasarim", 1) > 0 Then strAranan = "tasarımcı tasarımı tasarım dizaynı dizayn designer design " & strAranan 

	If inStr(1, strAranan, "yazılım", 1) > 0 Or _
	inStr(1, strAranan, "yazilim", 1) > 0 Or _
	inStr(1, strAranan, "programlama", 1) > 0 Then strAranan = "yazılım programlama " & strAranan 

	strAranan = Replace(Replace(Replace(strAranan, "\", "\\"), "^", "\^"), "|", "\|")
	strAranan = Replace(Replace(strAranan, "(", "\("), ")", "\)")
	strAranan = Replace(Replace(strAranan, "[", "\["), "]", "\]")
	strAranan = Replace(Replace(strAranan, "{", "\{"), "}", "\}")
	strAranan = Replace(Replace(strAranan, ".", "\."), "+", "\+")
	strAranan = Replace(Replace(strAranan, "*", "\*"), "?", "\?")
	strAranan = Replace(Replace(strAranan, "$", "\$"), "€", "\€")
	strAranan = Replace(strAranan, " ", "|")
	strAranan = Replace(strAranan, "I", "[{ewy_qs}]", 1, -1, 0)
	strAranan = Replace(strAranan, "ı", "[{ewy_qs}]")
	strAranan = Replace(strAranan, "İ", "[{ewy_qs}]")
	strAranan = Replace(strAranan, "i", "[{ewy_qs}]", 1, -1, 0)
	strAranan = Replace(strAranan, "[{ewy_qs}]", "[ıIiİ]")

	With New RegExp
		.IgnoreCase = True
		.MultiLine = True
		.Global = True
	'	.Pattern = "\s(html|web|tasarım)\s"
	'	.Pattern = "(Yaz[ıIiİ]l[ıIiİ]m)"

		.Pattern = "(" & strAranan & ")"
		strText = .Replace(strText, "<strong class=""serach_highlight""><em>$1</em></strong>")
		'strText = Replace(strText, vbCrLf, "<br />")

		.Pattern = "(TBMM)"
		strText = .Replace(strText, "<acronym title=""Türkiye Büyük Millet Meclisi"">$1</acronym>")

		.Pattern = "(SEO)"
		strText = .Replace(strText, "<acronym title=""Search Engin Optimization"">$1</acronym>")

		.Pattern = "(HOST[ıIiİ]NG|SUNUCU)"
		strText = .Replace(strText, "<acronym title=""Web Sitesi Barındırma"">$1</acronym>")

		.Pattern = "(VBS)"
		strText = .Replace(strText, "<acronym title=""Microsoft Visual Basic Script"">$1</acronym>")

		.Pattern = "(VB)"
		strText = .Replace(strText, "<acronym title=""Microsoft Visual Basic"">$1</acronym>")

		.Pattern = "(PHP)"
		strText = .Replace(strText, "<acronym title=""Hypertext Preprocessor"">$1</acronym>")

		.Pattern = "(CSS3)"
		strText = .Replace(strText, "<acronym title=""Cascading Style Sheets 3.0"">$1</acronym>")

		.Pattern = "(CSS)"
		strText = .Replace(strText, "<acronym title=""Cascading Style Sheets"">$1</acronym>")

		.Pattern = "(JS)"
		strText = .Replace(strText, "<acronym title=""Javascript"">$1</acronym>")

		.Pattern = "(XHTML)"
		strText = .Replace(strText, "<acronym title=""Extensible HyperText Markup Language"">$1</acronym>")

		.Pattern = "(HTML|HTM)"
		strText = .Replace(strText, "<acronym title=""Hypertext Markup Language"">$1</acronym>")

		.Pattern = "(CMS)"
		Search = .Replace(strText, "<acronym title=""Content Management System"">$1</acronym>")
	End With

	Search = TrimFix(strText)
End Function
'Clearfix Search("DINAMIK WEB SAYFASİ", "html Dinamik web sayfası " & vbCrLf & "Asp diğer adıyla <strong>&ldquo;İçerik Yönetim Sistemi&rdquo;</strong> ingilizcesi")






Private Function ReplaceHR(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	With New RegExp
		.IgnoreCase = True
		.MultiLine = True
		.Global = True
		.Pattern = "<hr[\s\S]*?id=""?'?readmore""?'?[\s\S]*?/>"
		varText = .Replace(varText, "")
	End With
	ReplaceHR = TrimFix(varText)
End Function
'Clearfix ReplaceHR(aaaaa sdffg hfg hf  fg hfg <hr id='readmore' /> fg hfg fg hfg)






Private Function PageBreakReplace(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	With New RegExp
		.IgnoreCase = True
		.MultiLine = True
		.Global = True
		.Pattern = "<hr[\s\S]*?class=""?'?system-pagebreak""?'?[\s\S]*?/>"
		varText = .Replace(varText, "")
	End With
	PageBreakReplace = TrimFix(varText)
End Function
'Clearfix PageBreakReplace("aaaaa sdffg hfg hf  fg hfg <hr class='system-pagebreak' /> fg hfg <hr title=""tyhhgh"" class=""system-pagebreak"" /> fg hfg <hr class=""system-pagebreak"" title=""yy"" />")






Function BinaryToString(ByVal Binary)
	Dim cl1, cl2, cl3, pl1, pl2, pl3, L
	cl1 = 1 : cl2 = 1 : cl3 = 1 : L = LenB(Binary)
	Do While cl1 <= L
		pl3 = pl3 & Chr(AscB(MidB(Binary, cl1, 1)))
		cl1 = cl1 + 1 : cl3 = cl3 + 1
		If cl3 > 300 Then
			pl2 = pl2 & pl3
			pl3 = ""
			cl3 = 1
			cl2 = cl2 + 1
			If cl2 > 200 Then
				pl1 = pl1 & pl2
				pl2 = ""
				cl2 = 1
			End If
		End If
	Loop
	BinaryToString = pl1 & pl2 & pl3
End Function

'clearfix BinaryToString(GETHTTP("http://www.r10.net/index.php"))

'// XmlHttp Fonksiyonu
Function GETHTTP(ByVal strUrl)
	strUrl = strUrl & ""
	If strUrl = "" Then Exit Function
	On Error Resume Next
	With Server.CreateObject("Microsoft.XMLHTTP") 'MSXML2.XMLHTTP.3.0
		.Open "GET", strUrl, False
		If Err <> 0 Then
			Response.Write("Bir Hata Oluştu: "& Err.Description)
			On Error GoTo 0
		Else
			.Send
			GETHTTP = .ResponseBody
		End If
	End With
End Function




'// Kur Hesaplama Fonksiyonu
Function FiyatCevir(ByVal Birim, ByVal strFiyat, ByVal Kdv)
	strFiyat = strFiyat & ""

	If strFiyat = "" Then Exit Function
	
	strFiyat = Cdbl(strFiyat)

	Dim TcmbDovizCek
	If Not Birim = "TL" Then TcmbDovizCek = GETHTTP("http://www.tcmb.gov.tr/kurlar/today.html")

	Dim GetStart, GetDoviz, strKdvDahil

	Select Case Birim
		Case "USD" '// Dolar
			GetStart   = inStr(1,TcmbDovizCek, "USD")
			GetDoviz  = Clng(Mid(TcmbDovizCek, GetStart + 42, 6))
			strFiyat  = FormatNumber((strFiyat * GetDoviz), 0) / 10000
			strKdvDahil = ((strFiyat + strFiyat) * Kdv) / 100

		Case "EUR" '// Euro
			GetStart    = inStr(1,TcmbDovizCek, "EUR")
			GetDoviz  = Clng(Mid(TcmbDovizCek, GetStart + 42, 6))
			strFiyat  = FormatNumber((strFiyat * GetDoviz), 0) / 10000
			strKdvDahil = ((strFiyat + strFiyat) * Kdv) / 100

		Case "GBP" '// Sterlin
			GetStart    = inStr(1,TcmbDovizCek, "GBP")
			GetDoviz  = Clng(Mid(TcmbDovizCek, GetStart + 37, 6))
			strFiyat  = FormatNumber((strFiyat * GetDoviz), 0) / 10000
			strKdvDahil = ((strFiyat + strFiyat) * Kdv) / 100

		Case "TL" ' Türk lirası
			'strFiyat  = strFiyat
			'strKdvDahil = ((strFiyat + strFiyat) * Kdv) / 100
			strKdvDahil = strFiyat *  Cdbl("1." & Kdv)
			strKdvDahil = Clong(strKdvDahil)
	End Select

	FiyatCevir = strKdvDahil
	'FiyatCevir = FormatNumber(GetDoviz, 2)
	'If Kdv Then FiyatCevir = FormatNumber(strKdvDahil, 2)
End Function
'Clearfix FiyatCevir("TL", "132,45", "18")






Function Reklendir(ByVal o)
	'// YÜZDE RENK SEÇİCİ
	If o >= 0 And o <= 20 Then
		Reklendir = "ff0000"
	ElseIf o >= 21 And o <= 40 Then
		Reklendir = "ffd800"
	ElseIf o >= 41 And o <= 60 Then
		Reklendir = "ba00ff"
	ElseIf o >= 61 And o <= 80 Then
		Reklendir = "009cff"
	ElseIf o >= 81 And o <= 100 Then
		Reklendir = "76cb24"
	Else
		Reklendir = "ffffff"
	End If
End Function








'Response.End
'Response.Write DateDiff("s",DateSerial(1970,1,1),Now())
'Response.Write TarihSQLFormat(Now(), True)



%>
