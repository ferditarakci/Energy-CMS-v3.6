<%

'// Content Hits
Sub ContentHits(ByVal ContentID)
	If isEmpty(Request.Cookies("EnergyCmsHit")("id" & ContentID)) Then
		sqlExecute("UPDATE #___content Set hit = hit + 1 WHERE id = "& ContentID &";")
		Response.Cookies("EnergyCmsHit")("id" & ContentID) = 1
		Response.Cookies("EnergyCmsHit").Path = GlobalConfig("sRoot")
	End If
End Sub



'// Global Page Number
Dim globalPageid : globalPageid = GlobalConfig("request_start")
If GlobalConfig("request_showall") = "true" Then globalPageid = GlobalConfig("request_showall")




GlobalConfig("HeaderMetaTag") = ""
GlobalConfig("header_title") = GlobalConfig("logo_alt_text")


'// Content Hits
Function ContentCheck(ByVal pT, ByVal pN, ByVal sL, ByVal qT)
Dim SQL

SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.id," & vbCrLf
SQL = SQL & "	a.anaid," & vbCrLf
SQL = SQL & "	a.ozel," & vbCrLf
SQL = SQL & "	IFNULL(a.pass, '') As pass," & vbCrLf
SQL = SQL & "	IFNULL(a.robots_meta, '') As robots_meta," & vbCrLf
'SQL = SQL & "	/*IF(b.text Is Null, 1, 0) As TextNull,*/" & vbCrLf
SQL = SQL & "	b.id As ContentID," & vbCrLf
SQL = SQL & "	IFNULL(b.title, '') As title," & vbCrLf
SQL = SQL & "	IFNULL(b.fixed_title, '') As fixed_title," & vbCrLf
SQL = SQL & "	IFNULL(b.text, '') As text," & vbCrLf
SQL = SQL & "	IFNULL(b.description, '') As description," & vbCrLf
SQL = SQL & "	IFNULL(b.keyword, '') As keyword," & vbCrLf
SQL = SQL & "	b.hit," & vbCrLf
SQL = SQL & "	IFNULL(e.id, 0) As menuid," & vbCrLf
'SQL = SQL & "	IFNULL(e.anaid, 0) As menuanaid," & vbCrLf
SQL = SQL & "	IFNULL(a.yorumizin, 0) As yorumizin," & vbCrLf
SQL = SQL & "	IFNULL(d.alias, '') As alias," & vbCrLf
'SQL = SQL & "	/*(SELECT lang FROM #___content WHERE Not parent = b.parent And parent_id = b.parent_id) As lng,*/" & vbCrLf
SQL = SQL & "	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date," & vbCrLf
SQL = SQL & "	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
SQL = SQL & "FROM #___"& pT &" As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "INNER JOIN #___content_url As c ON a.id = c.parent_id" & vbCrLf
SQL = SQL & "LEFT OUTER JOIN #___content_template As d ON a.typeAlias = d.alias" & vbCrLf
SQL = SQL & "LEFT OUTER JOIN #___content_menu As e ON a.id = e.parent_id And b.parent = e.parent" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	a.durum = 1" & vbCrLf

If pT <> "kategori" Then
	SQL = SQL & "And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
	SQL = SQL & "And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
End If

SQL = SQL & "	And b.lang = '"& sL &"'" & vbCrLf
SQL = SQL & "	And b.parent = "& pN &"" & vbCrLf
SQL = SQL & "	And LOWER(c.seflink) = '"& qT &"'" & vbCrLf
SQL = SQL & "	And d.durum = 1" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "Limit 1;"

ContentCheck = SQL

End Function







'Clearfix GlobalConfig("mail_type")

Select Case GlobalConfig("request_option")

