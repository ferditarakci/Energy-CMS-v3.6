<%
Dim AddReplyToAddress
Private Sub MailSender(ByVal strFrom, ByVal strFromName, ByVal strToMail, ByVal strToName, ByVal strSubject, ByVal strBody, ByVal intJSON)
	Dim strMailServer, strHost, strUsername, strPassword, strTo
	Dim obj, cssClass, MailMsg

	Server.ScriptTimeout = 600

	'// SMTP Mail Server Bağlantısı
	strMailServer = Cstr( GlobalConfig("mail_user_name") & ":" & GlobalConfig("mail_pwrd") & "@" & GlobalConfig("mail_host") )

	'// SMTP Mail Server Bağlantısı
	strHost = Cstr( GlobalConfig("mail_host") )
	strUsername = Cstr( GlobalConfig("mail_user_name") )
	strPassword = Cstr( GlobalConfig("mail_pwrd") )

	'// Gönderen Mail
	strFromName = Cstr( AjaxTurkish( strFromName ) )

	'// Gönderen adı
	strToName = Cstr( AjaxTurkish( strToName ) )

	'// Mail Konu Başlığı
	strSubject = Cstr( AjaxTurkish( strSubject ) )

	'// Mail İçeriği
	strBody = Cstr( AjaxTurkish( strBody ) )

	'// Hata oluşursa görmezden gelsin
	On Error Resume Next

	For Each strTo in Split(strToMail, ",")
		strTo = Trim( strTo )

		Select Case GlobalConfig("mail_type")

			Case "Persits Asp Mail"
				With Server.CreateObject("Persits.MailSender")
					.Host = strHost
					.Username = strUsername
					.Password = strPassword
					'If strHost = "smtp.live.com" Or strHost = "smtp.gmail.com" Then _
					If Cdbl(Left(.Version, 3)) = Cdbl(5.1) And (strHost = "smtp.live.com" Or strHost = "smtp.gmail.com") Then .TLS = True
					.Port = 587
					.From = strFrom
					.FromName = .EncodeHeader(strFromName, "UTF-8")
					.AddAddress strTo, .EncodeHeader(strToName, "UTF-8")
					.AddReplyTo "" & AddReplyToAddress
					.Subject = .EncodeHeader(strSubject, "UTF-8")
					'.AddCustomHeader "Return-Path: bilgi@webtasarimx.net"
					.isHTML = True
					.Body = strBody
					.CharSet = "UTF-8"
					.ContentTransferEncoding = "Quoted-Printable"
					'// append body from file
					'// .AppendBodyFromFile Server.MapPath(".") & "\SampleBody.htm"
					'// Add embedded image for background
					'// .AddEmbeddedImage Server.MapPath(".") & "\margin.gif", "My-Background-Image"
					.Send
					'Version = .Version
				End With


			Case "CDOSYS Mail"
				Dim CDOurl : CDOurl = "http://schemas.microsoft.com/cdo/configuration/"
				With Server.CreateObject("CDO.Message")
					.Configuration.Fields.item(CDOurl & "sendusing") = 2
					.Configuration.Fields.item(CDOurl & "smtpserver") = strHost
					.Configuration.Fields.item(CDOurl & "sendusername") = strUsername
					.Configuration.Fields.item(CDOurl & "sendpassword") = strPassword
					.Configuration.Fields.item(CDOurl & "smtpserverport") = 587
					.Configuration.Fields.item(CDOurl & "smtpusessl") = False
					.Configuration.Fields.item(CDOurl & "smtpconnectiontimeout") = 60
					.Configuration.Fields.item(CDOurl & "smtpauthenticate") = 1
					.Configuration.Fields.Update
					.BodyPart.CharSet = "UTF-8"
					.From = strFromName &"<"& strFrom &">"
					.To = strTo
					.Subject = strSubject
					.HTMLBody = strBody
					Rem .TextBody = Body
					MailMsg = .Send
				End With


			Case "JMail"
				With Server.CreateObject("JMail.Message")
					.MailServerUserName = strUsername
					.MailServerPassWord = strPassword
					.Encoding = "base64"
					.MimeVersion = "1.0"
					.AddHeader "X-Priority","3"
					.ContentTransferEncoding = "Quoted-Printable"
					.From = strFrom
					.FromName = strFromName
					.Subject = strSubject
					.AddRecipient strTo, strToName
					.Charset = "UTF-8"
					.ContentType = "text/html"
					.HTMLBody = strBody
					.Send( strHost )
				End With


			Case "CDONTS Mail"
				With Server.CreateObject("CDONTS.NewMail")
					.From = strFrom
					.To = strTo
					.Subject = strSubject
					.BodyFormat = 0
					.MailFormat = 0
					.Charset = "UTF-8"
					.Body = strBody
					.Send
				End With


			'Case "SMTPsvg.Mailer"
			'	With Server.CreateObject("SMTPsvg.Mailer")
			'		.FromName = strFromName
			'		.FromAddress = strFrom
			'		.RemoteHost = strMailServer
			'		.AddRecipient strTo, strToName
			'		.Subject = strSubject
			'		.BodyText = strBody
			'		SendOk = .SendMail
			'	End With


			'Case "JMail.SMTPMail"
			'	With Server.CreateObject("JMail.SMTPMail")
			'		.Sender = strFrom
			'		.ServerAddress = strMailServer
			'		.AddRecipient strTo
			'		.Subject = strSubject
			'		.ContentType = "text/html"
			'		.Body = strBody
			'		.Execute
			'	End With


			'Case "ASPMail.ASPMailCtrl.1"
			'	With Server.CreateObject("ASPMail.ASPMailCtrl.1")
			'		SendOk = .SendMail(strMailServer, strTo, strFrom, strSubject, strBody) 
			'	End With


			Case Else
				cssClass = "error"
				MailMsg = Lang("mailsender_err_01")

		End Select
	Next

	If Err <> 0 Then
		cssClass = "error"
		MailMsg = Replace(Lang("mailsender_err_02"), "[err]", Err.Description)
	Else
		cssClass = "success"
		MailMsg = Lang("mailsender_err_03")
	End If

	On Error Goto 0

	If intJSON = 1 Then
		Set obj = jsObject()
			obj("divClass") = cssClass
			obj("divMsg") = MailMsg
			obj.Flush
		Set obj = Nothing
	End If

End Sub
%>
