<%@Language = VBScript.Encode Codepage = 65001 LCID = 1055%>
<%
Option Explicit

With Session
	.CodePage = 65001
	.LCID = 1055
End With

With Response
	.Clear()
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
	.ContentType = "text/css"
End With

'On Error Resume Next


%>@charset "utf-8";

/*
	Copyright © 2008 - <%=Year(Now())%>
	Energy Web Yazılım / Ferdi Tarakcı / İstanbul
	www.webtasarimx.net
	bilgi@webtasarimx.net
*/

<%

Dim strPath, loadName, item, t, i, a

strPath = Request.QueryString("load")

'Response.Write vbCrLf & vbCrLf & vbCrLf & vbCrLf
loadName = Split(strPath, ",")
For Each item in loadName
	OpenFile "files/" & Trim(item) & ".css"
Next



Private Sub OpenFile(ByVal varFile)
	varFile = varFile & ""
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
