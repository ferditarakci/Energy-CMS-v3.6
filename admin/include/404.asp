<%
'// Option Replace
Function UrlClear(ByVal url)
	url = url & ""
	If url = "" Then Exit Function
	'url = Replace(url, ".html", "", 1, -1, 1)
	'url = Replace(url, ".htm", "", 1, -1, 1)
	'If Right(url, Len(LinkSonlandirici)) = LinkSonlandirici Then url = Left(url, Len(url) - Len(LinkSonlandirici))
	url = Replace(url, GlobalConfig("hidden_folder"), "")
	url = Replace(url, "404;", "")
	url = Replace(url, "http://", "", 1, -1, 1)
	url = Replace(url, "https://", "", 1, -1, 1)
	url = Replace(url, ":80", "")
	url = Replace(url, ":443", "")
	url = Replace(url, "///", "/")
	url = Replace(url, "//", "/")
	url = Replace(url, "?debug=true", "")
	url = Replace(url, "&debug=true", "")
	url = Replace(url, "/index.asp?", "", 1, -1, 1)
	url = Replace(url, "index.asp", "", 1, -1, 1)
	url = Replace(url, "/?", "")
	url = Replace(url, "&amp;", "&")
	url = Replace(url, Site_HTTP_HOST, "")
	url = Replace(url, GlobalConfig("sRoot"), "/", 1, -1, 1)
	url = Replace(url, "/Rejected-By-UrlScan?~", "", 1, -1, 1)
	'If Left(url, 1) = "/" Then url = Right(url, Len(url) -1)
	'If Right(url, 1) = "/" Then url = Left(url, Len(url) -1) '& "-"
	'UrlClear = AjaxTurkish( url )
	'url = UrlEncode(url)
	UrlClear = AjaxTurkish(url)
End Function

'clearfix Request.ServerVariables("QUERY_STRiNG")

Dim inStr404
inStr404 = Left(Request.ServerVariables("QUERY_STRiNG"), 4) = "404;" 'CBool(inStr(Request.ServerVariables("QUERY_STRiNG"), "404;"))

'// 404 Error Page Permalink Parçalama
If inStr404 Then

	Dim UrlParcala
	UrlParcala = UrlClear(Request.ServerVariables("QUERY_STRiNG"))
	UrlParcala = Replace(UrlParcala, ".html", "", 1, -1, 1)
	UrlParcala = Replace(UrlParcala, ".htm", "", 1, -1, 1)
	'UrlParcala = Replace(UrlParcala, ".xml", "", 1, -1, 1)
	If Right(UrlParcala, Len(LinkSonlandirici)) = LinkSonlandirici Then UrlParcala = Left(UrlParcala, Len(UrlParcala) - Len(LinkSonlandirici))

	'Clearfix UrlParcala
	If Right(UrlParcala, 1) = "/" Then UrlParcala = Left(UrlParcala, Len(UrlParcala) - 1)
	'Clearfix UrlParcala

	Dim SplitUrl
	SplitUrl = Split(UrlParcala, "/") 'clearfix join(SplitUrl, ", ")
	intCurr = UBound(SplitUrl)

	'// indis sıfırdan büyükse gerekli işlemleri yapalım
	If intCurr > 0 Then

		Dim blnActiveLang, errActiveLang
		If isArray(ActiveLanguages) Then errActiveLang = Join(ActiveLanguages, "|")
		With New RegExp
			.IgnoreCase = True
			.Global = True
			.Pattern = "^(" & errActiveLang & ")$"
			blnActiveLang = .Test(SplitUrl(1))
		End With

		Dim arrNumber : arrNumber = 1
		If blnActiveLang Then arrNumber = 2 : GlobalConfig("site_lang") = UCase(SplitUrl(1)) '// Site dili seçimi
		If blnActiveLang And UBound(SplitUrl) <= 1 Then arrNumber = 1

		'Clearfix blnActiveLang

		Dim blnOption
		If isArray(GlobalConfig("Search_404_Option")) Then GlobalConfig("Search_404_Option") = Join(GlobalConfig("Search_404_Option"), "|")
		With New RegExp
			.IgnoreCase = True
			.Global = True
			.Pattern = "^(" & Replace(GlobalConfig("Search_404_Option"), GlobalConfig("General_Sitemap"), GlobalConfig("General_Sitemap") & "\.xml") & ")$"
			blnOption = .Test(SplitUrl(arrNumber)) : GlobalConfig.Remove("Search_404_Option")
		End With
		'Clearfix SplitUrl(arrNumber)

		'// General Page
		If blnOption Then
			GlobalConfig("request_option") = SplitUrl(arrNumber)

		ElseIf Not blnOption Then
			GlobalConfig("request_option") = GlobalConfig("General_Page")

		End If
