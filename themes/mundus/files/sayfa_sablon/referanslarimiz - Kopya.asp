<%
addClass2 = "h1" : If GlobalConfig("request_sayfa_anaid") = 0 Then addClass2 = "h2" : Response.Write(GlobalConfig("PageText"))

'strLinks = GlobalConfig("site_uri")

SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.id, b.title, b.text, " & vbCrLf
SQL = SQL & "    (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date," & vbCrLf
SQL = SQL & "    (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	a.durum = 1" & vbCrLf
SQL = SQL & "	And (a.id = "& GlobalConfig("request_sayfaid") &" Or a.anaid = "& GlobalConfig("request_sayfaid") &")" & vbCrLf
SQL = SQL & "	And Not a.anaid = 0" & vbCrLf
SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "	And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "	And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "ORDER BY a.sira ASC;"

'SQL = setQuery( SQL )
'Clearfix SQL

OpenRs objRs, SQL
With Response


GlobalConfig("jsCarouselid") = ""
a = 1
Do While Not objRs.Eof

	strCDate = objRs("c_date") & ""
	strMDate = objRs("m_date") & ""
	If strMDate <> "" Then strCDate = strMDate

	strTitle = BasHarfBuyuk(objRs("title"))
	strText = fnPre(ReplaceHR(objRs("text")), GlobalConfig("sRoot"))
	strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs("id"), 0, "")


%>

<!-- begin selected projects -->
<div class="portfolio">
	<div class="side-content" style="margin-right:10px !important;">
		<h2 style="font-size:20px;"><%= strTitle %></h2>
		<%= strText %>
		<a class="smallbtn2" href="<%= strLinks %>"><span>Devamı...</span></a>
	</div>
<%



SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.id, b.title, b.text, c.id As filesid, c.resim, c.title As filesTitle, c.alt, c.url, c.text As filesText, " & vbCrLf
SQL = SQL & "    (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date," & vbCrLf
SQL = SQL & "    (SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "INNER JOIN #___files As c ON a.id = c.parent_id And c.anaresim = 1" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	a.durum = 1" & vbCrLf
SQL = SQL & "	And a.anaid = "& objRs("id") &"" & vbCrLf
'SQL = SQL & "	And Not a.anaid = 0" & vbCrLf
SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "	And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "	And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "ORDER BY a.sira ASC;"



