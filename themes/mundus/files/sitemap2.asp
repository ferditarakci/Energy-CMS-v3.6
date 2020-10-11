<%
'// Energy Sitemap Scripti
With Response
	.Clear()
	.CacheControl = "no-cache"
	.CacheControl = "no-store"
	.AddHeader "pragma", "no-cache"
	.ContentType = "text/xml"
End With

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

		MapWrite = "<?xml version=""1.0"" encoding=""utf-8""?>" & vbCrLf & vbCrLf

		MapWrite = MapWrite & "&lt;!--" & vbCrLf
		MapWrite = MapWrite & "    Copyright © 2008 - " & Year(Date()) & vbCrLf
		MapWrite = MapWrite & "    Energy Web Yazılım - İstanbul" & vbCrLf
		MapWrite = MapWrite & "    -+- Energy Sitemap Modülü -+-" & vbCrLf
		MapWrite = MapWrite & "    Web Site   : www.webtasarimx.net" & vbCrLf
		MapWrite = MapWrite & "    Web Site 2 : www.webtasarimx.net" & vbCrLf
		MapWrite = MapWrite & "    Mail & Msn : bilgi@webtasarimx.net" & vbCrLf
		MapWrite = MapWrite & "    Telefon    : 0546 831 2073" & vbCrLf
		MapWrite = MapWrite & "//--&gt;" & vbCrLf & vbCrLf
		MapWrite = Duzenle(MapWrite)

		MapWrite = MapWrite & "<?xml-stylesheet type=""text/xsl"" href=""" & GlobalConfig("sRoot") & "xsl/sitemap.xsl""?>" & vbCrLf
		MapWrite = MapWrite & "<urlset xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""" & vbCrLf
		MapWrite = MapWrite & vbTab & "xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9""" & vbCrLf
		MapWrite = MapWrite & vbTab & "xsi:schemaLocation=""http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd""" & vbCrLf
		MapWrite = MapWrite & vbTab & "xmlns:image=""http://www.google.com/schemas/sitemap-image/1.1"">" & vbCrLf

		SitemapDomain = "http://" & SitemapDomain

		If isArray(ActiveLanguages) Then
			Randomize
			For Each item in ActiveLanguages
				'// Url Write
				MapWrite = MapWrite & "	<url>" & vbCrLf
				MapWrite = MapWrite & "		<loc>" & UrlWrite(SitemapDomain, item, GlobalConfig("General_Home"), "", "", "", "", "") & "</loc>" & vbCrLf

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

						MapWrite = MapWrite & "		<image:image>" & vbCrLf
						MapWrite = MapWrite & "			<image:loc>"& SitemapDomain & bFolder & "/" & objRs("img") &"</image:loc>" & vbCrLf
						MapWrite = MapWrite & "			<image:title><![CDATA[" & HtmlEncode(objRs("title")) & "]]></image:title>" & vbCrLf
						If objRs("alt") <> "" Or objRs("text") <> "" Then
							MapWrite = MapWrite & "			<image:caption><![CDATA["

							If objRs("alt") <> "" Then _
								MapWrite = MapWrite & HtmlEncode(objRs("alt"))

							If objRs("text") <> "" Then _
								MapWrite = MapWrite & vbCrLf & objRs("text")

							MapWrite = MapWrite & "]]></image:caption>" & vbCrLf
						End If
						MapWrite = MapWrite & "		</image:image>" & vbCrLf
					objRs.MoveNext() : Loop
				Set objRs = Nothing
				
				'MapWrite = MapWrite & "		<lastmod>"& DateSqlFormat(Now(), "yy-mm-dd", 0) & "T" & (Time() - Rnd) &"+02:00</lastmod>" & vbCrLf
				MapWrite = MapWrite & "		<changefreq>daily</changefreq>" & vbCrLf ' 2012-05-23T08:40:20+00:00
				MapWrite = MapWrite & "		<priority>1.0</priority>" & vbCrLf
				MapWrite = MapWrite & "	</url>" & vbCrLf
			Next
		End If


		'// Sayfa Menü İçerik
		SQL = ""
		SQL = SQL & "SELECT" & vbCrLf
		SQL = SQL & "    t1.id, t2.lang, (SELECT DateTimes FROM #___content_revision_date WHERE parent = t2.parent And parent_id = t1.id ORDER BY DateTimes DESC Limit 1) As DTime" & vbCrLf
		SQL = SQL & "FROM #___sayfa t1" & vbCrLf
		SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
		SQL = SQL & "INNER JOIN #___content_url t3 ON t1.id = t3.parent_id And t2.parent = t3.parent And Not Left(t3.seflink, 4) = 'url='" & vbCrLf
		SQL = SQL & "WHERE (" & vbCrLf
		SQL = SQL & "    t1.durum = 1" & vbCrLf
		SQL = SQL & "    And t1.activeLink = 1" & vbCrLf
		SQL = SQL & "    And t2.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
		SQL = SQL & "    And t3.durum = 1" & vbCrLf
		SQL = SQL & ") " & vbCrLf
		SQL = SQL & "ORDER BY t2.lang DESC;" & vbCrLf
		Set objRs = setExecute(SQL)
			Do While Not objRs.Eof

				strLinks = UrlDecode(UrlWrite(SitemapDomain, objRs("lang"), GlobalConfig("General_Page"), "", "", objRs("id"), "", ""))

				If Not strLinks = "javascript:;" Then

					MapWrite = MapWrite & "	<url>" & vbCrLf
					MapWrite = MapWrite & "		<loc>"& strLinks &"</loc>" & vbCrLf

						Set objRs2 = setExecute("SELECT resim, title, alt, text FROM #___files WHERE durum = 1 And file_type = 1 And parent_id = "& objRs("id") &" And parent = "& GlobalConfig("General_PagePN") &" And lang = '"& objRs("lang") &"';")
							Do While Not objRs2.Eof
								MapWrite = MapWrite & "		<image:image>" & vbCrLf
								MapWrite = MapWrite & "			<image:loc>"& SitemapDomain & sFolder(objRs("id"), 0) & "/" & objRs2("resim") &"</image:loc>" & vbCrLf
								MapWrite = MapWrite & "			<image:title><![CDATA[" & HtmlEncode(objRs2("title")) & "]]></image:title>" & vbCrLf
								If objRs2("alt") <> "" Or objRs2("text") <> "" Then
									MapWrite = MapWrite & "			<image:caption><![CDATA["

									If objRs2("alt") <> "" Then _
										MapWrite = MapWrite & HtmlEncode(objRs2("alt"))

									If objRs2("text") <> "" Then _
										MapWrite = MapWrite & vbCrLf & objRs2("text")

									MapWrite = MapWrite & "]]></image:caption>" & vbCrLf
								End If
								MapWrite = MapWrite & "		</image:image>" & vbCrLf
							objRs2.MoveNext() : Loop
						Set objRs2 = Nothing

					MapWrite = MapWrite & "		<lastmod>"& Replace(DateSqlFormat(objRs("DTime"), "yy-mm-dd", 1), " ", "T") &"+02:00</lastmod>" & vbCrLf
					MapWrite = MapWrite & "		<changefreq>weekly</changefreq>" & vbCrLf
					MapWrite = MapWrite & "		<priority>0.7</priority>" & vbCrLf
					MapWrite = MapWrite & "	</url>" & vbCrLf

				End If
			objRs.MoveNext() : Loop
		Set objRs = Nothing






		'// Kategori Menü İçerik
		SQL = ""
		SQL = SQL & "SELECT" & vbCrLf
		SQL = SQL & "    t1.id, t2.lang, (SELECT DateTimes FROM #___content_revision_date WHERE parent = t2.parent And parent_id = t1.id ORDER BY DateTimes DESC Limit 1) As DTime" & vbCrLf
		SQL = SQL & "FROM #___kategori t1" & vbCrLf
		SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
		SQL = SQL & "INNER JOIN #___content_url t3 ON t1.id = t3.parent_id And t2.parent = t3.parent And Not Left(t3.seflink, 4) = 'url='" & vbCrLf
		SQL = SQL & "WHERE (" & vbCrLf
		SQL = SQL & "    t1.durum = 1" & vbCrLf
		SQL = SQL & "    And t1.activeLink = 1" & vbCrLf
		SQL = SQL & "    And t2.parent = "& GlobalConfig("General_CategoriesPN") &"" & vbCrLf
		SQL = SQL & "    And t3.durum = 1" & vbCrLf
		SQL = SQL & ")" & vbCrLf
		SQL = SQL & "ORDER BY t2.lang DESC;" & vbCrLf
		Set objRs = setExecute(SQL)
			Do While Not objRs.Eof

				strLinks = UrlDecode(UrlWrite(SitemapDomain, objRs("lang"), GlobalConfig("General_Categories"), "", "", objRs("id"), "", ""))

				If Not strLinks = "javascript:;" Then

					MapWrite = MapWrite & "	<url>" & vbCrLf
					MapWrite = MapWrite & "		<loc>"& strLinks &"</loc>" & vbCrLf

					Set objRs2 = setExecute("SELECT resim, title, alt FROM #___files WHERE durum = 1 And file_type = 1 And parent_id = "& objRs("id") &" And parent = "& GlobalConfig("General_CategoriesPN") &" And lang = '"& objRs("lang") &"';")
						Do While Not objRs2.Eof
							MapWrite = MapWrite & "		<image:image>" & vbCrLf
							MapWrite = MapWrite & "			<image:loc>" & SitemapDomain & kFolder(objRs("id"), 0) & "/" & objRs2("resim") & "</image:loc>" & vbCrLf
							MapWrite = MapWrite & "			<image:title><![CDATA[" & HtmlEncode(objRs2("title")) & "]]></image:title>" & vbCrLf

							If objRs2("alt") <> "" Or objRs2("text") <> "" Then
								MapWrite = MapWrite & "			<image:caption><![CDATA["

								If objRs2("alt") <> "" Then _
									MapWrite = MapWrite & HtmlEncode(objRs2("alt"))

								If objRs2("text") <> "" Then _
									MapWrite = MapWrite & vbCrLf & objRs2("text")

								MapWrite = MapWrite & "]]></image:caption>" & vbCrLf
							End If
							MapWrite = MapWrite & "		</image:image>" & vbCrLf
						objRs2.MoveNext() : Loop
					Set objRs2 = Nothing

					MapWrite = MapWrite & "		<lastmod>"& Replace(DateSqlFormat(objRs("DTime"), "yy-mm-dd", 1), " ", "T") &"+02:00</lastmod>" & vbCrLf
					MapWrite = MapWrite & "		<changefreq>weekly</changefreq>" & vbCrLf
					MapWrite = MapWrite & "		<priority>0.7</priority>" & vbCrLf
					MapWrite = MapWrite & "	</url>" & vbCrLf

				End If


				'// Ürün Menü İçerik
				SQL = ""
				SQL = SQL & "SELECT" & vbCrLf
				SQL = SQL & "    t1.id, t2.lang, (SELECT DateTimes FROM #___content_revision_date WHERE parent = t2.parent And parent_id = t1.id ORDER BY DateTimes DESC Limit 1) As DTime" & vbCrLf
				SQL = SQL & "FROM #___products t1" & vbCrLf
				SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
				SQL = SQL & "INNER JOIN #___content_url t3 ON t1.id = t3.parent_id And t2.parent = t3.parent And Not Left(t3.seflink, 4) = 'url='" & vbCrLf
				SQL = SQL & "WHERE (" & vbCrLf
				SQL = SQL & "    t1.durum = 1" & vbCrLf
				SQL = SQL & "    And t1.anaid = "& objRs("id") &"" & vbCrLf
				SQL = SQL & "    And t2.parent = "& GlobalConfig("General_ProductsPN") &"" & vbCrLf
				SQL = SQL & "    And t3.durum = 1" & vbCrLf
				SQL = SQL & ")" & vbCrLf
				SQL = SQL & "ORDER BY t2.lang DESC;" & vbCrLf
				'SQL = setQuery( SQL )
				Set objRs2 = setExecute(SQL)
					Do While Not objRs2.Eof

						strLinks = UrlDecode(UrlWrite(SitemapDomain, objRs("lang"), GlobalConfig("General_Products"), "", "", objRs("id"), "", ""))

						MapWrite = MapWrite & "	<url>" & vbCrLf
						MapWrite = MapWrite & "		<loc>" & strLinks & "</loc>" & vbCrLf

						Set objRs3 = setExecute("SELECT resim, title, alt FROM #___files WHERE durum = 1 And file_type = 1 And parent_id = "& objRs2("id") &" And parent = "& GlobalConfig("General_ProductsPN") &" And lang = '"& objRs2("lang") &"';")
							Do While Not objRs3.Eof
								MapWrite = MapWrite & "		<image:image>" & vbCrLf
								MapWrite = MapWrite & "			<image:loc>" & SitemapDomain & pFolder(objRs2("id"), 0) & "/" & objRs3("resim") & "</image:loc>" & vbCrLf
								MapWrite = MapWrite & "			<image:title><![CDATA[" & HtmlEncode(objRs2("title")) & "]]></image:title>" & vbCrLf

								If objRs2("alt") <> "" Or objRs2("text") <> "" Then
									MapWrite = MapWrite & "			<image:caption><![CDATA["

									If objRs2("alt") <> "" Then _
										MapWrite = MapWrite & HtmlEncode(objRs2("alt"))

									If objRs2("text") <> "" Then _
										MapWrite = MapWrite & vbCrLf & objRs2("text")

									MapWrite = MapWrite & "]]></image:caption>" & vbCrLf
								End If
								MapWrite = MapWrite & "		</image:image>" & vbCrLf
							objRs3.MoveNext() : Loop
						Set objRs3 = Nothing

						MapWrite = MapWrite & "		<lastmod>"& Replace(DateSqlFormat(objRs("DTime"), "yy-mm-dd", 1), " ", "T") &"+02:00</lastmod>" & vbCrLf
						MapWrite = MapWrite & "		<changefreq>weekly</changefreq>" & vbCrLf
						MapWrite = MapWrite & "		<priority>0.7</priority>" & vbCrLf
						MapWrite = MapWrite & "	</url>" & vbCrLf

					objRs2.MoveNext() : Loop
				Set objRs2 = Nothing
				
			objRs.MoveNext() : Loop
		Set objRs = Nothing


		'Set objRs = setExecute("SELECT kelime FROM #___etiketler WHERE status = 1 ORDER BY kelime ASC;")
		'	Do While Not objRs.Eof
		'	strLinks = UrlWrite(SitemapDomain, "", GlobalConfig("General_Search"), LCase2(Replace(Replace(UrlEncode(objRs("kelime")), " ", "+"), "%20", "+")), "", "", "", "")
		'	MapWrite = MapWrite & "	<url>" & vbCrLf
		'	MapWrite = MapWrite & "		<loc>"& strLinks &"</loc>" & vbCrLf
		'	MapWrite = MapWrite & "		<changefreq>weekly</changefreq>" & vbCrLf
		'	MapWrite = MapWrite & "		<priority>0.3</priority>" & vbCrLf
		'	MapWrite = MapWrite & "	</url>" & vbCrLf
		'	objRs.MoveNext() : Loop
		'Set objRs = Nothing




		Set objRs = setExecute("SELECT a.permalink, b.lang FROM #___etiket As a INNER JOIN #___etiket_id As b ON a.id = b.eid ORDER BY a.id DESC Limit 100;")
			Do While Not objRs.Eof
			strLinks = UrlWrite(SitemapDomain, objRs("lang"), GlobalConfig("General_Tags"), "", objRs("permalink"), "", "", "")
			MapWrite = MapWrite & "	<url>" & vbCrLf
			MapWrite = MapWrite & "		<loc>"& strLinks &"</loc>" & vbCrLf
			MapWrite = MapWrite & "		<changefreq>weekly</changefreq>" & vbCrLf
			MapWrite = MapWrite & "		<priority>0.3</priority>" & vbCrLf
			MapWrite = MapWrite & "	</url>" & vbCrLf
			objRs.MoveNext() : Loop
		Set objRs = Nothing

		'SQL1 = "" : SQL2 = ""
		'If (dataBaseName = "MySQL") Then SQL1 = "Limit 100 " Else SQL2 = "TOP 100 "
		// Ürün İçin Haritaya Veri Ekle
		'Set objRs = setExecute("Select t1.Starih, t1.sDomain From (SELECT Starih, sDomain FROM #___whois where Sdurum = 1 order by Starih desc) t1 Group By t1.sDomain Limit 100;")
		'	Do While Not objRs.Eof
		'		strLinks = UrlWrite(SitemapDomain, "tr", GlobalConfig("General_Whois"), "", objRs("sDomain") & " " & objRs("Starih"), "", "", "")
		'		MapWrite = MapWrite & "	<url>" & vbCrLf
		'		MapWrite = MapWrite & "		<loc>"& strLinks &"</loc>" & vbCrLf
		'		MapWrite = MapWrite & "		<changefreq>monthly</changefreq>" & vbCrLf
		'		MapWrite = MapWrite & "		<priority>0.3</priority>" & vbCrLf
		'		MapWrite = MapWrite & "	</url>" & vbCrLf
		'	objRs.MoveNext() : Loop
		'Set objRs = Nothing

		MapWrite = MapWrite & "</urlset>" & vbCrLf
		Response.Write( MapWrite )

	End If
Next
%>

