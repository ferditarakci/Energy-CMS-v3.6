<%

Private Sub TreeViewList(ByRef sqlQ, ByVal intAnaid, ByVal intLevel)
	Dim SQLs, objRs, intLevels

	SQLs = setQuery(Replace(sqlQ, "{0}", intAnaid))
	Set objRs = setExecute( SQLs )
		While Not objRs.Eof

			intLevels = 1 * intLevel

			intCurr = UBound(arrTreeView) + 1

			Redim Preserve arrTreeView(intCurr)
			arrTreeView(intCurr) = objRs.Fields("id").Value

			Redim Preserve arrSubLevel(intCurr)
			arrSubLevel(intCurr) = intLevels

			Call TreeViewList(sqlQ, Cdbl(objRs.Fields("id").Value), intLevel + 1)

		objRs.MoveNext() : Wend
	Set objRs = Nothing 
End Sub


Private Sub TreeViewList2(ByRef sqlQ, ByVal intAnaid, ByVal intLevel)
	Dim SQLs, objRs, intLevels

	SQLs = setQuery(Replace(sqlQ, "{0}", intAnaid))
	Set objRs = setExecute( SQLs )
		While Not objRs.Eof

			intLevels = 1 * intLevel

			intCurr = UBound(arrTreeView) + 1

			Redim Preserve arrTreeView(intCurr)
			arrTreeView(intCurr) = objRs.Fields("id").Value

			Redim Preserve arrSubLevel(intCurr)
			arrSubLevel(intCurr) = intLevels

			Call TreeViewList2(sqlQ, Cdbl(objRs.Fields("id").Value), intLevel + 1)

		objRs.MoveNext() : Wend
	Set objRs = Nothing 
End Sub




'Private Sub TreeViewPages2(ByVal intAnaid, ByVal intLevel)
'	Dim sSQL, objSubRs, spaces
'	sSQL = ""
'	sSQL = sSQL & "SELECT t1.id FROM #___sayfa t1 "
'	sSQL = sSQL & "LEFT JOIN #___content t2 ON t1.id = t2.parent_id "
'	sSQL = sSQL & "WHERE t1.anaid = "& intAnaid &" And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
'	sSQL = sSQL & "ORDER BY t1.sira ASC, t1.id DESC;"
'	sSQL = setQuery( sSQL )
'	Clearfix sSQL
'	Set objSubRs = setExecute( sSQL )
'		Do While Not objSubRs.Eof
'
'			spaces = 1 * intLevel
'
'			intCurr = UBound( arrTreeView ) + 1
'
'			Redim Preserve arrTreeView( intCurr )
'			arrTreeView( intCurr ) = Trim(objSubRs("id"))
'
'			Redim Preserve arrSubLevel( intCurr )
'			arrSubLevel( intCurr ) = spaces
'
'			Call TreeViewPages2(objSubRs("id"), intLevel +1)
'
'		objSubRs.MoveNext() : Loop
'	Set objSubRs = Nothing 
'End Sub







'// Gelecek Yeni id
Function Newid(ByVal strTable, ByVal strUrl, ByVal Parent, ByVal intPiD, ByVal strLng)
	Dim sSQL, intQueryiD : intPiD = intYap(intPiD, 0)

	strUrl = strUrl & "" : If Left(strUrl, 4) = "url=" Then Newid = strUrl : Exit Function

	If Len(strUrl) = 0 Then strUrl = ParentNumber(Parent) & "-" & intPiD
	'If Not Len(strUrl) > 3 Then strUrl = "ewy-" & LCase(Left(ParentNumber(Parent), 1)) & "-" & strUrl

	sSQL = ""
	sSQL = sSQL & "SELECT parent_id FROM #___content_url "
	sSQL = sSQL & "WHERE (seflink = '"& strUrl &"' And lang = '"& strLng &"' And parent = "& Parent &" And Not parent_id = "& intPiD &");"
	intQueryiD = Cdbl(sqlQuery(sSQL, 0))

	If Not intQueryiD = 0 Then
		If (intQueryiD <> intPiD And intPiD > 0) Then
			strUrl = strUrl & "-" & intPiD '// Kendi Kimliği
		Else
			strUrl = strUrl & "-" & sqlQuery("SELECT Auto_increment FROM information_schema.tables WHERE Table_Name = '#___"& strTable &"' And Table_Schema = Database();", 0) '// Sonraki Oluşacak Kimlik
		End If
	End If

	Newid = SefURL(strUrl)
End Function






