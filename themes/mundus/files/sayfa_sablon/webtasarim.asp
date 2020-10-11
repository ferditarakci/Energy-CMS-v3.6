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

	.Write("				<div class=""clr""></div>" & vbCrLf)
	Call MundusTags(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"), True)

	.Write("			<div class=""clr""></div>" & vbCrLf)

	.Write( Replace(strText, "class=""lightbox""", "class=""lightbox"" rel=""lightbox"" target=""_blank""") )
	'.Write( vbCrLf )

	If GlobalConfig("description") <> "" Then _
		.Write("<div class=""content-description""><p><strong>Tanım :</strong> " & GlobalConfig("description") & "</p></div>")


	.Write("				<div class=""clr""></div>" & vbCrLf)
'	.Write("			</div>" & vbCrLf)
'	.Write("		</div>" & vbCrLf)
'	.Write("	</div>" & vbCrLf)
'	.Write("</div>" & vbCrLf)
End With
%>

