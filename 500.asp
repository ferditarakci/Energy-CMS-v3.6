<%@ Language = VBScript.Encode Codepage = 65001 LCID = 1055%>
<%
Option Explicit

%><!--#include file="admin/include/include_500_err_page.asp"--><%

On Error Resume Next

With Session
	.Codepage = 65001
	.LCiD = 1055
End With

With Response
	.Clear
	.Codepage = 65001
	.LCiD = 1055
	.Charset = "utf-8"
	.ContentType = "text/html"
	.Expires = 0
	.Expiresabsolute = Now() - 1
	.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
	.AddHeader "pragma", "no-cache"
	.AddHeader "cache-control", "private"
	.CacheControl = "no-cache"
	.CacheControl = "no-store"
	.Status = "500 Internal Server Error"
End With

Dim Conn, blnSuperAdmin, objRs, strASPCode, intNumber, strSource, strFile, intLine, strDescription, strASPDescription, strTamUrl
Dim HTTP_URL, HTTP_URi, Site_SERVER_NAME, Site_HTTP_HOST, Site_REMOTE_ADDR, Site_QUERY_STRiNG
Dim Site_PATH_iNFO, Site_HTTPS, iSSL, iHttpHost, wwwKontrol, localKontrol, SCSTR, Pinfo


With Server.GetLastError()
	strASPCode = .ASPCode
	intNumber = .Number
	strSource = .Source
	strFile = LCase(.File)
	intLine = .Line
	strDescription = .Description
	strASPDescription = .ASPDescription
End With


With Request
	Site_SERVER_NAME = .ServerVariables("SERVER_NAME")
	Site_HTTP_HOST = .ServerVariables("HTTP_HOST")
	Site_REMOTE_ADDR = .ServerVariables("REMOTE_ADDR")
	Site_QUERY_STRiNG = .ServerVariables("QUERY_STRiNG")
	Site_PATH_iNFO = LCase(.ServerVariables("PATH_iNFO"))
	Site_HTTPS = UCase(.ServerVariables("HTTPS"))
End With

blnSuperAdmin = Request.QueryString("debug") = "true" Or _
   CBool(inStr(LCase(Request.ServerVariables("QUERY_STRiNG")), "debug=true")) Or _
   Request.ServerVariables("LOCAL_ADDR") = "127.0.0.1"

'blnSuperAdmin = Request.QueryString("debug") = "true"
'blnSuperAdmin = True
'Response.Write blnSuperAdmin
Debug
Dim Count, iPath
Count = inStrRev(LCase(Site_PATH_iNFO), "/")
iPath = Left(LCase(Site_PATH_iNFO), Count)
iPath = Replace(iPath, "/admin", "", 1, -1, 1)

'Response.Write iPath

iSSL = "" : If Site_HTTPS = "ON" Then iSSL = "s"

iHttpHost = "http"& iSSL &"://"

'wwwKontrol = (Left(Request.ServerVariables("HTTP_HOST"), 4) <> "www.") '// www yoksa
'localKontrol = (Request.ServerVariables("SERVER_NAME") = "localhost" Or Request.ServerVariables("SERVER_NAME") = "127.0.0.1")

'If wwwKontrol And Not LocalKontrol Then iHttpHost = iHttpHost & "www."
iHttpHost = iHttpHost & Request.ServerVariables("HTTP_HOST")

If (inStr(1, LCase(Request.ServerVariables("QUERY_STRiNG")), "404;", 1) > 0) Then
	HTTP_URL = Replace(Replace(Split(LCase(Request.ServerVariables("QUERY_STRiNG")), ";")(1), ":80/", "/"), ":443/", "/")
	HTTP_URi = "/" & Split(HTTP_URL, "/", 4, 1)(3)
	iHttpHost = iHttpHost & HTTP_URi
Else
	SCSTR = iPath
	Pinfo = Replace(LCase(Request.ServerVariables("PATH_iNFO")), iPath, "")
	If LCase(Request.ServerVariables("QUERY_STRiNG")) <> "" Then SCSTR = SCSTR & Pinfo & "?" & LCase(Request.ServerVariables("QUERY_STRiNG"))
	iHttpHost = iHttpHost & SCSTR
End If

