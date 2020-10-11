<!--#include file="include/inc.asp"-->
<!--#include file="admin_include/degiskenler.asp"-->
<!--#include file="admin_include/adminFonksiyon.asp"-->
<!--#include file="components/general.asp"-->
<%

Dim RequestModFalse
RequestModFalse = _
( _
	mods = "post" Or _
	mods = "list_post" Or _
	mods = "json" Or _
	mods = "img" Or _
	mods = "maps" Or _
	mods = "sistem_info" Or _
	mods = "fileUpdate" Or _
	mods = "load" Or _
	mods = "menu_settings" Or _
	mods = "menu_settings_save" Or _
	mods = GlobalConfig("General_Page") & "_settings" Or _
	mods = GlobalConfig("General_Banner") & "_settings" Or _
	mods = GlobalConfig("General_Categories") & "_settings" Or _
	mods = GlobalConfig("General_Products") & "_settings" Or _
	mods = GlobalConfig("General_Users") & "_settings" Or _
	mods = "popup_" & GlobalConfig("General_Page") Or _
	mods = "popup_" & GlobalConfig("General_Page") & "_list" Or _
	mods = GlobalConfig("General_Redirect") Or _
	mods = "preview" Or _
	mods = "list_json" Or _
	mods = "template" Or _
	mods = "modul" Or _
	mods = "file_manager" Or _
	mods = "pagebreak" Or _
	mods = "url_list" Or _
	mods = "upload" _
)

If Not RequestModFalse Then Call Ust_Bolge()

Select Case mods

Case GlobalConfig("General_Login")
%>
<!--#include file="components/login.asp"-->

<%
Case GlobalConfig("General_Home")
%>
<!--#include file="components/index.asp"-->

<%
Case GlobalConfig("General_Whois")
%>
<!--#include file="components/whois.asp"-->

<%
Case GlobalConfig("General_Page")
%>
<!--#include file="components/page_datalist.asp"-->
<%
Case GlobalConfig("General_Page") & "2"
%>
<!--#include file="components/page2.asp"-->

<%
Case GlobalConfig("General_Categories")
	If Not GlobalConfig("urun_yonetimi") Then
		Response.Redirect("index.asp?mod=" & GlobalConfig("General_Page") & Debug2) : Response.End()
	End If
%>
<!--#include file="components/category.asp"-->

<%
Case GlobalConfig("General_Products")
	If Not GlobalConfig("urun_yonetimi") Then
		Response.Redirect("index.asp?mod=" & GlobalConfig("General_Page") & Debug2) : Response.End()
	End If
%>
<!--#include file="components/products.asp"-->


<%
Case GlobalConfig("General_Tags")
%>
<!--#include file="components/etiket.asp"-->

<%
Case "yorum"
%>
<!--#include file="components/comment.asp"-->

<%
Case GlobalConfig("General_Banner")
%>
<!--#include file="components/banner.asp"-->

<%
Case GlobalConfig("General_Poll")
%>
<!--#include file="components/poll.asp"-->

<%
Case GlobalConfig("General_Mailist")
%>
<!--#include file="components/mailist.asp"-->

<%
Case GlobalConfig("General_Users")
%>
<!--#include file="components/user.asp"-->





<%
Case "menu"
%>
<!--#include file="components/menu.asp"-->
<%
Case "menu_settings"
%>
<!--#include file="components/menu/settings.asp"-->





<%
Case "ayar"
%>
<!--#include file="components/config.asp"-->


<%
Case "tema"
%>
<!--#include file="components/theme.asp"-->






<%
'// No Sub

Case "popup_" & GlobalConfig("General_Page")
%>
<!--#include file="components/_page.asp"-->

<%
Case "popup_" & GlobalConfig("General_Page") & "_list"
%>
<!--#include file="components/_pageList.asp"-->

<%
Case "fileUpdate"
%>
<!--#include file="components/_fileUpdate.asp"-->

<%
Case "load"
%>
<!--#include file="components/_load.asp"-->

<%
Case GlobalConfig("General_Page") & "_settings"
%>
<!--#include file="components/page/settings.asp"-->

<%
Case GlobalConfig("General_Banner") & "_settings"
%>
<!--#include file="components/banner/settings.asp"-->

<%
Case GlobalConfig("General_Page") & "_images"
%>
<!--#include file="components/page/image.asp"-->

<%
Case GlobalConfig("General_Categories") & "_settings"
%>
<!--#include file="components/category/settings.asp"-->

<%
Case GlobalConfig("General_Products") & "_settings"
%>
<!--#include file="components/product/settings.asp"-->








<%
Case GlobalConfig("General_Redirect")
%>
<!--#include file="components/_redirect.asp"-->

<%
Case "url_list"
%>
<!--#include file="components/_url_list.asp"-->

<%
Case "modul"
%>
<!--#include file="components/_modul.asp"-->

<%
Case "template"
%>
<!--#include file="components/_template.asp"-->

<%
Case "img"
%>
<!--#include file="components/_img.asp"-->

<%
Case "maps"
%>
<!--#include file="components/_maps.asp"-->

<%
Case "sistem_info"
%>
<!--#include file="components/__sistem_info.asp"-->

<%
Case "preview"
%>
<!--#include file="components/__preview.asp"-->

<%
Case "pagebreak"
%>
<!--#include file="components/__pagebreak.asp"-->






<%
Case "list_json"
%>
<!--#include file="components/_json.asp"-->

<%
Case "post"
%>
<!--#include file="components/_save.asp"-->

<%
Case "list_post"
%>
<!--#include file="components/_action.asp"-->

<%
Case "upload"
%>
<!--#include file="components/_upload.asp"-->








<%
'// End No Sub
Case Else

	Response.Redirect("index.asp?mod=" & GlobalConfig("General_Login") )

End Select

If Not RequestModFalse Then Call Alt_Bolge()

Call CloseDatabase(data)
%>
