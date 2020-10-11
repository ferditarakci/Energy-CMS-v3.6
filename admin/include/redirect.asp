<%

'// ---------------------------------------------------------------------------------------------
'// Redirect 301 Moved

Dim insertWWW, stopWWW, RegexTestDomain
insertWWW = "www."
stopWWW = Array()

'Response.end


'// Değişkenlerimizi Tanımlayalım
Dim strURL, strSSL, strHost, strPathInfo, strQueryString, strPath, strFile, strDomainName, stopDomain, subDomainControl, strDomainControl

'// Server Değişkenleri Alalım
strSSL = UCase(Request.ServerVariables("HTTPS")) = "ON"
strHost = Request.ServerVariables("SERVER_NAME")

'strPathInfo = Request.ServerVariables("REQUEST_URI")
'If Not strPathInfo <> "" Then _
'	strPathInfo = Request.ServerVariables("HTTP_X_ORIGINAL_URL")
'If Not strPathInfo <> "" Then _
	strPathInfo = Replace(Request.ServerVariables("PATH_INFO"), hiddenFolder, "")

strQueryString = Replace(Replace(Request.ServerVariables("QUERY_STRING"), "&debug=true", ""), hiddenFolder, "")






'// Scriptin Çalıştırıldığı Klasörümüzü Bulalım
strPath = Left(strPathInfo, inStrRev(strPathInfo, "/"))

'// Scriptin Çalıştırıldığı Klasörümüzü Bulalım
strFile = Right(strPathInfo, Len(strPathInfo) - inStrRev(strPathInfo, "/"))


