<%

Dim tur, menu_id, anaid, menu_url, menu_tag, menu_title, menu_private_text
Dim menu_target, menu_rel, menu_class, menu_style

'clearfix  Request.Form & " " & menu_tag
menu_id = intYap(sqlQuery("SELECT id FROM #___content_menu_type WHERE type = '"& menutype &"';", ""), 0)

If menu_id = 0 Then
	jAddClass = "error"
	jMessage = "Üzgünüz, istek yapılan menüye şuan ulaşılamıyor."
End If

For i = 1 To Request.Form("id").Count
	If menu_id = 0 Then Exit For
	intSira = 0
	anaid = 0
	menu_url = ""
	menu_tag = ""
	menu_title = ""
	menu_private_text = ""
	menu_target = 0
	menu_rel = ""
	menu_class = ""
	menu_style = ""

	If Request.Form("menu_parentid").Count => i Then _
		parent_id = intYap(Request.Form("menu_parentid")(i), 0)

'If Not parent_id = "" Then

	'// Form nesnelerimi alalım
	If Request.Form("menu_parent").Count => i Then _
		parent = intYap(Request.Form("menu_parent")(i), 0)
		GlobalConfig("General_Parent") = ParentNumber(parent)

	If Request.Form("id").Count => i Then _
		pageid = intYap(Request.Form("id")(i), 0)


	If Request.Form("menu_lang").Count => i Then _
		strLng = Temizle(Request.Form("menu_lang")(i), 1)

	If Request.Form("menu_anaid").Count => i Then _
		anaid = Temizle(Request.Form("menu_anaid")(i), 1)

	If Request.Form("menu_tag").Count => i Then _
		menu_tag = Request.Form("menu_tag")(i)

	If Request.Form("menu_url").Count => i Then _
		menu_url = Replace(SefUrl("url=" & Request.Form("menu_url")(i)), "url=", "")

	If Request.Form("menu_title").Count => i Then _
		menu_title = Temizle(Request.Form("menu_title")(i), 1)

	If Request.Form("menu_private_text").Count => i Then _
		menu_private_text = Temizle(Request.Form("menu_private_text")(i), 1)

	If Request.Form("menu_target").Count => i Then _
		menu_target = intYap(Request.Form("menu_target")(i), 0)

	If Request.Form("menu_rel").Count => i Then _
		menu_rel = Temizle(Request.Form("menu_rel")(i), 1)

	If Request.Form("menu_class").Count => i Then _
		menu_class = Temizle(Request.Form("menu_class")(i), 1)

	If Request.Form("menu_style").Count => i Then _
		menu_style = Temizle(Request.Form("menu_style")(i), 1)



'clearfix "<script>alert('" & (GlobalConfig("General_Parent")) & "')</script>"
	If menu_tag = "" And GlobalConfig("General_Parent") = GlobalConfig("General_Home") Then
		menu_tag = "Ana Sayfa"
		menu_url = UrlWrite(GlobalConfig("sDomain"), strLng, GlobalConfig("General_Parent"), "", "", "", "", "")
	End If

	If menu_tag = "" And Not (GlobalConfig("General_Parent") = GlobalConfig("General_Home") Or GlobalConfig("General_Parent") = GlobalConfig("General_CustomURL")) Then
		Set objRs = setExecute("SELECT id, title FROM #___content WHERE (parent_id = "& parent_id &" And parent = "& parent &" And lang = '"& strLng &"');")
		If Not objRs.Eof Then
			menu_tag = BasHarfBuyuk(objRs("title")) & ""
			menu_url = UrlWrite(GlobalConfig("sDomain"), strLng, GlobalConfig("General_Parent"), "", "", objRs("id"), "", "")
		End If
	End If
'clearfix "<script>alert('" & menu_tag & "')</script>"

	menu_tag = Temizle(menu_tag, 1)
