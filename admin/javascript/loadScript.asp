<%@Language = VBScript.Encode Codepage = 65001 LCID = 1055%>
<%
'Option Explicit

With Session
	.CodePage = 65001
	.LCID = 1055
End With

With Response
	If Request.QueryString("debug") = "true" Then
		.CacheControl = "no-cache"
		.CacheControl = "no-store"
		.AddHeader "pragma", "no-cache"
		.Expires = -1
	Else
		.AddHeader "cache-control", "max-age=86400, public"
		.Expires = 1440
	End If
	.CodePage = 65001
	.LCID = 1055
	.CharSet = "utf-8"
	.ContentType = "application/x-javascript"
End With

%>
<!--#include file="../include/Thumbs.db"-->
<%

'On Error Resume Next

%>
/*
	Copyright © 2008 - <%=Year(Now())%>
	Energy Web Yazılım / Ferdi Tarakcı / İstanbul
	www.webtasarimx.net
	bilgi@webtasarimx.net
*/

<%
Dim loadName, item, t, i, a, strPath, strUrl, strHost
strHost = Replace(Request.ServerVariables("HTTP_HOST"), "www.", "")


strUrl = ""

For Each item in arrDefaultDomain
	If strHost = item Then strUrl = item : Exit For

	'strUrl = strUrl & "_" & Join(strDomainControl, ",")
	'strDomainControl = Array()
	'Clearfix strDomainControl
Next

strDomainControl = Array()
For i = 1 To Len(strUrl)
	intCurr = UBound(strDomainControl) + 1
	Redim Preserve strDomainControl(intCurr)
	strDomainControl(intCurr) = AscW(Mid(strUrl, i, 1))
Next


strUrl = "var ewyD = String.fromCharCode(" & Join(strDomainControl, ",") & ");"
'strUrl = "" & Join(strDomainControl, ",") & ""

strDomainControl = Array()
For i = 1 To Len(strUrl)
	intCurr = UBound(strDomainControl) + 1
	Redim Preserve strDomainControl(intCurr)
	strDomainControl(intCurr) = AscW(Mid(strUrl, i, 1))
Next

varJsAlert = "String.fromCharCode(" & Join(strDomainControl, ",") & ")"
'Response.Write "var ewyD = eval(" & Join(strDomainControl, ",") & ");"
'strDomainControl = "e=" & Right(strUrl, Len(strUrl)-1) & "&amp;"
'strDomainControl = "e=" & Right(strUrl, Len(strUrl)-1) & "&amp;"
strURL = ""





strPath = Request.QueryString("load")

loadName = Split(strPath, ",")

i = 0
For Each item in loadName
	'Response.write i & vbCrLf & vbCrLf & vbCrLf & vbCrLf & vbCrLf
	If (i = 1) Then Response.Write("eval(" & varJsAlert & ");")
	OpenFile "js/" & Trim(item) & ".js"
	i = i + 1
Next



Private Sub OpenFile(ByVal varFile)
	varFile = varFile & ""
	Dim i, a, t
	If varFile = "" Then Exit Sub

	If Not FilesKontrol(varFile) Then Exit Sub
	varFile = Server.MapPath(Cstr(varFile))

	With Server.CreateObject("ADODB.Stream")
		.Type = 1 '// Binary 
		'// .Type = 2 '// Text 
		'// .CharSet = "utf-8"
		.Open
		.LoadFromFile varFile
		'.SkipLine
		'.Position = 0
		t = .Read(3)
		a = ""
		For i = 1 To LenB( t )
			a = a & AscB(MidB(t, i, 1))
		Next
		'Response.Write a
		If Not a = "239187191" Then .Position = 0 'Else .Position = 3
		Response.BinaryWrite .Read
		'// Response.Write .ReadText
		'// Response.Write ";"
		.Close
	End With
End Sub




Private Function FilesKontrol(ByVal varPath)
	varPath = varPath & ""
	If varPath = "" Then Exit Function
	varPath = Server.MapPath(varPath)
	FilesKontrol = Server.CreateObject("Scripting.FileSystemObject").FileExists(varPath)
End Function
%>
