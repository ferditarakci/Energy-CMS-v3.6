<%
If GlobalConfig("MaxPage") <= sqlQuery("SELECT Count(id) FROM #___sayfa;", 0) And pageid = 0 Then
	Response.Clear()
	Call ActionPost(saveid, "warning", "Maksimun kategori ekleme sınırını aştınız. Toplam "& GlobalConfig("MaxPage") &" adet kategori ekleyebilirsiniz.")
	Call CloseDatabase(data)
	Response.End()
End If

Count = 0
For Each strLng in Request.Form("languages")
	Count = Count + 1
	strPostTitle = Temizle(ClearHtml(Request.Form("title_" & strLng)), 1)
	strLangTitle = Request.Form("lang_title_" & strLng)

	'// Kontroller
	If Len(strPostTitle) = 0 And Count = 1 Then
		Response.Clear()
		Call ActionPost(saveid, "warning", "Lütfen bir başlık girin.")
		Call CloseDatabase(data)
		Response.End()
		Exit For

	ElseIf Len(strPostTitle) > 200 Then
		Response.Clear()
		Call ActionPost(saveid, "warning", strLangTitle & " Başlık çok uzun, lütfen kısaltın.")
		Call CloseDatabase(data)
		Response.End()
		Exit For
	End If
Next

'// Form nesnelerimi alalım

intSira = intYap(Request.Form("sira"), 0)

'CreateDate = DateSqlFormat(Request.Form("cDate"), "yy-mm-dd", 1)
'If Not isDate(CreateDate) Then CreateDate = DateSqlFormat(Now(), "yy-mm-dd", 1)

'ModifiedDate = DateSqlFormat(Request.Form("mDate"), "yy-mm-dd", 1)
'If Not isDate(ModifiedDate) Then ModifiedDate = DateSqlFormat(Now(), "yy-mm-dd", 1)
'ModifiedDate = DateSqlFormat(Now(), "yy-mm-dd", 1)

StartDate = DateSqlFormat(Request.Form("sDate"), "yy-mm-dd", 1)
If Not isDate(StartDate) Then StartDate = "Null" Else StartDate = "'"& StartDate &"'"

EndDate = DateSqlFormat(Request.Form("eDate"), "yy-mm-dd", 1)
If Not isDate(EndDate) Then EndDate = "Null" Else EndDate = "'"& EndDate &"'"

'yazar = Temizle(Request.Form("yazar"), 1)
pass = Temizle(Request.Form("pass"), 1)
ozelsayfa = intYap(Request.Form("ozel"), 0)
intAnaid = intYap(Request.Form("anaid"), 0)
intDurum = intYap(Request.Form("durum"), 0)
TitleStatus = intYap(Request.Form("title_status"), 0)
ActiveLink = intYap(Request.Form("active_link"), 0)
ActiveHome = intYap(Request.Form("active_home"), 0)
yorumizin = intYap(Request.Form("yorumizin"), 0)
HomeAlias = Temizle(Request.Form("home_page_alias"), 1)
typeAlias = Temizle(Request.Form("alias"), 1)
strMeta = Temizle(Request.Form("robots_meta"), 1)

'// Form kontrollerimizi yapalım
If intSira < 0 Or intSira > 999 Then
	saveClass = "warning"
	saveMessage = "Geçersiz sıra numarası girdiniz {1} ile {999} arasında bir numara girmelisin."

'ElseIf Not isDate(CreateDate) Then
'	saveClass = "warning"
'	saveMessage = "Lütfen geçerli oluşturma tarihi girin."

'ElseIf Not isDate(ModifiedDate) And pageid > 0 Then
'	saveClass = "warning"
'	saveMessage = "Lütfen geçerli güncelleme tarihi girin."

ElseIf ozelsayfa = 2 And Len(pass) = 0 Then
	saveClass = "warning"
	saveMessage = "Parola korumalı kayıt için geçerli bir şifre girin."

ElseIf ozelsayfa = 2 And (Len(pass) < 4 Or Len(pass) > 16) Then
	saveClass = "warning"
	saveMessage = "Parola minimun 4, maksimun 16 karekter olmalı."

