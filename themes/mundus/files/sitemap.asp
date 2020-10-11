<%
'// Energy Sitemap Scripti
With Response
	.Clear()
	.CacheControl = "no-cache"
	.CacheControl = "no-store"
	.AddHeader "pragma", "no-cache"
	.ContentType = "text/xml"
End With








Sub SiteMapUrlListesi(ByVal domain, ByVal parent, ByVal parent_id)
		Dim SQL, objRs, objRs2, strLinks
		'// Sayfa Menü İçerik
		SQL = ""
		SQL = SQL & "SELECT" & vbCrLf
		SQL = SQL & "    a.id, b.lang, (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = a.id ORDER BY DateTimes DESC Limit 1) As DTime" & vbCrLf
		SQL = SQL & "FROM #___sayfa As a" & vbCrLf
		SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
		SQL = SQL & "INNER JOIN #___content_url As c ON a.id = c.parent_id And b.parent = c.parent And Not Left(c.seflink, 4) = 'url='" & vbCrLf
		SQL = SQL & "WHERE (" & vbCrLf
		SQL = SQL & "    a.durum = 1" & vbCrLf
		SQL = SQL & "    And a.activeLink = 1" & vbCrLf
		SQL = SQL & "    And a.anaid = "& parent_id &"" & vbCrLf
		SQL = SQL & "    And b.parent = "& parent &"" & vbCrLf
		SQL = SQL & "    And c.durum = 1" & vbCrLf
		SQL = SQL & ") " & vbCrLf
		SQL = SQL & "ORDER BY b.lang DESC;" & vbCrLf
		'Clearfix SQL
		Set objRs = setExecute(SQL)
			Do While Not objRs.Eof

				strLinks = UrlDecode(UrlWrite(domain, objRs("lang"), ParentNumber(parent), "", "", objRs("id"), "", ""))

				If Not strLinks = "javascript:;" Then

					Response.Write "	<url>" & vbCrLf
					Response.Write "		<loc>"& strLinks &"</loc>" & vbCrLf

						Set objRs2 = setExecute("SELECT resim, title, alt, text FROM #___files WHERE durum = 1 And file_type = 1 And parent_id = "& objRs("id") &" And parent = "& parent &" And lang = '"& objRs("lang") &"';")
							Do While Not objRs2.Eof
								Response.Write "		<image:image>" & vbCrLf
								Response.Write "			<image:loc>"& domain & sFolder(objRs("id"), 0) & "/" & objRs2("resim") &"</image:loc>" & vbCrLf
								Response.Write "			<image:title><![CDATA[" & HtmlEncode(objRs2("title")) & "]]></image:title>" & vbCrLf
								If objRs2("alt") <> "" Or objRs2("text") <> "" Then
									Response.Write "			<image:caption><![CDATA["

									If objRs2("alt") <> "" Then _
										Response.Write HtmlEncode(objRs2("alt"))

									If objRs2("text") <> "" Then _
										Response.Write vbCrLf & objRs2("text")

									Response.Write "]]></image:caption>" & vbCrLf
								End If
								Response.Write "		</image:image>" & vbCrLf
							objRs2.MoveNext() : Loop
						Set objRs2 = Nothing

					Response.Write "		<lastmod>"& Replace(DateSqlFormat(objRs("DTime"), "yy-mm-dd", 1), " ", "T") &"+02:00</lastmod>" & vbCrLf
					Response.Write "		<changefreq>weekly</changefreq>" & vbCrLf
					Response.Write "		<priority>0.6</priority>" & vbCrLf
					Response.Write "	</url>" & vbCrLf

					Call SiteMapUrlListesi(domain, parent, objRs("id"))

				End If
			objRs.MoveNext() : Loop
		Set objRs = Nothing

End Sub




