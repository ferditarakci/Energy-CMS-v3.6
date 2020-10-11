<%
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "    Count(a.id) As Toplam" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "    a.durum = 1" & vbCrLf
SQL = SQL & "    And a.anaid = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
SQL = SQL & "    And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
SQL = SQL & "    And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "    And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "    And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
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
SQL = SQL & "    a.id, b.title, b.text, b.description, b.keyword, b.readmore_text, b.parent " & vbCrLf
'SQL = SQL & ",    (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date" & vbCrLf
'SQL = SQL & ",    (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "    a.durum = 1" & vbCrLf
SQL = SQL & "    And a.anaid = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
SQL = SQL & "    And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
SQL = SQL & "    And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "    And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "    And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "ORDER BY a.sira ASC, a.id DESC" & vbCrLf
SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi & "" & vbCrLf
SQL = SQL & ";" & vbCrLf
SQL = setQuery( SQL )
'Clearfix SQL

OpenRs objRs, SQL

If objRs.Eof Then

	With Response
		.Write("<div class=""ewy_sys_msg warning tn""><div class=""ewy_messages""><span>" & Replace(Lang("ara_04"), "[Search]", BasHarfBuyuk( GlobalConfig("request_q") )) & "</span></div></div>")
		.Status = 404
		.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
	End With

Else
	With Response

		.Write("<div class=""contents clearfix"" style=""margin:0 0 -10px;"">" & vbCrLf)
		i = 1
		Do While Not objRs.Eof

			If Not i = 1 Then .Write("<div class=""ewy_hr"" style=""margin:20px 0px;""><hr /></div>" & vbCrLf)

			.Write("<div class=""clearfix"" style=""margin:0 0 20px;"">" & vbCrLf)

			'// Değişkenlerimiz
			intid = objRs("id")
			strTitle = objRs("title")
			'strCDate  = TarihFormatla(objRs("tarih"))
			'strCDate = objRs("c_date") & ""
			'strMDate = objRs("m_date") & ""
			'If strMDate <> "" Then strCDate = strMDate
			strText = fnPre(objRs("text"), GlobalConfig("sRoot"))

			strLinks = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), ParentNumber(objRs("parent")), "", "", objRs("id"), "", "")
			If strLinks = "javascript:;" Then strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", "", "", "")

			.Write("		<h2 class=""title""><a href="""& strLinks &""" title="""& BasHarfBuyuk(objRs("title")) &""">"& strTitle &"</a></h2>" & vbCrLf)
			'.Write("		<span class=""tarih hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strCDate) &"</span>" & vbCrLf)
			'.Write("		<abbr title="""& DateSqlFormat(strCDate, "yy-mm-dd", 1) &""" class=""dates hidden"">"& TarihFormatla( strCDate ) &"</abbr>" & vbCrLf)
			.Write("		<div class=""clr""></div>" & vbCrLf)

			Call MundusTags(objRs("parent"), objRs("id"), GlobalConfig("site_lang"), True)
			.Write("<div class=""clr""></div>" & vbCrLf)

			Call featuredFile(GlobalConfig("General_PagePN"), intid, GlobalConfig("site_lang"))

			.Write( ReadMore("rel=""bookmark"" class=""smallbtn2"" style=""float:right; margin-top:10px;""", strTitle, ReadMoreText(objRs("readmore_text")), strLinks, Replace(strText, "class=""lightbox""", "class=""lightbox"" rel=""lightbox""")) )

			.Write("<div class=""clr""></div>" & vbCrLf)

			'If objRs("description") <> "" Then _
			'	.Write("<div class=""content-description""><p><strong>Tanım :</strong> " & objRs("description") & "</p></div>")

			.Write("	</div>" & vbCrLf)

			i = i + 1
		objRs.MoveNext() : Loop
		.Write("	</div>" & vbCrLf)

		If intTotalRecord > 5 Then
			Response.Write("<div class=""clr""></div>" & vbCrLf)
			Response.Write("<div class=""ewy_hr"" style=""margin:20px 0 10px;""><hr /></div>" & vbCrLf)
			Response.Write("<div class=""clr""></div>" & vbCrLf)
			Response.Write( MundusSayfala(intTotalRecord, intSayfaSayisi, intSayfaNo, GlobalConfig("header_title"), GlobalConfig("request_title"), GlobalConfig("request_sayfaid")) )
		End If

	End With
End If
CloseRs objRs
%>