Else

	If ozelsayfa < 2 Then pass = ""

	'Set objRs = Server.CreateObject("ADODB.Recordset")

	'SQL = Empty
	'SQL = SQL & "SELECT "
	'SQL = SQL & "t.id, t.anaid, t.durum, t.titleStatus, t.activeLink, t.anasyf, t.anasyfAlias, t.typeAlias, "
	'SQL = SQL & "t.sira, t.c_date, t.m_date, t.s_date, t.e_date, t.yazar, t.ozelsayfa, t.pass "
	'SQL = SQL & "FROM #___sayfa t "
	'If (pageid > 0) Then SQL = SQL & "WHERE (t.id = "& pageid &")"
	'SQL = SQL & ";"

	'objRs.Open( SQL ),data,1,3' : SQL = Empty
	'If (pageid = 0) Then
	'	objRs.AddNew()
	'End If
	'	objRs("anaid") = intYap(Request.Form("anaid"), 0)
	'	objRs("durum") = CBool(Request.Form("durum"))
	'	objRs("titleStatus") = CBool(Request.Form("title_status"))
	'	objRs("activeLink") = CBool(Request.Form("active_link"))
	'	objRs("anasyf") = CBool(Request.Form("active_home"))
	'	objRs("anasyfAlias") = Request.Form("home_page_alias")
	'	objRs("typeAlias") = Request.Form("alias")
	'	objRs("sira") = intSira
	'	If isDate(CreateDate) Then objRs("c_date") = CreateDate
	'	If (pageid > 0) Then objRs("m_date") = ModifiedDate
	'	If isDate(StartDate) Then objRs("s_date") = StartDate
	'	If isDate(EndDate) Then objRs("e_date") = EndDate
	'	objRs("yazar") = yazar
	'	objRs("ozel") = ozelsayfa
	'	objRs("pass") = pass
	'	objRs.Update
	'	objRs.Requery
	'	saveid = objRs("id")
	'objRs.Close()

	'// Formdan gelen IDye ait kayıt kontrolü yapıyoruz
	intGetRow = Cdbl(sqlQuery("SELECT id FROM #___sayfa WHERE id = "& pageid &";", 0))
	If Not CBool(intGetRow) Then

		'// Yeni kayıt oluşturuyoruz
		SQL = ""
		SQL = SQL & "INSERT INTO #___sayfa "
		SQL = SQL & "("
		SQL = SQL & "anaid, durum, titleStatus, activeLink, anasyf, anasyfAlias, "
		SQL = SQL & "typeAlias, sira, s_date, e_date, ozel, pass, robots_meta "
		SQL = SQL & ") VALUES ("
		SQL = SQL & ""& intAnaid &", "& intDurum &", "& TitleStatus &", "& ActiveLink &", "& ActiveHome &", '"& HomeAlias &"', "
		SQL = SQL & "'"& typeAlias &"', "& intSira &", "& StartDate &", "& EndDate &", "& ozelsayfa &", '"& pass &"', '"& strMeta &"'"
		SQL = SQL & ");"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = Cdbl(sqlQuery("SELECT id FROM #___sayfa ORDER BY id DESC Limit 1;", 0))
		Call RevisionDate(GlobalConfig("General_PagePN"), saveid, 1) '// 1 Insert -- 2 Revision

		sqlExeCute("INSERT INTO #___content (lang, parent, parent_id, title) VALUES ('"& GlobalConfig("default_lang") &"', "& GlobalConfig("General_PagePN") &", "& saveid &", '( Başlık yok )');")

	Else

		'// Kaydı güncelliyoruz
		SQL = ""
		SQL = SQL & "UPDATE #___sayfa Set "
		SQL = SQL & "anaid = "& intAnaid &", "
		SQL = SQL & "durum = "& intDurum &", "
		SQL = SQL & "titleStatus = "& TitleStatus &", "
		SQL = SQL & "activeLink = "& ActiveLink &", "
		SQL = SQL & "anasyf = "& ActiveHome &", "
		SQL = SQL & "anasyfAlias = '"& HomeAlias &"', "
		SQL = SQL & "typeAlias = '"& typeAlias &"', "
		SQL = SQL & "sira = "& intSira &", "
		'SQL = SQL & "c_date = '"& CreateDate &"', "
		'SQL = SQL & "m_date = '"& ModifiedDate &"', "
		SQL = SQL & "s_date = "& StartDate &", "
		SQL = SQL & "e_date = "& EndDate &", "
		SQL = SQL & "yorumizin = '"& yorumizin &"', "
		'SQL = SQL & "yazar = '"& yazar &"', "
		SQL = SQL & "ozel = "& ozelsayfa &", "
		SQL = SQL & "pass = '"& pass &"', "
		SQL = SQL & "robots_meta = '"& strMeta &"' "
		SQL = SQL & "WHERE id = "& intGetRow &";"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = intGetRow
		Call RevisionDate(GlobalConfig("General_PagePN"), saveid, 2) '// 1 Insert -- 2 Revision

	End If
	Session("pageid") = saveid


	Set ArrMenuiD = Request.Form("menu")

	Count = 0
	For Each strLng in Request.Form("languages")
		Count = Count + 1
		strLangTitle = Request.Form("lang_title_" & strLng)

		strPostTitle = Temizle(ClearHtml(Request.Form("title_" & strLng)), 1)
		strTitleFix = ""
		'strTitleAlt = ""
		strLink = ""
		strDesc = ""
		strKeyword = ""
		strText = ""
		strReadMoreText = ""

		If Not strPostTitle = "" Then
			strTitleFix = Temizle(ClearHtml(Request.Form("fixtitle_"& strLng)), 1)
			'strTitleAlt = Temizle(ClearHtml(Request.Form("title_alt_"& strLng)), 1)
			strLink = Request.Form("seflink_"& strLng)
			strDesc = Temizle(ClearHtml(Request.Form("description_"& strLng)), 1)
			strKeyword = Temizle(ClearHtml(Request.Form("keyword_"& strLng)), 1)
			strText = Temizle(Request.Form("text_"& strLng), 0)
			strTextShort = TextBR(Temizle(Request.Form("s_text_"& strLng), 0))
			strReadMoreText = Temizle(Request.Form("readmore_"& strLng), 0)
		End If

		'// Kontroller
		If Len(strPostTitle) = 0 And Count = 1 Then
			saveClass = "warning"
			saveMessage = "Lütfen bir başlık girin."
			Exit For

		ElseIf Len(strTitleShort) > 30 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Menü ismi çok uzun, lütfen kısaltın."
			Exit For

		ElseIf Len(strDesc) > 160 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Description çok uzun, lütfen kısaltın."
			Exit For

		ElseIf Len(strKeyword) > 200 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Keyword çok uzun, lütfen kısaltın."
			Exit For

		Else

			Call EtiketSave(Request.Form("etiket_"& strLng), GlobalConfig("General_PagePN"), saveid, strLng)

			Call ContentMenuSave(ArrMenuiD, strPostTitle, GlobalConfig("General_PagePN"), saveid, strLng)

			'// *********************************************************** //'


			'// İçerik işlemleri
			intGetContentRow = CdbL(sqlQuery("SELECT id FROM #___content WHERE (parent = "& GlobalConfig("General_PagePN") &" And parent_id = "& saveid &" And lang = '"& strLng &"');", 0))

			If Not strPostTitle = "" Then
				If intGetContentRow = 0 Then
					sqlExeCute("INSERT INTO #___content (hit, parent, parent_id, lang, title, fixed_title, description, keyword, text, short_text, readmore_text) VALUES (0, "& GlobalConfig("General_PagePN") &", "& saveid &", '"& strLng &"', '"& strPostTitle &"', '"& strTitleFix &"', '"& strDesc &"', '"& strKeyword &"', '"& strText &"', '"& strTextShort &"', '"& strReadMoreText &"');")
				Else
					sqlExeCute("UPDATE #___content Set title = '"& strPostTitle &"', fixed_title = '"& strTitleFix &"', description = '"& strDesc &"', keyword = '"& strKeyword &"', text = '"& strText &"', short_text = '"& strTextShort &"', readmore_text = '"& strReadMoreText &"' WHERE id = "& intGetContentRow &";")
				End If
			Else
				If intGetContentRow > 0 Then sqlExeCute("DELETE FROM #___content WHERE (parent = "& GlobalConfig("General_PagePN") &" And parent_id = "& saveid &" And lang = '"& strLng &"');")
			End If

			'// *********************************************************** //'


			'// Permalink işlemleri
			sqlExeCute("UPDATE #___content_url Set durum = 0 WHERE (durum = 1 And parent_id = "& saveid &" And parent = "& GlobalConfig("General_PagePN") &" And lang = '"& strLng &"');")

			If Not strPostTitle = "" Then
				'// Permalink
				If strLink = "" Then strLink = strPostTitle
				strLink = SefUrl( strLink )
				strLink = Newid("sayfa", strLink, GlobalConfig("General_PagePN"), saveid, strLng)

				intGetLinkRow = CdbL(sqlQuery("SELECT id FROM #___content_url WHERE (parent_id = "& saveid &" And parent = "& GlobalConfig("General_PagePN") &" And lang = '"& strLng &"' And seflink = '"& strLink &"');", 0))
				If intGetLinkRow = 0 Then
					sqlExeCute("INSERT INTO #___content_url (parent, parent_id, lang, seflink, durum) VALUES ("& GlobalConfig("General_PagePN") &", "& saveid &", '"& strLng &"', '"& strLink &"', 1);")
				Else
					sqlExeCute("UPDATE #___content_url Set durum = 1 WHERE id = "& intGetLinkRow &";")
				End If
			End If

		End If
	Next

	Set ArrMenuiD = Nothing

	If Len(saveMessage) = 0 And pageid = 0 Then saveMessage = "Sayfa Başarıyla Eklendi."
	If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "Sayfa Başarıyla Güncellendi."

End If
%>
