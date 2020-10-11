<%

'GlobalConfig("request_option")
'GlobalConfig("request_sayfaid")
'GlobalConfig("request_sayfa_anaid")

'GlobalConfig("sayfa_ozelsayfa")
'GlobalConfig("sayfa_ozelsayfa_pass")

'GlobalConfig("PageTitle")
'GlobalConfig("PageText")

'GlobalConfig("description")
'GlobalConfig("keyword")

'GlobalConfig("c_date")
'GlobalConfig("m_date")

'GlobalConfig("sayfa_alias")
'GlobalConfig("sayfa_hits")

'Clearfix ascw("ı")
strTitle = BasHarfBuyuk(GlobalConfig("PageTitle"))
'strText = GlobalConfig("PageText")
strText = BSayfaLink(GlobalConfig("request_sayfaid"), strTitle, GlobalConfig("PageText"))
strText = strText & RegExpSayfaBol(GlobalConfig("PageText"))

'strCDate = DateSqlFormat(GlobalConfig("c_date"), "dd.mm.yy", 3)
strCDate = GlobalConfig("c_date")
strMDate = GlobalConfig("m_date")
If strMDate <> "" Then strCDate = strMDate

With Response








'	.Write("<div class=""contents clearfix"">" & vbCrLf)
'	.Write("	<div class=""sutun clearfix"">" & vbCrLf)
'	.Write("		<div class=""orta"">" & vbCrLf)
'	.Write("			<div class=""background"">" & vbCrLf)

'	strSharedUrl = Replace(Server.UrlEncode(GlobalConfig("site_uri")), "%2E", ".")

'	.Write("			<div class=""share-button clearfix"">" & vbCrLf)
'	.Write("				<div class=""tweet_share""><a href=""#"" onclick=""window.open('http://twitter.com/?status="& Server.UrlEncode(BasHarfBuyuk(strTitle)) &" - "& strSharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Twitter&apos;da Paylaş"" target=""_blank"">Twitter&apos;da Paylaş</a></div>" & vbCrLf)
'	.Write("				<div class=""face_share""><a href=""#"" onclick=""window.open('http://www.facebook.com/sharer.php?u="& strSharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Facebook&apos;da Paylaş"" target=""_blank"">Facebook&apos;da Paylaş</a></div>" & vbCrLf)
'	'If Site_REMOTE_ADDR = "z127.0.0.1" Then _
'	'.Write("				<div class=""face_like""><iframe style=""border:none; overflow:hidden; width:110px; height:21px"" src=""http://www.facebook.com/plugins/like.php?href="& strSharedUrl &"&amp;layout=button_count&amp;show_faces=true&amp;width=110&amp;action=like&amp;colorscheme=light&amp;height=21"" frameborder=""0"" scrolling=""no""></iframe></div>" & vbCrLf)
'	.Write("			</div>" & vbCrLf)

	.Write("			<h1 class=""title""><a href="""& GlobalConfig("site_uri") &""" title="""& strTitle &""">"& strTitle &"</a></h1>" & vbCrLf)
	'.Write("			<span class=""date hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strCDate) &"</span>" & vbCrLf)
'	.Write("			<abbr title="""& DateSqlFormat(strCDate, "yy-mm-dd", 1) &""" class=""dates hidden"">"& TarihFormatla( strCDate ) &"</abbr>" & vbCrLf)
	.Write("			<div class=""clr""></div>" & vbCrLf)

	.Write( strText )
	.Write( vbCrLf )

	.Write("				<div class=""clr""></div>" & vbCrLf)
'	.Write("			</div>" & vbCrLf)
'	.Write("		</div>" & vbCrLf)
'	.Write("	</div>" & vbCrLf)
'	.Write("</div>" & vbCrLf)





	'// Protfolyo listesi
	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, a.title, a.text, a.resim, a.alt, a.url" & vbCrLf
	SQL = SQL & "FROM #___files As a" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	a.durum = 1" & vbCrLf
	SQL = SQL & "	And a.anaresim = 0" & vbCrLf
	SQL = SQL & "	And a.parent_id = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
	SQL = SQL & "	And a.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	SQL = SQL & "	And a.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & ")" & vbCrLf
	SQL = SQL & "ORDER BY a.sira ASC;"
	'Clearfix setQuery(SQL)

	Set objRs2 = setExecute( SQL )
	If Not objRs2.Eof Then

		'GlobalConfig("jsCarouselid") = objRs("id") '& ", "

		'addClass = "" : If Not (a = objRs.RecordCount) Then addClass = " add-margin"
		'.Write("<div class=""carousel"" id=""carousel_"& a &""">" & vbCrLf)
		'.Write("<div class=""mask clearfix"">" & vbCrLf)
		'.Write("	<ul class=""portfolio_list"">" & vbCrLf)

		i = 0
		While Not objRs2.Eof

			addClass = ""
			'If i = 0 Then addClass = " class=""alpha"""
			If i Mod 3 = 0 Then addClass = " class=""alpha"""
			If i Mod 3 = 2 Then addClass = " class=""omega"""

			Pictureid = objRs2("id")
			PicturePath = sFolder(GlobalConfig("request_sayfaid"), 0) & "/" & objRs2("resim") & ""
			PictureTitle = objRs2("title") & ""
			PictureAlt = objRs2("alt") & "" : If PictureAlt = "" Then PictureAlt = PictureTitle
			PictureUrl = objRs2("url") & ""
			PictureText = objRs2("text") & ""

			If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"

			'strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objRs2("id"), 0, "")

			.Write("			<img src="""& PicturePath &""" alt="""& PictureAlt &""" />" & vbCrLf)


			i = i + 1
		objRs2.MoveNext() : Wend
	End If
	Set objRs2 = Nothing


End With
%>

