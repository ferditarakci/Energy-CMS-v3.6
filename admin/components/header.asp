<%
Response.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"


VarCss = "reset"

If Not mods = GlobalConfig("General_Login") Then
	VarCss = VarCss & ",jquery-ui-1.9.2,fonts"
End If

VarCss = VarCss & ",style"

VarJs = "jquery-1.7.2.min,jquery-ui-1.9.2.min,css-browser-selector" ',jquery-browser


Select Case mods
	Case GlobalConfig("General_Login")
		varCss2 = "login"
		VarJs2 = "validate"

	Case GlobalConfig("General_Page"), GlobalConfig("General_Page") & "_settings"
		varCss2 = "tag-editor,file-list"
		VarJs2 = "friendurl,tag-editor,ajaxupload" ',tinyscrollbar

	Case GlobalConfig("General_Categories"), GlobalConfig("General_Categories") & "_settings"
		varCss2 = "tag-editor,file-list"
		VarJs2 = "friendurl,tag-editor,ajaxupload" ',tinyscrollbar

	Case GlobalConfig("General_Products"), GlobalConfig("General_Products") & "_settings"
		varCss2 = "tag-editor,file-list"
		VarJs2 = "friendurl,tag-editor,ajaxupload,price-format" ',tinyscrollbar

	Case GlobalConfig("General_Whois")
		varCss2 = ""
		VarJs2 = ""

	Case GlobalConfig("General_Poll")
		varCss2 = "friendurl"
		VarJs2 = "friendurl"

	Case GlobalConfig("General_Orders")
		varCss2 = ""
		VarJs2 = ""

	Case GlobalConfig("General_Banner"), GlobalConfig("General_Banner") & "_settings"
		varCss2 = ""
		VarJs2 = "ajaxupload"

	Case GlobalConfig("General_Mailist")
		varCss2 = ""
		VarJs2 = ""

	Case GlobalConfig("General_Users")
		varCss2 = ""
		VarJs2 = ""

	Case "menu"
		varCss2 = "menu-list"
		VarJs2 = "nested-sortable_v2.0" '"nested-sortable"

	Case "ayar"
		varCss2 = ""
		VarJs2 = "ajaxupload"

	Case Else
End Select

If Not mods = GlobalConfig("General_Login") Then
	VarJs = VarJs & ",superfish,fancybox,selectbox,dataTables,jeditable," & VarJs2
	varCss = varCss & ",superfish,fancybox,selectbox,dataTables,dataTables_ui," & varCss2
End If

If mods = GlobalConfig("General_Login") Then VarJs = VarJs & "," & VarJs2 : varCss = varCss & "," & varCss2


VarJs = VarJs & ",EnergyGlobal"
If Left(VarJs, 1) = "," Then VarJs = Right(VarJs, Len(VarJs) -1)
If Right(VarJs, 1) = "," Then VarJs = Left(VarJs, Len(VarJs) -1)

If Left(varCss, 1) = "," Then varCss = Right(varCss, Len(varCss) -1)
If Right(varCss, 1) = "," Then varCss = Left(varCss, Len(varCss) -1)



'jQueryLibrary = "loadStyle.asp?load=style,tagEditor&amp;v=1" & Debug
'jQueryUiLibrary = "jquery-ui-1.8.21.custom.min.js"
varCss = "loadStyle.css?load="& varCss &"&amp;v=1" & Debug
VarJs = "loadScript.js?load="& VarJs &"&amp;v=1" & Debug
'EnergyJs = "EnergyGlobal-min.js?v=5"


Select Case mods
	Case GlobalConfig("General_Login") AdminTitle = ""
	Case GlobalConfig("General_Page") AdminTitle = "Sayfa Yönetimi"
	Case GlobalConfig("General_Categories") AdminTitle = "Kategori Yönetimi"
	Case GlobalConfig("General_Products") AdminTitle = "Ürün Yönetimi"
	Case GlobalConfig("General_Whois")  AdminTitle = "Whois Yönetimi"
	Case GlobalConfig("General_Poll") AdminTitle = "Anket Yönetimi"
	Case GlobalConfig("General_Orders") AdminTitle = "Sipariş Yönetimi"
	Case GlobalConfig("General_Banner") AdminTitle = "Banner Yönetimi"
	Case GlobalConfig("General_Mailist") AdminTitle = "Mailist Yönetimi"
	Case GlobalConfig("General_Users") AdminTitle = "Kullanıcı Yönetimi"
	Case "menu" AdminTitle = "Menü Yönetimi"
	'Case "iletisim" AdminTitle = "İletişim Bilgileri"
	Case "istatistik" AdminTitle = "İstatistikler"
	Case "ayar" AdminTitle = "Genel Ayarlar"
	Case Else AdminTitle = ""
End Select
If AdminTitle <> "" Then AdminTitle = AdminTitle & " - "
'Response.Addheader "X-UA-Compatible", "IE=EmulateIE7"

%><!DOCTYPE html>
<!-- www.webtasarimx.net -->
<html id="energy-web-yazilim">
<head>
<meta charset="utf-8" />
<meta name="author" content="<%=xAuthor%>" />
<meta name="generator" content="<%=xGenerator%>" />
<meta name="reply-to" content="<%=xReply%>" />
<meta name="copyright" content="&copy; 2008 - <%=Year(Date()) & " / " & xGenerator%>" />
<title><%=AdminTitle & xGenerator%> - &copy; 2008 - <%=Year(Date())%></title>
<link href="<%=GlobalConfig("vBase")%>favicon.ico" rel="shortcut icon" type="image/x-icon" title="<%=xGenerator%>" />
<link href="<%=GlobalConfig("vBase")%>css/<%=varCss%>" rel="stylesheet" type="text/css" media="screen" /><%
'If Not mods = "login" Then

Call JsLoad()

'End If
%>
<script src="<%=GlobalConfig("vBase")%>javascript/<%=VarJs%>" type="text/javascript" charset="utf-8"></script>

<%
If mods = "login" Then
%>
<!--[if lt IE 8]>
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function() {
	$("#login .inputbox").focusin(function() {
		$(this).addClass("focus")
	}).focusout(function() {
		$(this).removeClass("focus")
	});
});
/*]]>*/
</script>
<![endif]-->
<!--[if lte IE 9]>
<style type="text/css">
	#login .login-form {width:330px;}
	#login .inputbox {width:97%;}
	#login .login-btn {width:70px; height:36px; line-height:23px; padding:0; border:none; text-indent:-9999px; background:transparent url(<%=GlobalConfig("vRoot")%>images/login-button.png) no-repeat;}
	#login .login-btn:hover {background-position:left bottom;}
	#login .login-btn.back {width:65px; height:31px; border:none; text-indent:-9999px; background:transparent url(<%=GlobalConfig("vRoot")%>images/recover-button.png) no-repeat;}
	#login .login-btn.back:hover {background-position:left -32px;}
	#login .login-btn.recover {width:104px; height:31px; border:none; text-indent:-9999px; background:transparent url(<%=GlobalConfig("vRoot")%>images/recover-button.png) no-repeat -68px 0;}
	#login .login-btn.recover:hover {background-position:-68px -32px;}
	#login.recover .login-form {width:350px;}
	#login #imgCaptcha {margin-left:5px;}
</style>
<![endif]--><%
End If
%>