'// Domainden Sub Domaini Silelim
strDomainName = Replace(strHost, insertWWW, "")
If isArray(stopWWW) Then
	stopDomain = ""
	For i = 0 To UBound(stopWWW)
		stopDomain = stopDomain & "strHost = """ & stopWWW(i) & strDomainName & """ Or "
	Next

	RegexTestDomain = Replace(strHost, insertWWW, "")
	For i = 0 To UBound(stopWWW)
		stopDomain = Replace(stopDomain, "." & stopWWW(i), ".")
		RegexTestDomain = Replace(RegexTestDomain, stopWWW(i), "")
	Next
Else
	stopDomain = "strHost = """ & stopWWW & strDomainName & """ Or "
End If
'Response.Write stopDomain & "<br />"

stopDomain = Eval("(" & stopDomain & " strHost = ""localhostXXX"" Or strHost = ""127.0.0.1XXX"")")


subDomainControl = Left(strHost, Len(insertWWW)) <> insertWWW '// Örenk: www. kontrolü
'Response.Write subDomainControl & "<br />"

If isArray(arrDefaultDomain) Then arrDefaultDomain = Join(arrDefaultDomain, "|")
With New RegExp
	.IgnoreCase = True
	.Global = True
	.Pattern = "^(" & arrDefaultDomain & ")$" '|localhost|127.0.0.1
	'Response.Write .Test(RegexTestDomain)
	If Debug <> "" Then
		If Not (.Test(RegexTestDomain) And ipC(localIP)) Then ErrMsg "Hatalı Alan Adı <br />Sistem biglileri doğrulanmadı."
	Else
		If Not (.Test(RegexTestDomain) And ipC(localIP)) Then Response.Clear : Response.Write "" : Response.End
	End If
End With


'// Prokotolümüzü Yazalım
strURL = "http" : If strSSL Then strURL = strURL & "s" End If : strURL = strURL & "://"


 '// Örenk: www. yoksa ekle
If subDomainControl And Not stopDomain Then strURL = strURL & insertWWW


 '// Örenk: webdizayni.org Domainimizi Ekleyelim
strURL = strURL & strHost

If (Request.QueryString("option") = "search" And Request.QueryString("task") = "urun" And Request.QueryString("q") <> "") Or inStr(1, Request.QueryString, "Search.asp", 1) > 0 Then
	Response.Status = "301 Moved Permanently"
	Response.AddHeader "Location", strURL
	Response.End()
End If

'// #################
GlobalConfig("sDomain") = strURL
GlobalConfig("sBase") = strURL & GlobalConfig("sRoot")
GlobalConfig("vBase") =strURL & GlobalConfig("vRoot")



If Left(strQueryString, 4) = "404;" Then
	strURL = strURL & "/" & Split(Replace(Replace(strQueryString, "404;", ""), ":80/", "/"), "/", 4, 1)(3)
Else
	strURL = strURL & strPath
	'If Not (strFile = "index.asp" Or strFile = "default.asp") Then strURL = strURL & strFile
	If Not strQueryString = "" Then strURL = strURL & strFile & "?" & strQueryString
End If
'Response.Write strURL & "<br />"


If subDomainControl And Not stopDomain Then
	Response.Status = "301 Moved Permanently"
	Response.AddHeader "Location", strURL
	Response.End()

ElseIf inStr(strURL, "/v3.5") Or inStr(strURL, "/demo-gelir-takip-sistemi") Then
	Response.Status = "301 Moved Permanently"
	Response.AddHeader "Location", Replace(Replace(strURL, "/v3.5", "/v3.6"), "/demo-gelir-takip-sistemi", "/demo/gelir-takip-sistemi/v1.0")
	Response.End()
End If


'// End Redirect 301 Moved
'// ---------------------------------------------------------------------------------------------


GlobalConfig("site_uri") = Replace(strURL, "&", "&amp;")



'clearfix GlobalConfig("site_uri")


'Clearfix MD5("webdizayni.org") & "&" & strDomainControl






'// ################################################################################################################ //'












'	'On Error Resume next
'	'Call Redirect301("www.", Array("test.", "demo.", "wwe.", "cvc."), 1)
'
'	Private Function Redirect301(ByVal strSubDomain, ByVal stopWWW, ByVal islem)
'
'	'// Değişkenlerimizi Tanımlayalım
'	Dim strURL, strSSL, strHost, strPathInfo, strQueryString, strPath, strFile
'
'	'// Server Değişkenleri Alalım
'	strSSL = UCase(Request.ServerVariables("HTTPS")) = "ON"
'	strHost = Request.ServerVariables("HTTP_HOST")
'	strPathInfo = Request.ServerVariables("PATH_INFO")
'	strQueryString = Request.ServerVariables("QUERY_STRING")
'
'	'// Scriptin Çalıştırıldığı Klasörümüzü Bulalım
'	strPath = Left(strPathInfo, inStrRev(strPathInfo, "/"))
'
'	'// Scriptin Çalıştırıldığı Klasörümüzü Bulalım
'	strFile = Right(strPathInfo, Len(strPathInfo) - inStrRev(strPathInfo, "/"))
'
'	'// Prokotolümüzü Yazalım
'	strURL = "http" : If strSSL Then strURL = strURL & "s" End If : strURL = strURL & "://"
'	'Response.Write strURL & "<br />"
'
'	strDomainName = Replace(strHost, strSubDomain, "")
'	If isArray(stopWWW) Then
'		stopDomain = ""
'		For ix = 0 To UBound(stopWWW)
'			stopDomain = stopDomain & "strHost = """ & stopWWW(ix) & strDomainName & """ Or "
'		Next
'		For ix = 0 To UBound(stopWWW)
'			stopDomain = Replace(stopDomain, "." & stopWWW(ix), ".")
'		Next
'	Else
'		stopDomain = "strHost = """ & stopWWW & strDomainName & """ Or "
'	End If
'	'Response.Write stopDomain & "<br />"
'
'	stopDomain = Eval("(" & stopDomain & " strHost = ""localhost"" Or strHost = ""127.0.0.1"")")
'
'	subDomainControl = Left(strHost, Len(strSubDomain)) <> strSubDomain '// Örenk: www. kontrolü
'	'Response.Write subDomainControl & "<br />"
'
'	If subDomainControl And Not stopDomain Then strURL = strURL & strSubDomain '// Örenk: www. yoksa ekle
'
'	strURL = strURL & strHost
'
'	'GlobalConfig("sDomain") = GlobalConfig("site_uri")
'	'GlobalConfig("sBase") = GlobalConfig("site_uri") & GlobalConfig("sRoot")
'	'GlobalConfig("vBase") = GlobalConfig("site_uri") & GlobalConfig("vRoot")
'
'	'GlobalConfig("Tema_Dizin") = GlobalConfig("sBase") & "energy-tema/"
'
'	'If Session("tema_path_" & GlobalConfig("sRoot")) <> "" Then
'	'	GlobalConfig("General_Theme") = Session("tema_path_" & GlobalConfig("sRoot"))
'	'Else
'	'	'GlobalConfig("General_Theme") = "default"
'	'	GlobalConfig("General_Theme") = sqlQuery("SELECT path FROM #___tema WHERE (durum = -1 Or durum = 1);", "default")
'	'End If
'
'	'Dim HTTP_URL, HTTP_URI, SCSTR
'
'	If Left(strQueryString, 4) = "404;" Then
'
'		strURL = strURL & "/" & Split(Replace(Replace(strQueryString, "404;", ""), ":80/", "/"), "/", 4, 1)(3)
'
'		'HTTP_URI = "/" & Split(HTTP_URL, "/", 4, 1)(3)
'
'		'strURL = strURL & HTTP_URI
'
'	Else
'
'		strURL = strURL & strPath
'		If Not (strFile = "index.asp" Or strFile = "default.asp") Then strURL = strURL & strFile
'		If Not strQueryString = "" Then strURL = strURL & "?" & strQueryString
'
'	End If
'
'		'Response.Write strURL
'		'Response.End
'
'	If subDomainControl And Not stopDomain And islem = 1 Then
'		Response.Status = "301 Moved Permanently"
'		Response.AddHeader "Location", strURL
'		Call CloseDatabase(data)
'		Response.End()
'		'Response.write strURL
'
'	ElseIf inStr(1, strURL, "/v3.5/", 1) And islem = 1 Then
'		Response.Status = "301 Moved Permanently"
'		Response.AddHeader "Location", Replace(strURL, "/v3.5/", "/v3.6/")
'		Call CloseDatabase(data)
'		Response.End()
'		'Response.write Replace(strURL, "/v3.5/", "/v3.6/")
'	Else
'		strURL = Replace(strURL, "&", "&amp;")
'		Redirect301 = strURL
'	End If
'
'	'strURL = "<br />" & Split("http://webdizayni2.org/admin/test.asp?admin", "/", 4, 1)(3)
'
'
'	'Response.Write strURL
'	'Response.Write Replace(strURL, Left(strHost, inStr(strHost, ".")), "")
'	'Response.End()
'	End Function



'GlobalConfig("site_uri") = AjaxTurkish(Replace(GlobalConfig("site_uri"), "&", "&amp;"))

'Response.Write Request.ServerVariables("HTTP_COOKIE")

%>