strTamUrl = Replace(Replace(iHttpHost, "&", "&amp;"), "'", "&apos;")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--[if IE 6]><html class="ie6" xmlns="http://www.w3.org/1999/xhtml" lang="tr_TR"><![endif]-->
<!--[if IE 7]><html class="ie7" xmlns="http://www.w3.org/1999/xhtml" lang="tr_TR"><![endif]-->
<!--[if !(IE)]><html xmlns="http://www.w3.org/1999/xhtml" lang="tr_TR"><![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="author" content="Ferdi Tarakcı, www.webtasarimx.net" />
		<meta name="generator" content="webtasarimx.net - Freelance Web Developer" />
		<meta name="reply-to" content="bilgi@webtasarimx.net" />
		<meta name="robots" content="noindex, nofollow, noarchive, noimageindex" />
		<link href="http://www.webtasarimx.net/favicon.ico" rel="shortcut icon" type="image/x-icon" title="Web Tasarım" />
		<title>500 İç Sunucu Hatası Oluştu! - webtasarimx.net</title>
		<style type="text/css">
			/*
				Copyright © 2008 - <%=Year(Date)%>
				Freelance Web Developer - Ferdi Tarakcı
				www.webtasarimx.net
				bilgi@webtasarimx.net
			*/
			* {
				margin:0; 
				padding:0;
			}
			html {
				min-height:100%;
			}
			body {
				overflow:auto;
				overflow-y:scroll;
				font-family:"Segoe UI", Arial;
				line-height:1;
			}
			html.ie7 body {
				/*overflow:hidden;*/
			}
			table {
				border-collapse:separate;
				border-spacing:0;
			}
			.ie7 table {
				border-collapse:collapse;
			}
			td, th {
				padding:1px;
			}
			#ewy-error {
				margin:2em auto;
				padding:1em 2em;
				color:#fff;
				font:85%;
				background-color:#f5f5f5;
			}
			#ewy-error-content {
				width:750px;
				margin:1.5em auto;
				padding:25px 10px;
				text-align:center;
				border:1px solid #dfdfdf;
				border-radius:8px;
				-moz-border-radius:8px;
				-khtml-border-radius:8px;
				-webkit-border-radius:8px;
				-o-border-radius:8px;
				background-color:#fff;
			}
			#ewy-error-content h1 {
				margin:0;
				padding:0 0 5px 0;
				line-height:18px;
				font-size: 17px;
				color:#444;
			}
			#ewy-error-content h2, #ewy-error-content h2 a {
				margin:0;
				padding:0 0 5px 0;
				line-height:14px;
				font-size: 13px;
				color:#444;
			}
			#ewy-error-content p {
				margin:0;
				margin-bottom:5px;
				padding:0;
				line-height:15px;
				font-size: 14px;
				color:#444;
			}
			#ewy-error-content span {
				color:#f00;
			}
			#ewy-error-content .line {
				margin-bottom:6px;
				padding:3px 0;
				border-bottom:1px solid #ccc;
			}
			#ewy-error-content .table {
				margin:20px auto 0;
				padding:1px;
				border-radius:5px;
				-moz-border-radius:5px;
				-khtml-border-radius:5px;
				-webkit-border-radius:5px;
				-o-border-radius:5px;
				background-color:#aaa;
			}
			#ewy-error-content table {
				width:100%;
				margin:0 auto;
				padding:5px;
				line-height:13px;
				font-size:12px;
				color:#444;
				border:0;
				background-color:#aaa;
			}
			#ewy-error-content th {
				padding:2px 5px;
				text-align:left;
				vertical-align:middle;
				color:#fff;
				white-space:nowrap;
				border:none;
				border-right:1px solid #fefbd8;
				border-bottom:1px solid #fefbd8;
				background-color:#333333;
			}
			#ewy-error-content td {
				height:32px;
				padding:2px 5px;
				text-align:left;
				vertical-align:middle;
				color:#000;
				border:none;
				border-right:1px solid #fefbd8;
				border-bottom:1px solid #fefbd8;
				background-color:#eee;
			}
			.clearfix:after {
				height:0;
				clear:both;
				content:".";
				display:block;
				visibility:hidden;
			}
			.clearfix {
				display:inline-block;
			}
			* html .clearfix { /* Hides From IE-MAC \*/
				height:1%;
				display:inline-block;
			}
			.clearfix { /* Endhide From IE-MAC \*/
				display:block;
			}
			.ie6 .clearfix {
				height:1%;
			}
			.ie7 .clearfix {
				display:inline-block;
			}
			.clr {
				clear:both;
				display:block;
				font-size:0;
				line-height:0;
			}
			.hidden {
				display:none;
			}
		</style>
	</head>
	<body id="ewy-error">
		<div id="ewy-error-content">
			<h1>Web Developer: Ferdi TARAKCI</h1>
			<h2>Web Site: <a href="http://www.webtasarimx.net/" title="Freelance Web Developer">www.webtasarimx.net</a></h2>
			<h2>Mail: bilgi@webtasarimx.net</h2>
			<div class="line"></div>
			<p><span><strong>500 - İç Sunucu Hatası Oluştu!</strong></span></p>
			<p><strong>Aradığınız kaynakta bir sorun var ve kaynak görüntülenemiyor.</strong></p>
			<%
			If blnSuperAdmin Then
			%>			<p><strong>Lütfen Site Yöneticisi ile irtibata geçin.</strong></p>
			<%
			End If
			If blnSuperAdmin Then
			%>
			<div class="table">
				<table>
					<%If strASPCode <> "" Then%>
					<tr>
						<th>IIS Hata Numarası</th>
						<td><%=strASPCode%></td>
					</tr>
					<%End If%>
					<%If intNumber <> "" Then%>
					<tr>
						<th>Hata Numarası</th>
						<td><%=intNumber & " (0x" & Hex(intNumber) & ")"%></td>
					</tr>
					<%End If%>
					<%If strSource <> "" Then%>
					<tr>
						<th>Hata Kaynağı</th>
						<td><span><%=strSource%></span></td>
					</tr>
					<%End If%>
					<%If strFile <> "" Then%>
					<tr>
						<th>Dosya adı</th>
						<td><%=strFile%></td>
					</tr>
					<%End If%>
					<%If intLine <> "" Then%>
					<tr>
						<th>Satır</th>
						<td><%=intLine%></td>
					</tr>
					<%End If%>
					<%If strDescription <> "" Then%>
					<tr>
						<th>Kısa Açıklama</th>
						<td><b><%=strDescription%></b></td>
					</tr>
					<%End If%>
					<%If strASPDescription <> "" Then%>
					<tr>
						<th>Tam Açıklaması</th>
						<td><%=strASPDescription%></td>
					</tr>
					<%End If%>
					<%If strTamUrl <> "" Then%>
					<tr>
						<th>Hatalı Url</th>
						<td><%=strTamUrl%></td>
					</tr>
					<%End If%>
					<tr>
						<th>OS / Tarayıcı</th>
						<td><%=OSType() & " / " & BrowserType()%></td>
					</tr>
					<%If Site_REMOTE_ADDR <> "" Then%>
					<tr>
						<th>IP Numarası</th>
						<td><%=Site_REMOTE_ADDR%></td>
					</tr>
					<%End If%>
				</table>
			</div>
			<%
			End If
			%>
		</div>
<%
If Not blnSuperAdmin Then

	OpenDatabase Conn
	'Response.Write Conn
	If (Conn.State = 1 Or Conn.Errors.Count = 0) Then
		Dim SQL
		SQL = ""
		SQL = SQL & "INSERT INTO #___asperror (errDate, errASPCode, errNumber, errSource, errFile, errLine, errDescription, errASPDescription, errPageUrl, errBrowser, errIpNo) "
		SQL = SQL & "VALUES ("
		SQL = SQL & "'"& DateSqlFormat(Now(), "yy-mm-dd", 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(strASPCode, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(intNumber, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(strSource, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(strFile, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(intLine, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(strDescription, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(strASPDescription, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(strTamUrl, 1) &"', "
		SQL = SQL & "'"& sqlGuvenlik(OSType() & " / " & BrowserType(), 1) &"', "
		SQL = SQL & "'"& Site_REMOTE_ADDR &"'"
		SQL = SQL & ");"

		SQL = setQuery( SQL )
		'Response.Write SQL
		Conn.Execute SQL
	End If

	CloseDatabase Conn
End If

%>
	</body>
</html>