'	SQL = ""
'	SQL = SQL & "SELECT id, parent_id, resim, title, alt, url, text" & vbCrLf
'	SQL = SQL & "FROM #___files" & vbCrLf
'	SQL = SQL & "WHERE (" & vbCrLf
'	SQL = SQL & "	parent_id = "& objRs("id") &"" & vbCrLf
'	'SQL = SQL & "	And id = 1042" & vbCrLf
'	SQL = SQL & "	And durum = 1" & vbCrLf
'	SQL = SQL & "	And file_type = 1" & vbCrLf
'	SQL = SQL & "	And anaresim = 1" & vbCrLf
'	SQL = SQL & "	And parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
'	SQL = SQL & "	And lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
'	SQL = SQL & ")" & vbCrLf
'	SQL = SQL & "Limit 1;"
'	'SQL = setQuery( SQL )
'	'Clearfix SQL

	Set objRs2 = setExecute( SQL )
	If Not objRs2.Eof Then
	
		GlobalConfig("jsCarouselid") = objRs("id") '& ", "

		'addClass = "" : If Not (a = objRs.RecordCount) Then addClass = " add-margin"
		.Write("<div class=""carousel"" id=""carousel_"& objRs("id") &""">" & vbCrLf)
		.Write("	<ul class=""portfolio_list"">" & vbCrLf)

	i = 0
	While Not objRs2.Eof

		addClass = ""
		If i Mod 2 = 1 Then addClass = " ml"

		Pictureid = objRs2("filesid")
		PicturePath = sFolder(objRs2("id"), 0) & "/" & objRs2("resim") & ""
		PictureTitle = objRs2("filesTitle") & ""
		PictureAlt = objRs2("alt") & ""' : If PictureAlt = "" Then PictureAlt = PictureTitle
		PictureUrl = objRs2("url") & ""
		PictureText = objRs2("text") & ""

		If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"

		.Write("<li class="""& addClass &""">" & vbcrlf) 
		.Write("	<div class=""entry-thumb"">" & vbcrlf) 
		.Write("		<div class=""entry-thumb-wrap"">" & vbcrlf) 

		If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<span id=""ewy_lnk_"& Pictureid &""" class=""ewy_lnk"& addClass &" hidden"">"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "//", "") &"</span>" & vbCrLf)
		If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<a id=""ewy_addlnk_"& Pictureid &""" href=""#"& SefURL(PictureTitle) &""" title="""& PictureTitle &""">")
		If Not PictureUrl = "" And Not Left(PictureUrl, 2) = "//" Then .Write("<a href="""& PictureUrl &""" title="""& PictureTitle &""" rel=""prettyPhoto[gallery]"" target=""_blank"">")

		'.Write("		<a href=""http://www.webtasarimx.net/themes/mundus/images/entries/full-size/image-8.jpg"" rel=""prettyPhoto[gallery]"" title=""Project Title"">" & vbcrlf) 
		.Write("			<span class=""overlay image""></span>" & vbcrlf) 
		.Write("			<img"& imgAlign(PicturePath, 296, 296, 290, 290) &" src="""& PicturePath &""" title="""& PictureTitle &""" alt="""& PictureTitle &""" />" & vbcrlf) 
		If PictureUrl <> "" Then .Write("		</a>" & vbcrlf)  ' imgAlign(PicturePath, 206, 116, 206, 116)
		.Write("		</div>" & vbcrlf) 
		.Write("	</div>" & vbcrlf) 
		.Write("	<h3 class=""entry-title"">" & vbcrlf) 
		.Write("		<a href=""#"">"& PictureTitle &"</a>" & vbcrlf) 
		.Write("	</h3>" & vbcrlf) 
		.Write("	<div class=""entry-description"">" & vbcrlf) 
		.Write("		"& TextBR(PictureText) &"" & vbcrlf) 
		.Write("	</div>" & vbcrlf) 
		.Write("</li>") 

		i = i + 1
	objRs2.MoveNext() : Wend

	.Write("	</ul><div class=""clr""></div>" & vbCrLf)
%>



<%
	.Write("</div>" & vbCrLf)
	End If
	Set objRs2 = Nothing

%>

	<header>
		<div id="carouselButton_<%= GlobalConfig("jsCarouselid") %>" class="carousel_button">
			<div>
				<a href="#" class="prev" title="Önceki" onclick="return false;">Önceki</a>
				<a href="#" class="next" title="Sonraki" onclick="return false;">Sonraki</a>
			</div>
		</div>
	</header>


	<!--
	<ul class="pager">
		<li id="testimonial-prev" class="prev" style="display: list-item; "><a href="#">«</a></li>
		<li id="testimonial-next" class="next" style="display: list-item; "><a href="#">»</a></li>
	</ul>
	-->
	<div class="clr"></div>
</div>
<!-- end selected projects -->
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function() {
	var $ewy_portfolioCarousel = $("#carousel_<%= GlobalConfig("jsCarouselid") %>");
	if($ewy_portfolioCarousel.length > 0){

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
/*
		$ewy_portfolioCarousel.carousel({
			itemsPerPage: 2,
			itemsPerTransition: 2,
			pagination: true,
			noOfRows: 1
		});
*/
	}
});
/*]]>*/
</script>



<div class="clr"></div>
<div class="ewy_hr" style="margin:20px 0px;"><hr /></div>
<div class="clr"></div>








<%




'	.Write("	<div class=""contents"" style=""display:none !important"">" & vbCrLf)

	'.Write("		<div class=""sutun"">" & vbCrLf)
	'.Write("			<div class=""orta"">" & vbCrLf)
	'.Write("				<div class=""background"">" & vbCrLf)

'	.Write("					<"& addClass2 &" class=""title""><a href="""& strLinks &""" title="""& BasHarfBuyuk(strTitle) &""">"& strTitle &"</a></"& addClass2 &">" & vbCrLf)
'	.Write("					<abbr title="""& DateSqlFormat(strCDate, "yy-mm-dd", 1) &""" class=""date hidden"">"& TarihFormatla( strCDate ) &"</abbr>" & vbCrLf)
'	.Write("					<div class=""clr""></div>" & vbCrLf)
'	.Write(vbCrLf & strText & vbCrLf)




'	SQL = ""
'	SQL = SQL & "SELECT id, parent_id, resim, title, alt, url, text" & vbCrLf
'	SQL = SQL & "FROM #___files" & vbCrLf
'	SQL = SQL & "WHERE (" & vbCrLf
'	SQL = SQL & "	parent_id = "& objRs("id") &"" & vbCrLf
	'SQL = SQL & "	And id = 1042" & vbCrLf
'	SQL = SQL & "	And durum = 1" & vbCrLf
'	SQL = SQL & "	And file_type = 1" & vbCrLf
'	SQL = SQL & "	And parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
'	SQL = SQL & "	And lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
'	SQL = SQL & ")" & vbCrLf
'	SQL = SQL & "ORDER BY Rand();"
	'SQL = setQuery( SQL )
	'Clearfix SQL

'	i = 1
'	Set objRs2 = setExecute( SQL )
'	If Not objRs2.Eof Then
'		addClass = "" : If Not (a = objRs.RecordCount) Then addClass = " add-margin"
'		.Write("					<ol class=""referans"& addClass &""">" & vbCrLf)
'		While Not objRs2.Eof

'			Pictureid = objRs2("id")
'			PicturePath = sFolder(objRs2("parent_id"), 1) & "/" & objRs2("resim") & ""
'			PictureTitle = objRs2("title") & ""
'			PictureAlt = objRs2("alt") & ""' : If PictureAlt = "" Then PictureAlt = PictureTitle
'			PictureUrl = objRs2("url") & ""
'			PictureText = objRs2("text") & ""

'			If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"

			'If i Mod 4 = 1 Then .Write("					<div class=""divider"" style=""margin-top:5px;""></div>" & vbCrLf)

'			addClass = "" : If i Mod 4 = 1 Then addClass = " class=""no-margin"""

'			.Write("						<li"& addClass &">" & vbCrLf)
'			.Write("							<div class=""grid"">" & vbCrLf)
'			.Write("								<h5 id="""& SefURL(PictureTitle) &""" title="""& PictureTitle &"""><span>"& PictureAlt &"</span> "& PictureTitle &"</h5>" & vbCrLf)
'			.Write("								")

'			addClass = "" : If inStrBot() Then addClass = " o"
'			If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<span id=""ewy_lnk_"& Pictureid &""" class=""ewy_lnk"& addClass &" hidden"">"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "//", "") &"</span>" & vbCrLf)
'			If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<a id=""ewy_addlnk_"& Pictureid &""" href=""#"& SefURL(PictureTitle) &""" title="""& PictureTitle &""">")
'			If Not PictureUrl = "" And Not Left(PictureUrl, 2) = "//" Then .Write("<a href="""& PictureUrl &""" title="""& PictureTitle &""" target=""_blank"">")

'			.Write("<span class=""img_bg""><img"& imgAlign(PicturePath, 214, 128, 210, 126) &" src="""& PicturePath &""" title="""& PictureTitle &""" alt="""& PictureTitle &""" /></span>")

			'.Write("<span>" & Replace(PictureTitle, " - ", " <br />") & "</span>")

'			If PictureUrl <> "" Then .Write("</a>")
'			.Write( vbCrLf & "								<p>"& TextBR(PictureText) &"</p>")
'			.Write("							</div>" & vbCrLf)
'			.Write("						</li>" & vbCrLf)




'		i = i + 1
'	objRs2.MoveNext() : Wend
'	.Write("					</ol>" & vbCrLf)
'	End If
'	Set objRs2 = Nothing


'	.Write("					<div class=""clr""></div>" & vbCrLf)
	'.Write("				</div>" & vbCrLf)
	'.Write("			</div>" & vbCrLf)
	'.Write("		</div>" & vbCrLf)
'	.Write("	</div>" & vbCrLf)

'	If Not (a = objRs.RecordCount) Then .Write("					<div class=""divider"" style=""margin-top:5px;""></div>" & vbCrLf)
'	a = a + 1
objRs.MoveNext() : Loop
End With
CloseRs objRs

'If GlobalConfig("jsCarouselid") <> "" Then _
'GlobalConfig("jsCarouselid") = Left(GlobalConfig("jsCarouselid"), Len(GlobalConfig("jsCarouselid"))-2)

%>