'// Revizyon listesi
Private Function ContentRevizyon(ByVal prnt, ByVal prid)
	If prid = 0 Then Exit Function
	Dim sSQL, strWrite
	ContentRevizyon = ""
	sSQL = ""
	sSQL = sSQL & "SELECT IFNULL(AccountName, '') As AccountName, DateTimes "
	sSQL = sSQL & "FROM #___content_revision_date "
	sSQL = sSQL & "WHERE parent = "& prnt &" And parent_id = "& prid &" And Revizyon = 1 "
	sSQL = sSQL & "ORDER BY DateTimes ASC Limit 1;"
	'Clearfix setQuery( sSQL )
	Set objRs = setExecute(sSQL)
	If Not objRs.Eof Then
		strWrite = strWrite & "<b>Oluşturuldu :</b> <b style=""color:#00a8ff;"">" & objRs("AccountName") & "</b> <b style=""color:#ffd200;""> { " & objRs("DateTimes") & " }</b> <br />"
	End If
	Set objRs = Nothing

	sSQL = ""
	sSQL = sSQL & "SELECT IFNULL(a.AccountName, '') As AccountName, a.DateTimes "
	sSQL = sSQL & "FROM (SELECT AccountName, DateTimes FROM #___content_revision_date WHERE parent = "& prnt &" And parent_id = "& prid &" And Revizyon = 2 ORDER BY DateTimes DESC Limit 4) As a "
	sSQL = sSQL & "ORDER BY a.DateTimes ASC;"
	'Clearfix setQuery( sSQL )
	Set objRs = setExecute(sSQL)
	Do While Not objRs.Eof
		strWrite = strWrite & "<b>Düzenlendi&nbsp; :</b> <b style=""color:#00a8ff;"">" & objRs("AccountName") & "</b> <b style=""color:#ffd200;""> { " & objRs("DateTimes") & " }</b> <br />"
	objRs.MoveNext() : Loop
	Set objRs = Nothing
	If strWrite <> "" Then _
		ContentRevizyon = "<span style=""float:right; padding-top:2px;""><a class=""tooltip blueinfo"" href=""#"" title=""" & Server.HtmlEncode("<span style=""line-height:1.3;"">" & strWrite & "</span>") & """>&nbsp;</a></span> "
End Function





Sub RevisionDate(ByVal intP, ByVal intPid, ByVal intS)
	If (Session("strP_" & intPid) = 1 And Session("intP_" & intPid) = 1 And intS = 2) Then Exit Sub
	Session("strP_" & intPid) = 1 : Session("intP_" & intPid) = 1
	sqlExecute("INSERT INTO #___content_revision_date (parent, parent_id, AccountName, DateTimes, Revizyon) Values ("& intP &", "& intPid &", '"& GlobalConfig("admin_name") &"', Now(), "& intS &");")
End Sub





'// Css background-color Fonksiyonu
Function TabloModClass(ByVal intC)
	TabloModClass = "odd"
	If intC Mod 2 = 0 Then TabloModClass = "even"
End Function





'// Yönetim Paneli İçin İcon Fonksiyonu
Function StatusStyle(ByVal iStatus, ByVal iClass1, ByVal iClass2)
	StatusStyle = iClass1 : If CBool(iStatus) Then StatusStyle = iClass2
End Function
'StatusStyle(True, "list-passive-icon", "list-active-icon")





Function Gorunurluk(ByVal iVal)
	Select Case intYap(iVal, 0)
		Case 0 Gorunurluk = "<span style=""color:green;"">Herkese Açık</span>"
		Case 1 Gorunurluk = "<span style=""color:blue;"">Üyelere Özel</span>"
		Case 2 Gorunurluk = "<span style=""color:red;"">Parola Korumalı</span>"
		Case Else Gorunurluk = "<span style=""color:red;"">Bilinmiyor</span>"
	End Select
End Function




Private Function UyeTipi(ByVal tip)
	Select Case tip
		Case -1 UyeTipi = "Seçiniz"
		Case  0 UyeTipi = "Yönetici"
		Case  1 UyeTipi = "Özel Üye"
		Case  2 UyeTipi = "Son Kullanıcı"
		Case  3 UyeTipi = "Bayi"
	End Select
End Function





'// Sayfalama Fonksiyonu
Function Sayfala(ByVal intToplamKayitSayisi, ByVal intGosterilecekKayit, ByVal intSayfaNumarasi)
	'If (intToplamKayitSayisi <= intGosterilecekKayit) Then Exit Function

	Dim sWrite, intToplamSayfaSayisi

	intSayfaNumarasi = intYap((intSayfaNumarasi + 1), 1)
	'If intSayfaNumarasi < 1 Then intSayfaNumarasi = 1

	If (intToplamKayitSayisi/intGosterilecekKayit = int(intToplamKayitSayisi/intGosterilecekKayit)) Then
		intToplamSayfaSayisi = int(intToplamKayitSayisi/intGosterilecekKayit)
	Else
		intToplamSayfaSayisi = int(intToplamKayitSayisi/intGosterilecekKayit) + 1
	End If

	If intSayfaNumarasi > intToplamSayfaSayisi Then intSayfaNumarasi = intToplamSayfaSayisi

	'Dim xURL
	'xURL = "?" & UrlQuery("sayfa")

	sWrite = "<div class=""sayfala clearfix"">"
	sWrite = sWrite & vbCrLf & "	<ul>"
	sWrite = sWrite & vbCrLf & "			<li><label style=""display:inline; font-weight:bold;"" for=""sayfa"">Git :</label> <input style=""width:30px; margin-top:-0.5px;"" class=""inputbox list-order"" id=""limitstart1"" name=""limitstart1"" value="""" autocomplete=""off"" maxlength=""5"" type=""text"" /></li>"

	If intSayfaNumarasi > 1 Then
		sWrite = sWrite & vbCrLf & "		<li><a href=""javascript:sayfa_no(1);"">&laquo; İlk (1)</a></li>"
	Else
		sWrite = sWrite & vbCrLf & "		<li class=""active""><span>&laquo; İlk (1)</span></li>"
	End If

	If intSayfaNumarasi > 1 Then
		sWrite = sWrite & vbCrLf & "		<li><a href=""javascript:sayfa_no("& intYap(intSayfaNumarasi - 1, 1) &");"">&lsaquo; Önceki ("& intYap(intSayfaNumarasi - 1, 1) &")</a></li>"
	Else
		sWrite = sWrite & vbCrLf & "		<li class=""active""><span>&lsaquo; Önceki (1)</span></li>"
	End If

	Dim intDonguBasla, intDonguBitis

	intDonguBasla = intYap((intSayfaNumarasi - 2), 1)
	intDonguBitis = intYap((intSayfaNumarasi + 4), 1)

	If intSayfaNumarasi > intToplamSayfaSayisi - 2 Then intDonguBasla = intToplamSayfaSayisi - 4

	intDonguBasla = intYap(intDonguBasla, 1)
	If intDonguBasla = 0 Then intDonguBasla = 1

	If intDonguBitis > intToplamSayfaSayisi Then intDonguBitis = intToplamSayfaSayisi

	'If intToplamKayitSayisi < intGosterilecekKayit Then intDonguBitis = intToplamKayitSayisi

	Dim sNo', sNoo
	For sNo = intDonguBasla To intDonguBitis

		'sNoo = sNo : If sNo < 10 Then sNoo = 0 & sNo

		If sNo = intSayfaNumarasi Then
			sWrite = sWrite & vbCrLf & "		<li class=""active""><span>"& sNo &"</span></li>"
		'	sWrite = sWrite & vbCrLf & "		<li class=""active""><span>"& sNo &"</span></li>"

		ElseIf (sNo = 1) Then
			sWrite = sWrite & vbCrLf & "		<li><a href=""javascript:sayfa_no("& sNo &");"">"& sNo &"</a></li>"
		'	sWrite = sWrite & vbCrLf & "		<li><a href="""& xURL &""">"& sNo &"</a></li>"

		ElseIf (sNo <= 5 And sNo > intSayfaNumarasi - 3) Then
			sWrite = sWrite & vbCrLf & "		<li><a href=""javascript:sayfa_no("& sNo &");"">"& sNo &"</a></li>"
		'	sWrite = sWrite & vbCrLf & "		<li><a href="""& xURL &"&amp;sayfa="& sNo &""">"& sNo &"</a></li>"

		ElseIf sNo < intSayfaNumarasi + 3 Then
			sWrite = sWrite & vbCrLf & "		<li><a href=""javascript:sayfa_no("& sNo &");"">"& sNo &"</a></li>"
		'	sWrite = sWrite & vbCrLf & "		<li><a href="""& xURL &"&amp;sayfa="& sNo &""">"& sNo &"</a></li>"

		End If
	Next

	If intToplamSayfaSayisi > intSayfaNumarasi Then
		sWrite = sWrite & vbCrLf & "		<li><a href=""javascript:sayfa_no("& intSayfaNumarasi + 1 &");"">Sonraki &rsaquo; ("& intSayfaNumarasi + 1 &")</a></li>"
	'	sWrite = sWrite & vbCrLf & "		<li><a href="""& xURL &"&amp;sayfa="& intSayfaNumarasi + 1 &""">Sonraki &rsaquo; ("& intSayfaNumarasi + 1 &")</a></li>"
	Else
		sWrite = sWrite & vbCrLf & "		<li class=""active""><span>Sonraki &rsaquo; ("& intToplamSayfaSayisi &")</span></li>"
	'	sWrite = sWrite & vbCrLf & "		<li class=""active""><span>Sonraki &rsaquo; ("& intToplamSayfaSayisi &")</span></li>"
	End If

	If intToplamSayfaSayisi > intSayfaNumarasi Then
		sWrite = sWrite & vbCrLf & "		<li><a href=""javascript:sayfa_no("& intToplamSayfaSayisi &");"">Son &raquo; ("& intToplamSayfaSayisi &")</a></li>"
	'	sWrite = sWrite & vbCrLf & "		<li><a href="""& xURL &"&amp;sayfa="& intToplamSayfaSayisi &""">Son &raquo; ("& intToplamSayfaSayisi &")</a></li>"
	Else
		sWrite = sWrite & vbCrLf & "		<li class=""active""><span>Son &raquo; ("& intToplamSayfaSayisi &")</span></li>"
	'	sWrite = sWrite & vbCrLf & "		<li class=""active""><span>Son &raquo; ("& intToplamSayfaSayisi &")</span></li>"
	End If

	sWrite = sWrite & vbCrLf & "	</ul>"
	sWrite = sWrite & vbCrLf & "<div class=""page_count_text clearfix"">Toplam "& intToplamSayfaSayisi &" sayfadan "& intSayfaNumarasi &". sayfayı görüntülüyorsunuz.</div>"
	sWrite = sWrite & vbCrLf & "</div>"
	'sWrite = sWrite & vbCrLf & "<input id=""plimitstart"" name=""plimitstart"" value="""& PageLimitStart &""" type=""hidden"" />"
	Sayfala = sWrite