Case GlobalConfig("General_Page")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""

	'SQL = "Call ContentCheck("
	'SQL = SQL & "'"& GlobalConfig("site_lang") &"', "
	'SQL = SQL & "'"& GlobalConfig("General_PagePN") &"', "
	'SQL = SQL & "'"& GlobalConfig("request_title") &"', "
	'SQL = SQL & "'"& DateTimeNull &"', "
	'SQL = SQL & "'"& tablePrefix &"', "
	'SQL = SQL & "'sayfa'"
	'SQL = SQL & ");"
	'Set objRs = setExecute( SQL )

	'Set objRs = setExecute(ContentCheck("sayfa", GlobalConfig("General_PagePN"), GlobalConfig("site_lang"), GlobalConfig("request_title")))
	OpenRs objRs, ContentCheck("sayfa", GlobalConfig("General_PagePN"), GlobalConfig("site_lang"), GlobalConfig("request_title"))
		If objRs.Eof Then
			GlobalConfig("request_option") = "Not Found"
			GlobalConfig("sayfa_ozelsayfa") = 0

		Else

			'// Hit için çerez bırakalım
			Call ContentHits(objRs("ContentID"))

			'// Redirect Url
			Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), globalPageid, ""))

			If  objRs("robots_meta") <> "" Then
				Response.AddHeader "X-Robots-Tag", objRs("robots_meta")
				GlobalConfig("HeaderMetaTag") = objRs("robots_meta")
			End If

			GlobalConfig("request_option") = GlobalConfig("General_Page")
			GlobalConfig("request_sayfaid") = objRs("id")
			GlobalConfig("request_sayfa_anaid") = objRs("anaid")

			GlobalConfig("sayfa_yorumizin") = objRs("yorumizin")
			GlobalConfig("sayfa_ozelsayfa") = objRs("ozel")
			GlobalConfig("sayfa_ozelsayfa_pass") = objRs("pass")

			GlobalConfig("PageTitle") = objRs("title")
			GlobalConfig("PageTitleFix") = objRs("fixed_title")
			GlobalConfig("PageText") = fnPre(ReplaceHR(objRs("text")), GlobalConfig("sBase"))
			'GlobalConfig("TextNull") = objRs("TextNull")

			GlobalConfig("description") = HtmlEncode(objRs("description"))
			GlobalConfig("keyword") = HtmlEncode(objRs("keyword"))

			GlobalConfig("c_date") = objRs("c_date")
			GlobalConfig("m_date") = objRs("m_date")

			GlobalConfig("sayfa_alias") = objRs("alias")
			GlobalConfig("sayfa_hits") = objRs("hit")

			'// Sayfanın üst sayfalarını çağıralım
			Call ewyActiveMenu(GlobalConfig("request_sayfaid"))
			Call ewyPathway(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfa_anaid"))

			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon"">" & UCase2(GlobalConfig("PageTitle"))
			GlobalConfig("site_ismi") = GlobalConfig("PageTitle")
			If GlobalConfig("PageTitleFix") = "" Then
				GlobalConfig("header_title") = BasHarfBuyuk(GlobalConfig("PageTitle"))
			Else
				GlobalConfig("header_title") = GlobalConfig("PageTitleFix")
			End If

			If GlobalConfig("request_start") > 1 Then
				'GlobalConfig("header_title") = GlobalConfig("header_title") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("PageTitleFix") = GlobalConfig("PageTitleFix") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("site_ismi") = GlobalConfig("site_ismi") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("cpathway") = GlobalConfig("cpathway") & " (" & GlobalConfig("request_start") & ")"

				'If  objRs("HeaderMetaTag") <> "" Then
				'	Response.AddHeader "X-Robots-Tag", "noindex, follow"
				'	GlobalConfig("HeaderMetaTag") = "noindex, follow"
				'End If

			End If

			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "</li> "

			'GlobalConfig("activeMenuid") = GlobalConfig("activeMenuid") & "[" & objRs("menuid")	& "]"
			'Clearfix GlobalConfig("activeMenuid")
		End If
	CloseRs objRs
'[544][586][593][590]
	GlobalConfig("HeaderLinks") = HeaderLinks("sayfa", GlobalConfig("request_sayfaid"), GlobalConfig("General_PagePN"))



Case GlobalConfig("General_Categories")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""

	'SQL = "Call ContentCheck("
	'SQL = SQL & "'"& GlobalConfig("site_lang") &"', "
	'SQL = SQL & "'"& GlobalConfig("General_CategoriesPN") &"', "
	'SQL = SQL & "'"& GlobalConfig("request_title") &"', "
	'SQL = SQL & "'"& DateTimeNull &"', "
	'SQL = SQL & "'"& tablePrefix &"', "
	'SQL = SQL & "'kategori'"
	'SQL = SQL & ");"
	'Set objRs = setExecute( SQL )

	'Set objRs = setExecute(ContentCheck("kategori", GlobalConfig("General_CategoriesPN"), GlobalConfig("site_lang"), GlobalConfig("request_title")))
	OpenRs objRs, ContentCheck("kategori", GlobalConfig("General_CategoriesPN"), GlobalConfig("site_lang"), GlobalConfig("request_title"))
		If objRs.Eof Then
			GlobalConfig("request_option") = "Not Found"
			GlobalConfig("sayfa_ozelsayfa") = 0

		Else

			'// Hit için çerez bırakalım
			Call ContentHits(objRs("ContentID"))

			'// Redirect Url
			Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Categories"), "", "", Cdbl(objRs("id")), globalPageid, ""))

			If  objRs("robots_meta") <> "" Then
				Response.AddHeader "X-Robots-Tag", objRs("robots_meta")
				GlobalConfig("HeaderMetaTag") = objRs("robots_meta")
			End If

			GlobalConfig("request_option") = GlobalConfig("General_Categories")
			GlobalConfig("request_sayfaid") = objRs("id")
			GlobalConfig("request_sayfa_anaid") = objRs("anaid")

			GlobalConfig("sayfa_ozelsayfa") = objRs("ozel")
			GlobalConfig("sayfa_ozelsayfa_pass") = objRs("pass")

			GlobalConfig("PageTitle") = objRs("title")
			GlobalConfig("PageTitleFix") = objRs("fixed_title")
			GlobalConfig("PageText") = fnPre(ReplaceHR(objRs("text")), GlobalConfig("sBase"))
			'GlobalConfig("TextNull") = objRs("TextNull")

			GlobalConfig("description") = HtmlEncode(objRs("description"))
			GlobalConfig("keyword") = HtmlEncode(objRs("keyword"))

			GlobalConfig("c_date") = objRs("c_date")
			GlobalConfig("m_date") = objRs("m_date")

			GlobalConfig("sayfa_alias") = objRs("alias")
			GlobalConfig("sayfa_hits") = objRs("hit")

			'// Sayfanın üst sayfalarını çağıralım
			Call ewyActiveMenu(GlobalConfig("request_sayfaid"))
			Call ewyPathway(GlobalConfig("General_Categories"), GlobalConfig("request_sayfa_anaid"), GlobalConfig("request_sayfaid"))

			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon"">" & UCase2(GlobalConfig("PageTitle"))
			GlobalConfig("site_ismi") = GlobalConfig("PageTitle")
			If GlobalConfig("PageTitleFix") = "" Then
				GlobalConfig("header_title") = BasHarfBuyuk(GlobalConfig("PageTitle"))
			Else
				GlobalConfig("header_title") = GlobalConfig("PageTitleFix")
			End If

			If GlobalConfig("request_start") > 1 Then
				'GlobalConfig("header_title") = GlobalConfig("header_title") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("PageTitleFix") = GlobalConfig("PageTitleFix") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("site_ismi") = GlobalConfig("site_ismi") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("cpathway") = GlobalConfig("cpathway") & " (" & GlobalConfig("request_start") & ")"

				'If  objRs("HeaderMetaTag") <> "" Then
				'	Response.AddHeader "X-Robots-Tag", "noindex, follow"
				'	GlobalConfig("HeaderMetaTag") = "noindex, follow"
				'End If

			End If

			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "</li> "

			'GlobalConfig("activeMenuid") = GlobalConfig("activeMenuid") & "[" & objRs("menuid")	& "]"
			'Clearfix GlobalConfig("activeMenuid")

		End If
	CloseRs objRs

	GlobalConfig("HeaderLinks") = HeaderLinks("kategori", GlobalConfig("request_sayfaid"), GlobalConfig("General_CategoriesPN"))







Case GlobalConfig("General_Products")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""

	'SQL = "Call ContentCheck("
	'SQL = SQL & "'"& GlobalConfig("site_lang") &"', "
	'SQL = SQL & "'"& GlobalConfig("General_ProductsPN") &"', "
	'SQL = SQL & "'"& GlobalConfig("request_title") &"', "
	'SQL = SQL & "'"& DateTimeNull &"', "
	'SQL = SQL & "'"& tablePrefix &"', "
	'SQL = SQL & "'products'"
	'SQL = SQL & ");"
	'Set objRs = setExecute( SQL )

	'Set objRs = setExecute(ContentCheck("products", GlobalConfig("General_ProductsPN"), GlobalConfig("site_lang"), GlobalConfig("request_title")))
	OpenRs objRs, ContentCheck("products", GlobalConfig("General_ProductsPN"), GlobalConfig("site_lang"), GlobalConfig("request_title"))
		If objRs.Eof Then
			GlobalConfig("request_option") = "Not Found"
			GlobalConfig("sayfa_ozelsayfa") = 0

		Else

			'// Hit için çerez bırakalım
			Call ContentHits(objRs("ContentID"))

			'// Redirect Url
			Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Products"), "", "", Cdbl(objRs("id")), globalPageid, ""))

			If  objRs("robots_meta") <> "" Then
				Response.AddHeader "X-Robots-Tag", objRs("robots_meta")
				GlobalConfig("HeaderMetaTag") = objRs("robots_meta")
			End If

			GlobalConfig("request_option") = GlobalConfig("General_Products")
			GlobalConfig("request_sayfaid") = objRs("id")
			GlobalConfig("request_sayfa_anaid") = objRs("anaid")

			GlobalConfig("sayfa_ozelsayfa") = objRs("ozel")
			GlobalConfig("sayfa_ozelsayfa_pass") = objRs("pass")

			GlobalConfig("PageTitle") = objRs("title")
			GlobalConfig("PageTitleFix") = objRs("fixed_title")
			GlobalConfig("PageText") = fnPre(ReplaceHR(objRs("text")), GlobalConfig("sBase"))
			'GlobalConfig("TextNull") = objRs("TextNull")

			GlobalConfig("description") = HtmlEncode(objRs("description"))
			GlobalConfig("keyword") = HtmlEncode(objRs("keyword"))

			GlobalConfig("c_date") = objRs("c_date")
			GlobalConfig("m_date") = objRs("m_date")

			GlobalConfig("sayfa_alias") = objRs("alias")
			GlobalConfig("sayfa_hits") = objRs("hit")

			'// Sayfanın üst sayfalarını çağıralım
			Call ewyActiveMenu(GlobalConfig("request_sayfaid"))
			Call ewyPathway(GlobalConfig("General_Categories"), GlobalConfig("request_sayfa_anaid"), GlobalConfig("request_sayfaid"))

			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon"">" & UCase2(GlobalConfig("PageTitle"))
			GlobalConfig("site_ismi") = GlobalConfig("PageTitle")
			If GlobalConfig("PageTitleFix") = "" Then
				GlobalConfig("header_title") = BasHarfBuyuk(GlobalConfig("PageTitle"))
			Else
				GlobalConfig("header_title") = GlobalConfig("PageTitleFix")
			End If

			If GlobalConfig("request_start") > 1 Then
				'GlobalConfig("header_title") = GlobalConfig("header_title") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("PageTitleFix") = GlobalConfig("PageTitleFix") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("site_ismi") = GlobalConfig("site_ismi") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("cpathway") = GlobalConfig("cpathway") & " (" & GlobalConfig("request_start") & ")"

				'If  objRs("HeaderMetaTag") <> "" Then
				'	Response.AddHeader "X-Robots-Tag", "noindex, follow"
				'	GlobalConfig("HeaderMetaTag") = "noindex, follow"
				'End If

			End If

			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "</li> "

			'GlobalConfig("activeMenuid") = GlobalConfig("activeMenuid") & "[" & objRs("menuid")	& "]"
			'Clearfix GlobalConfig("activeMenuid")

		End If
	CloseRs objRs

	GlobalConfig("HeaderLinks") = HeaderLinks("products", GlobalConfig("request_sayfaid"), GlobalConfig("General_ProductsPN"))






Case GlobalConfig("General_Poll")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""

	SQL = ""
	SQL = SQL & "SELECT t1.id" & vbCrLf
	SQL = SQL & "FROM #___anket t1" & vbCrLf
	SQL = SQL & "INNER JOIN #___content_url t2 ON t1.id = t2.parent_id" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	t1.durum = 1" & vbCrLf
	SQL = SQL & "	And t1.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "	And (t1.s_date = '"& DateTimeNull &"' OR t1.s_date Is Null OR t1.s_date <= Now())" & vbCrLf
	SQL = SQL & "	And (t1.e_date = '"& DateTimeNull &"' OR t1.e_date Is Null OR t1.e_date >= Now())" & vbCrLf
	SQL = SQL & "	And t2.parent = "& GlobalConfig("General_PollPN") &"" & vbCrLf
	SQL = SQL & "	And t2.seflink = '"& GlobalConfig("request_title") &"'" & vbCrLf
	SQL = SQL & ");"
	'SQL = setQuery( SQL )
	'Clearfix SQL

	'Set objRs = setExecute(SQL)
	OpenRs objRs, SQL
		If objRs.Eof Then
			GlobalConfig("request_option") = GlobalConfig("General_Poll")
			GlobalConfig("sayfa_ozelsayfa") = 0

		Else

			Call RedirectToUrl(UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Poll"), "", "", Cdbl(objRs("id")), "", ""))

			GlobalConfig("request_option") = GlobalConfig("General_Poll")
			GlobalConfig("request_sayfaid") = Cdbl(objRs("id"))

		End If
	CloseRs objRs







Case GlobalConfig("General_Tags")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""
	'Clearfix GlobalConfig("request_title")
	SQL = ""
	SQL = SQL & "SELECT a.id, a.etiket, a.description, a.keywords, a.robots_meta, b.parent, b.parent_id, b.lang" & vbCrLf
	SQL = SQL & "FROM #___etiket As a" & vbCrLf
	SQL = SQL & "LEFT JOIN #___etiket_id As b ON a.id = b.eid And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	a.status = 1 And a.permalink = '"& GlobalConfig("request_title") &"'" & vbCrLf
	SQL = SQL & ");"
	'Clearfix setQuery( SQL )

	OpenRs objRs, SQL
		If objRs.Eof Then
			'GlobalConfig("request_option") = "Not Found"
			'GlobalConfig("sayfa_ozelsayfa") = 0
			'GlobalConfig("request_title") = ""
			GlobalConfig("request_sayfaid") = 0
			GlobalConfig("site_ismi") = "Etiketler"
			GlobalConfig("header_title") = "Etiketler"
			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon"">[EtiketTitle]</li>"

			strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", "", "", "", "")
			Call RedirectToUrl(strLinks)

		Else

			strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", GlobalConfig("request_title"), "", globalPageid, "")
			Call RedirectToUrl(strLinks)

			If objRs("robots_meta") <> "" Then
				Response.AddHeader "X-Robots-Tag", objRs("robots_meta")
				GlobalConfig("HeaderMetaTag") = objRs("robots_meta")
			End If

			GlobalConfig("request_option") = GlobalConfig("General_Tags")
			GlobalConfig("request_sayfaid") = Cdbl(objRs("id"))

			GlobalConfig("description") = objRs("description")
			GlobalConfig("keyword") = objRs("keywords")

			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon""><a href="""& UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", "", "", "", "") &""" title=""[EtiketTitle]"">[EtiketTitle]</a></li>"
			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon""><a href="""& strLinks &""" title="""& objRs("etiket") &""">" & UCase2(objRs("etiket")) & "</a>"
			GlobalConfig("PageTitle") = objRs("etiket")
			GlobalConfig("PageTitleFix") = ""'objRs("etiket")
			GlobalConfig("header_title") = BasHarfBuyuk(objRs("etiket"))

			If GlobalConfig("PageTitleFix") = "" Then
				GlobalConfig("header_title") = BasHarfBuyuk(GlobalConfig("PageTitle"))
			Else
				GlobalConfig("header_title") = GlobalConfig("PageTitleFix")
			End If

			GlobalConfig("site_ismi") = GlobalConfig("PageTitle")

			If GlobalConfig("request_start") > 1 Then
				'GlobalConfig("header_title") = GlobalConfig("header_title") & " (" & GlobalConfig("request_start") & ")"
				'GlobalConfig("PageTitleFix") = GlobalConfig("PageTitleFix") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("site_ismi") = GlobalConfig("site_ismi") & " (" & GlobalConfig("request_start") & ")"
				GlobalConfig("cpathway") = GlobalConfig("cpathway") & " (" & GlobalConfig("request_start") & ")"

				If  objRs("HeaderMetaTag") <> "" Then
					Response.AddHeader "X-Robots-Tag", "noindex, follow"
					GlobalConfig("HeaderMetaTag") = "noindex, follow"
				End If

			End If




			GlobalConfig("cpathway") = GlobalConfig("cpathway") & "</li> "

			'GlobalConfig("activeMenuid") = GlobalConfig("activeMenuid") & "[" & objRs("menuid")	& "]"
			'Clearfix GlobalConfig("activeMenuid")

		End If
	CloseRs objRs




















Case GlobalConfig("General_Design")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""

'clearfix Left(GlobalConfig("request_title"), Len(GlobalConfig("request_title")) - Len("-su-tesisatcisi"))
Set objRs2 = setExecute("SELECT id, ilce, mahalle, permalink FROM #___mahalle_sayfalari WHERE permalink = '"& Left(GlobalConfig("request_title"), intYap(Len(GlobalConfig("request_title")) - Len("-su-tesisatcisi"), 0)) &"';")
	If objRs2.Eof Then
		GlobalConfig("request_option") = "Not Found"
		GlobalConfig("sayfa_ozelsayfa") = 0

	Else

'If objRs2("mahalle") <> "" Then intid = 57272 Else intid = 57273

SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.id," & vbCrLf
SQL = SQL & "	a.anaid," & vbCrLf
'SQL = SQL & "	a.ozel," & vbCrLf
'SQL = SQL & "	IFNULL(a.pass, '') As pass," & vbCrLf
SQL = SQL & "	IFNULL(a.robots_meta, '') As robots_meta," & vbCrLf
'SQL = SQL & "	# IF(b.text Is Null, 1, 0) As TextNull," & vbCrLf
SQL = SQL & "	b.id As ContentID," & vbCrLf
SQL = SQL & "	IFNULL(b.title, '') As title," & vbCrLf
SQL = SQL & "	IFNULL(b.fixed_title, '') As fixed_title," & vbCrLf
SQL = SQL & "	IFNULL(b.text, '') As text," & vbCrLf
SQL = SQL & "	IFNULL(b.description, '') As description," & vbCrLf
SQL = SQL & "	IFNULL(b.keyword, '') As keyword," & vbCrLf
SQL = SQL & "	b.hit," & vbCrLf
SQL = SQL & "	IFNULL(d.alias, '') As alias" & vbCrLf
'SQL = SQL & "	# (SELECT lang FROM #___content WHERE Not parent = b.parent And parent_id = b.parent_id) As lng," & vbCrLf
'SQL = SQL & "	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date," & vbCrLf
'SQL = SQL & "	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content b ON a.id = b.parent_id" & vbCrLf
'SQL = SQL & "INNER JOIN #___content_url c ON a.id = c.parent_id" & vbCrLf
SQL = SQL & "LEFT OUTER JOIN #___content_template d ON a.typeAlias = d.alias" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	a.durum = 1" & vbCrLf
'SQL = SQL & "And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
'SQL = SQL & "And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
'SQL = SQL & "	And LOWER(c.seflink) = '"& qT &"'" & vbCrLf
If objRs2("mahalle") <> "" Then SQL = SQL & "	And a.id = 57272" & vbCrLf Else SQL = SQL & "	And a.id = 57273" & vbCrLf
SQL = SQL & "	And d.durum = 1" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "Limit 1;"

'clearfix sql
		OpenRs objRs, SQL
			If objRs.Eof Then
				GlobalConfig("request_option") = "Not Found"
				GlobalConfig("sayfa_ozelsayfa") = 0

			Else

				'// Hit için çerez bırakalım
				Call ContentHits(objRs("ContentID"))

				'// Redirect Url
				Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Design"), "", objRs2("permalink") & "-su-tesisatcisi", "", "", ""))

				If  objRs("robots_meta") <> "" Then
					Response.AddHeader "X-Robots-Tag", objRs("robots_meta")
					GlobalConfig("HeaderMetaTag") = objRs("robots_meta")
				End If

				GlobalConfig("request_option") = GlobalConfig("General_Page")
				GlobalConfig("request_sayfaid") = objRs("id")
				GlobalConfig("request_sayfa_anaid") = objRs("anaid")

				'GlobalConfig("sayfa_ozelsayfa") = 0
				'GlobalConfig("sayfa_ozelsayfa_pass") = ""


				If objRs2("mahalle") <> "" Then
					GlobalConfig("PageTitle") = TrimFix(Replace(Replace(Replace(Replace(objRs("title"), "[ilceadi]", ""), "[mahalleadi]", objRs2("mahalle")), " Mahallesi", ""), "Atatürk ", "Atatürk Mahallesi "))
					GlobalConfig("PageTitleFix") = TrimFix(Replace(Replace(Replace(Replace(objRs("fixed_title") & "", "[ilceadi]", ""), "[mahalleadi]", objRs2("mahalle")), " Mahallesi", ""), "Atatürk ", "Atatürk Mahallesi "))
				Else
					GlobalConfig("PageTitle") = TrimFix(Replace(Replace(objRs("title"), "[ilceadi]", objRs2("ilce")), "[mahalleadi]", objRs2("mahalle")))
					GlobalConfig("PageTitleFix") = TrimFix(Replace(Replace(objRs("fixed_title") & "", "[ilceadi]", objRs2("ilce")), "[mahalleadi]", objRs2("mahalle")))
				End If

				GlobalConfig("PageText") = Replace(Replace(fnPre(ReplaceHR(TrimFix(Replace(Replace(objRs("text"), "[ilceadi]", objRs2("ilce")), "[mahalleadi]", objRs2("mahalle")))), GlobalConfig("sRoot")), " <strong></strong>", ""), " <strong><ins><em></em></ins></strong>", "")
				'GlobalConfig("TextNull") = objRs("TextNull")

				GlobalConfig("description") = HtmlEncode(Replace(Replace(objRs("description"), "[ilceadi]", objRs2("ilce")), "[mahalleadi]", objRs2("mahalle")))
				GlobalConfig("keyword") = HtmlEncode(Replace(Replace(Replace(objRs("keyword"), "[ilceadi]", objRs2("ilce")), "[mahalleadi]", objRs2("mahalle")), " Mahallesi", ""))

				'GlobalConfig("c_date") = objRs("c_date")
				'GlobalConfig("m_date") = objRs("m_date")

				GlobalConfig("sayfa_alias") = objRs("alias")
				GlobalConfig("sayfa_hits") = objRs("hit")

				'// Sayfanın üst sayfalarını çağıralım
			Call ewyActiveMenu(GlobalConfig("request_sayfaid"))
				Call ewyPathway(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfa_anaid"))

				GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon""><a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Design"), "", "", "", "", "") &""" title=""Tesisat işleri"">TESİSAT İŞLERİ</a></li> <li class=""icon"">" & UCase2(GlobalConfig("PageTitle"))
				GlobalConfig("site_ismi") = Replace(Replace(GlobalConfig("PageTitle"), " Mahallesi", ""), "Atatürk ", "Atatürk Mahallesi ")
				GlobalConfig("header_title") = Replace(Replace(GlobalConfig("PageTitle"), " Mahallesi", ""), "Atatürk ", "Atatürk Mahallesi ")

				If GlobalConfig("PageTitleFix") = "" Then
					GlobalConfig("header_title") = Replace(Replace(GlobalConfig("PageTitle"), " Mahallesi", ""), "Atatürk ", "Atatürk Mahallesi ")
				Else
					GlobalConfig("header_title") = Replace(Replace(GlobalConfig("PageTitleFix"), " Mahallesi", ""), "Atatürk ", "Atatürk Mahallesi ")
				End If

				If GlobalConfig("request_start") > 1 Then
					'GlobalConfig("header_title") = GlobalConfig("header_title") & " (" & GlobalConfig("request_start") & ")"
					GlobalConfig("PageTitleFix") = GlobalConfig("PageTitleFix") & " (" & GlobalConfig("request_start") & ")"
					GlobalConfig("site_ismi") = GlobalConfig("site_ismi") & " (" & GlobalConfig("request_start") & ")"
					GlobalConfig("cpathway") = GlobalConfig("cpathway") & " (" & GlobalConfig("request_start") & ")"
				End If

				GlobalConfig("cpathway") = GlobalConfig("cpathway") & "</li> "

			'GlobalConfig("activeMenuid") = GlobalConfig("activeMenuid") & "[" & objRs("menuid")	& "]"
			'Clearfix GlobalConfig("activeMenuid")

			End If
		CloseRs objRs

		'GlobalConfig("HeaderLinks") = HeaderLinks("sayfa", GlobalConfig("request_sayfaid"), GlobalConfig("General_Page"))

	End If
Set objRs2 = Nothing
















Case GlobalConfig("General_Search")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""

If Site_HTTP_HOST = "www.webtasarimx.net" Then
	If GlobalConfig("request_q") = "arama" Then GlobalConfig("request_q") = "arama motoru optimizasyon"
	If GlobalConfig("request_q") = "demo" Then GlobalConfig("request_q") = "demo içerik yönetimi"
	If GlobalConfig("request_q") = "metin" Then GlobalConfig("request_q") = "html css metin biçimlendirme"
	If GlobalConfig("request_q") = "ticaret" Then GlobalConfig("request_q") = "ttk ticaret kanunu"
	If GlobalConfig("request_q") = "access" Then GlobalConfig("request_q") = "microsoft access veritabanı"
	If GlobalConfig("request_q") = "cascading" Then GlobalConfig("request_q") = "css cascading style sheets"
	If GlobalConfig("request_q") = "prof." Then GlobalConfig("request_q") = "prof. dr. ünal tekinalp"
	If GlobalConfig("request_q") = "para cezas" Or GlobalConfig("request_q") = "para" Then GlobalConfig("request_q") = "web sitesi olmayana para cezası"
	If GlobalConfig("request_q") = "html" Then GlobalConfig("request_q") = "html hypertext markup language"
	If GlobalConfig("request_q") = "optimize" Then GlobalConfig("request_q") = "web site optimize"
	If GlobalConfig("request_q") = "browser" Then GlobalConfig("request_q") = "cross browser"
	If GlobalConfig("request_q") = "html 5 destekleyen web taray" Then GlobalConfig("request_q") = "html 5 destekleyen web tarayıcıları"
	If GlobalConfig("request_q") = "standard" Then GlobalConfig("request_q") = "html kodlama standartları"
	If GlobalConfig("request_q") = "dinamik i" Then GlobalConfig("request_q") = "dinamik içerik yönetimi"
	If GlobalConfig("request_q") = "ip" Then GlobalConfig("request_q") = "ip adresi"
	'Clearfix GlobalConfig("request_q")
End If

	If Not CBool(sqlQuery("SELECT Count(id) As Toplam FROM #___etiketler WHERE kelime = '"& sqlGuvenlik(GlobalConfig("request_q"), 1) &"';", 0)) Then
		sqlExecute("INSERT INTO #___etiketler (kelime, hit, status) VALUES('"& sqlGuvenlik(GlobalConfig("request_q"), 1) &"', 1, 0);")
	Else
		sqlExecute("UPDATE #___etiketler Set hit = hit + 1 WHERE kelime = '"& sqlGuvenlik(GlobalConfig("request_q"), 1) &"';")
	End If

	'GlobalConfig("request_q") = sqlQuery("SELECT kelime FROM #___etiketler WHERE kelime = '"& Temizle(GlobalConfig("request_q"), 1) &"';", "")

	Set objRs = setExecute("SELECT status, kelime FROM #___etiketler WHERE kelime = '"& sqlGuvenlik(GlobalConfig("request_q"), 1) &"';")
		If Not objRs.Eof Then
			If  objRs("status") = 0 Then
				Response.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
				GlobalConfig("HeaderMetaTag") = "noindex, nofollow, noarchive, noimageindex"
			End If
			GlobalConfig("request_q") = objRs("kelime")
		End If
	Set objRs = Nothing

	'Set objRs2 = setExecute("SELECT title, kelime FROM #___etiketler ORDER BY Rand() Limit 10;")
	'	Do While Not objRs2.Eof
	'		Response.Write("<li><h4><a href="""& GlobalConfig("sRoot") & "arama/" & UrlEncode(objRs2("link")) &""" class=""tag-btn""><span>"& objRs2("title") &"</span></a></h4></li>" & vbCrLf)
	'	objRs2.MoveNext() : Loop
	'Set objRs2 = Nothing

	Dim strSearchURL
	strSearchURL = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Search"), GlobalConfig("request_q"), "", "", globalPageid, "")
	'Clearfix GlobalConfig("request_q") & " <br/> " & Request.ServerVariables("QUERY_STRiNG") & " <br/> " & strSearchURL
	Call RedirectToUrl(strSearchURL)


	If Not GlobalConfig("request_start") > 1 Then

		GlobalConfig("keyword") = GlobalConfig("request_q")
		'GlobalConfig("keyword") = GlobalConfig("keyword") & ", web tasarım, webdizayni, " & Replace(GlobalConfig("request_q"), " ", ", ") & ", webtasarım, webdizayn, webdizayni.org"

		If Site_HTTP_HOST = "www.webtasarimx.net" Then
			If inStr(1, GlobalConfig("request_q"), "design", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "dizayn", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "dızayn", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "tasarım", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "tasarim", 1) > 0 Then GlobalConfig("description") = BasHarfBuyuk(GlobalConfig("request_q")) & " - Freelancer olarak web tasarım hizmeti veriyoruz. +90 546 831 2073 - Freelance Webmaster - Webcoder" : GlobalConfig("keyword") = GlobalConfig("request_q") & ", web tasarım, webdizayni, " & Replace(GlobalConfig("request_q"), " ", ", ") & ", webtasarım, webdizayn, webdizayni.org"

			If inStr(1, GlobalConfig("request_q"), "yazılım", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "yazilim", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "programlama", 1) > 0 Then GlobalConfig("description") = BasHarfBuyuk(GlobalConfig("request_q")) & " - Freelancer olarak web dizayn ve asp mysql web yazılım hizmeti veriyoruz. +90 546 831 2073 - asp webcoder" : GlobalConfig("keyword") = GlobalConfig("request_q") & ", " & Replace(GlobalConfig("request_q"), " ", ", ")

			If inStr(1, GlobalConfig("request_q"), "html", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "css", 1) > 0 Or _
			inStr(1, GlobalConfig("request_q"), "geliştir", 1) > 0 Then GlobalConfig("description") = BasHarfBuyuk(GlobalConfig("request_q")) & " - Freelancer olarak web dizayn ve html css arayüz geliştirme hizmeti veriyoruz. +90 546 831 2073 - psd to html css tasarımcı" : GlobalConfig("keyword") = GlobalConfig("request_q") & ", " & Replace(GlobalConfig("request_q"), " ", ", ")
		End If

	End If

	GlobalConfig("request_q") = HtmlEncode(GlobalConfig("request_q"))
	GlobalConfig("cpathway") = "<li class=""icon""><a href="""& GlobalConfig("sBase") &""" title=""[AramaTitle]"">[AramaTitle]</a></li> <li class=""icon""><a href="""& strSearchURL &""" title="""& BasHarfBuyuk(GlobalConfig("request_q")) &""">" & UCase2(GlobalConfig("request_q"))
	GlobalConfig("site_ismi") = GlobalConfig("request_q")
	GlobalConfig("header_title") = BasHarfBuyuk(GlobalConfig("request_q"))

	If GlobalConfig("request_start") > 1 Then
		'GlobalConfig("header_title") = GlobalConfig("header_title") & " (" & GlobalConfig("request_start") & ")"
		GlobalConfig("site_ismi") = GlobalConfig("site_ismi") & " (" & GlobalConfig("request_start") & ")"
		GlobalConfig("cpathway") = GlobalConfig("cpathway") & " (" & GlobalConfig("request_start") & ")"
	End If
	GlobalConfig("cpathway") = GlobalConfig("cpathway") & "</a></li> "

	








Case GlobalConfig("General_Whois"), GlobalConfig("General_Whois2")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""

	Dim strWhoisURL
	strWhoisURL = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Whois"), GlobalConfig("request_domain"), "", "", "", "")
	Call RedirectToUrl(strWhoisURL)

	GlobalConfig("request_domain") = HtmlEncode(Replace(GlobalConfig("request_domain"), "_", "."))
	GlobalConfig("cpathway") = "<li class=""icon""><a href="""& GlobalConfig("sBase") &""" title=""WHOIS BİLGİLERİ"">WHOIS BİLGİLERİ</a></li> "
	GlobalConfig("cpathway") = GlobalConfig("cpathway") & "<li class=""icon""><a href="""& strWhoisURL &""" title="""& BasHarfBuyuk(GlobalConfig("request_domain")) &""">" & UCase2(GlobalConfig("request_domain")) & "</a></li> "
	GlobalConfig("site_ismi") = GlobalConfig("request_domain") & " Whois Bilgileri"
	GlobalConfig("header_title") = GlobalConfig("request_domain") & " Whois Bilgileri"








Case GlobalConfig("General_Sitemap")
	Response.AddHeader "X-Robots-Tag", "noindex, follow"
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""
	Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Sitemap"), GlobalConfig("request_domain"), "", "", "", ""))








Case GlobalConfig("General_Redirect"), GlobalConfig("General_Post")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""
	Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("request_option"), GlobalConfig("request_task"), GlobalConfig("request_title"), GlobalConfig("request_globalid"), "", ""))








Case GlobalConfig("General_Rss")
	GlobalConfig("description") = "" : GlobalConfig("keyword") = ""
	Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Rss"), "", "", "", "", ""))






End Select












'// Prev, Next Page And Alternate Languages Page Link
Function HeaderLinks(ByVal TableName, ByVal ContentID, ByVal Contents)
	Dim SQL, objRs, strLinks, strTitle, strTitle2

	HeaderLinks = ""

	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, IF((b.fixed_title = '' Or b.fixed_title is Null), b.title, b.fixed_title) As title, b.lang" & vbCrLf
	SQL = SQL & "FROM #___"& TableName &" As a" & vbCrLf
	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "LEFT OUTER JOIN (SELECT parent, parent_id, seflink, durum FROM #___content_url Limit 1) As c ON a.id = c.parent_id And b.parent = c.parent And Not Left(c.seflink, 4) = 'url=' And c.durum = 1" & vbCrLf
	SQL = SQL & "WHERE" & vbCrLf
	SQL = SQL & "	a.id > "& ContentID &"" & vbCrLf
	SQL = SQL & "	And b.parent = "& Contents &"" & vbCrLf
	SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "ORDER BY a.id ASC Limit 1;" & vbCrLf
	'Clearfix setQuery(SQL)
	OpenRs objRs, SQL
		If Not objRs.Eof Then
			strTitle = objRs("title") & ""
			strLinks = UrlWrite(GlobalConfig("sDomain"), objRs("lang"), ParentNumber(Contents), "", "", objRs("id"), "", "")
			If Not strLinks = "javascript:;" Then _
			HeaderLinks = HeaderLinks & "<link rel=""next"" title="""& BasHarfBuyuk(strTitle) &""" href="""& strLinks &""" />" & vbCrLf
		End If
	CloseRs objRs

	OpenRs objRs, Replace(Replace(SQL, "a.id > ", "a.id <"), "ASC", "DESC")
		If Not objRs.Eof Then
			strTitle = objRs("title") & ""
			strLinks = UrlWrite(GlobalConfig("sDomain"), objRs("lang"), ParentNumber(Contents), "", "", objRs("id"), "", "")
			If Not strLinks = "javascript:;" Then _
				HeaderLinks = HeaderLinks & "<link rel=""prev"" title="""& BasHarfBuyuk(strTitle) &""" href="""& strLinks &""" />" & vbCrLf
		End If
	CloseRs objRs

	OpenRs objRs, Replace(Replace(Replace(SQL, "a.id >", "a.id ="), "b.lang =", "Not b.lang ="), " Limit 1;", ";")
		Do While Not objRs.Eof
			strTitle = objRs("title") & ""
			strLinks = UrlWrite(GlobalConfig("sDomain"), objRs("lang"), ParentNumber(Contents), "", "", objRs("id"), "", "")
			If Not strLinks = "javascript:;" Then _
				HeaderLinks = HeaderLinks & "<link rel=""alternate"" hreflang="""& LCase(objRs("lang")) &""" title="""& BasHarfBuyuk(strTitle) &""" href="""& strLinks &""" />" & vbCrLf
		objRs.MoveNext : Loop
	CloseRs objRs
End Function









If Response.Status = "404" Then
	Response.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
	GlobalConfig("HeaderMetaTag") = "noindex, nofollow, noarchive, noimageindex"
End If










'// Şu dillerde geçerli
'Dim langs : langs = Array()
'Sub DigerDillerde()
'
'	SQL = ""
'	SQL = SQL & "SELECT" & vbCrLf
'	SQL = SQL & "	a.id, b.lang, b.title, b.text, d.orj_title As LangTitle, d.not_available_text" & vbCrLf
'	'SQL = SQL & "	/*," & vbCrLf
'	'SQL = SQL & "	(" & vbCrLf
'	'SQL = SQL & "		SELECT seflink" & vbCrLf
'	'SQL = SQL & "		FROM #___content_url" & vbCrLf
'	'SQL = SQL & "		WHERE" & vbCrLf
'	'SQL = SQL & "			IF(durum, 1, 0)" & vbCrLf
'	'SQL = SQL & "			And parent_id = a.id" & vbCrLf
'	'SQL = SQL & "			And lang = b.lang" & vbCrLf
'	'SQL = SQL & "			Limit 1" & vbCrLf
'	'SQL = SQL & "	) As seflink" & vbCrLf
'	'SQL = SQL & "	*/" & vbCrLf
'	SQL = SQL & "FROM #___sayfa As a" & vbCrLf
'	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
'	SQL = SQL & "INNER JOIN #___content_url As c ON a.id = c.parent_id" & vbCrLf
'	SQL = SQL & "INNER JOIN #___languages As d ON b.lang = d.lng" & vbCrLf
'	SQL = SQL & "WHERE (" & vbCrLf
'	SQL = SQL & "	IF(a.durum, 1, 0)" & vbCrLf
'	'SQL = SQL & "	And a.id = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
'	SQL = SQL & "	And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
'	SQL = SQL & "	And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
'	'SQL = SQL & "	And b.title Is Not Null" & vbCrLf
'	SQL = SQL & "	And b.text Is Not Null" & vbCrLf
'	SQL = SQL & "	And b.parent = '"& GlobalConfig("General_Page") &"'" & vbCrLf
'	SQL = SQL & "	And Not b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
'	SQL = SQL & "	And Lower(c.seflink) = '"& GlobalConfig("request_title") &"'" & vbCrLf
'	SQL = SQL & "	And IF(d.durum, 1, 0)" & vbCrLf
'	'SQL = SQL & "	And '1' = '"& GlobalConfig("TextNull") &"'" & vbCrLf
'	SQL = SQL & ")" & vbCrLf
'	SQL = SQL & "ORDER BY IF(d.default_lng, 1, 0) DESC, d.sira ASC;"
'	'SQL = setQuery( SQL )
'	'Clearfix SQL
'	Set objRs = setExecute( SQL )
'	If Not objRs.Eof Then
'		Do While Not objRs.Eof
'
'				intCurr = Ubound( langs ) + 1
'				Redim Preserve langs( intCurr )
'
'				langs( intCurr ) = "<a href="""& UrlWrite(GlobalConfig("sDomain"), cstr(objRs("lang")), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", "") &""" title="""& objRs("LangTitle") &""">" & objRs("LangTitle") & "</a>"
'				'langs( intCurr ) = objRs("LangTitle")
'
'		objRs.MoveNext : Loop
'		'GlobalConfig("not_available_lang") = "Üzgünüm, bu içerik sadece %LANG:, : ve % dilinde geçerli."
'		GlobalConfig("not_available_lang") = "Bu içerik %LANG:, : ve % dillerinde de mevcut."
'	End If
'	Set objRs = Nothing
'End Sub

'Call DigerDillerde()

'If isArray(langs) Then GlobalConfig("PageText") = GlobalConfig("PageText") & DilYoksa(GlobalConfig("not_available_lang"), langs)


'Private Function DilYoksa(ByVal text, ByVal lang)
'	text = text & ""
'	If text = "" Then Exit Function
'	Dim arrLng, xxx, intCurr, SonEk
'	arrLng = Array()
'	'lang = Join(lang, ", ")
'	'lang = Split(lang, ", ")
'	For xxx = 1 To UBound(lang)
'		intCurr = UBound(arrLng) + 1
'		ReDim Preserve arrLng(intCurr)
'		arrLng(intCurr) = lang(xxx - 1)
'	Next
'
'	SonEk = Join(arrLng, ", ")
'	If UBound(lang) > 0 Then
'		'SonEk = Join(arrLng, ", ") & "$2" & lang(UBound(lang))
'		SonEk = SonEk & "$2" & lang(UBound(lang))
'	End If
'
'	Dim oReg
'	Set oReg = New RegExp
'		oReg.IgnoreCase = True
'		oReg.MultiLine = True
'		oReg.Global = True
'		oReg.Pattern = "%LANG:([^:]*):([^%]*)%"
'		text = oReg.Replace(text, SonEk)
'	Set oReg = Nothing
'	DilYoksa = text
'End Function

'Response.contenttype = "text/plain"
'GlobalConfig("PageText") = GlobalConfig("PageTitle") & GlobalConfig("PageText")
'Dim st
'For i = 1 To Len(GlobalConfig("PageText"))
'	st = Mid(GlobalConfig("PageText"), i, 1)
'	Response.Write(st & " : " & ascw(st)  & vbCrLf)
'
'Next

'Response.End
%>