Sub SiteMapKategoriUrlListesi(ByVal domain, ByVal parent, ByVal parent_id)
		Dim SQL, objRs, objRs2, strLinks
		'// Sayfa Menü İçerik
		SQL = ""
		SQL = SQL & "SELECT" & vbCrLf
		SQL = SQL & "    a.id, b.lang, (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = a.id ORDER BY DateTimes DESC Limit 1) As DTime" & vbCrLf
		SQL = SQL & "FROM #___kategori As a" & vbCrLf
		SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
		SQL = SQL & "INNER JOIN #___content_url As c ON a.id = c.parent_id And b.parent = c.parent And Not Left(c.seflink, 4) = 'url='" & vbCrLf
		SQL = SQL & "WHERE (" & vbCrLf
		SQL = SQL & "    a.durum = 1" & vbCrLf
		SQL = SQL & "    And a.activeLink = 1" & vbCrLf
		SQL = SQL & "    And a.anaid = "& parent_id &"" & vbCrLf
		SQL = SQL & "    And b.parent = "& parent &"" & vbCrLf
		SQL = SQL & "    And c.durum = 1" & vbCrLf
		SQL = SQL & ") " & vbCrLf
		SQL = SQL & "ORDER BY b.lang DESC;" & vbCrLf
		'Clearfix SQL
		Set objRs = setExecute(SQL)
			Do While Not objRs.Eof

				strLinks = UrlDecode(UrlWrite(domain, objRs("lang"), ParentNumber(parent), "", "", objRs("id"), "", ""))

				If Not strLinks = "javascript:;" Then

					Response.Write "	<url>" & vbCrLf
					Response.Write "		<loc>"& strLinks &"</loc>" & vbCrLf

						Set objRs2 = setExecute("SELECT resim, title, alt, text FROM #___files WHERE durum = 1 And file_type = 1 And parent_id = "& objRs("id") &" And parent = "& parent &" And lang = '"& objRs("lang") &"';")
							Do While Not objRs2.Eof
								Response.Write "		<image:image>" & vbCrLf
								Response.Write "			<image:loc>"& domain & kFolder(objRs("id"), 0) & "/" & objRs2("resim") &"</image:loc>" & vbCrLf
								Response.Write "			<image:title><![CDATA[" & HtmlEncode(objRs2("title")) & "]]></image:title>" & vbCrLf
								If objRs2("alt") <> "" Or objRs2("text") <> "" Then
									Response.Write "			<image:caption><![CDATA["

									If objRs2("alt") <> "" Then _
										Response.Write HtmlEncode(objRs2("alt"))

									If objRs2("text") <> "" Then _
										Response.Write vbCrLf & objRs2("text")

									Response.Write "]]></image:caption>" & vbCrLf
								End If
								Response.Write "		</image:image>" & vbCrLf
							objRs2.MoveNext() : Loop
						Set objRs2 = Nothing

					Response.Write "		<lastmod>"& Replace(DateSqlFormat(objRs("DTime"), "yy-mm-dd", 1), " ", "T") &"+02:00</lastmod>" & vbCrLf
					Response.Write "		<changefreq>weekly</changefreq>" & vbCrLf
					Response.Write "		<priority>0.6</priority>" & vbCrLf
					Response.Write "	</url>" & vbCrLf

					Call SiteMapUrlListesi(domain, parent, objRs("id"))
					Call SiteMapUrunUrlListesi(domain, GlobalConfig("General_ProductsPN"), objRs("id"))

				End If
			objRs.MoveNext() : Loop
		Set objRs = Nothing

End Sub