End Function










Sub getAdminCookie2(ByVal strName)
	Dim SearchSessionName, CookieName
	SearchSessionName = Cstr( strName & "_search_" & GlobalConfig("vRoot") & "_" & GlobalConfig("admin_username") )
	CookieName = Cstr("Energy_" & GlobalConfig("admin_username") )

	If blnPostMethod Then
		With Response
			.Cookies( CookieName )(strName & "limit") = Request.Form("iDisplayLength")
			'If Len(inputSearch) Then .Cookies( CookieName )(strName & "id") = 0
			limitstart1 = intYap(Request.Form("limitstart1"), 0)
			If Not limitstart1 > 0 Then limitstart1 = Request.Form("limitstart") Else limitstart1 = limitstart1 - 1
			'If (Len(inputSearch) > 0) Then limitstart1 = 0
			.Cookies( CookieName )(strName & "id") = limitstart1

			If Session(SearchSessionName) = "" And (Len(inputSearch) > 0 Or ViewsiD > 0) Then _
				.Cookies( CookieName )(strName & "id") = 0 : Session(SearchSessionName) = "ASD"

			If Len(inputSearch) = 0 Or ViewsiD > 0 Then Session.Contents.Remove(SearchSessionName)

			.Cookies( CookieName ).Expires = Now() + 45
			.Cookies( CookieName ).Path = GlobalConfig("vRoot")
			'If Len(inputSearch) = 0 And ViewsiD = 0 And Not (strName = "popup_" & GlobalConfig("General_Page") & "_list" Or strName = GlobalConfig("General_Page") & "2" Or strName = "json") Then .Redirect( Site_HTTP_REFERER )
		End With
	End If

	SayfaLimiti = Request.Cookies( CookieName )(strName & "limit")

	Select Case SayfaLimiti
		Case "" SayfaLimiti = 5 : intSayfaSayisi = 5
		Case "all" intSayfaSayisi = ToplamCount
		Case Else intSayfaSayisi = SayfaLimiti
	End Select

	If SayfaLimiti = "all" Or SayfaLimiti = "" Then Response.Cookies( CookieName )(strName & "id") = 0
	SayfaLimitStart  = intYap(Request.Cookies( CookieName )(strName & "id"), 0)
	'If Len(PageSearch) > 0 Then SayfaLimitStart  = intYap(Request.Cookies( CookieName )(strName & "s_id"), 0)

	intSayfaNo = 0
	If SayfaLimitStart > 0 Then
		intSayfaNo = SayfaLimitStart
		intToplamSayfaAdedi = intYap(int(ToplamCount/intSayfaSayisi), 0)
		If (intSayfaNo > intToplamSayfaAdedi) Then intSayfaNo = intToplamSayfaAdedi
	End If

	intLimitStart = intYap(int(intSayfaNo * intSayfaSayisi), 0)

	'Response.Write Request.Cookies( CookieName )
	'Response.Write "Limit "& intLimitStart & ", " & intSayfaSayisi

	'If intLimitStart >= ToplamCount Then intLimitStart = 0 : intSayfaNo = 0
	If intSayfaNo = 0 Then intLimitStart = 0' : intSayfaNo = 0
	'If Session(SearchSessionName) <> "" And Len(PageSearch) > 0 Then intLimitStart = 0 : intSayfaNo = 0
	
