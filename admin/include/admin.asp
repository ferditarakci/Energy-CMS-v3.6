<%

GlobalConfig("admin_username") = Session("admin_username" & SefUrl(GlobalConfig("sRoot")))
GlobalConfig("admin_login") = Session("admin_login_" & SefUrl(GlobalConfig("sRoot")))

'Response.Write Session.SessionID
If GlobalConfig("admin_folder_true") Then

	Dim SessionPiD, pageid
	SessionPiD = intYap(Session("pageid"), 0)

	If task = "" Then Session.Contents.Remove("pageid")

	If (mods = "upload" Or task = "new" Or task = "edit") Then pageid = SessionPiD : Session.Contents.Remove("pageid")
	'If Not (mods = GlobalConfig("General_Page") And task = "new") Then pageid = 0

	GlobalConfig("admin_login") = Session("admin_login_" & SefUrl(GlobalConfig("sRoot")))
	GlobalConfig("admin_name") = Session("admin_name" & SefUrl(GlobalConfig("sRoot")))
	GlobalConfig("admin_login_time") = Session("admin_login_time" & SefUrl(GlobalConfig("sRoot")))
	GlobalConfig("admin_yetki") = Session("admin_yetki" & SefUrl(GlobalConfig("sRoot")))
	GlobalConfig("admin_yetki_message") = "Üzgünüm! Yeni kayıt ekleme, güncelleme ve silme yetkiniz bulunmamaktadır."

	GlobalConfig("general_admin") = (GlobalConfig("admin_username") = GlobalConfig("super_admin"))

	If GlobalConfig("admin_folder_true") Then

		If GlobalConfig("admin_login") Then
			If mods = GlobalConfig("General_Login") And Not (task = "logout" Or task = "admin") Then Response.Redirect("index.asp?mod=" & GlobalConfig("General_Page") & Debug2) : Response.End()
		Else
			If Not mods = GlobalConfig("General_Login") Then Response.Redirect("index.asp?mod=" & GlobalConfig("General_Login")) : Response.End()
		End If

		'If ( _
		'	(Not mods = GlobalConfig("General_Login")) And _
		'	(Not Session("site_status" & SefUrl(GlobalConfig("sRoot")))) And _
		'	(Not GlobalConfig("general_admin")) _
		') Then
		Dim blnLoginErr
		blnLoginErr = (mods <> GlobalConfig("General_Login") And Not Session("site_status" & SefUrl(GlobalConfig("sRoot"))) And Not GlobalConfig("general_admin"))
		If blnLoginErr Then
			Session("logerror") = True
			Response.Redirect("index.asp?mod=" & GlobalConfig("General_Login") & "&task=logout")
			Response.End()
		End If

		%><!--#include file="tinymce.asp"--><%

	End If


		If Not GlobalConfig("general_admin") And Request.QueryString("debug").Count > 0 Then
			Response.Redirect("?" & RequestQueryStringRemove("debug", 0) )
			Response.End()
		End If

End If


'Response.Write 	GlobalConfig("admin_login") & "<br>"
'Response.Write 	GlobalConfig("admin_login") & "<br>"
'Response.Write 	GlobalConfig("admin_username") & "<br>"
'Response.Write 	GlobalConfig("admin_name")  & "<br>"
'Response.Write 	GlobalConfig("admin_login_time")  & "<br>"
'Response.Write 	GlobalConfig("admin_yetki")  & "<br>"
'Response.Write 	GlobalConfig("admin_yetki_message")  & "<br>"
'Response.Write	Session("admin_login_" & GlobalConfig("sRoot"))

%>
