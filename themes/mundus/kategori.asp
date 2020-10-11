<!--#include file="header.asp"-->
<!--#include file="files/kategori_files/folder-list-category.asp"-->
	<div id="maincolumn" class="content">
		<div class="nopad">

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


strTitle = UCase2( GlobalConfig("PageTitle") )
'strText = GlobalConfig("PageText")
strText = BSayfaLink(GlobalConfig("request_sayfaid"), strTitle, GlobalConfig("PageText"))
strText = strText & RegExpSayfaBol(GlobalConfig("PageText"))

'strCDate = DateSqlFormat(GlobalConfig("c_date"), "dd.mm.yy", 3)
strCDate = TarihFormatla(GlobalConfig("c_date"))
'strPageMDate = TarihFormatla(GlobalConfig("m_date"))

With Response
	.Write("<div class=""contents clearfix"">" & vbCrLf)
	.Write("	<div class=""sutun clearfix"">" & vbCrLf)
	.Write("		<div class=""orta"">" & vbCrLf)
	.Write("			<div class=""background"">" & vbCrLf)

	SharedUrl = Server.UrlEncode( GlobalConfig("site_uri") )
	SharedUrl = Replace(SharedUrl, "%2E", ".", 1, -1, 1)
	.Write("					<div class=""share-button clearfix"">" & vbCrLf)
	.Write("						<div class=""tweet_share""><a href=""#"" onclick=""window.open('http://twitter.com/?status="& UrlEncode( ""& strTitle ) &" - "& SharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Twitter&apos;da Paylaş"" target=""_blank"">Twitter&apos;da Paylaş</a></div>" & vbCrLf)
	.Write("						<div class=""face_share""><a href=""#"" onclick=""window.open('http://www.facebook.com/sharer.php?u="& SharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Facebook&apos;da Paylaş"" target=""_blank"">Facebook&apos;da Paylaş</a></div>" & vbCrLf)
	'If Site_REMOTE_ADDR = "z127.0.0.1" Then _
	'.Write("						<div class=""face_like""><iframe style=""border:none; overflow:hidden; width:110px; height:21px"" src=""http://www.facebook.com/plugins/like.php?href="& SharedUrl &"&amp;layout=button_count&amp;show_faces=true&amp;width=110&amp;action=like&amp;colorscheme=light&amp;height=21"" frameborder=""0"" scrolling=""no""></iframe></div>" & vbCrLf)
	.Write("					</div>" & vbCrLf)

	.Write("					<h2 class=""title"" title="""& strTitle &"""><a href="""& iUrlWrite &""" title="""& strTitle &""">"& strTitle &"</a></h2>" & vbCrLf) 
	.Write("					<span class=""tarih hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strCDate) &"</span>" & vbCrLf)
	.Write("					<div class=""clr""></div>" & vbCrLf)

	.Write( strText )
	.Write( vbCrLf )

	.Write("				<div class=""clr""></div>" & vbCrLf)
	.Write("			</div>" & vbCrLf)
	.Write("		</div>" & vbCrLf)
	.Write("	</div>" & vbCrLf)
	.Write("</div>" & vbCrLf)
End With




Call VisualCategoryList(GlobalConfig("request_sayfaid"), GlobalConfig("vitrin_alt_kategori"), Lang("kategori_alt_kategoriler"))



%>

<!--#'include file="files/kategori_files/urun1.asp"-->
	</div>
	</div>
	<div id="rightcolumn">
		<%
			Call PixModules("sag")
		%>
	</div>

<!--#include file="footer.asp"-->
