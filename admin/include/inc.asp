<%@Language = VBScript.Encode Codepage = 65001 LCID = 1055%>
<%
Option Explicit
'EnableSessionState = False

Dim iStartTime, iEndTime
iStartTime = Timer


With Session
	.Codepage = 65001
	.LCID = 1055
End With

With Response
	.Codepage = 65001
	.LCID = 1055
	.Charset = "utf-8"
	.ContentType = "text/html"
End With

Dim GlobalConfig
Set GlobalConfig = Server.CreateObject("Scripting.Dictionary")

Dim objRs, objRs2, objRs3
Dim SQL, SQL2, SQL3
Dim Count, intCurr
Dim item, i, a, y, x


%>
<!--#include file="sistem.asp"-->
<%

'Response.Write Request.ServerVariables("HTTP_USER_AGENT")
With Response
	.AddHeader "X-Author", Replace(xAuthor, "ı", "i")
	.AddHeader "X-Generator", Replace(xGenerator, "ı", "i")
	.AddHeader "X-Reply-To", Replace(xReply, "ı", "i")
	'If Not CBool(inStr(1, Request.ServerVariables("HTTP_USER_AGENT"), "Google", 1)) Then
		.AddHeader "X-Frame-Options", "SAMEORIGIN"
		.AddHeader "X-XSS-Protection", "1; mode=block"
	'End If
	If GlobalConfig("admin_folder_true") Then
		.AddHeader "pragma", "no-cache"
		.AddHeader "cache-control", "private"
	'	.CacheControl = "no-cache"
	'	.CacheControl = "no-store"
	'	.ExpiresAbsolute = Now() - 1
	'	.Expires = 0
	'Else
	'	.AddHeader "cache-control", "max-age=1440, public"
	'	.Expires = 1440
	End If
	.ExpiresAbsolute = Now() - 1
	.Expires = 0
End With



If Request.QueryString("new_theme") <> "" Then
	Session("tema_path_" & GlobalConfig("sRoot")) = Cstr(Request.QueryString("new_theme"))
	'Response.Redirect( GlobalConfig("sBase") )
	Response.Status = "301 Moved Permanently"
	Response.AddHeader "Location", GlobalConfig("sBase")
	Response.End()
End If
'Clearfix Session("tema_path_" & GlobalConfig("sRoot"))
%><!-- #include file = "database.asp" --><%






'// Veritabanına bağlanıyoruz
OpenDatabase data







Dim ActiveLanguages : ActiveLanguages = Array()
	OpenRs objRs, "SELECT lng FROM #___languages WHERE durum = 1 ORDER BY default_lng DESC, sira ASC;"
		Do While Not objRs.Eof
			intCurr = UBound(ActiveLanguages) + 1
			ReDim Preserve ActiveLanguages(intCurr)
			ActiveLanguages(intCurr) = objRs("lng")
		objRs.MoveNext() : Loop
	CloseRs objRs
'Clearfix Ubound(ActiveLanguages) > 0
If Ubound(ActiveLanguages) = -1 Then ActiveLanguages = ""

If isArray(ActiveLanguages) Then
	GlobalConfig("default_lang") = ActiveLanguages(0)
Else
	GlobalConfig("default_lang") = "TR"
End If

If isArray(ActiveLanguages) And GlobalConfig("site_lang") = "" Then
	GlobalConfig("site_lang") = ActiveLanguages(0)
	'ActiveLanguages = Join(ActiveLanguages, "|")
Else
	GlobalConfig("site_lang") = "TR"
End If
'Clearfix LCase(GlobalConfig("default_lang"))

GlobalConfig("site_lang") = UCase(GlobalConfig("site_lang"))
GlobalConfig("default_lang") = UCase(GlobalConfig("default_lang"))

Private Function sTotalLang()
	If isArray(ActiveLanguages) Then
		sTotalLang = UBound(ActiveLanguages) + 1
	Else
		sTotalLang = 1
	End If
End Function
'Clearfix sTotalLang()


'If Session("seolink") = "" Then Session("seolink") = True

If Request.QueryString("seo") = "false" Then
	Session("seolink") = "false"

ElseIf Request.QueryString("seo") = "true" Then
	Session("seolink") = "true"
'Else
	'Session.Contents.Remove("seolink")
End If




'// 404 hata sayfası ile seflink kullanım ayarları
%>
<!--#include file="404.asp"-->
<%







Dim strxLNG, strSiteStas
strSiteStas = "200 OK"
strxLNG = sqlQuery("SELECT lang FROM #___ayar_langs WHERE lang = '"& GlobalConfig("site_lang") &"';", "")

If strxLNG = "" Then strxLNG = GlobalConfig("default_lang") : strSiteStas = "Not Found"

SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.*," & vbCrLf
SQL = SQL & "	IFNULL(b.lang, '"& GlobalConfig("default_lang") &"') As lang," & vbCrLf
SQL = SQL & "	'"& strSiteStas &"' As NotFound," & vbCrLf
SQL = SQL & "	IFNULL(b.site_ismi, '') As site_ismi," & vbCrLf
SQL = SQL & "	IFNULL(b.slogan, '') As slogan," & vbCrLf
SQL = SQL & "	IFNULL(b.logo_alt_text, '') As logo_alt_text," & vbCrLf
SQL = SQL & "	IFNULL(b.copyright, '') As copyright," & vbCrLf
SQL = SQL & "	IFNULL(b.description, '') As description," & vbCrLf
SQL = SQL & "	IFNULL(b.keyword, '') As keyword" & vbCrLf
SQL = SQL & "FROM #___ayarlar As a" & vbCrLf
SQL = SQL & "LEFT OUTER JOIN #___ayar_langs As b ON b.lang = '"& strxLNG &"'" & vbCrLf
SQL = SQL & "LEFT OUTER JOIN #___languages As c ON c.lng = '"& strxLNG &"' And c.durum = 1" & vbCrLf
SQL = SQL & "WHERE c.lng = '"& strxLNG &"';"

'Set objRs = setExecute("Call Ayarlar('"& GlobalConfig("site_lang") &"', '"& GlobalConfig("default_lang") &"', '"& tablePrefix &"');")
OpenRs objRs, SQL
	If Not objRs.Eof Then

		'// Site Global Options
		'GlobalConfig("site_lang") = objRs("lang")
		'If objRs("NotFound") = "Not Found" Then GlobalConfig("request_option") = objRs("NotFound")

		'// Site Options
		GlobalConfig("site_ismi") = ""
		GlobalConfig("default_site_ismi") = objRs("site_ismi")
		GlobalConfig("slogan") = objRs("slogan")
		GlobalConfig("logo_alt_text") = objRs("logo_alt_text")
		GlobalConfig("logoName") = objRs("logo") & ""
		GlobalConfig("domain") = objRs("domain")
		GlobalConfig("copyright") = Replace(objRs("copyright"), " - [Year]", " - " & Year(Now()))
		' GlobalConfig("default_page") = objRs("default_page")

		GlobalConfig("seo_url") = CBool(objRs("seo_url"))
		
		'// Seo Options
		If Session("seolink") = "false" Then
			GlobalConfig("seo_url") = False
		ElseIf Session("seolink") = "true" Then
			GlobalConfig("seo_url") = True
		Else
			GlobalConfig("seo_url") = CBool(objRs("seo_url"))
		End If
		GlobalConfig("description") = objRs("description")
		GlobalConfig("keyword") = objRs("keyword")
		GlobalConfig("verify") = Duzenle(objRs("verify"))
		GlobalConfig("analytics") = Duzenle(objRs("analytics"))
		GlobalConfig("facebook_url") = objRs("facebook_url")
		GlobalConfig("twitter_url") = objRs("twitter_url")
		GlobalConfig("googleplus_url") = objRs("googleplus_url")

		'// Mail Options
		GlobalConfig("mail_type") = objRs("mail_type")
		GlobalConfig("mail_host") = objRs("mail_host")
		GlobalConfig("mail_from") = objRs("mail_from")
		GlobalConfig("mail_user_name") = objRs("mail_user_name")
		GlobalConfig("mail_pwrd") = objRs("mail_pwrd")
		GlobalConfig("mail_to") = objRs("mail_to")

		'// Site Status Options
		GlobalConfig("site_status") = CBool(objRs("site_status"))
		If GlobalConfig("admin_folder_true") Then
			Session("site_status" & SefUrl(GlobalConfig("sRoot"))) = GlobalConfig("site_status")

			'// Maksimun Kayıt
			GlobalConfig("MaxPage") = objRs("MaxPage")
			GlobalConfig("MaxCategory") = objRs("MaxCategory")
			GlobalConfig("MaxProduct") = objRs("MaxProduct")
			GlobalConfig("MaxBanner") = objRs("MaxBanner")
			GlobalConfig("MaxPoll") = objRs("MaxPoll")
		End If

		'// Global Picture Config Options
		'GlobalConfig("resim_logo_baski") = CBool(objRs("resim_logo_baski"))
		'GlobalConfig("resim_yazi_durum") = objRs("resim_yazi_durum")
		'GlobalConfig("resim_yazi") = Duzenle(objRs("resim_yazi"))

		GlobalConfig("urun_yonetimi") = CBool(objRs("urun_yonetimi"))

		GlobalConfig("uye_modul") = CBool(objRs("uye_modul"))
		GlobalConfig("doviz_modul") = CBool(objRs("doviz_modul"))

		'// Product Options
		GlobalConfig("vitrin_modul") = CBool(objRs("vitrin_modul"))
		GlobalConfig("vitrin_kategori") = CBool(objRs("vitrin_kategori"))
		GlobalConfig("vitrin_alt_kategori") = CBool(objRs("vitrin_alt_kategori"))
		GlobalConfig("sepet_modul") = CBool(objRs("sepet_modul"))
		GlobalConfig("sip_modul") = CBool(objRs("sip_modul"))

		'// Menü Option
		'GlobalConfig("disable_menu") = CBool(objRs("disable_menu"))
	End If