'And ActiveLanguages(0) = UCase(SplitUrl(1)))
'Clearfix GlobalConfig("request_option")
		If (GlobalConfig("request_option") = "" Or SplitUrl(arrNumber) = GlobalConfig("General_Home")) And Not GlobalConfig("General_introPage") Then
			GlobalConfig("request_option") = GlobalConfig("General_Home")

			If GlobalConfig("request_title") = GlobalConfig("General_Design") Then GlobalConfig("request_option") = GlobalConfig("General_Page")
			If SplitUrl(intCurr-1) = GlobalConfig("General_Design") And GlobalConfig("request_title") <> GlobalConfig("General_Design") Then GlobalConfig("request_option") = GlobalConfig("General_Design")

		End If
		'Clearfix GlobalConfig("request_option")


		'GlobalConfig("request_title") = AjaxTurkish(URLDecode(ClearHtml(SplitUrl(intCurr))))
		If Not GlobalConfig("request_option") = GlobalConfig("General_Home") Then
			GlobalConfig("request_title") = SplitUrl(intCurr)
		End If

		If UCase(GlobalConfig("request_title")) = GlobalConfig("site_lang") And GlobalConfig("General_introPage") Then
			GlobalConfig("request_title") = ""
			GlobalConfig("request_option") = GlobalConfig("General_Default")

		ElseIf UCase(GlobalConfig("request_title")) = GlobalConfig("site_lang") And Not GlobalConfig("General_introPage") Then
			GlobalConfig("request_title") = ""
			GlobalConfig("request_option") = GlobalConfig("General_Home")

		ElseIf GlobalConfig("request_title") <> "" Then
			'// Page Number
			Dim intPageNo
			intPageNo = Split(GlobalConfig("request_title"), "_")
			If UBound(intPageNo) > 0 Then
				GlobalConfig("request_title") = intPageNo(0)

				If isNumeric(intPageNo(1)) Then
					GlobalConfig("request_start") = intPageNo(1)

				ElseIf intPageNo(1) = "ewy-all-page" Then
					GlobalConfig("request_showall") = "true"

				End If
			End If
		End If



		Select Case GlobalConfig("request_option")

		'// Search Config
		Case GlobalConfig("General_Search"), GlobalConfig("General_Search2")

			GlobalConfig("request_title") = ""

			If Not intCurr > arrNumber Then GlobalConfig("request_option") = "Not Found"
			If intCurr >= arrNumber + 1 Then GlobalConfig("request_q") = SplitUrl(intCurr)

			intPageNo = Split(GlobalConfig("request_q"), "_")

			If UBound(intPageNo) > 0 Then
				GlobalConfig("request_q") = intPageNo(0)

				If isNumeric(intPageNo(1)) Then
					GlobalConfig("request_start") = intPageNo(1)

				ElseIf intPageNo(1) = "ewy-all-page" Then
					GlobalConfig("request_showall") = "true"

				End If
			End If




		'// Redirect Or Post Config
		Case GlobalConfig("General_Xml")

			GlobalConfig("request_title") = ""
			'Clearfix SafUrl
			If Not intCurr > arrNumber Then GlobalConfig("request_option") = "Not Found"
			If intCurr >= arrNumber + 1 Then GlobalConfig("request_task") = SplitUrl(intCurr)

			If intCurr >= arrNumber + 1 And isNumeric(GlobalConfig("request_task")) Then
				GlobalConfig("request_task") = SplitUrl(intCurr - 1)
				GlobalConfig("request_globalid") = SplitUrl(intCurr)
			End If



		'// Redirect Or Post Config
		Case GlobalConfig("General_Redirect"), GlobalConfig("General_Post")

			GlobalConfig("request_title") = ""
			'Clearfix SafUrl
			If Not intCurr > arrNumber Then GlobalConfig("request_option") = "Not Found"
			If intCurr >= arrNumber + 1 Then GlobalConfig("request_task") = SplitUrl(intCurr)

			If intCurr >= arrNumber + 1 And isNumeric(GlobalConfig("request_task")) Then
				GlobalConfig("request_task") = SplitUrl(intCurr - 1)
				GlobalConfig("request_globalid") = SplitUrl(intCurr)
			End If




		'// Sitemap Config
		Case GlobalConfig("General_Sitemap") & ".xml"

			GlobalConfig("request_domain") = ""
			GlobalConfig("request_title") = ""
			'If intCurr = arrNumber Then GlobalConfig("request_option") = "Not Found"
			'If intCurr >= arrNumber + 1 Then GlobalConfig("request_domain") = SplitUrl(intCurr)
			
			GlobalConfig("request_option") = Replace(GlobalConfig("General_Sitemap"), ".xml", "")
			
			'Clearfix GlobalConfig("request_domain")
			'If GlobalConfig("request_domain") = "4f4b5f623c1d3a27" Or GlobalConfig("request_domain") = Md5(Site_HTTP_HOST) Then
				'GlobalConfig("request_option") = GlobalConfig("General_Sitemap")
				'GlobalConfig("request_domain") = "sitemap.xml"
			'ElseIf Not GlobalConfig("request_domain") = "sitemap.xml" Then
			'	GlobalConfig("request_option") = "Not Found"
			'	GlobalConfig("request_domain") = ""
			'End If





		'// Whois Config
		Case GlobalConfig("General_Whois"), GlobalConfig("General_Whois2")

			GlobalConfig("request_title") = ""
			If intCurr = arrNumber Then GlobalConfig("request_option") = "Not Found"
			If intCurr >= arrNumber + 1 Then GlobalConfig("request_domain") = SplitUrl(intCurr)
			'GlobalConfig("request_domain") = Replace(GlobalConfig("request_domain"), "_", ".")
			'Clearfix isValidDomain(GlobalConfig("request_domain"))
		End Select

	End If
