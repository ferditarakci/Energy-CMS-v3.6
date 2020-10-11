<%
addClass2 = "h1" : If GlobalConfig("request_sayfa_anaid") = 0 Then addClass2 = "h2" : Response.Write(GlobalConfig("PageText"))
'strLinks = GlobalConfig("site_uri")
GlobalConfig("jsCarousel") = ""




SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.id, b.title, b.text " & vbCrLf
'SQL = SQL & "    ,(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date," & vbCrLf
'SQL = SQL & "	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	a.durum = 1" & vbCrLf
If GlobalConfig("request_sayfa_anaid") = 0 Then _
SQL = SQL & "	And a.anaid = "& GlobalConfig("request_sayfaid") &" And Not a.id = 57327 " & vbCrLf
If GlobalConfig("request_sayfa_anaid") > 0 Then _
SQL = SQL & "	And a.id = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
'SQL = SQL & "	And Not a.anaid = 0" & vbCrLf
'SQL = SQL & "	And Not a.id = 57327" & vbCrLf
SQL = SQL & "	And a.activelink = 1" & vbCrLf
SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
'SQL = SQL & "	And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
'SQL = SQL & "	And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "ORDER BY a.sira ASC;"
'Clearfix setQuery( SQL )

OpenRs objRs, SQL
With Response

a = 1
Do While Not objRs.Eof

	'strCDate = objRs("c_date") & ""
	'strMDate = objRs("m_date") & ""
	'If strMDate <> "" Then strCDate = strMDate

	strTitle = objRs("title")
	strText = fnPre(ReplaceHR(objRs("text")), GlobalConfig("sRoot"))
	strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs("id"), 0, "")

%>


