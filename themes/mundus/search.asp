<!--#include file="header.asp"-->
	<div id="main">
	<%
'clearfix LCase(GlobalConfig("request_q"))
If (LCase(GlobalConfig("request_q")) = "{search}" Or GlobalConfig("request_q") = "") Then
	Response.Status = 404
	Response.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
End If

'SearchSqlQuery = "SELECT id,isim, MATCH (isim,icerik) AGAINST ('veri') AS arama_deger FROM articles WHERE MATCH (isim, icerik) AGAINST ('veri');"
'SearchSqlQuery = "And match(t2.title, t2.short_title, t2.short_text, t2.text) Against('"& GlobalConfig("request_q") &"' IN BOOLEAN MODE) " & vbCrLf
'SearchSqlQuery = "And match(t2.title, t2.short_title, t2.short_text, t2.text) Against('"& GlobalConfig("request_q") &"' WITH QUERY EXPANSION) " & vbCrLf
'SearchSqlQuery = "And match(t2.title, t2.short_title, t2.short_text, t2.text) Against('"& Temizle(GlobalConfig("request_q"), 1) &"') " & vbCrLf

SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "    Count(a.id) As Toplam" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "    a.durum = 1" & vbCrLf
SQL = SQL & "    And a.activeLink = 1" & vbCrLf
SQL = SQL & "    And Length(b.text) > 50" & vbCrLf
SQL = SQL & "    And match(b.text) Against('"& Temizle(GlobalConfig("request_q"), 1) &"')" & vbCrLf
'SQL = SQL & "    And match(b.title, b.text) Against('"& Temizle(GlobalConfig("request_q"), 1) &"')" & vbCrLf
SQL = SQL & "    And b.parent = '"& GlobalConfig("General_PagePN") &"'" & vbCrLf
SQL = SQL & "    And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "    And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "    And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
'SQL = SQL & "Limit 0, 3"
SQL = SQL & ";" & vbCrLf
SQL = setQuery( SQL )


intTotalRecord = Cdbl(sqlQuery(SQL, 0))
intSayfaSayisi = 5
'Clearfix intTotalRecord


intSayfaNo = intYap(GlobalConfig("request_start") -1, 0)
If (intSayfaNo > 0) Then
	intSayfaNos = intYap(int(intTotalRecord/intSayfaSayisi), 0)
	If (intSayfaNo > intSayfaNos) Then intSayfaNo = intSayfaNos
Else
	intSayfaNo = 0
End If

intLimitStart = intYap(int(intSayfaNo * intSayfaSayisi), 0)

intTotalRecord = intYap(intTotalRecord, 0)
intSayfaSayisi = intYap(intSayfaSayisi, 0)



SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "    a.id" & vbCrLf
SQL = SQL & "    ,IFNULL(b.title, '') As title" & vbCrLf
SQL = SQL & "    ,IFNULL(b.text, '') As text" & vbCrLf
SQL = SQL & "    ,IFNULL(b.description, '') As description" & vbCrLf
SQL = SQL & "    ,IFNULL(b.readmore_text, '') As readmore_text" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "    a.durum = 1" & vbCrLf
SQL = SQL & "    And a.activeLink = 1" & vbCrLf
SQL = SQL & "    And Length(b.text) > 50" & vbCrLf
SQL = SQL & "    And match(b.text) Against('"& Temizle(GlobalConfig("request_q"), 1) &"')" & vbCrLf
'SQL = SQL & "    And match(b.title, b.text) Against('"& Temizle(GlobalConfig("request_q"), 1) &"')" & vbCrLf
SQL = SQL & "    And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
SQL = SQL & "    And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "    And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "    And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
'SQL = SQL & "Limit 0, 3"
SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi & vbCrLf
SQL = SQL & ";"
SQL = setQuery( SQL )
'If Session("admin_login_" & SefUrl(GlobalConfig("sRoot"))) Then Clearfix SQL

OpenRs objRs, SQL

'intTotalRecord = objRs.RecordCount
If objRs.Eof Then

	With Response
		.Write("<div class=""ewy_sys_msg warning tn""><div class=""ewy_messages""><span>" & Replace(Lang("ara_04"), "[Search]", BasHarfBuyuk( GlobalConfig("request_q") )) & "</span></div></div>")
		.Status = 404
		.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
	End With