End Sub








Sub getAdminCookie(ByVal strName)
	Dim SearchSessionName, CookieName
	SearchSessionName = Cstr( strName & "_search_" & GlobalConfig("vRoot") & "_" & GlobalConfig("admin_username") )
	CookieName = Cstr("Energy_" & GlobalConfig("admin_username") )

	If blnPostMethod Then
		With Response
			.Cookies( CookieName )(strName & "limit") = Request.Form("limit")
			'If Len(inputSearch) Then .Cookies( CookieName )(strName & "id") = 0
			limitstart1 = intYap(Request.Form("limitstart1"), 0)
			If Not limitstart1 > 0 Then limitstart1 = Request.Form("limitstart") Else limitstart1 = limitstart1 - 1
			'If (Len(inputSearch) > 0) Then limitstart1 = 0
			.Cookies( CookieName )(strName & "id") = limitstart1

			If Session(SearchSessionName) = "" And (Len(inputSearch) > 0 Or ViewsiD > 0) Then _
				.Cookies( CookieName )(strName & "id") = 0 : Session(SearchSessionName) = "ASD"

			If Len(inputSearch) = 0 Or ViewsiD > 0 Then Session.Contents.Remove(SearchSessionName)

			.Cookies( CookieName ).Expires = Now() + 45
			.Cookies( CookieName ).Path = GlobalConfig("vRoot")
			'If Len(inputSearch) = 0 And ViewsiD = 0 And Not (strName = "popup_" & GlobalConfig("General_Page") & "_list" Or strName = GlobalConfig("General_Page") & "2" Or strName = "json") Then .Redirect( Site_HTTP_REFERER )
		End With
	End If

	SayfaLimiti = Request.Cookies( CookieName )(strName & "limit")

	Select Case SayfaLimiti
		Case "" SayfaLimiti = 5 : intSayfaSayisi = 5
		Case "all" intSayfaSayisi = ToplamCount
		Case Else intSayfaSayisi = SayfaLimiti
	End Select

	If SayfaLimiti = "all" Or SayfaLimiti = "" Then Response.Cookies( CookieName )(strName & "id") = 0
	SayfaLimitStart  = intYap(Request.Cookies( CookieName )(strName & "id"), 0)
	'If Len(PageSearch) > 0 Then SayfaLimitStart  = intYap(Request.Cookies( CookieName )(strName & "s_id"), 0)

	intSayfaNo = 0
	If SayfaLimitStart > 0 Then
		intSayfaNo = SayfaLimitStart
		intToplamSayfaAdedi = intYap(int(ToplamCount/intSayfaSayisi), 0)
		If (intSayfaNo > intToplamSayfaAdedi) Then intSayfaNo = intToplamSayfaAdedi
	End If

	intLimitStart = intYap(int(intSayfaNo * intSayfaSayisi), 0)

	'Response.Write Request.Cookies( CookieName )
	'Response.Write "Limit "& intLimitStart & ", " & intSayfaSayisi

	'If intLimitStart >= ToplamCount Then intLimitStart = 0 : intSayfaNo = 0
	If intSayfaNo = 0 Then intLimitStart = 0' : intSayfaNo = 0
	'If Session(SearchSessionName) <> "" And Len(PageSearch) > 0 Then intLimitStart = 0 : intSayfaNo = 0
	