Sub SiteMapUrunUrlListesi(ByVal domain, ByVal parent, ByVal parent_id)
		Dim SQL, objRs, objRs2, strLinks
		'// Sayfa Menü İçerik
		SQL = ""
		SQL = SQL & "SELECT" & vbCrLf
		SQL = SQL & "    a.id, b.lang, (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = a.id ORDER BY DateTimes DESC Limit 1) As DTime" & vbCrLf
		SQL = SQL & "FROM #___products As a" & vbCrLf
		SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
		SQL = SQL & "INNER JOIN #___content_url As c ON a.id = c.parent_id And b.parent = c.parent And Not Left(c.seflink, 4) = 'url='" & vbCrLf
		SQL = SQL & "WHERE (" & vbCrLf
		SQL = SQL & "    a.durum = 1" & vbCrLf
		'SQL = SQL & "    And a.activeLink = 1" & vbCrLf
		SQL = SQL & "    And a.anaid = "& parent_id &"" & vbCrLf
		SQL = SQL & "    And b.parent = "& parent &"" & vbCrLf
		SQL = SQL & "    And c.durum = 1" & vbCrLf
		SQL = SQL & ") " & vbCrLf
		SQL = SQL & "ORDER BY b.lang DESC;" & vbCrLf
		'Clearfix SQL
		Set objRs = setExecute(SQL)
			Do While Not objRs.Eof

				strLinks = UrlDecode(UrlWrite(domain, objRs("lang"), ParentNumber(parent), "", "", objRs("id"), "", ""))

				If Not strLinks = "javascript:;" Then

					Response.Write "	<url>" & vbCrLf
					Response.Write "		<loc>"& strLinks &"</loc>" & vbCrLf

						Set objRs2 = setExecute("SELECT resim, title, alt, text FROM #___files WHERE durum = 1 And file_type = 1 And parent_id = "& objRs("id") &" And parent = "& parent &" And lang = '"& objRs("lang") &"';")
							Do While Not objRs2.Eof
								Response.Write "		<image:image>" & vbCrLf
								Response.Write "			<image:loc>"& domain & pFolder(objRs("id"), 0) & "/" & objRs2("resim") &"</image:loc>" & vbCrLf
								Response.Write "			<image:title><![CDATA[" & HtmlEncode(objRs2("title")) & "]]></image:title>" & vbCrLf
								If objRs2("alt") <> "" Or objRs2("text") <> "" Then
									Response.Write "			<image:caption><![CDATA["

									If objRs2("alt") <> "" Then _
										Response.Write HtmlEncode(objRs2("alt"))

									If objRs2("text") <> "" Then _
										Response.Write vbCrLf & objRs2("text")

									Response.Write "]]></image:caption>" & vbCrLf
								End If
								Response.Write "		</image:image>" & vbCrLf
							objRs2.MoveNext() : Loop
						Set objRs2 = Nothing

					Response.Write "		<lastmod>"& Replace(DateSqlFormat(objRs("DTime"), "yy-mm-dd", 1), " ", "T") &"+02:00</lastmod>" & vbCrLf
					Response.Write "		<changefreq>weekly</changefreq>" & vbCrLf
					Response.Write "		<priority>0.6</priority>" & vbCrLf
					Response.Write "	</url>" & vbCrLf

					'Call SiteMapUrlListesi(domain, parent, objRs("id"))

				End If
			objRs.MoveNext() : Loop
		Set objRs = Nothing

End Sub



















MapWrite = ""
'strDomain = Split(E_SiteURL, ",")
'Response.Write Ubound(strDomain)
'For i = 0 To Ubound(strDomain)
'Clearfix Site_HTTP_HOST
If (Left(Site_LOCAL_ADDR, 7) = "192.168" Or Site_LOCAL_ADDR = "127.0.0.1") And Not inStr(1, GlobalConfig("domain"), Site_HTTP_HOST, 1) > 0 Then GlobalConfig("domain") = Site_HTTP_HOST & ", " & GlobalConfig("domain")