'clearfix  Request.Form & " " & menu_tag




	'// Form kontrollerimizi yapalım
	If GlobalConfig("General_Parent") = GlobalConfig("General_CustomURL") And menu_url = "" Then
		jAddClass = "warning"
		jMessage = "Lütfen geçerli menü için bir bağlantı adresi girin."

	ElseIf menu_tag = "" Then
			jAddClass = "warning"
			jMessage = "Lütfen geçerli menü için bir etiket girin."

	ElseIf Len(menu_tag) > 100 Then
			jAddClass = "warning"
			jMessage = "Navigasyon etiketi çok uzun! maksimun 100 karekter girebilirsiniz."

	ElseIf Len(menu_title) > 200 Then
			jAddClass = "warning"
			jMessage = "Navigasyon title özniteliği çok uzun! maksimun 200 karekter girebilirsiniz."

	ElseIf Not (menu_target >= 0 And menu_target <= 2) Then
			jAddClass = "warning"
			jMessage = "Navigasyon hedef seçimi varsayılanın dışında! lütfen düzeltin."

	ElseIf Len(menu_rel) > 50 Then
			jAddClass = "warning"
			jMessage = "Navigasyon bağlantı ilişkisi çok uzun! maksimun 50 karekter girebilirsiniz."

	ElseIf Len(menu_class) > 50 Then
			jAddClass = "warning"
			jMessage = "Navigasyon CSS sınıfı çok uzun! maksimun 50 karekter girebilirsiniz."

	Else

		'// Formdan gelen IDye ait kayıt kontrolü yapıyoruz
		intGetRow = Cdbl(sqlQuery("SELECT id FROM #___content_menu WHERE id = "& pageid &";", 0))
		

		If Not CBool(intGetRow) Then
			If Not GlobalConfig("General_Parent") = GlobalConfig("General_Home") Then
				intSira = sqlQuery("SELECT IFNULL(Max(sira), 0) As sira FROM #___content_menu WHERE menu_id = "& menu_id &";", 0) + 1
			End If

			'// Yeni kayıt oluşturuyoruz
			SQL = ""
			SQL = SQL & "INSERT INTO #___content_menu "
			SQL = SQL & "("
			SQL = SQL & "anaid, parent, parent_id, menu_id, lang, sira, "
			SQL = SQL & "menu_tag, title_attr, text_value, menu_target, rel_attr, css_class, css_style "
			SQL = SQL & ") VALUES ("
			SQL = SQL & ""& anaid &", "& parent &", "& parent_id &", "& menu_id &", '"& strLng &"', "& intSira &", "
			SQL = SQL & "'"& menu_tag &"', '"& menu_title &"', '"& menu_private_text &"', "& menu_target &", '"& menu_rel &"', '"& menu_class &"', '"& menu_style &"'"
			SQL = SQL & ");"
			'Clearfix setQuery( SQL )
			sqlExeCute( SQL )
			saveid = Cdbl(sqlQuery("SELECT id FROM #___content_menu ORDER BY id DESC Limit 1;", 0))

			jMessage = "Menü başarıyla eklendi."
		Else

			'// Kaydı güncelliyoruz
			SQL = ""
			SQL = SQL & "UPDATE #___content_menu Set "
			SQL = SQL & "anaid = "& anaid &", "
			SQL = SQL & "parent = "& parent &", "
			SQL = SQL & "parent_id = "& parent_id &", "
			SQL = SQL & "menu_id = "& menu_id &", "
			SQL = SQL & "lang = '"& strLng &"', "
			SQL = SQL & "menu_tag = '"& menu_tag &"', "
			SQL = SQL & "title_attr = '"& menu_title &"', "
			SQL = SQL & "text_value = '"& menu_private_text &"', "
			SQL = SQL & "menu_target = "& menu_target &", "
			SQL = SQL & "rel_attr = '"& menu_rel &"', "
			SQL = SQL & "css_class = '"& menu_class &"', "
			SQL = SQL & "css_style = '"& menu_style &"' "
			SQL = SQL & "WHERE id = "& intGetRow &";"
			'Clearfix setQuery( SQL )
			sqlExeCute( SQL )
			saveid = intGetRow

			jMessage = "Menü başarıyla düzenlendi."
		End If


		Set objRs = setExecute("SELECT menu_tag, title_attr, text_value, menu_target, rel_attr, css_class, css_style FROM #___content_menu WHERE id = "& saveid &";")
		If Not objRs.Eof Then
			menu_tag = objRs("menu_tag") & ""
			menu_title = objRs("title_attr") & ""
			menu_private_text = objRs("text_value") & ""
			menu_target = objRs("menu_target") & ""
			menu_rel = objRs("rel_attr") & ""
			menu_class = objRs("css_class") & ""
			menu_style = objRs("css_style") & ""
			'strLink = UrlWrite(GlobalConfig("sDomain"), strLng, parent, "", "", objRs("id"), "", "")
		End If


		'// Permalink
		If GlobalConfig("General_Parent") = GlobalConfig("General_CustomURL") Then
			sqlExeCute("UPDATE #___content_url Set durum = 0 WHERE (durum = 1 And parent_id = "& saveid &" And parent = "& parent &" And lang = '"& strLng &"');")
			intGetLinkRow = CdbL(sqlQuery("SELECT id FROM #___content_url WHERE (parent_id = "& saveid &" And parent = "& parent &" And lang = '"& strLng &"' And seflink = '"& menu_url &"');", 0))
			If intGetLinkRow = 0 Then
				sqlExeCute("INSERT INTO #___content_url (parent, parent_id, lang, seflink, durum) VALUES ("& parent &", "& saveid &", '"& strLng &"', '"& menu_url &"', 1);")
			Else
				sqlExeCute("UPDATE #___content_url Set durum = 1 WHERE id = "& intGetLinkRow &";")
			End If
		End If



		jAddClass = "success"



		If GlobalConfig("General_Parent") = GlobalConfig("General_Home") Then
			strLink = UrlWrite(GlobalConfig("sDomain"), strLng, GlobalConfig("General_Parent"), "", "", "", "", "")

		ElseIf GlobalConfig("General_Parent") = GlobalConfig("General_CustomURL") Then
			strLink = UrlWrite(GlobalConfig("sDomain"), strLng, GlobalConfig("General_Parent"), "", "", saveid, "", "")

		Else
			strLink = UrlWrite(GlobalConfig("sDomain"), strLng, GlobalConfig("General_Parent"), "", "", parent_id, "", "")
		End If
		

	End If
'End If

	Call ArrMenuJSON(saveid, anaid, menu_tag, menu_title, menu_private_text, strLink, _
		menu_target, menu_rel, menu_class, menu_style, parent, parent_id, strLng)

Next

Dim AddMenus
Set AddMenus = jsObject()
	AddMenus("msg_class") = jAddClass
	AddMenus("msg_text") = jMessage
	AddMenus("menu_list") = Array(arrAddMenuPost)
	AddMenus.Flush

'arrAddMenuPost.Flush
%>