End If '// End Seo Link Split()




'If GlobalConfig("request_title") = "sitemap.xml" Then
'	GlobalConfig("request_option") = GlobalConfig("General_Sitemap")
'	GlobalConfig("request_title") = ""
'	GlobalConfig("request_domain") = ""
'End If




'// Admin Klasöründe işlem yapmıyoruz
If Not GlobalConfig("admin_folder_true") Then

	If GlobalConfig("request_option") = "home" Then GlobalConfig("request_option") = GlobalConfig("General_Home")

	'// Global Variant
	GlobalConfig("site_lang") = UCase(SefUrl(GlobalConfig("site_lang")))

	'// Global Home Page Option
	If Not inStr404 And Not (GlobalConfig("request_title") <> "" Or GlobalConfig("request_option") <> "") Then

		If GlobalConfig("General_introPage") Then
			GlobalConfig("request_option") = GlobalConfig("General_Default")
		ElseIf Not GlobalConfig("General_introPage") Then
			GlobalConfig("request_option") = GlobalConfig("General_Home")
		End If

	'// Global Page Option
	ElseIf Not inStr404 And GlobalConfig("request_title") <> "" And GlobalConfig("request_option") = "" Then

		GlobalConfig("request_option") = GlobalConfig("General_Page")

	End If

	If Not GlobalConfig("request_option") = "Not Found" Then GlobalConfig("request_option") = SefUrl(GlobalConfig("request_option"))

	GlobalConfig("request_task") = SefUrl(GlobalConfig("request_task"))
	GlobalConfig("request_title") = SefUrl(GlobalConfig("request_title"))

	GlobalConfig("request_sayfaid") = intYap(GlobalConfig("request_sayfaid"), 0)
	GlobalConfig("request_globalid") = intYap(GlobalConfig("request_globalid"), 0)

	If intYap(GlobalConfig("request_start"), 0) < 1 Or GlobalConfig("request_showall") = "true" Then GlobalConfig("request_start") = 1
	GlobalConfig("request_start") = intYap(GlobalConfig("request_start"), 1)

	GlobalConfig("request_showall") = Cstr(SefUrl(GlobalConfig("request_showall")))

	GlobalConfig("request_q") = TrimFix(AjaxTurkish(URLDecode(ClearHtml(GlobalConfig("request_q")))))
	GlobalConfig("request_q") = Replace(GlobalConfig("request_q"), "+", " ")

	GlobalConfig("request_limit") = intYap(GlobalConfig("request_limit"), 0)
	GlobalConfig("request_limitstart") = intYap(GlobalConfig("request_limitstart"), 0)
	GlobalConfig("request_domain") = Temizle(GlobalConfig("request_domain"), 1)

	If GlobalConfig("request_option") = GlobalConfig("General_Search2") Then GlobalConfig("request_option") = GlobalConfig("General_Search")

End If

'Clearfix GlobalConfig("request_option") & "  " & GlobalConfig("request_domain")
'ApplicationClear()
'Clearfix _
'	"AktifDiller() : " & errActiveLang & "<br />" & _
'	"blnOption : " & blnOption & "<br />" & _
'	"site_lang : " & GlobalConfig("site_lang") & "<br />" & _
'	"request_option : " & GlobalConfig("request_option") & "<br />" & _
'	"request_task : " & GlobalConfig("request_task") & "<br />" & _
'	"request_title : " & GlobalConfig("request_title") & "<br />" & _
'	"request_start : " & GlobalConfig("request_start") & "<br />" & _
'	"request_showall : " & GlobalConfig("request_showall") & "<br />" & _
'	"request_domain : " & GlobalConfig("request_domain") & "<br />" & _
'	"request_globalid : " & GlobalConfig("request_globalid") & "<br />" & _
'	"request_sayfaid : " & GlobalConfig("request_sayfaid") & "<br />" & _
'	"request_q : " & GlobalConfig("request_q") & "<br />"


If GlobalConfig("request_option") = GlobalConfig("General_Redirect") Or _
   GlobalConfig("request_option") = GlobalConfig("General_Post") Or _
   GlobalConfig("request_option") = GlobalConfig("General_Sitemap") Or _
   GlobalConfig("request_option") = GlobalConfig("General_Xml") Or _
   GlobalConfig("request_option") = GlobalConfig("General_Rss") Then 
	With Response
		.AddHeader "pragma", "no-cache"
		.AddHeader "cache-control", "private"
		.CacheControl = "no-cache"
		.CacheControl = "no-store"
		.ExpiresAbsolute = Now() - 1
		.Expires = 0
	End With
End If
%>
