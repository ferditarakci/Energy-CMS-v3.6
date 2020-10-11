<%
If Not blnPostMethod Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
'Response.Clear()
'Response.Buffer = True
Response.ContentType = "text/plain"
'On Error Resume Next


pageid = intYap(Request.Form("pageid"), 0)


'// Yetki kotrolü yapalım
If Not GlobalConfig("admin_yetki") Then

	Response.Clear()
	Call ActionPost(pageid, "warning", GlobalConfig("admin_yetki_message"))
	Call CloseDatabase(data)
	Response.End()

End If


saveid = pageid
saveClass = "success"

Select Case task

Case GlobalConfig("General_Categories")
%>
<!--#include file="categories.asp"-->

<%
Case GlobalConfig("General_Products")
%>
<!--#include file="products.asp"-->

<%
Case GlobalConfig("General_Page")
%>

<!--#include file="sayfa.asp"-->

<%
Case GlobalConfig("General_Poll")
%>
<!--#include file="poll.asp"-->

<%
Case GlobalConfig("General_Banner")
%>
<!--#include file="banner.asp"-->

<%
Case GlobalConfig("General_Tags")
%>
<!--#include file="etiket.asp"-->

<%
Case GlobalConfig("General_Users")
%>
<!--#include file="user.asp"-->

<%
Case "ayar"
%>
<!--#include file="config.asp"-->

<%
Case "yorum"
%>
<!--#include file="yorum.asp"-->

<%
Case Else

	Response.Clear()
	Call ActionPost(saveid, "warning", "Üzgünüm! Bir hata oluştu, Belirtilen yol bulunamadı.")
	Call CloseDatabase(data)
	Response.End()

End Select


If Err <> 0 Then

	Response.Clear()
	Call ActionPost(saveid, "error", "Hata oluştu! Hata Kodu: " & Err.Description)
	Call CloseDatabase(data)
	Response.End()

End If


On Error GoTo 0


'// Ajax Json
Call ActionPost(saveid, saveClass, saveMessage)


'// Submit Sitemap
If saveClass = "success" And pageid = 0 Then Call PingSiteMap()

%>
