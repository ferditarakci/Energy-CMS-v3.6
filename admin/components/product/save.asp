<%
If GlobalConfig("MaxProduct") <= sqlQuery("SELECT Count(id) FROM #___products;", 0) And pageid = 0 Then
	Response.Clear()
	Call ActionPost(saveid, "warning", "Maksimun ürün ekleme sınırını aştınız. Toplam "& GlobalConfig("MaxProduct") &" adet ürün ekleyebilirsiniz.")
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

'TitleStatus = intYap(Request.Form("title_status"), 0)
'ActiveLink = intYap(Request.Form("active_link"), 0)
ActiveHome = intYap(Request.Form("active_home"), 0)
yorumizin = intYap(Request.Form("yorumizin"), 0)
HomeAlias = Temizle(Request.Form("home_page_alias"), 1)
typeAlias = Temizle(Request.Form("alias"), 1)

Dim intYeni, intFlash, strStockCode, intTotalStock

intYeni = intYap(Request.Form("yeni"), 0)
intFlash = intYap(Request.Form("flash"), 0)
strStockCode = Temizle(Request.Form("stock_code"), 1)
intTotalStock = intYap(Request.Form("total_stock"), 0)

Dim product_code, price, strPara, intYuzde, int_iskonto

product_code = Temizle(Request.Form("product_code"), 1)
price = PriceFormat(Request.Form("price"))
strPara = Temizle(Request.Form("para"), 1)
intYuzde = intYap(Request.Form("yuzde"), 18)
int_iskonto = intYap(Request.Form("iskonto"), 0)

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

	'// Formdan gelen IDye ait kayıt kontrolü yapıyoruz
	intGetRow = Cdbl(sqlQuery("SELECT id FROM #___products WHERE id = "& pageid &";", 0))
	If Not CBool(intGetRow) Then

		'// Yeni kayıt oluşturuyoruz
		SQL = ""
		SQL = SQL & "INSERT INTO #___products "
		SQL = SQL & "("
		SQL = SQL & "anaid, "
		SQL = SQL & "typeAlias, "
	'	SQL = SQL & "titleStatus, "
	'	SQL = SQL & "activeLink, "
		SQL = SQL & "sira, "
		SQL = SQL & "kodu, "
		SQL = SQL & "fiyat, "
		SQL = SQL & "para, "
		SQL = SQL & "yuzde, "
		SQL = SQL & "iskonto, "
		'SQL = SQL & "c_date, "
		SQL = SQL & "s_date, "
		SQL = SQL & "e_date, "
		SQL = SQL & "durum, "
		SQL = SQL & "stokNo, "
		SQL = SQL & "stokAdet, "
		SQL = SQL & "yeni, "
		SQL = SQL & "anasyf, "
		SQL = SQL & "anasyfAlias, "
	'	SQL = SQL & "flash, "
		SQL = SQL & "ozel, "
		SQL = SQL & "pass, "
		SQL = SQL & "yorumizin, "
		SQL = SQL & "yazar, "
		SQL = SQL & "robots_meta "
		SQL = SQL & ") VALUES ("
		SQL = SQL & ""& intAnaid &", "
		SQL = SQL & "'"& typeAlias &"', "
	'	SQL = SQL & ""& TitleStatus &", "
	'	SQL = SQL & ""& ActiveLink &", "
		SQL = SQL & ""& intSira &", "
		SQL = SQL & "'"& product_code &"', "
		SQL = SQL & "'"& price &"', "
		SQL = SQL & "'"& strPara &"', "
		SQL = SQL & ""& intYuzde &", "
		SQL = SQL & ""& int_iskonto &", "
		'SQL = SQL & "'"& CreateDate &"', "
		SQL = SQL & ""& StartDate &", "
		SQL = SQL & ""& EndDate &", "
		SQL = SQL & ""& intDurum &", "
		SQL = SQL & "'"& strStockCode &"', "
		SQL = SQL & ""& intTotalStock &", "
		SQL = SQL & ""& intYeni &", "
		SQL = SQL & ""& ActiveHome &", "
		SQL = SQL & "'"& HomeAlias &"', "
	'	SQL = SQL & ""& intFlash &", "
		SQL = SQL & ""& ozelsayfa &", "
		SQL = SQL & "'"& pass &"', "
		SQL = SQL & ""& yorumizin &", "
		SQL = SQL & "'"& yazar &"', "
		SQL = SQL & "'"& strMeta &"' "
		SQL = SQL & ");"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = Cdbl(sqlQuery("SELECT id FROM #___products ORDER BY id DESC Limit 1;", 0))
		Call RevisionDate(GlobalConfig("General_ProductsPN"), saveid, 1) '// 1 Insert -- 2 Revision

		sqlExeCute("INSERT INTO #___content (lang, parent, parent_id, title) VALUES ('"& GlobalConfig("default_lang") &"', "& GlobalConfig("General_ProductsPN") &", "& saveid &", '( Başlık yok )');")

	Else

		'// Kaydı güncelliyoruz
		SQL = ""
		SQL = SQL & "UPDATE #___products Set "
		SQL = SQL & "anaid = "& intAnaid &", "
		SQL = SQL & "typeAlias = '"& typeAlias &"', "
	'	SQL = SQL & "titleStatus = "& TitleStatus &", "
	'	SQL = SQL & "activeLink = "& ActiveLink &", "
		SQL = SQL & "sira = "& intSira &", "
		SQL = SQL & "kodu = '"& product_code &"', "
		SQL = SQL & "fiyat = '"& price &"', "
		SQL = SQL & "para = '"& strPara &"', "
		SQL = SQL & "yuzde = "& intYuzde &", "
		SQL = SQL & "iskonto = "& int_iskonto &", "
		'SQL = SQL & "c_date = '"& CreateDate &"', "
		'SQL = SQL & "m_date = '"& ModifiedDate &"', "
		SQL = SQL & "s_date = "& StartDate &", "
		SQL = SQL & "e_date = "& EndDate &", "
		SQL = SQL & "durum = "& intDurum &", "
		SQL = SQL & "stokNo = '"& strStockCode &"', "
		SQL = SQL & "stokAdet = "& intTotalStock &", "
		SQL = SQL & "yeni = "& intYeni &", "
		SQL = SQL & "anasyf = "& ActiveHome &", "
		SQL = SQL & "anasyfAlias = '"& HomeAlias &"', "
	'	SQL = SQL & "flash = "& intFlash &", "
		SQL = SQL & "ozel = "& ozelsayfa &", "
		SQL = SQL & "pass = '"& pass &"', "
		SQL = SQL & "yorumizin = "& yorumizin &", "
		SQL = SQL & "yazar = '"& yazar &"', "
		SQL = SQL & "robots_meta = '"& strMeta &"' "
		SQL = SQL & "WHERE (id = "& intGetRow &");"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = intGetRow
		Call RevisionDate(GlobalConfig("General_ProductsPN"), saveid, 2) '// 1 Insert -- 2 Revision

	End If
	Session("pageid") = saveid

	'// *********************************************************** //'