End Sub




















Sub ContentDelete(ByVal intAnaid, ByVal Parent)
	intAnaid = intYap(intAnaid, 0)
	Parent = intYap(Parent, 0)

	Dim DelFolder : DelFolder = ""

	Select Case Parent
		Case GlobalConfig("General_CategoriesPN")
			DelFolder = kFolder(intAnaid, 0)

		Case GlobalConfig("General_ProductsPN")
			DelFolder = pFolder(intAnaid, 0)

		Case GlobalConfig("General_PagePN")
			DelFolder = sFolder(intAnaid, 0)

		Case GlobalConfig("General_UsersPN")
			DelFolder = uFolder(intAnaid, 0)

	End Select

	Call DeleteFolder( DelFolder )

	If Not Parent = GlobalConfig("General_UsersPN") Then
		sqlExeCute("DELETE FROM #___content WHERE (parent = "& Parent &" And parent_id = "& intAnaid &");")
		sqlExeCute("DELETE FROM #___content_url WHERE (parent = "& Parent &" And parent_id = "& intAnaid &");")
		sqlExeCute("DELETE FROM #___content_menu WHERE (parent = "& Parent &" And parent_id = "& intAnaid &");")
	End If

	sqlExeCute("DELETE FROM #___etiket_id WHERE (parent = "& Parent &" And parent_id = "& intAnaid &");")
	sqlExeCute("DELETE FROM #___files WHERE (parent = "& Parent &" And parent_id = "& intAnaid &");")
	sqlExeCute("DELETE FROM #___content_revision_date WHERE (parent = "& Parent &" And parent_id = "& intAnaid &");")

