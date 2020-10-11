<!--#include file="../admin/include/inc.asp"-->
<%
Dim Default_URL
%>
<!--#include file="languages/index.asp"-->
<%
If GlobalConfig("request_option") = "Not Found" Then
	With Response
		.Status = 404
		'.Status = "404 Not Found"
		'.AddHeader "status", "404 Not Found"
		'.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
	End With
End If
%>
<!--#include file="page_default_files/default.asp"-->
<!--#include file="functions.asp"-->
<%

'Private Function SubClear()
'	Dim OptionArray, OptionDurum, item
'	OptionArray = Array("whois2", "whois-check", "server", "sitemap", "rss", "redirect", "post", "anket")
'	OptionDurum = False
'	For Each item in OptionArray
'		If (GlobalConfig("request_option") = item) Then OptionDurum = True
'		If OptionDurum Then Exit For
'	Next
'	SubClear = OptionDurum
'End Function


'// İstatistik
'Dim SiteBugunHit, SiteToplamHit
'SiteBugunHit = 0
'SiteToplamHit = 0

'If Not SubClear() Then
	'If (dataBaseName = "MySQL") Then Tarihim = "current_date" Else Tarihim = Cdate("24/03/2011")
	'If (dataBaseName = "MySQL") Then
	'	Kosul = "WHERE tarih = current_date"
	'ElseIf (dataBaseName = "MsSQL") Then
	'	Kosul = "WHERE tarih = getdate()"
	'Else
		'Kosul = "WHERE tarih = #"&Date()&"#"
	'	Kosul = "WHERE ((Day(tarih) = "&Day(Date())&") And (Month(tarih) = "&Month(Date())&") And (Year(tarih) = "&Year(Date())&"))"
	'End If
	'Kosul = "WHERE ((Day(tarih) = "&Day(Date())&") And (Month(tarih) = "&Month(Date())&") And (Year(tarih) = "&Year(Date())&"))"

'	SQL = Empty
'	SQL = SQL & "SELECT hit, tarih FROM #___sayac "
'	SQL = SQL & "WHERE "
'	'SQL = SQL & "("
'	'SQL = SQL & "(Day(tarih) = "& Day(Date()) &") "
'	'SQL = SQL & "(Month(tarih) = "& Month(Date()) &") "
'	'SQL = SQL & "(Year(tarih) = "& Year(Date()) &") "
'	'SQL = SQL & ") "
'	SQL = SQL & "tarih = CURDATE() "
'	SQL = SQL & "ORDER BY id DESC Limit 1;"
'	SQL = setQuery( SQL )

'	Set objRs = Server.CreateObject("ADODB.Recordset")
'	objRs.Open( SQL ),data,1,3
'	If Not inStrBot() Then
'		Dim strSessionName
'		strSessionName = SefUrl("energy-global-hit-" & GlobalConfig("sBase") & "-" & Date())
'		If (Session( strSessionName ) <> True) Then
'			If objRs.Eof Then
'				objRs.AddNew()
'				objRs("tarih") = DateSqlFormat(Date(), "yy-mm-dd", 0)
'				objRs("hit") = 1
'			Else
'				objRs("hit") = objRs("hit") + 1
'			End If
'			objRs.Update()
'			Session( strSessionName ) = True
'		End If
'	End If

'	If Not objRs.Eof Then SiteBugunHit = objRs("hit")

'	objRs.Close : Set objRs = Nothing

'	SiteToplamHit = sqlQuery("SELECT Sum( hit ) FROM #___sayac;", 0)

'End If '// Option kontrol

'If Not inStrBot() Then
'	Call LogActiveUser(SefUrl(GlobalConfig("sRoot")))
'	Call ActiveUserCleanup(SefUrl(GlobalConfig("sRoot")))
'End If
%>
