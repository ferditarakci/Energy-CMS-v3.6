<%
With Response
	.Expires = 0
	.Expiresabsolute = Now() - 1
	.CacheControl = "no-cache"
	.AddHeader "pragma", "no-cache"
	.ContentType = "text/xml"
End With

strLinks = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", "", "", "")

rssWrite = "<?xml version=""1.0"" encoding=""UTF-8"" ?>" & vbCrLf
rssWrite = rssWrite & "<rss version=""2.0"""& vbCrLf
rssWrite = rssWrite & "    xmlns:media=""http://search.yahoo.com/mrss/""" & vbCrLf
rssWrite = rssWrite & "    xmlns:dc=""http://purl.org/dc/elements/1.1/"">" & vbCrLf
rssWrite = rssWrite & "    <channel>" & vbCrLf



'rssWrite = rssWrite & "		<image>" & vbCrLf
'rssWrite = rssWrite & "			<url>"& GlobalConfig("sBase") & "images/logo.png</url>" & vbCrLf
'rssWrite = rssWrite & "			<title>"& GlobalConfig("default_site_ismi") &" logo</title>" & vbCrLf
'rssWrite = rssWrite & "			<link>"& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", "", "", "") &"</link>" & vbCrLf
'rssWrite = rssWrite & "			<description>"& GlobalConfig("description") &"</description>")
'rssWrite = rssWrite & "		</image>" & vbCrLf

	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, b.title, b.text," & vbCrLf
	SQL = SQL & "	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date" & vbCrLf
	SQL = SQL & "FROM #___sayfa As a" & vbCrLf
	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	a.durum = 1" & vbCrLf
	SQL = SQL & "	And a.activeLink = 1" & vbCrLf
	SQL = SQL & "	And Length(b.text) > 200" & vbCrLf
	SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "	And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
	SQL = SQL & "	And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
	SQL = SQL & ")" & vbCrLf
	SQL = SQL & "ORDER BY a.id DESC" & vbCrLf
	SQL = SQL & "Limit 10;" & vbCrLf

	'SQL = setQuery( SQL )
	'Clearfix SQL

	Set objRs = setExecute( SQL )
		Do While Not objRs.Eof

		strLinks2 = UrlDecode(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", ""))
			If strLinks2 = "javascript:;" Then strLinks2 = strLinks

			rssWrite = rssWrite & "			<item>" & vbCrLf
			rssWrite = rssWrite & "				<title>" & objRs("title") & "</title>" & vbCrLf
			rssWrite = rssWrite & "				<link>" & strLinks2 & "</link>" & vbCrLf
			rssWrite = rssWrite & "				<description><![CDATA[" & vbCrLf & fnPre(ReplaceHR(HtmlUnicodeEdit(DuzenleHTML(Server.HtmlEncode(objRs("text"))))), GlobalConfig("sBase")) & vbCrLf &"				]]></description>" & vbCrLf
			'rssWrite = rssWrite & "				<category>" & KategoriName & "</category>" & vbCrLf
			rssWrite = rssWrite & "				<pubDate>" & TarihFormatla2( objRs("c_date") ) & "</pubDate>" & vbCrLf
			rssWrite = rssWrite & "			</item>" & vbCrLf

		objRs.MoveNext() : Loop
	Set objRs = Nothing

rssWrite = rssWrite & "    </channel>" & vbCrLf
rssWrite = rssWrite & "</rss>"

Response.Write(rssWrite)
%>