<%
	.Write("<div class=""portfolio"">" & vbCrLf)
	.Write("	<" & addClass2 & " class=""title""><a href="""& strLinks &""" title="""& strTitle &""">" & strTitle & "</a></" & addClass2 & ">" & vbCrLf)
	.Write( strText  & vbCrLf)

	'// Protfolyo listesi
	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, b.title, b.text, c.resim, c.title As filesTitle, c.alt, c.url, c.text As filesText, " & vbCrLf
	SQL = SQL & "    IFNULL((SELECT resim FROM #___files WHERE parent = b.parent And parent_id = b.parent_id And durum = 1 And anaresim = 0 Limit 1), '') As fullPicture" & vbCrLf
	SQL = SQL & "FROM #___sayfa As a" & vbCrLf
	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "INNER JOIN #___files As c ON a.id = c.parent_id And c.anaresim = 1" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	a.durum = 1" & vbCrLf
	SQL = SQL & "	And a.anaid = "& objRs("id") &"" & vbCrLf
	SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & ")" & vbCrLf
	SQL = SQL & "ORDER BY a.sira ASC;"
	'Clearfix setQuery(SQL)

	Set objRs2 = setExecute( SQL )
	If Not objRs2.Eof Then

		.Write("<div class=""carousel"" id=""ewy_carousel_"& a &""">" & vbCrLf)
		.Write("	<ul class=""portfolio_list"">" & vbCrLf)

		i = 0
		While Not objRs2.Eof

			addClass = ""
			If i Mod 3 = 0 Then addClass = " class=""alpha"""
			If i Mod 3 = 2 Then addClass = " class=""omega"""

			PicturePath = sFolder(objRs2("id"), 2) & "/" & objRs2("resim") & ""
			If Not FilesKontrol(PicturePath) Then PicturePath = PicturePath

			PictureFullPath = sFolder(objRs2("id"), 0) & "/" & objRs2("fullPicture")
			If Not objRs2("fullPicture") <> "" Then PictureFullPath = Replace(PicturePath, "/medium/", "/")
			
			PictureTitle = objRs2("filesTitle") & ""
			PictureAlt = objRs2("alt") & "" : If PictureAlt = "" Then PictureAlt = "/images/blank.gif"
			PictureUrl = objRs2("url") & ""
			PictureText = objRs2("text") & ""

			strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs2("id"), 0, "")

			'If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<span id=""ewy_lnk_"& Pictureid &""" class=""ewy_lnk"& addClass &" hidden"">"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "//", "") &"</span>" & vbCrLf)
			'If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<a id=""ewy_addlnk_"& Pictureid &""" href=""#"& SefURL(PictureTitle) &""" title="""& PictureTitle &""">")

			.Write("<li"& addClass &">" & vbCrLf)

			.Write("	<h5 class=""entry-domain"">" & vbCrLf)
			'.Write("		<a style=""font-size:13px;"" href=""#"">"& PictureUrl &"</a>" & vbCrLf)
			.Write("		"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "/index.html", "") &"" & vbCrLf)
			.Write("	</h5>" & vbCrLf)

			.Write("	<div class=""entry-thumb"">" & vbCrLf)
			.Write("		<div class=""entry-thumb-wrap"">" & vbCrLf)
			.Write("			<a href="""& PictureFullPath &""" title="""& objRs2("title") &""" class=""lightbox webtasarim-portfolio"" target=""_blank"">")
			.Write("				<span class=""overlay""><span class=""zoom-icon""></span></span>" & vbCrLf)
			.Write("				<img"& imgAlign(PicturePath, 296, 296, 294, 294) &" src="""& PicturePath &""" alt="""& PictureAlt &""" />" & vbCrLf)
			.Write("			</a>" & vbCrLf)
			.Write("		</div>" & vbCrLf)
			.Write("	</div>" & vbCrLf)

			.Write("	<h3 class=""entry-title"">" & vbCrLf)
			.Write("		<a href="""& strLinks &""" title="""& PictureAlt &""">"& objRs2("title") &"</a>" & vbCrLf)
			.Write("	</h3>" & vbCrLf)

			.Write("	<div class=""entry-description"">" & vbCrLf)
			.Write("		"& PictureText &"" & vbCrLf)
			.Write("	</div>" & vbCrLf)

			.Write("</li>" & vbCrLf)

			i = i + 1
		objRs2.MoveNext() : Wend

	.Write("	</ul>" & vbCrLf)
	.Write("</div> <!-- /ewy_carousel_"& a &" -->" & vbCrLf)

	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "		var $ewy_portfolio"& a &" = $(""#ewy_carousel_"& a &""");" & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "			if($ewy_portfolio"& a &".length > 0 && $ewy_portfolio"& a &".find(""ul > li"").length > 3){" & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "				$ewy_portfolio"& a &".carousel({" & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "					itemsPerPage: 3," & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "					itemsPerTransition: 3," & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "					pagination: true," & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "					noOfRows: 1" & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "				});" & vbCrLf
	GlobalConfig("jsCarousel") = GlobalConfig("jsCarousel") & "			}" & vbCrLf

	End If
	Set objRs2 = Nothing

	.Write("	<div class=""clr""></div>" & vbCrLf)
	.Write("</div> <!-- /portfolio -->" & vbCrLf)


	If Not (a = objRs.RecordCount) Then
		.Write("<div class=""ewy_hr"" style=""margin:20px 0px;""><hr /></div>")
	End If

	a = a + 1
objRs.MoveNext() : Loop

	Response.Write("	<div class=""clr""></div>" & vbCrLf)
	Response.Write("<div class=""ewy_hr"" style=""margin:20px 0px;""><hr /></div>")
	Call MundusTags(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"), True)
	Response.Write("	<div class=""clr""></div>" & vbCrLf)
'	Response.Write("<div class=""ewy_hr"" style=""margin:20px 0px;""><hr /></div>")

'If GlobalConfig("description") <> "" Then _
'	.Write("<div class=""content-description""><p><strong>Tanım :</strong> " & GlobalConfig("description") & "</p></div>")


End With
CloseRs objRs

%>


<%If Not GlobalConfig("jsCarousel") <> "" Then%>
<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function() {
<%
Response.Write GlobalConfig("jsCarousel")
%>
	});
/*]]>*/
</script>
<%End If%>