For Each SitemapDomain in Split(GlobalConfig("domain"), ",")
	SitemapDomain = Trim( SitemapDomain )
	'SiteDomain2 = Trim(strDomain(i))

	If Site_HTTP_HOST = SitemapDomain Then

		Response.Write "<?xml version=""1.0"" encoding=""utf-8""?>" & vbCrLf & vbCrLf

		Response.Write "<" & "!--" & vbCrLf
		Response.Write "    Copyright © 2008 - " & Year(Date()) & vbCrLf
		Response.Write "    Energy Web Yazılım - İstanbul" & vbCrLf
		Response.Write "    -+- Energy Sitemap Modülü -+-" & vbCrLf
		Response.Write "    Web Site   : www.webtasarimx.net" & vbCrLf
		Response.Write "    Web Site 2 : www.webtasarimx.net" & vbCrLf
		Response.Write "    Mail & Msn : bilgi@webtasarimx.net" & vbCrLf
		Response.Write "    Telefon    : 0546 831 2073" & vbCrLf
		Response.Write "//--" & ">" & vbCrLf & vbCrLf

		Response.Write "<?xml-stylesheet type=""text/xsl"" href=""" & GlobalConfig("sRoot") & "xsl/sitemap.xsl""?>" & vbCrLf
		Response.Write "<urlset xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""" & vbCrLf
		Response.Write vbTab & "xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9""" & vbCrLf
		Response.Write vbTab & "xsi:schemaLocation=""http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd""" & vbCrLf
		Response.Write vbTab & "xmlns:image=""http://www.google.com/schemas/sitemap-image/1.1"">" & vbCrLf

		SitemapDomain = "http://" & SitemapDomain

		If isArray(ActiveLanguages) Then
			'Randomize
			For Each item in ActiveLanguages
				'// Url Write
				Response.Write "	<url>" & vbCrLf
				Response.Write "		<loc>" & UrlWrite(SitemapDomain, item, GlobalConfig("General_Home"), "", "", "", "", "") & "</loc>" & vbCrLf

				'// Ana Sayfa Banner
				SQL = ""
				SQL = SQL & "SELECT" & vbCrLf
				SQL = SQL & "    t1.title, t1.alt, t1.img, t1.text" & vbCrLf
				SQL = SQL & "FROM #___banner t1" & vbCrLf
				SQL = SQL & "WHERE (" & vbCrLf
				SQL = SQL & "	t1.durum = 1" & vbCrLf
				SQL = SQL & "    And t1.lang = '"& item &"'" & vbCrLf
				SQL = SQL & ") " & vbCrLf
				SQL = SQL & "ORDER BY t1.sira ASC;" & vbCrLf
				Set objRs = setExecute(SQL)
					Do While Not objRs.Eof

						Response.Write "		<image:image>" & vbCrLf
						Response.Write "			<image:loc>"& SitemapDomain & bFolder & "/" & objRs("img") &"</image:loc>" & vbCrLf
						Response.Write "			<image:title><![CDATA[" & HtmlEncode(objRs("title")) & "]]></image:title>" & vbCrLf
						If objRs("alt") <> "" Or objRs("text") <> "" Then
							Response.Write "			<image:caption><![CDATA["

							If objRs("alt") <> "" Then _
								Response.Write HtmlEncode(objRs("alt"))

							If objRs("text") <> "" Then _
								Response.Write vbCrLf & objRs("text")

							Response.Write "]]></image:caption>" & vbCrLf
						End If
						Response.Write "		</image:image>" & vbCrLf
					objRs.MoveNext() : Loop
				Set objRs = Nothing
				
				'Response.Write "		<lastmod>"& DateSqlFormat(Now(), "yy-mm-dd", 0) & "T" & (Time() - Rnd) &"+02:00</lastmod>" & vbCrLf
				Response.Write "		<changefreq>daily</changefreq>" & vbCrLf ' 2012-05-23T08:40:20+00:00
				Response.Write "		<priority>1.0</priority>" & vbCrLf
				Response.Write "	</url>" & vbCrLf
			Next
		End If

		'// Sayfa Url Listesi
		Call SiteMapUrlListesi(SitemapDomain, GlobalConfig("General_PagePN"), 0)


		'// Kategori Url Listesi
		Call SiteMapKategoriUrlListesi(SitemapDomain, GlobalConfig("General_CategoriesPN"), 0)


		Set objRs = setExecute("SELECT a.permalink, b.lang FROM #___etiket As a INNER JOIN #___etiket_id As b ON a.id = b.eid WHERE a.status = 1 ORDER BY a.id DESC Limit 150;")
			Do While Not objRs.Eof
				strLinks = UrlWrite(SitemapDomain, objRs("lang"), GlobalConfig("General_Tags"), "", objRs("permalink"), "", "", "")
				Response.Write "	<url>" & vbCrLf
				Response.Write "		<loc>"& strLinks &"</loc>" & vbCrLf
				Response.Write "		<changefreq>weekly</changefreq>" & vbCrLf
				Response.Write "		<priority>0.4</priority>" & vbCrLf
				Response.Write "	</url>" & vbCrLf
			objRs.MoveNext() : Loop
		Set objRs = Nothing

		'Set objRs = setExecute("SELECT kelime FROM #___etiketler WHERE status = 1 ORDER BY kelime ASC;")
		'	Do While Not objRs.Eof
		'	strLinks = UrlWrite(SitemapDomain, "", GlobalConfig("General_Search"), LCase2(Replace(Replace(UrlEncode(objRs("kelime")), " ", "+"), "%20", "+")), "", "", "", "")
		'	Response.Write "	<url>" & vbCrLf
		'	Response.Write "		<loc>"& strLinks &"</loc>" & vbCrLf
		'	Response.Write "		<changefreq>weekly</changefreq>" & vbCrLf
		'	Response.Write "		<priority>0.3</priority>" & vbCrLf
		'	Response.Write "	</url>" & vbCrLf
		'	objRs.MoveNext() : Loop
		'Set objRs = Nothing

		Response.Write "</urlset>" & vbCrLf
		'Response.Write( MapWrite )

	End If
Next
%>
