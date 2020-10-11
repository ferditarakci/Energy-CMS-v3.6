<%
'// Permalink Fonksiyonu
Private Function SefUrl(ByVal oMe)
	oMe = oMe & ""
	If oMe = "" Then Exit Function

	oMe = TrimFix(oMe)

	If LCase(Left(oMe, 4)) = "url=" Then
		oMe = URLEncode( oMe )
		SefUrl = Temizle(oMe, 1)
		Exit Function
	End If

	If GlobalConfig("site_lang") = "TR" Then
		oMe = Replace(oMe, "&amp;", " ve ")
		oMe = Replace(oMe, "&", " ve ")
	Else
		oMe = Replace(oMe, "&amp;", " and ")
		oMe = Replace(oMe, "&", " and ")
	End If

	Dim AsciiArr, intCounter
	AsciiArr = Array("!", """", "#", "$", "%25", "%", "&", "'", "(", ")", "*", "+", ",", ".", "/", ":", ";", "<", "=", ">", "?", "@", "[", "\", "]", "^", "`", "{", "|", "}", "~", "¡", "£", "©", "«", "®", "°", "»", "¿", "·", "¸", "´", "¶", "±", Chr(127), vbTab, vbCrLf)

	For intCounter = 0 To UBound(AsciiArr)
		oMe = Replace(oMe, AsciiArr(intCounter), "-")
	Next

	Dim UnicodeArr, latinArr
	UnicodeArr = Array(" ", "ª", "à", "á", "â", "ã", "ä", "å", "æ", "ç", "è", "é", "ê", "ë", _
		"ì", "í", "î", "ï", "ð", "ñ", "º", "ò", "ó", "ô", "õ", "ö", "ø", _
		"ù", "ú", "û", "ü", "ý", "þ", "ß")

	latinArr = Array("-", "a", "a", "a", "a", "a", "a", "a", "ae", "c", "e", "e", "e", "e", _
		"i", "i", "i", "i", "d", "n", "o", "o", "o", "o", "o", "o", "o", _
		"u", "u", "u", "u", "y", "th", "s")

	For intCounter = 0 To UBound(UnicodeArr)
		oMe = Replace(oMe, UnicodeArr(intCounter), latinArr(intCounter))
	Next

	oMe = URLDecode(Duzenle(LCase2(oMe)))


	oMe = Replace(oMe, Chr(39), "")
	oMe = Replace(oMe, ChrW(775), "")
	oMe = Replace(oMe, ChrW(775), Chr(105))
	oMe = Replace(oMe, Chr(231), "c", 1, -1, 1)
	oMe = Replace(oMe, Chr(240), "g", 1, -1, 1)
	oMe = Replace(oMe, Chr(221), "i", 1, -1, 1)
	oMe = Replace(oMe, Chr(253), "i", 1, -1, 1)
	oMe = Replace(oMe, Chr(246), "o", 1, -1, 1)
	oMe = Replace(oMe, Chr(254), "s", 1, -1, 1)
	oMe = Replace(oMe, Chr(252), "u", 1, -1, 1)
	oMe = Replace(oMe, Chr(226), "a", 1, -1, 0)  ' â
	oMe = Replace(oMe, Chr(194), "a", 1, -1, 0)  ' Â
	oMe = Replace(oMe, Chr(202), "e", 1, -1, 0)  ' Ê
	oMe = Replace(oMe, Chr(234), "e", 1, -1, 0)  ' ê
	oMe = URLEncode( oMe )
	oMe = Replace(oMe, "%23", "-")
	'oMe = Replace(oMe, "%20", "-")

	Dim oRg
	Set oRg = New RegExp
		With oRg
			.IgnoreCase = True
			.Global = True
			.Pattern = "&(.*?);"
			oMe = .Replace(oMe, "-")
			.Pattern = "([^a-z0-9%])"
			oMe = .Replace(oMe, "-")
			.Pattern = "([\-]{2,})"
			oMe = .Replace(oMe, "-")
		End With
	Set oRg = Nothing

	If Left(oMe, 1) = "-" Then oMe = Right(oMe, Len(oMe) -1)
	If Right(oMe, 1) = "-" Then oMe = Left(oMe, Len(oMe) -1)

	SefUrl = Temizle(oMe, 1)
End Function
'Clearfix _
'	SefUrl("url=[base]en.wiktionary.org/w/index.php?title=العربية&amp;oldid=11644704") & " <br><br> " & _
'	SefUrl("url=http://www.webtasarimx.net/test/upload/upload.asp?task=sayfa&id=57227&admin ' "" \ \n") & " <br><br> " & _
'	SefUrl("مرحبا-بكم-في-موقع-شركة-المركبة-·-تتوفر-لدينا-قطع-غيار-السيارات-الامريكية-مرحبا-بكم-في-موقع-المركبه-للسيارت") & " <br><br> " & _
'	SefUrl("ARAMA MOTORU OPTİMİZASYONUNDA YAPILMASI GEREKENLER")








'// Seo ve Normal Link İçin Geçiş Fonksiyonu
Private Function UrlWrite(ByVal strDomain, ByVal strLangValue, ByVal strOptionValue, ByVal strTaskValue, ByVal strTitleValue, ByVal intidValue, ByVal strPageNoValue, ByVal strAnchorValue)
	Dim uWrite, strTaskName, intidName, strTitleValue2, SeoLink_id

	Select Case strOptionValue
		Case      GlobalConfig("General_Redirect"), GlobalConfig("General_Post") SeoLink_id = True
		Case Else SeoLink_id = False
	End Select

	strLangValue = LCase(strLangValue)

	intidValue = intYap(intidValue, 0)

	If strTitleValue <> "" Then strTitleValue = SefUrl(strTitleValue)

	If Not strPageNoValue = "true" Then strPageNoValue = intYap(strPageNoValue, 0)

	If intidValue > 0 Then
		strTitleValue2 = EnergyURLKontrol(0, strOptionValue, intidValue, strLangValue)
		If strTitleValue2 <> "#" Then strTitleValue = strTitleValue2 Else UrlWrite = "javascript:;" : Exit Function
	End If

	If LCase(Left(strTitleValue, 4)) = "url=" Then
		UrlWrite = Replace(strTitleValue, "url=", "")
		UrlWrite = Replace(UrlWrite, "[base]", GlobalConfig("sBase"))
		UrlWrite = Replace(UrlWrite, "[root]", GlobalConfig("sRoot"))
		Exit Function
	End If

	If LCase(GlobalConfig("default_lang")) = strLangValue Then strLangValue = ""

	strTitleValue = Replace(strTitleValue, "-ee-nn-ee-rr-gg-yy-", "/")
	'strTitleValue = SefUrl( strTitleValue )

	uWrite = ""

	If strOptionValue = GlobalConfig("General_Home") And Not GlobalConfig("General_introPage") Then strOptionValue = ""
	If strOptionValue = GlobalConfig("General_Whois") Or strOptionValue = GlobalConfig("General_Whois2") Then strTaskValue = Replace(strTaskValue, ".", "_")
	If strOptionValue = GlobalConfig("General_Search") Then strTaskValue = Replace(Replace(Replace(Replace(Replace(Replace(Replace(LCase2(TrimFix(strTaskValue)), " ", "+"), "++", "+"), "++", "+"), "++", "+"), "++", "+"), "++", "+"), "++", "+")

	If GlobalConfig("seo_url") Then '// For Sef Link

		If strLangValue <> "" Then uWrite = uWrite & strLangValue

		If Not strOptionValue = GlobalConfig("General_Page") Then 
			If uWrite <> "" Then uWrite = uWrite & "/"
			If strOptionValue <> "" Then uWrite = uWrite & strOptionValue
		End If

		If strOptionValue = GlobalConfig("General_Sitemap") Then
			uWrite = uWrite & ".xml"
		End If

		If uWrite <> "" And strTaskValue <> "" Then uWrite = uWrite & "/"
		If strTaskValue <> "" Then uWrite = uWrite & strTaskValue

		If uWrite <> "" And strTitleValue <> "" Then uWrite = uWrite & "/"
		If strTitleValue <> "" Then uWrite = uWrite & strTitleValue

		If Not strPageNoValue = "true" Then 
			If uWrite <> "" And strPageNoValue > 1 Then uWrite = uWrite & "_"
			If strPageNoValue > 1 Then uWrite = uWrite & strPageNoValue
		Else
			If uWrite <> "" And strPageNoValue = "true" Then uWrite = uWrite & "_ewy-all-page"
			'If strPageNoValue = "true" Then uWrite = uWrite & strPageNoValue
		End If

		If uWrite <> "" And SeoLink_id And intidValue > 0 Then uWrite = uWrite & "/"
		If SeoLink_id And intidValue > 0 Then uWrite = uWrite & intidValue

		'If Not ( _
		'	strOptionValue = "" Or _
		'	strOptionValue = GlobalConfig("General_Sitemap") Or _
		'	strOptionValue = GlobalConfig("General_Whois") Or _
		'	strOptionValue = GlobalConfig("General_Whois2") Or _
		'	strOptionValue = "javascript:;" Or _
		'	strOptionValue = "#" _
		') Then
		'uWrite = uWrite & LinkSonlandirici

		If Not strOptionValue = GlobalConfig("General_Sitemap") Then
			uWrite = uWrite & LinkSonlandirici
		End If

	Else '// For Not Sef Link

		Select Case strOptionValue
			Case GlobalConfig("General_Page")
				strTaskName = ""
				intidName = ewy_queryid

			Case GlobalConfig("General_Categories")
				strTaskName = ""
				intidName = ewy_queryid

			Case GlobalConfig("General_Products")
				strTaskName = ""
				intidName = ewy_queryid

			Case GlobalConfig("General_Search")
				strTaskName = ewy_querySearch

			Case GlobalConfig("General_Redirect"), GlobalConfig("General_Post")
				strTaskName = ewy_queryTask
				intidName = ewy_queryid

			Case GlobalConfig("General_Sitemap")
				strTaskName = "" : strTaskValue = ""

			Case GlobalConfig("General_Whois"), GlobalConfig("General_Whois2")
				strTaskName = ewy_queryDomain

			Case Else
				strTaskName = ewy_queryTask
				intidName = ewy_queryid
		End Select

		If strLangValue <> "" Then uWrite = uWrite & ewy_queryLang & "=" & strLangValue

		If Not strOptionValue = GlobalConfig("General_Page") Then 
			If uWrite <> "" And strOptionValue <> "" Then uWrite = uWrite & "&amp;"
			If strOptionValue <> "" Then uWrite = uWrite & ewy_queryOption & "=" & strOptionValue
		End If

		If uWrite <> "" And strTaskValue <> "" Then uWrite = uWrite & "&amp;"
		If strTaskValue <> "" Then uWrite = uWrite & strTaskName & "=" & strTaskValue

		If uWrite <> "" And strTitleValue <> "" Then uWrite = uWrite & "&amp;"
		If strTitleValue <> "" Then uWrite = uWrite & ewy_queryTitle & "=" & strTitleValue

		If uWrite <> "" And SeoLink_id And intidValue > 0 Then uWrite = uWrite & "&amp;"
		If SeoLink_id And intidValue > 0 Then uWrite = uWrite & intidName &"="& intidValue

		'If uWrite <> "" And strPageNoValue > 1 Then uWrite = uWrite & "&amp;"
		'If strPageNoValue > 1 Then uWrite = uWrite & "start=" & strPageNoValue

		If Not strPageNoValue = "true" Then
			If uWrite <> "" And strPageNoValue > 1 Then uWrite = uWrite & "&amp;"
			If strPageNoValue > 1 Then uWrite = uWrite & ewy_queryStart & "=" & strPageNoValue
		Else
			If uWrite <> "" And strPageNoValue = "true" Then uWrite = uWrite & "&amp;"
			If strPageNoValue = "true" Then uWrite = uWrite & ewy_queryShowAll & "=" & strPageNoValue
		End If

		If uWrite <> "" Then uWrite = "?" & uWrite
		If uWrite <> "" Then uWrite = "index.asp" & uWrite
	End If

	'If strDomain <> "" Then strDomain = Left(strDomain, Len(strDomain) -1)
	If Not strDomain = GlobalConfig("sBase") Then uWrite = GlobalConfig("sRoot") & uWrite
	uWrite = strDomain & uWrite
	uWrite = Replace(Replace(Replace(uWrite, "//", "/"), "http:/", "http://"), "https:/", "https://")

	If strAnchorValue <> "" Then uWrite = uWrite & "#" & strAnchorValue

	If uWrite = "#" Then uWrite = "javascript:;"

	UrlWrite = uWrite
End Function
'Response.Write UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), "redirect", "iletisim", "title", 0, 26, "")



'E_SeoUrl = False
'Response.Write UrlWrite("https://www.webtasarimx.net", "tr", "index", "sites", "web-tasarim-nedir", 50, 10, "ferdi") &"<br /><br />"
'Response.Write UrlWrite("http://www.webtasarimx.net", "en", "whois", "webdizayni.org", "", "", "", "")

'E_SeoUrl = True
'Response.Write UrlWrite("http://www.webtasarimx.net", "", "sayfa", "", "", 57217, 0, "") &"<br /><br />"














'Response.Write LinkYap(3)
Public Function LinkYap(ByVal iNum)
	If Request.QueryString.Count = 0 Then LinkYap = "?sayfa="& iNum : Exit Function
	LinkYap = "index.asp?"
	For Each iParam in Request.QueryString
		If iParam <> "sayfa" Then LinkYap = Linkyap & iParam &"="& Request.QueryString(iParam) & "&"
	Next
	LinkYap = Linkyap & "sayfa="& iNum
End Function

'Function UrlQuery(ByVal veri)
'	UrlQuery = Join(Filter(Split(Request.QueryString(), "&"), veri & "=", True, vbTextCompare), "&amp;")
'End Function

'// Remove
Function RequestQueryStringRemove(ByVal param, ByVal delimiter)
	If delimiter = 1 Then delimiter = "&amp;" Else delimiter = "&"
	RequestQueryStringRemove = Join(Filter(Split(Request.QueryString(), "&"), param & "=", False, vbTextCompare), delimiter)
End Function

'// Modify
Function RequestQueryStringSet(ByVal param, ByVal val, ByVal delimiter)
	Dim str : If delimiter = 1 Then delimiter = "&amp;" Else delimiter = "&"
	str = Join(Filter(Split(Request.ServerVariables("QUERY_STRiNG"), "&"), param & "=", 0, vbTextCompare), delimiter)
	If str <> "" Then str = str & delimiter & param & "=" & val
	
	RequestQueryStringSet = str
	
End Function

'Clearfix RequestQueryStringRemove("mod", 0)


Private Function EnergyURLKontrol(ByRef UstMenu, ByRef strMenuTuru, ByVal intMenuiD, ByRef strLang)
	intMenuiD = intYap(intMenuiD ,0)
	If isNull(intMenuiD) Or intMenuiD <= 0 Then Exit Function
	Dim EnergyWrite, EnergyRs, sSQL

	Select Case strMenuTuru
		'// İçerik Url Çek
		Case GlobalConfig("General_Page")

			sSQL = ""
			sSQL = sSQL & "SELECT" & vbCrLf
			sSQL = sSQL & "    IF(Left(t2.seflink, 4) = 'url=', 0, t1.anaid) As anaid, t2.seflink" & vbCrLf
			sSQL = sSQL & "FROM #___sayfa t1" & vbCrLf
			sSQL = sSQL & "INNER JOIN #___content_url t2 ON t1.id = t2.parent_id And t2.durum = 1 /*And t2.lang IN ('"& strLang &"', '"& GlobalConfig("default_lang") &"')*/" & vbCrLf
			sSQL = sSQL & "WHERE (" & vbCrLf
			If Not UstMenu = 1 Then _
			sSQL = sSQL & "    t1.activeLink = 1 And" & vbCrLf
			sSQL = sSQL & "    t1.id = "& intMenuiD &"" & vbCrLf
			sSQL = sSQL & "    And t2.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
			sSQL = sSQL & "    And t2.lang = '"& strLang &"'" & vbCrLf
			sSQL = sSQL & ")" & vbCrLf
			sSQL = sSQL & "Limit 1;"
			'Clearfix setQuery( sSQL )
			Set EnergyRs = setExecute(sSQL)
				If EnergyRs.Eof Then
					EnergyWrite = "#"
				Else
					If GlobalConfig("seo_url") And EnergyRs("anaid") > 0 Then EnergyWrite = EnergyURLKontrol(1, strMenuTuru, EnergyRs("anaid"), strLang) & "-ee-nn-ee-rr-gg-yy-"
					EnergyWrite = EnergyWrite & EnergyRs("seflink")
				End If
			Set EnergyRs = Nothing




		'// Kategori Url Çek
		Case GlobalConfig("General_Categories")

			sSQL = ""
			sSQL = sSQL & "SELECT" & vbCrLf
			sSQL = sSQL & "    IF(Left(t2.seflink, 4) = 'url=', 0, t1.anaid) As anaid, t2.seflink" & vbCrLf
			sSQL = sSQL & "FROM #___kategori t1" & vbCrLf
			sSQL = sSQL & "INNER JOIN #___content_url t2 ON t1.id = t2.parent_id And t2.durum = 1 /*And t2.lang IN ('"& strLang &"', '"& GlobalConfig("default_lang") &"')*/" & vbCrLf
			sSQL = sSQL & "WHERE (" & vbCrLf
			If Not UstMenu = 1 Then _
			sSQL = sSQL & "    t1.activeLink = 1 And" & vbCrLf
			sSQL = sSQL & "    t1.id = "& intMenuiD &"" & vbCrLf
			sSQL = sSQL & "    And t2.parent = "& GlobalConfig("General_CategoriesPN") &"" & vbCrLf
			sSQL = sSQL & "    And t2.lang = '"& strLang &"'" & vbCrLf
			sSQL = sSQL & ")" & vbCrLf
			sSQL = sSQL & "Limit 1;"
			'Clearfix setQuery( sSQL )
			Set EnergyRs = setExecute(sSQL)
				If EnergyRs.Eof Then
					EnergyWrite = "#"
				Else
					If GlobalConfig("seo_url") And EnergyRs("anaid") > 0 Then EnergyWrite = EnergyURLKontrol(1, strMenuTuru, EnergyRs("anaid"), strLang) & "-ee-nn-ee-rr-gg-yy-"
					EnergyWrite = EnergyWrite & EnergyRs("seflink")
				End If
			Set EnergyRs = Nothing




		'// Ürün Url Çek
		Case GlobalConfig("General_Products")

			sSQL = ""
			sSQL = sSQL & "SELECT" & vbCrLf
			sSQL = sSQL & "    IF(Left(t2.seflink, 4) = 'url=', 0, t1.anaid) As anaid, t2.seflink" & vbCrLf
			sSQL = sSQL & "FROM #___products t1" & vbCrLf
			sSQL = sSQL & "INNER JOIN #___content_url t2 ON t1.id = t2.parent_id And t2.durum = 1 /*And t2.lang IN ('"& strLang &"', '"& GlobalConfig("default_lang") &"')*/" & vbCrLf
			sSQL = sSQL & "WHERE (" & vbCrLf
			'If Not UstMenu = 1 Then _
			'sSQL = sSQL & "    t1.activeLink = 1 And" & vbCrLf
			sSQL = sSQL & "    t1.id = "& intMenuiD &"" & vbCrLf
			sSQL = sSQL & "    And t2.parent = "& GlobalConfig("General_ProductsPN") &"" & vbCrLf
			sSQL = sSQL & "    And t2.lang = '"& strLang &"'" & vbCrLf
			sSQL = sSQL & ")" & vbCrLf
			sSQL = sSQL & "Limit 1;"
			'Clearfix setQuery( sSQL )
			Set EnergyRs = setExecute(sSQL)
				If EnergyRs.Eof Then
					EnergyWrite = "#"
				Else
					If GlobalConfig("seo_url") And EnergyRs("anaid") > 0 Then EnergyWrite = EnergyURLKontrol(1, GlobalConfig("General_Categories"), EnergyRs("anaid"), strLang) & "-ee-nn-ee-rr-gg-yy-"
					EnergyWrite = EnergyWrite & EnergyRs("seflink")
				End If
			Set EnergyRs = Nothing



		'// Anket Url Çek
		Case GlobalConfig("General_Poll")

			sSQL = ""
			sSQL = sSQL & "SELECT" & vbCrLf
			sSQL = sSQL & "    t2.seflink" & vbCrLf
			sSQL = sSQL & "FROM #___anket t1" & vbCrLf
			sSQL = sSQL & "INNER JOIN #___content_url t2 ON t1.id = t2.parent_id And t2.durum = 1 /*And t2.lang IN ('"& strLang &"', '"& GlobalConfig("default_lang") &"')*/" & vbCrLf
			sSQL = sSQL & "WHERE (" & vbCrLf
			sSQL = sSQL & "    t1.id = "& intMenuiD &"" & vbCrLf
			sSQL = sSQL & "    And t2.parent = "& GlobalConfig("General_PollPN") &"" & vbCrLf
			sSQL = sSQL & "    And t2.lang = '"& strLang &"'" & vbCrLf
			sSQL = sSQL & ")" & vbCrLf
			sSQL = sSQL & "Limit 1;"
			'Clearfix setQuery( sSQL )
			 Set EnergyRs = setExecute(sSQL)
				If EnergyRs.Eof Then
					EnergyWrite = "#"
				Else
					EnergyWrite = EnergyRs("seflink")
				End If
			Set EnergyRs = Nothing



		'// Özel Url Çek
		Case GlobalConfig("General_CustomURL")

			sSQL = ""
			sSQL = sSQL & "SELECT" & vbCrLf
			sSQL = sSQL & "    t2.seflink" & vbCrLf
			sSQL = sSQL & "FROM #___content_menu t1" & vbCrLf
			sSQL = sSQL & "INNER JOIN #___content_url t2 ON t1.id = t2.parent_id And t2.durum = 1 /*And t2.lang IN ('"& strLang &"', '"& GlobalConfig("default_lang") &"')*/" & vbCrLf
			sSQL = sSQL & "WHERE (" & vbCrLf
			sSQL = sSQL & "    t1.id = "& intMenuiD &"" & vbCrLf
			sSQL = sSQL & "    And t2.parent = "& GlobalConfig("General_CustomURLPN") &"" & vbCrLf
			sSQL = sSQL & "    And t2.lang = '"& strLang &"'" & vbCrLf
			sSQL = sSQL & ")" & vbCrLf
			sSQL = sSQL & "Limit 1;"
			'Clearfix setQuery( sSQL )
			 Set EnergyRs = setExecute(sSQL)
				If EnergyRs.Eof Then
					EnergyWrite = "#"
				Else
					EnergyWrite = "url=" & EnergyRs("seflink")
				End If
			Set EnergyRs = Nothing

	End Select
	EnergyURLKontrol = EnergyWrite
End Function
'Clearfix EnergyURLKontrol(GlobalConfig("General_Categories"), "", 	57658, "TR")
'Clearfix UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Categories"), "", "", 57658, "", "")


'Call PingSiteMap()

Sub PingSiteMap()
	If Left(Site_LOCAL_ADDR, 7) = "192.168" Or Site_LOCAL_ADDR = "127.0.0.1" Then Exit Sub
	Dim PingSitemapUrl, sDmn
	For Each sDmn in Split(GlobalConfig("domain"), ",")
		sDmn = Trim(sDmn) 'GlobalConfig("General_Sitemap")
		PingSitemapUrl = Replace(Server.UrlEncode(UrlWrite("http://" & sDmn, "", GlobalConfig("General_Sitemap"), "sitemap.xml", "", "", "", "")), "%2E", ".")
		'Clearfix PingSitemapUrl
		Call GETHTTP("http://www.google.com/webmasters/tools/ping?sitemap=" & PingSitemapUrl)
		Call GETHTTP("http://api.moreover.com/ping?u=" & PingSitemapUrl)
		Call GETHTTP("http://submissions.ask.com/ping?sitemap=" & PingSitemapUrl)
		Call GETHTTP("http://www.bing.com/webmaster/ping.aspx?siteMap=" & PingSitemapUrl)
		Call GETHTTP("http://www.validome.org/google/validate?lang=en&googleTyp=SITEMAP&url=" & PingSitemapUrl)
	Next
End Sub
%>