CloseRs objRs

'Clearfix GlobalConfig("mail_type")












%>
<!--#include file="URLWrite.asp"-->
<!--#include file="Function.asp"-->
<%



'Clearfix GlobalConfig("request_option")

'// Anasayfa da Url Yönlendirme işlemi
'// http://www.webdizayni2.org/index.asp?energy_lang=en >>>>>>>> http://www.webdizayni2.org/en/
If _
	GlobalConfig("request_option") = GlobalConfig("General_Home") _
	And Not GlobalConfig("General_introPage") _
	And Not GlobalConfig("admin_folder_true") _
	Then Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), "", "", "", "", "", ""))












If Not GlobalConfig("admin_folder_true") Then
	EnergySiteDurum GlobalConfig("site_status"), GlobalConfig("admin_username")
End If

If GlobalConfig("site_status") And Session("superAdminXXX") <> "" Then Session.Contents.Remove("superAdminXXX")

'// Site durumu pasif ise uyarı veriyoruz
Sub EnergySiteDurum(ByVal sS, ByVal uN)
	If sS Then Exit Sub
	If uN = GlobalConfig("super_admin") Then
		If Session("superAdminXXX") = "" Then _
			Session("superAdminXXX") = "<h1 style=""padding:5px; text-align:center; color:red; background-color:#fff;"">Oturum : "& uN &", Kapalı Site</h1>"
		Exit Sub
	End If

	If Not sS Then
		ErrMsg "Web sitemiz en kısa zamanda tekrar yayına başlayacaktır, <br /><br />Bu durumdan dolayı özür dileriz."
	End If
End Sub

















'// Url yapısında ki farklılıkları düzenleme ve yönlendirme
Sub RedirectToUrl(ByVal getUrl)
	Dim bln404, SiteQueryString
	SiteQueryString = Request.ServerVariables("QUERY_STRiNG")
	If (SiteQueryString = "" Or GlobalConfig("request_option") = "" Or inStr(1, SiteQueryString, "debug=true", 1) > 0) Then Exit Sub
	'If request("ReWrite") = "true" Then Exit Sub

	getUrl = Replace(getUrl, "&amp;", "&")
	'getUrl = Replace(Replace(Replace(getUrl, "&amp;", "&"), "++", "+"), "++", "+")
	'getUrl = AjaxTurkish2( getUrl )

	'bln404 = CBool(inStr(1, SiteQueryString, "404;", 1))
	'ewy_qs = UrlClear(SiteQueryString)
	'ewy_qs = UrlDecode(ewy_qs)
	'ewy_qs = LCase(ewy_qs)
	'Clearfix LCase(UrlDecode(UrlClear(getUrl))) & " " & LCase(UrlDecode(UrlClear(SiteQueryString)))
	If (Not LCase(UrlDecode(UrlClear(getUrl))) = LCase(UrlDecode(UrlClear(SiteQueryString)))) Or LCase(UrlDecode(UrlClear(getUrl))) = "javascript:;" Then
		Response.Clear()
		'Clearfix LCase(UrlDecode(UrlClear(getUrl))) & " = " & LCase(UrlDecode(UrlClear(SiteQueryString)))
		If LCase(UrlDecode(UrlClear(getUrl))) = "javascript:;" Then getUrl = GlobalConfig("sBase")
		'Clearfix getUrl
		CloseDatabase data
		Response.Status = "301 Moved Permanently"
		Response.AddHeader "Location", getUrl
		Response.End()
	End If
End Sub
'Call RedirectToUrl("http://www.webdizayni2.org/index.asp?energy_option=arama&energy_query=web+tasar%C4%B1m")









If Not GlobalConfig("admin_folder_true") Then

	GlobalConfig("locale_lang")	= sqlQuery("SELECT locale_lang FROM #___languages WHERE lng = '"& GlobalConfig("site_lang") &"';", GlobalConfig("site_lang"))

%>
	<!--#include file="ContentCheck.asp"-->
<%

End If







If Session("tema_path_" & GlobalConfig("sRoot")) <> "" Then
	GlobalConfig("General_Theme") = Session("tema_path_" & GlobalConfig("sRoot"))
	GlobalConfig("General_ThemeStyle") = Session("tema_style_" & GlobalConfig("sRoot"))

Else

	Set objRs = setExecute("SELECT IFNULL(path, '') As path, IFNULL(styles, '') As styles FROM #___tema WHERE durum = 1;")
		If Not objRs.Eof Then
			GlobalConfig("General_Theme") = objRs("path") & ""
			GlobalConfig("General_ThemeStyle") = objRs("styles") & ""
		End If	
	Set objRs = Nothing

End If

GlobalConfig("Tema_Dizin") = GlobalConfig("sBase") & "themes/"
GlobalConfig("General_ThemePath") = GlobalConfig("Tema_Dizin") & GlobalConfig("General_Theme") & "/"







%>
<!--#include file="MailSender.asp"-->