End Sub





'// Etiket Sistemine Kayıt ve Silme İşlemi
Sub EtiketSave(ByVal fn, ByVal parent, ByVal parentid, Byval lng)
	Dim strEtiket, item, intGetContentRow : strEtiket = ""
	For Each item in Split(fn, ",")
		item = Temizle(item, 1)

		intGetContentRow = CdbL(sqlQuery("SELECT id FROM #___etiket WHERE etiket = '"& item &"';", 0))

		If intGetContentRow > 0 Then
			If Not CBool(sqlQuery("SELECT id FROM #___etiket_id WHERE (eid = "& intGetContentRow &" And parent = "& parent &" And parent_id = "& parentid &" And lang = '"& lng &"') Limit 1;", 0)) Then
				sqlExeCute("INSERT INTO #___etiket_id (eid, parent, parent_id, lang) VALUES("& intGetContentRow &", "& parent &", "& parentid &", '"& lng &"');")
			End If
		Else
			sqlExeCute("INSERT INTO #___etiket (etiket, permalink) VALUES('"& item &"', '"&  SefUrl(item) &"');")
			intGetContentRow = CdbL(sqlQuery("SELECT id FROM #___etiket ORDER BY id DESC Limit 1;", 0))
			sqlExeCute("INSERT INTO #___etiket_id (eid, parent, parent_id, lang) VALUES("& intGetContentRow &", "& parent &", "& parentid &", '"& lng &"');")
		End If

		strEtiket = strEtiket & intGetContentRow & " ,"
	Next

	If strEtiket <> "" Then
		strEtiket = Left(strEtiket, Len(strEtiket)-2)
		sqlExeCute("DELETE FROM #___etiket_id WHERE (eid Not IN ("& strEtiket &") And parent = "& parent &" And parent_id = "& parentid &" And lang = '"& lng &"');")
	End If

	If fn = "" Then _
		sqlExeCute("DELETE FROM #___etiket_id WHERE (parent = "& parent &" And parent_id = "& parentid &" And lang = '"& lng &"');")
End Sub










