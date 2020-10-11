<!--#include file="header.asp"-->

		<div id="main" class="clearfix">
<%
Call MundusGetPages("ust_tekli", "a.sira ASC Limit 1", "OKs", 2, 1)
%>
		</div>
		<aside id="right_sidebar">
			<%
				'Call MundusModules("sag")
				'Call MundusFacebook()
				'Call MundusTags("", "", GlobalConfig("site_lang"))
				Call MundusMainMenu(0)
				'Call MundusAnket()
			%>
			<div class="clr"></div>
		</aside> <!-- #right_sidebar End -->

		<div class="clr"></div>
		<div class="ewy_hr" style="margin:20px 10px;"><hr /></div>
		<div class="clr"></div>

			<div id="mainfull">
				<!-- begin selected projects -->
				<div class="portfolio">
					<div class="side-content">
<%
	'// Protfolyo listesi 
	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id," & vbCrLf
	SQL = SQL & "	IFNULL(b.title, '') As title," & vbCrLf
	SQL = SQL & "	IFNULL(b.text, '') As text," & vbCrLf
	SQL = SQL & "	IFNULL(b.readmore_text, '') As readmore_text" & vbCrLf
	SQL = SQL & "FROM #___sayfa As a" & vbCrLf
	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	a.durum = 1" & vbCrLf
	SQL = SQL & "	And a.id = 57254" & vbCrLf
'	SQL = SQL & "	And a.anasyfAlias = 'alt_tekli'" & vbCrLf
	SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & ")" & vbCrLf
	SQL = SQL & "ORDER BY a.id ASC Limit 1;"
	'Clearfix setQuery(SQL)

	Set objRs = setExecute( SQL )
	If Not objRs.Eof Then
		strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", 57212, 0, "")
%>
						<h3 class="title"><a href="<%=strLinks%>"><%=objRs("title")%></a></h3>
						<%=fnPre(objRs("text"), GlobalConfig("sBase"))%>
						<a rel="bookmark" class="smallbtn2" href="<%=strLinks%>" title="<%=objRs("title")%>"><span><%

Response.Write(ReadMoreText(objRs("readmore_text")))

						'If objRs("readmore_text") <> "" Then Response.Write(objRs("readmore_text")) Else Response.Write("Daha Fazlası...")

						%></span></a>
					
<%
	End If
Set objRs = Nothing
%>
					</div> <!-- /side-content -->

<%

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
	'If Session("homeRefid") = "" Then
		SQL = SQL & "	And a.anaid IN (57211, 57213, 57271)" & vbCrLf
	'Else
	'	SQL = SQL & "	And a.id IN ("& Session("homeRefid") &")" & vbCrLf
	'End If
	SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & ")" & vbCrLf
	'If Session("homeRefid") = "" Then
		SQL = SQL & "ORDER BY Rand() Limit 8;"
	'Else
	'	SQL = SQL & "ORDER BY Field(a.id, "& Session("homeRefid") &") Limit 8;"
	'End If
	'Clearfix setQuery(SQL)

	Set objRs2 = setExecute( SQL )
	If Not objRs2.Eof Then
		With Response
		.Write("	<ul class=""portfolio_list"">" & vbCrLf)

		i = 0 : intid = ""
		While Not objRs2.Eof
			intid = intid & objRs2("id") & ", "

			addClass = ""
			If i Mod 4 = 0 Then addClass = " class=""alpha"""
			If i Mod 4 = 3 Then addClass = " class=""omega"""

			PicturePath = sFolder(objRs2("id"), 1) & "/" & objRs2("resim") & ""
			'If Not FilesKontrol(PicturePath) Then PicturePath = "./images/blank.gif"
			
			PictureFullPath = sFolder(objRs2("id"), 0) & "/" & objRs2("fullPicture")
			If Not objRs2("fullPicture") <> "" Then PictureFullPath = Replace(PicturePath, "/thumb/", "/")
			
			PictureTitle = objRs2("filesTitle") & ""
			PictureAlt = objRs2("alt") & "" : If PictureAlt = "" Then PictureAlt = PictureTitle
			PictureUrl = objRs2("url") & ""
			PictureText = objRs2("text") & ""
			PictureText = fnPre(PictureText, GlobalConfig("sBase"))
			strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs2("id"), 0, "")

			'If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<span id=""ewy_lnk_"& Pictureid &""" class=""ewy_lnk"& addClass &" hidden"">"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "//", "") &"</span>" & vbCrLf)
			'If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<a id=""ewy_addlnk_"& Pictureid &""" href=""#"& SefURL(PictureTitle) &""" title="""& PictureTitle &""">")

			.Write("<li"& addClass &">" & vbCrLf)

			.Write("	<h5 class=""entry-domain"">" & vbCrLf)
			'.Write("		<a style=""font-size:13px;"" href=""#"">"& PictureUrl &"</a>" & vbCrLf)
			'.Write("		"& Replace(Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "/index.html", ""), "www.", "") &"" & vbCrLf)
			.Write("		"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "/index.html", "") &"" & vbCrLf)
			.Write("	</h5>" & vbCrLf)

			.Write("	<div class=""entry-thumb"">" & vbCrLf)
			.Write("		<div class=""entry-thumb-wrap"">" & vbCrLf)
			.Write("			<a href="""& PictureFullPath &""" title="""& objRs2("title") &""" class=""lightbox webtasarim-portfolio"" target=""_blank"">")
			.Write("				<span class=""overlay""><span class=""zoom-icon""></span></span>" & vbCrLf)
			.Write("				<img"& imgAlign(PicturePath, 146, 146, 144, 144) &" src="""& PicturePath &""" alt="""& PictureAlt &""" />" & vbCrLf)
			.Write("			</a>" & vbCrLf)
			.Write("		</div>" & vbCrLf)
			.Write("	</div>" & vbCrLf)

			.Write("	<h4 class=""entry-title"">")
			'.Write("		<a href="""& strLinks &""" title="""& PictureAlt &""">"& objRs2("title") &"</a>" & vbCrLf)
			.Write( objRs2("title"))
			.Write("</h4>" & vbCrLf)

			'.Write("	<div class=""entry-description"">" & vbCrLf)
			'.Write("		"& PictureText &"" & vbCrLf)
			'.Write("	</div>" & vbCrLf)

			.Write("</li>" & vbCrLf)

			i = i + 1
		objRs2.MoveNext() : Wend

		.Write("	</ul>" & vbCrLf)

		.Write("	<div class=""clr""></div>" & vbCrLf)
		.Write("</div> <!-- /portfolio -->" & vbCrLf)

		End With

		If Session("homeRefid") = "" Then Session("homeRefid") = Left(intid, Len(intid) -2)
		
	End If
Set objRs2 = Nothing
%>
			</div> <!-- /mainfull -->

<!--#include file="footer.asp"-->
