<%
addClass2 = "h1" : If GlobalConfig("request_sayfa_anaid") = 0 Then addClass2 = "h2" ': Response.Write(GlobalConfig("PageText"))
'strLinks = GlobalConfig("site_uri")
GlobalConfig("jsCarouselid") = ""



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
SQL = SQL & "	And a.anaid = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
If GlobalConfig("request_sayfa_anaid") > 0 Then _
SQL = SQL & "	And a.id = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
'SQL = SQL & "	And Not a.anaid = 0" & vbCrLf
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

	strTitle = BasHarfBuyuk(objRs("title"))
	strText = fnPre(ReplaceHR(objRs("text")), GlobalConfig("sRoot"))
	strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs("id"), 0, "")

%>

<!-- begin selected projects -->
<div class="portfolio">
<%
	.Write("<" & addClass2 & " style=""font-size:20px;"">" & strTitle & "</" & addClass2 & ">" & vbCrLf)
	.Write( strText  & vbCrLf)


	'// Protfolyo listesi
	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, b.title, b.text, c.id As filesid, c.resim, c.title As filesTitle, c.alt, c.url, c.text As filesText, " & vbCrLf
	SQL = SQL & "    (SELECT resim FROM #___files WHERE parent = b.parent And parent_id = b.parent_id And durum = 1 And anaresim = 0 Limit 1) As fullPicture" & vbCrLf
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

		GlobalConfig("jsCarouselid") = objRs("id") '& ", "

		'addClass = "" : If Not (a = objRs.RecordCount) Then addClass = " add-margin"
		.Write("<div class=""carousel"" id=""carousel_"& objRs("id") &""">" & vbCrLf)
		'.Write("<div class=""mask clearfix"">" & vbCrLf)
		.Write("	<ul class=""portfolio_list"">" & vbCrLf)

		i = 0
		While Not objRs2.Eof

			addClass = ""
			If i Mod 3 = 0 Then addClass = " class=""alpha"""
			If i Mod 3 = 2 Then addClass = " class=""omega"""

			Pictureid = objRs2("filesid")
			PicturePath = sFolder(objRs2("id"), 0) & "/" & objRs2("resim") & ""
			PictureTitle = objRs2("filesTitle") & ""
			PictureAlt = objRs2("alt") & "" : If PictureAlt = "" Then PictureAlt = PictureTitle
			PictureUrl = objRs2("url") & ""
			PictureText = objRs2("text") & ""

			If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"

			'strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs2("id"), 0, "")

			.Write("<li"& addClass &">" & vbcrlf)
			.Write("	<h5 style=""margin-top:0; margin-bottom: -1px; font-size:13px; text-align:right;"" class=""entry-title"">" & vbcrlf) 
			'.Write("		<a style=""font-size:13px;"" href=""#"">"& PictureTitle &"</a>" & vbcrlf) 
			.Write("		"& PictureTitle &"" & vbcrlf) 
			.Write("	</h5>" & vbcrlf)
			.Write("	<div class=""entry-thumb"">" & vbcrlf) 
			.Write("		<div class=""entry-thumb-wrap"">" & vbcrlf) 

			'If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<span id=""ewy_lnk_"& Pictureid &""" class=""ewy_lnk"& addClass &" hidden"">"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "//", "") &"</span>" & vbCrLf)
			'If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<a id=""ewy_addlnk_"& Pictureid &""" href=""#"& SefURL(PictureTitle) &""" title="""& PictureTitle &""">")

			If objRs2("fullPicture") <> "" Then
				.Write("<a href="""& sFolder(objRs2("id"), 0) & "/" & objRs2("fullPicture") & "" &""" title="""& PictureTitle &""" rel=""prettyPhoto[gallery]"" target=""_blank"">")
			Else
				.Write("<a href="""& PicturePath & "" &""" title="""& PictureTitle &""" rel=""prettyPhoto[gallery]"" target=""_blank"">")
			End If

			'.Write("<a href="""& strLinks &""" title="""& PictureTitle &""">")
			.Write("			<span class=""overlay image""></span>" & vbcrlf) 
			.Write("			<img"& imgAlign(PicturePath, 296, 296, 294, 294) &" src="""& PicturePath &""" alt="""& PictureAlt &""" />" & vbcrlf) 
			.Write("		</a>" & vbcrlf)  ' imgAlign(PicturePath, 206, 116, 206, 116)
			.Write("		</div>" & vbcrlf) 
			.Write("	</div>" & vbcrlf) 
			.Write("	<h3 class=""entry-title"">" & vbcrlf) 
			.Write("		<a href=""#"">"& objRs2("title") &"</a>" & vbcrlf) 
			.Write("	</h3>" & vbcrlf) 

			.Write("	<div style=""line-height:1.4em;"" class=""entry-description"">" & vbcrlf) 
			.Write("		"& TextBR(PictureText) &"" & vbcrlf) 
			.Write("	</div>" & vbcrlf) 
			.Write("</li>") 

			i = i + 1
		objRs2.MoveNext() : Wend

	.Write("	</ul>" & vbCrLf)
	'.Write("</div>" & vbCrLf)
	.Write("</div>" & vbCrLf)
%>

<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function() {
	var $ewy_portfolioCarousel = $("#carousel_<%= GlobalConfig("jsCarouselid") %>s");
	if($ewy_portfolioCarousel.length > 0){
/*
	$ewy_portfolioCarousel.jCarouselLite({
			vertical:false,
			hoverPause:true,
			visible:2,
			scroll:2,
			auto:4000,
			speed:1200,
			easing:"easeInOutBack",
			btnNext:$("#carouselButton_<%= GlobalConfig("jsCarouselid") %> a.next"),
			btnPrev: $("#carouselButton_<%= GlobalConfig("jsCarouselid") %> a.prev")
		});
*/
		$ewy_portfolioCarousel.carousel({
			itemsPerPage: 2,
			itemsPerTransition: 2,
			pagination: true,
			noOfRows: 1,
			easing:""
		});

	}
});
/*]]>*/
</script>
<%
	End If
	Set objRs2 = Nothing

%>
	<div class="clr"></div>
</div>
<!-- end selected projects -->


<%
	If Not (a = objRs.RecordCount) Then
		.Write("<div class=""ewy_hr"" style=""margin:20px 0px;""><hr /></div>")
	End If

	a = a + 1
objRs.MoveNext() : Loop

End With
CloseRs objRs
%>