Sub ContentMenuSave(ByVal arrid, ByVal strTitle, ByVal parent, ByVal parentid, Byval lng)
	Dim intMenuid, objRs, intMenuSira, intGetMenuRow
	intMenuid = Replace(arrid, "0, ", "")
	Set objRs = setExeCute("SELECT id FROM #___content_menu WHERE (parent = "& parent &" And parent_id = "& parentid &" And menu_id Not IN ("& intMenuid &") And lang = '"& lng &"');")
		Do While Not objRs.Eof
		Call MenuParentDelete(objRs("id"))
		objRs.MoveNext() : Loop
	Set objRs = Nothing
	sqlExeCute("DELETE FROM #___content_menu WHERE (parent = "& parent &" And parent_id = "& parentid &" And menu_id Not IN ("& intMenuid &") And lang = '"& lng &"');")
	If strTitle = "" Then sqlExeCute("DELETE FROM #___content_menu WHERE (parent = "& parent &" And parent_id = "& parentid &" And lang = '"& lng &"');")

	If Not strTitle = "" Then
		'// Yeni seçilmiş menü(leri) kayıt yapıyoruz
		For Each intMenuid in arrid
			intMenuid = Cdbl(intMenuid)
			If intMenuid > 0 Then
				intMenuSira = sqlQuery("SELECT IFNULL(Max(sira), 0) As sira FROM #___content_menu WHERE menu_id = "& intMenuid &" And lang = '"& lng &"';", 0) + 1

				intGetMenuRow = sqlQuery("SELECT Count( id ) FROM #___content_menu WHERE (parent = "& parent &" And parent_id = "& parentid &" And menu_id = "& intMenuid &" And lang = '"& lng &"');", 0)
				If Not CBool(intGetMenuRow) Then
					sqlExeCute("INSERT INTO #___content_menu (menu_tag, parent, parent_id, menu_id, sira, lang) VALUES ('"& strTitle &"', "& parent &", "& parentid &", "& intMenuid &", "& intMenuSira &", '"& lng &"');")
				End If

			End If
		Next
	End If
End Sub


Sub MenuParentDelete(ByVal iid)
	Dim objRs
	OpenRs objRs, "SELECT id, parent FROM #___content_menu WHERE anaid = "& iid &";"
		Do While Not objRs.Eof
			Call MenuParentDelete(objRs("id"))
				If intYap(objRs("parent"), 0) = GlobalConfig("General_CustomURLPN") Then
				'sqlExeCute("DELETE FROM #___content_menu WHERE (parent = "& strNerde &" And parent_id = "& objRs("id") &");")
				sqlExeCute("DELETE FROM #___content_url WHERE (parent = "& GlobalConfig("General_CustomURLPN") &" And parent_id = "& objRs("id") &");")
			End If
			objRs.Delete
		objRs.MoveNext : Loop
	CloseRs objRs
End Sub









Dim arrAddMenuPost : Set arrAddMenuPost = jsArray()
Sub ArrMenuJSON(ByVal intid, ByVal intanaid, ByVal strTag, ByVal strTitle, ByVal strText, ByVal strUrl, _
	ByVal strTarget, ByVal strRel, ByVal strClass, ByVal strStyle, _
	ByVal strParent, ByVal intParent, ByVal strLang)
	Set arrAddMenuPost(Null) = jsObject()
	arrAddMenuPost(Null)("m_id") = intid
	arrAddMenuPost(Null)("m_anaid") = intanaid
	arrAddMenuPost(Null)("m_tag") = strTag
	arrAddMenuPost(Null)("m_title") = strTitle
	arrAddMenuPost(Null)("m_text") = strText
	arrAddMenuPost(Null)("m_url") = strUrl
	arrAddMenuPost(Null)("m_target") = strTarget
	arrAddMenuPost(Null)("m_rel") = strRel
	arrAddMenuPost(Null)("m_class") = strClass
	arrAddMenuPost(Null)("m_style") = strStyle
	arrAddMenuPost(Null)("m_parent") = strParent
	arrAddMenuPost(Null)("m_parentid") = intParent
	arrAddMenuPost(Null)("m_lang") = strLang
	'arrAddMenuPost(Null)("msg_class") = MsgClass
	'arrAddMenuPost(Null)("msg_text") = MsgText
End Sub












Dim arrListPost : Set arrListPost = jsArray()
Sub ArrJSON(ByVal intid, ByVal strTitle, ByVal strUrl, ByVal strEvent)
	Set arrListPost(Null) = jsObject()
	arrListPost(Null)("siD") = intid
	arrListPost(Null)("sTitle") = strTitle
	arrListPost(Null)("sUrl") = strUrl
	arrListPost(Null)("sOlay") = strEvent
	'arrListPost(Null)("sMsg") = strMsg
	'arrListPost(Null)("sClass") = strAddClass
End Sub




Sub ActionPost(ByVal jsSaveid, ByVal jsSaveClass, ByVal jsSaveMessage)
	Dim ActionPost
	Set ActionPost = jsObject()
	ActionPost("siD") = jsSaveid
	ActionPost("sClass") = jsSaveClass
	ActionPost("sMsg") = jsSaveMessage
	ActionPost.Flush
End Sub


Dim arrAutoCompleteList : Set arrAutoCompleteList = jsArray()
Sub EtiketAutoCompletePost(ByVal label, ByVal value)
	Set arrAutoCompleteList(Null) = jsObject()
	arrAutoCompleteList(Null)("label") = label
	arrAutoCompleteList(Null)("value") = value