'	Set ArrMenuiD = Request.Form("menu")
'
'	'// Seçimi iptal edilmiş menü(ler) varsa siliyoruz
'	intMenuid = Replace(ArrMenuiD, "0, ", "")
'	sqlExeCute("DELETE FROM #___content_menu WHERE (parent = "& GlobalConfig("General_ProductsPN") &" And parent_id = "& saveid &" And menu_id Not IN ("& intMenuid &"));")
'
'	'// Yeni seçilmiş menü(leri) kayıt yapıyoruz
'	For Each intMenuid in ArrMenuiD
'		intMenuid = Cdbl(intMenuid)
'		If intMenuid > 0 Then
'
'			intGetMenuRow = sqlQuery("SELECT Count( id ) FROM #___content_menu WHERE (parent = "& GlobalConfig("General_ProductsPN") &" And parent_id = "& saveid &" And menu_id = "& intMenuid &");", 0)
'			If Not CBool(intGetMenuRow) Then
'				sqlExeCute("INSERT INTO #___content_menu (parent, parent_id, menu_id, sira) VALUES ("& GlobalConfig("General_ProductsPN") &", "& saveid &", "& intMenuid &", "& intSira &");")
'			End If
'
'		End If
'	Next
'	Set ArrMenuiD = Nothing

	'// *********************************************************** //'

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
		strTextShort = ""
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

			'// *********************************************************** //'

			Call EtiketSave(Request.Form("etiket_"& strLng), GlobalConfig("General_ProductsPN"), saveid, strLng)

			Call ContentMenuSave(ArrMenuiD, strPostTitle, GlobalConfig("General_ProductsPN"), saveid, strLng)

		'// *********************************************************** //'


			'// İçerik işlemleri
			intGetContentRow = CdbL(sqlQuery("SELECT id FROM #___content WHERE (parent = "& GlobalConfig("General_ProductsPN") &" And parent_id = "& saveid &" And lang = '"& strLng &"');", 0))

			If Not strPostTitle = "" Then
				If intGetContentRow = 0 Then
					sqlExeCute("INSERT INTO #___content (hit, parent, parent_id, lang, title, fixed_title, description, keyword, text, short_text, readmore_text) VALUES (0, "& GlobalConfig("General_ProductsPN") &", "& saveid &", '"& strLng &"', '"& strPostTitle &"', '"& strTitleFix &"', '"& strDesc &"', '"& strKeyword &"', '"& strText &"', '"& strTextShort &"', '"& strReadMoreText &"');")
				Else
					sqlExeCute("UPDATE #___content Set title = '"& strPostTitle &"', fixed_title = '"& strTitleFix &"', description = '"& strDesc &"', keyword = '"& strKeyword &"', text = '"& strText &"', short_text = '"& strTextShort &"', readmore_text = '"& strReadMoreText &"' WHERE id = "& intGetContentRow &";")
				End If
			Else
				If intGetContentRow > 0 Then sqlExeCute("DELETE FROM #___content WHERE (parent = "& GlobalConfig("General_ProductsPN") &" And parent_id = "& saveid &" And lang = '"& strLng &"');")
			End If

			'// *********************************************************** //'


			'// Permalink işlemleri
			sqlExeCute("UPDATE #___content_url Set durum = 0 WHERE (durum = 1 And parent_id = "& saveid &" And parent = "& GlobalConfig("General_ProductsPN") &" And lang = '"& strLng &"');")

			If Not strPostTitle = "" Then
				'// Permalink
				If strLink = "" Then strLink = strPostTitle
				strLink = SefUrl( strLink )
				strLink = Newid("products", strLink, GlobalConfig("General_ProductsPN"), saveid, strLng)

				intGetLinkRow = CdbL(sqlQuery("SELECT id FROM #___content_url WHERE (parent_id = "& saveid &" And parent = "& GlobalConfig("General_ProductsPN") &" And lang = '"& strLng &"' And seflink = '"& strLink &"');", 0))
				If intGetLinkRow = 0 Then
					sqlExeCute("INSERT INTO #___content_url (parent, parent_id, lang, seflink, durum) VALUES ("& GlobalConfig("General_ProductsPN") &", "& saveid &", '"& strLng &"', '"& strLink &"', 1);")
				Else
					sqlExeCute("UPDATE #___content_url Set durum = 1 WHERE id = "& intGetLinkRow &";")
				End If
			End If

		End If
	Next

	Set ArrMenuiD = Nothing

	If Len(saveMessage) = 0 And pageid = 0 Then saveMessage = "Ürün Başarıyla Eklendi."
	If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "Ürün Başarıyla Güncellendi."

End If
%>
