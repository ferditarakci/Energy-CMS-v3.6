<!--#include file="header.asp"-->


	 <!--<aside id="left_sidebar" style="margin-right:10px;">
		<%
			'Call MundusModules("sag")
		%>
		<div class="clr"></div>
	</aside> #left_sidebar End -->

	<div id="main" class="ewy_content"> <!-- style="margin-right:0;" -->
<%

'Clearfix GlobalConfig("request_title")
If GlobalConfig("request_sayfaid") <> 0 Then


SQL = "SELECT Count(a.id) As Toplam FROM #___etiket As a INNER JOIN #___etiket_id As b ON a.id = b.eid WHERE a.permalink = '"& GlobalConfig("request_title") &"' And b.lang = '"& GlobalConfig("site_lang") &"';"
'Clearfix setQuery( SQL )

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




Set objRs2 = setExecute("SELECT b.parent, b.parent_id, b.lang FROM #___etiket As a INNER JOIN #___etiket_id As b ON a.id = b.eid WHERE a.permalink = '"& GlobalConfig("request_title") &"' And b.lang = '"& GlobalConfig("site_lang") &"' Limit "& intLimitStart & ", " & intSayfaSayisi & ";")
If objRs2.Eof Then

	'With Response
	'	.Write("<div class=""ewy_sys_msg warning tn""><div class=""ewy_messages""><span>" & Replace(Lang("ara_04"), "[Search]", BasHarfBuyuk( GlobalConfig("request_q") )) & "</span></div></div>")
		'.Status = "404 Not Found"
	'	.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
	'End With

Else
	Response.Write("	<div class=""contents"" style=""margin: 0 0 -10px;"">" & vbCrLf)
	
	i = 1
	Do While Not objRs2.Eof

		If Not i = 1 Then Response.Write("<div class=""ewy_hr"" style=""margin:20px 0px;""><hr /></div>" & vbCrLf)

		SQL = ""
		SQL = SQL & "SELECT" & vbCrLf
		SQL = SQL & "    a.id" & vbCrLf
		SQL = SQL & "    ,b.parent" & vbCrLf
		SQL = SQL & "    ,IFNULL(b.title, '') As title" & vbCrLf
		SQL = SQL & "    ,IFNULL(b.text, '') As text" & vbCrLf
		SQL = SQL & "    ,IFNULL(b.readmore_text, '') As readmore_text " & vbCrLf
		'SQL = SQL & "    ,IFNULL(b.description, '') As description" & vbCrLf
		'SQL = SQL & "    ,IFNULL(b.keyword, '') As keyword" & vbCrLf
		'SQL = SQL & "    ,(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date" & vbCrLf
		'SQL = SQL & "    ,(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
		SQL = SQL & "FROM #___sayfa As a" & vbCrLf
		SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
		SQL = SQL & "WHERE (" & vbCrLf
		SQL = SQL & "    a.durum = 1" & vbCrLf
		SQL = SQL & "    And a.id = "& objRs2("parent_id") &"" & vbCrLf
		SQL = SQL & "    And b.parent = "& objRs2("parent") &"" & vbCrLf
		SQL = SQL & "    And b.lang = '"& objRs2("lang") &"'" & vbCrLf
		SQL = SQL & "    And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
		SQL = SQL & "    And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
		SQL = SQL & ")" & vbCrLf
		'SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi & ";" & vbCrLf
		SQL = SQL & ";" & vbCrLf
		'SQL = setQuery( SQL )
		'Clearfix SQL

		OpenRs objRs, SQL

			If Not objRs.Eof Then
				With Response

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

					Call featuredFile(GlobalConfig("General_PagePN"), intid, GlobalConfig("site_lang"))
					.Write("<div class=""clr""></div>" & vbCrLf)
					.Write("	<h2 class=""title""><a href="""& strLinks &""" title="""& strTitle &""">"& strTitle &"</a></h2>" & vbCrLf)

					'.Write("	<span class=""tarih hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strCDate) &"</span>" & vbCrLf)
					'.Write("	<abbr title="""& DateSqlFormat(strCDate, "yy-mm-dd", 1) &""" class=""dates hidden"">"& TarihFormatla( strCDate ) &"</abbr>" & vbCrLf)

					.Write("	<div class=""clr""></div>" & vbCrLf)

					Call MundusTags(objRs("parent"), objRs("id"), GlobalConfig("site_lang"), True)
					.Write("<div class=""clr""></div>" & vbCrLf)

			

					.Write( ReadMore("rel=""bookmark"" class=""smallbtn2"" style=""float:right; margin-top:10px;""", strTitle, ReadMoreText(objRs("readmore_text")), strLinks, strText) )

					.Write("<div class=""clr""></div>" & vbCrLf)

					'If objRs("description") <> "" Then _
					'	.Write("<div class=""content-description""><p><strong>Tanım :</strong> " & objRs("description") & "</p></div>")

				End With
			End If
		CloseRs objRs

	i = i + 1
objRs2.MoveNext() : Loop


	If intTotalRecord > 5 Then
		Response.Write("<div class=""clr""></div>" & vbCrLf)
		Response.Write("<div class=""ewy_hr"" style=""margin:20px 0 10px;""><hr /></div>" & vbCrLf)
		Response.Write("<div class=""clr""></div>" & vbCrLf)
		Response.Write( MundusSayfala(intTotalRecord, intSayfaSayisi, intSayfaNo, GlobalConfig("header_title"), GlobalConfig("request_title"), GlobalConfig("request_sayfaid")) )
		'Response.Write( UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Search"), Replace(GlobalConfig("request_q"), " ", "+"), "", "", "", "") )
	End If

	Response.Write("	</div>" & vbCrLf)


End If
Set objRs2 = Nothing




Else



	Response.Status = "301 Moved Permanently"
	Response.AddHeader "Location", GlobalConfig("sBase")
	Response.End()



	SQL = "SELECT a.etiket, a.permalink, b.lang FROM #___etiket As a INNER JOIN #___etiket_id As b ON a.id = b.eid WHERE b.lang = '"& GlobalConfig("site_lang") &"' ORDER BY a.etiket ASC Limit 100;"

	Set objRs = setExecute(SQL)
	If Not objRs.Eof Then
		'Response.Write("<div class=""module"">" & vbCrLf)
		Response.Write("	<h2 class=""title"">ETİKETLER</h2>" & vbCrLf)
		Response.Write("	<ul class=""tag-widget clearfix"" style=""margin: 0; padding: 0; list-style:none;"">" & vbCrLf)
		Do While Not objRs.Eof
			Response.Write("<li><a rel=""tag"" class=""tag-btn"" href="""& UrlWrite("", objRs("lang"), GlobalConfig("General_Tags"), "", objRs("permalink"), "", "", "") &""" title="""& objRs("etiket") &"""><span style=""font-size:11px;"">" & BasHarfBuyuk(objRs("etiket")) & "</span></a><li>")
		objRs.MoveNext() : Loop
		Response.Write("	</ul>" & vbCrLf)
		'Response.Write("</div>" & vbCrLf)
	End If
	Set objRs = Nothing









End If



%>
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<% 'clearfix GlobalConfig("request_sayfaid")
			'Call MundusModules("sag")
			Call MundusHizmetlerMenu(0)
			If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->


<!--#include file="footer.asp"-->