End Sub




Set arrUpload = jsArray()
Sub PictureJson(sLng, mt, sPostiD, sFileiD, sFolderName, sFileName, sFileTitle, sFileAlt, cssStatusClass, sDefaultClass, cssStyle, sMsg, sTarih)
	Set arrUpload(Null) = jsObject()
	arrUpload(Null)("Lng") = sLng
	arrUpload(Null)("mimeType") = mt
	arrUpload(Null)("PageiD") = sPostiD
	arrUpload(Null)("FileiD") = sFileiD
	arrUpload(Null)("FolderName") = sFolderName
	arrUpload(Null)("FileName") = sFileName
	arrUpload(Null)("FileTitle") = sFileTitle
	arrUpload(Null)("FileAlt") = sFileAlt
	arrUpload(Null)("cssStatusClass") = cssStatusClass
	arrUpload(Null)("cssDefaultClass") = sDefaultClass
	arrUpload(Null)("cssStyle") = cssStyle
	arrUpload(Null)("Msg") = sMsg
	arrUpload(Null)("Tarih") = sTarih
End Sub


Sub JsonFlush(ByRef Nesne)
	Nesne.Flush
End Sub





















Private Function ProductCategories(ByVal intParentid, ByVal intLevel, ByRef linkWrite)
	Dim sSQL, objSubRs
	sSQL = ""
	sSQL = sSQL & "SELECT "
	sSQL = sSQL & "t1.id, t1.anaid, t2.title "
	sSQL = sSQL & "FROM #___kategori t1 "
	sSQL = sSQL & "LEFT JOIN #___content t2 ON t1.id = t2.parent_id "
	'sSQL = sSQL & "LEFT JOIN #___languages t3 ON t2.lang = t3.lng "
	sSQL = sSQL & "WHERE (t1.id = "& intParentid &" And t2.parent = "& GlobalConfig("General_CategoriesPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"') ORDER BY t2.title ASC;"
	'sSQL = setQuery( sSQL )
	Set objSubRs = setExecute( sSQL )
		Do While Not objSubRs.Eof

			Call ProductCategories(objSubRs("anaid"), intLevel + 1, linkWrite)

			linkWrite = linkWrite  & ("<a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Categories"), "", "", Cdbl(objSubRs("id")), "", "") &""" title="""& objSubRs("title") &""" target=""_blank"">"& KacKarekter(objSubRs("title"), 35) &"</a>")

			If (intLevel > 0) Then linkWrite = linkWrite  & (" <span class=""red"">&raquo;</span> ")
		objSubRs.MoveNext() : Loop
	Set objSubRs = Nothing

	ProductCategories = linkWrite
End Function







Sub JsLoad()

%>
<script type="text/javascript">
/*<![CDATA[*/
var GlobalDomainName = "<%=Site_HTTP_HOST%>", GlobalPath = "<%=GlobalConfig("vRoot")%>", GlobalModValue = "<%=mods%>", GlobalPageNo = "&id=<%=id%>", GlobalLangValue = "<%=Replace(sLang, "&amp;", "&")%>", GlobalMenuType = "<%=menutype%>", GlobalDebug = "<%=Debug2%>", SpanPageNoWrite = false, RefreshPage = false, UploadLimit = false, tagLink = "<a href=\"<%= UrlWrite(GlobalConfig("sBase"), GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "[perma}", "", "", "", "") %>\">{tag}</a>";
function TinymceTriggerSave() {if (GlobalModValue == "<%=GlobalConfig("General_Categories")%>" || GlobalModValue == "<%=GlobalConfig("General_Products")%>" || 	GlobalModValue == "<%=GlobalConfig("General_Page")%>" || GlobalModValue == "<%=GlobalConfig("General_Poll")%>" || GlobalModValue == "<%=GlobalConfig("General_Banner")%>") {tinyMCE.triggerSave()}}
if(GlobalModValue == "<%=GlobalConfig("General_Page")%>" || GlobalModValue == "<%=GlobalConfig("General_Products")%>") { SpanPageNoWrite = true}
if(GlobalModValue == "<%=GlobalConfig("General_Poll")%>") { RefreshPage = true}
if(GlobalModValue == "<%=GlobalConfig("General_Categories")%>" || GlobalModValue == "<%=GlobalConfig("General_Products")%>" || GlobalModValue == "<%=GlobalConfig("General_Page")%>") {UploadLimit = true}
/*]]>*/
</script><%

End Sub





%>