Else
	With Response

		.Write("<div style=""width:99.5%; margin-bottom:8px;"" class=""ewy_sys_msg success tn""><div class=""ewy_messages""><span>" & Replace(Replace(Lang("ara_05"), "[Search]", BasHarfBuyuk( GlobalConfig("request_q") )), "[Count]", intTotalRecord) & "</span></div></div>")

		.Write("	<div class=""contents"">" & vbCrLf)
		'.Write("		<div class=""sutun"">" & vbCrLf)
		Do While Not objRs.Eof

			'// Değişkenlerimiz
			intid = objRs("id")
			strTitle = objRs("title")
			'strCDate  = TarihFormatla(objRs("tarih"))
			strText = objRs("text") & ""
			strText = Replace(strText, "<br />", " ")
			strText = Replace(strText, "</p>", " ")
			strText = ClearHtml( strText )
			strText = Duzenle( strText )
			strText = Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(strText, "ftp.", "ftp_"), "mail.", "mail_"), "www.", "www_"), ".com", "_com"), ".net", "_net"), ".org", "_org"), "_co", ".co"), "_eu", ".eu"), ".tr", "_tr"), "FERDİ TARAKCI", "", 1, -1, 1)
			strText = Cstr(strText)

			'// Yazı uzunluğu
			intLength = Len(strText)

			strBulunan = ""
			strNokta1 = ""
			strNokta2 = ""

			'// Aranan kelimeleri bulalım
			For Each strAranan in Split(GlobalConfig("request_q"), " ")

				'// Aranan kelime
				strAranan = Cstr(strAranan)

				'// Aranan kelimeyi bul
				intBul = inStr(1, strText, strAranan, 1)
				'Response.Write intBul & "<br>"

				'// Aranan kelimenin başlangıç yeri
				intBasla = inStr(1, strText, strAranan, 1)
				intBasla = intBasla + Len(strAranan) - 1
				intBasla = intYap(intBasla, 1)
					'Response.Write "Bulunduğu nokta " & intBasla & "<br>"

							'// Aranan kelimenin başlangıç yerinden sonra ki ilk noktaya git
							'intSonrakiNokta = inStr(intBasla, strText, ".")
							'intSonrakiNokta = intYap(intSonrakiNokta, 1)
								'If intYap(intBasla-intSonrakiNokta, 1) <= intBasla Then intSonrakiNokta = intYap(inStr(intBasla+intSonrakiNokta+1, strText, "."), 1)
								'Response.Write "noktaya Git " & intSonrakiNokta & "<br>"
								'Response.Write "ileri kaçtane " & ilerle & "<br>"
								'Response.Write "Bitiş noktası " & intYap(intBasla-intSonrakiNokta, 1) <= intBasla & "<br>"

				'// Aranan kelimenin başlangıç yerinden önce ki ilk noktaya git
				intOncekiNokta = inStrRev(Left(strText, intBasla), ".") + 1
				'Response.Write intOncekiNokta & "<br>"

				'// Aranan kelimenin başlangıç yerinden sonra ki ilk noktaya git
				intSonrakiNokta = inStr(intOncekiNokta, strText, ".")
				If intSonrakiNokta <= 1 Then intSonrakiNokta = intLength
				'Clearfix intSonrakiNokta 
				intSonrakiNokta = intYap(intSonrakiNokta, 1)

				If intYap((intSonrakiNokta - intOncekiNokta), 1) < 100 Then
					intSonrakiNokta = intYap(inStr(intSonrakiNokta + 1, strText, "."), 1)
				End If
				'Response.Write "Son Nokta " & intSonrakiNokta & " <br>"

				intSonrakiNokta = intYap(intSonrakiNokta - intOncekiNokta + 1, 1)
				'Response.Write intSonrakiNokta & "<br>"

				If intSonrakiNokta = 1 Then intSonrakiNokta = intYap(inStr(1, strText, "."), 1)

				If intLength < 400 Then intOncekiNokta = 1 : intSonrakiNokta = intLength

				If intBul > 0 And intOncekiNokta > 1 Then strNokta1 = "<strong>...</strong> "
				If intBul > 0 And Not intSonrakiNokta = intLength Then strNokta2 = " <strong>...</strong>"
				If intBul > 0 And intSonrakiNokta = intLength Then strNokta2 = "."

				If (strBulunan = "" Or intBul > 0) And intOncekiNokta > 0 Then
					strBulunan = Mid(strText, intOncekiNokta, intSonrakiNokta)
				End If

			Next

			strBulunan = Replace(strBulunan, "&nbsp;", " ")
			strTitle = HtmlEncode(Temizle(strTitle, -1))
			strTitle = TrimFix(Search(GlobalConfig("request_q"), strTitle))
			strText = HtmlEncode(Temizle(strBulunan, -1))
			strText = Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(strText, "www_", "www."), "ftp_", "ftp."), "mail_", "mail."), "_com", ".com"), "_net", ".net"), "_org", ".org"), "_co", ".co"), "_eu", ".eu"), "_tr", ".tr")
			strText = TrimFix(Search(GlobalConfig("request_q"), strText))

			If Len(strText) < 5 Then strText = "<span class=""red"" style=""text-align:right; font-size:15px;"">İçerik Bulunamadı!</span>"

			strLinks = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs("id"), "", "")
			If strLinks = "javascript:;" Then strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", "", "", "")

			.Write("			<div class=""orta"" style=""background-position:left center;"">" & vbCrLf)
			.Write("				<div class=""background"">" & vbCrLf)
			.Write("					<h2 class=""title""><a href="""& strLinks &""" title="""& objRs("title") &""">"& strTitle &"</a></h2>" & vbCrLf)
			'.Write("					<span class=""tarih hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strCDate) &"</span>" & vbCrLf)
			.Write("					<div class=""clr""></div>" & vbCrLf)

			.Write( vbCrLf & String(3, vbTab) & "<p style=""font-size:12px;"">" & vbCrLf & String(4, vbTab))

			If strNokta1 <> "" Then .Write( strNokta1 )

			.Write( strText )

			If strNokta2 <> "" Then .Write( strNokta2 )

			.Write( vbCrLf & String(3, vbTab) & "</p>")


			.Write("<div class=""clr""></div>" & vbCrLf)
			If Not inStrBot() Then
				.Write("<cite style=""float:left; width:85%; font-size:11px; font-style:normal;"" class=""yesil"">" & Search(GlobalConfig("request_q"), KacKarekter(strLinks, 105)) & "</cite>")
			Else
				.Write("<cite style=""float:left; width:85%; font-size:11px; font-style:normal;"" class=""yesil"">" & Search(GlobalConfig("request_q"), strLinks) & "</cite>")
			End If


			'.Write( vbCrLf & String(3, vbTab) & "<div style=""margin-top:10px; margin-right:10px""><a class=""devami"" href="""& strLinks &""" title="""& objRs("title") &""">"& objRs("title") &"</a></div>")
			'.Write( vbCrLf & String(3, vbTab) & "<a href="""& strLinks &""" title="""& objRs("title") &""">"& xxUrlTitle &"</a>")
			.Write("						<div style=""float:right; margin-top:0px; margin-right:0px;""><a class=""smallbtn2"" href="""& strLinks &""" title="""& objRs("title") &"""><span>"& ReadMoreText(objRs("readmore_text")) &"</span></a></div>" & vbCrLf)

			.Write("<div class=""clr""></div>" & vbCrLf)
			.Write("<p style=""margin-top:5px;""><em style=""font-size:85%;"" class=""gri"">" & objRs("description") & "</em></p>")

			.Write("<div class=""clr""></div>" & vbCrLf)
			.Write("				</div>" & vbCrLf)
			.Write("			</div>" & vbCrLf)
			.Write("			<div class=""divider""></div>" & vbCrLf)

		objRs.MoveNext() : Loop
		'.Write("		</div>" & vbCrLf)
		.Write("	</div>" & vbCrLf)

		.Write("<div class=""clr""></div><br />" & vbCrLf)
		.Write( MundusSayfala(intTotalRecord, intSayfaSayisi, intSayfaNo, GlobalConfig("request_q"), Replace(GlobalConfig("request_q"), " ", "+"), GlobalConfig("request_sayfaid")) )
		'.Write( UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Search"), Replace(GlobalConfig("request_q"), " ", "+"), "", "", "", "") )

	End With
End If
CloseRs objRs
%>
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<%
			Call MundusModules("sag")
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->

<!--#include file="footer.asp"-->
