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
strTitle = GlobalConfig("PageTitle")
'strText = GlobalConfig("PageText")
strText = BSayfaLink(GlobalConfig("request_sayfaid"), strTitle, GlobalConfig("PageText"))
strText = strText & RegExpSayfaBol(GlobalConfig("PageText"))

'strCDate = DateSqlFormat(GlobalConfig("c_date"), "dd.mm.yy", 3)
strCDate = GlobalConfig("c_date")
strMDate = GlobalConfig("m_date")
If strMDate <> "" Then strCDate = strMDate

With Response

	.Write("			<h1 class=""title"">"& strTitle &"</h1>" & vbCrLf)
	'.Write("			<span class=""date hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strCDate) &"</span>" & vbCrLf)
'	.Write("			<abbr title="""& DateSqlFormat(strCDate, "yy-mm-dd", 1) &""" class=""dates hidden"">"& TarihFormatla( strCDate ) &"</abbr>" & vbCrLf)
	.Write("				<div class=""clr""></div>" & vbCrLf)
		Call MundusTags(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"), True)
	.Write("			<div class=""clr""></div>" & vbCrLf)
	.Write( Replace(strText, "class=""lightbox""", "class=""lightbox"" rel=""lightbox"" target=""_blank""") )
	.Write("				<div class=""clr""></div>" & vbCrLf)

End With

If GlobalConfig("sayfa_yorumizin") = 1 Then
	Response.Write("	<div class=""clr""></div>" & vbCrLf)
	Response.Write("<div class=""ewy_hr"" style=""margin:30px 0px;""><hr /></div>")
	Response.Write("	<div class=""clr""></div>" & vbCrLf)
	Call MundusComment(GlobalConfig("request_sayfaid"), GlobalConfig("General_PagePN"), 10, 1)
End If
%>

