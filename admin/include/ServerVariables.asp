<%
Dim Site_SCRiPT_NAME, Site_SERVER_NAME, Site_HTTP_HOST, Site_HTTP_REFERER, blnPostMethod
Dim Site_APPL_PHYSiCAL_PATH, Site_LOCAL_ADDR, Site_REMOTE_ADDR, Site_QUERY_STRiNG
Dim Site_HTTP_USER_AGENT, Site_PATH_iNFO, Site_HTTPS, Site_FORM_METHOD, Site_REQUEST_URi, Site_HTTP_X_ORIGINAL_URL, Site_X_Original_URL

With Request
	Site_SCRIPT_NAME = .ServerVariables("SCRiPT_NAME")
	Site_SERVER_NAME = .ServerVariables("SERVER_NAME")
	Site_HTTP_HOST = .ServerVariables("HTTP_HOST")
	Site_HTTP_REFERER = .ServerVariables("HTTP_REFERER")
	Site_APPL_PHYSiCAL_PATH = .ServerVariables("APPL_PHYSiCAL_PATH")
	Site_LOCAL_ADDR = .ServerVariables("LOCAL_ADDR")
	Site_REMOTE_ADDR = .ServerVariables("REMOTE_ADDR")
	Site_QUERY_STRiNG = .ServerVariables("QUERY_STRiNG")
	Site_HTTP_USER_AGENT = .ServerVariables("HTTP_USER_AGENT")
	Site_PATH_iNFO = .ServerVariables("PATH_iNFO")
	Site_HTTPS = LCase(.ServerVariables("HTTPS"))
	Site_FORM_METHOD = UCase(.ServerVariables("REQUEST_METHOD"))
	blnPostMethod = UCase(.ServerVariables("REQUEST_METHOD")) = "POST"
	Site_REQUEST_URi = .ServerVariables("REQUEST_URi")
	Site_HTTP_X_ORIGINAL_URL = .ServerVariables("HTTP_X_ORIGINAL_URL")
	Site_X_Original_URL = .ServerVariables("X-Original-URL")

End With

'For each a in Request.ServerVariables
'Response.Write a & ": " & Request.ServerVariables( a ) & vbCrLf
'Next
'Response.end
Dim mods, task, update, menutype, parent, parent_id, id, g_, o_

mods = Temizle(Request.QueryString("mod"), 1)
task = Temizle(Request.QueryString("task"), 1)
update = Temizle(Request.QueryString("update"), 1)
menutype = Temizle(Request.QueryString("menutype"), 1)
parent = Temizle(Request.QueryString("parent"), 1)
parent_id = intYap(Request.QueryString("parent_id"), 0)
id = intYap(Request.QueryString("id"), 0)
g_ = Request.QueryString("g1") : o_ = Request.QueryString("o1")


Const ewy_queryLang = "ewy_lang"
Const ewy_queryOption = "ewy_option"
Const ewy_queryTask = "ewy_task"
Const ewy_queryTitle = "ewy_title"
Const ewy_querySayfaid = "ewy_sid"
Const ewy_queryStart = "ewy_start"
Const ewy_queryShowAll = "ewy_all"
Const ewy_queryid = "ewy_id"
Const ewy_queryLimit = "ewy_limit"
Const ewy_queryLimitStart = "ewy_limitstart"
Const ewy_querySearch = "ewy_query"
Const ewy_queryDomain = "ewy_domain"

With Request

	GlobalConfig("site_lang") = .QueryString( ewy_queryLang )

	GlobalConfig("request_option") = .QueryString( ewy_queryOption )

	GlobalConfig("request_task") = .QueryString( ewy_queryTask )

	GlobalConfig("request_title") = .QueryString( ewy_queryTitle )

	'GlobalConfig("request_sayfaid") = .QueryString( ewy_querySayfaid )

	GlobalConfig("request_start") = .QueryString( ewy_queryStart )

	GlobalConfig("request_showall") = .QueryString( ewy_queryShowAll )

	GlobalConfig("request_globalid") = .QueryString( ewy_queryid )

	GlobalConfig("request_sayfaid") = .QueryString( ewy_queryid )

	GlobalConfig("request_limit") = .QueryString( ewy_queryLimit )

	GlobalConfig("request_limitstart") = .QueryString( ewy_queryLimitStart )

	'GlobalConfig("request_q") = Urlencode(.QueryString( ewy_querySearch ))
	GlobalConfig("request_q") = .QueryString( ewy_querySearch )

	GlobalConfig("request_domain") = .QueryString( ewy_queryDomain )

	If .QueryString("option") <> "" Then GlobalConfig("request_option") = .QueryString("option")
	If .QueryString("title") <> "" Then GlobalConfig("request_title") = .QueryString("title")

End With

If Request.QueryString = "option=web-tasarim-referanslarim" Then GlobalConfig("request_title") = Request.QueryString("option") : GlobalConfig("request_option") = "sayfa"
If Request.QueryString = "option=web-tasarim-hizmetleri" Then GlobalConfig("request_title") = Request.QueryString("option") : GlobalConfig("request_option") = "sayfa"

Dim sLang : sLang = "" : If GlobalConfig("site_lang") <> "" Then sLang = "&amp;"& ewy_queryLang &"=" & GlobalConfig("site_lang")



Function isTrue(ByVal varStr)
	isTrue = CBool(inStr(1, Request.ServerVariables("HTTP_USER_AGENT"), varStr, 1))
End Function


'GlobalConfig("request_q") = "web tasarım yazılım%" 'Replace(Request.QueryString( ewy_querySearch ), "%", "")
'Set EnergyRs = data.ExeCute("Select * FROM "& tblPreFix &"sayfa limit 1")
'    For Each Item In EnergyRs.Fields
'        Response.Write(EnergyRs(Item.Name) & "<br />")
'    Next
'Set EnergyRs = Nothing

'http://translate.google.com/translate?js=n&prev=_t&hl=en&ie=UTF-8&u=http://www.diyarbakirspor.org&sl=tr&tl=en&history_state0=
'url = "http://translate.google.com.tr/m?hl=tr&sl="&dil1&"&tl="&dil2&"&ie=UTF-8&prev=_m&q="&q&"" 
'Set objXmlHttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1") 
'	objXmlHttp.Open "GET",url,False  
'	objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded;"
'	objXmlHttp.SetRequestHeader "Referer", ""&url&""
'	objXmlHttp.SetRequestHeader "User-Agent", "Nokia6300/"
'	objXmlHttp.SetRequestHeader "Pragma", "no-cache"
'	objXmlHttp.SetRequestHeader "Cache-control", "no-cache" 
'	objXmlHttp.Send 
'	veriler = objXmlHttp.Responsetext
'Set objXmlHttp = Nothing
%>
