<%
'Dim strName, strTelNo, strMail, strKonu, strMesaj, strBanadaGonder, strMesajTarih, ajaxCssClass, ajaxMessages, strKontrol, strHtmlBody
strName = Temizle(ClearHtml(Request.Form("info_isim")), -1)
strTelNo = Temizle(ClearHtml(Request.Form("info_tel")), -1)
strMail = Temizle(ClearHtml(Request.Form("info_mail")), -1)
strKonu = Temizle(ClearHtml(Request.Form("info_konu")), -1)
strMesaj = TextBR(Temizle(Request.Form("info_mesaj"), -1))
strBanadaGonder = Request.Form("info_banadayolla")
strMesajTarih = TarihFormatla(Now())

ajaxCssClass = ""
ajaxMessages = ""

strKontrol = _
	inStr(1, Request.Form("info_isim"), "<script", 1) Or _
	inStr(1, Request.Form("info_tel"), "<script", 1) Or _
	inStr(1, Request.Form("info_mail"), "<script", 1) Or _
	inStr(1, Request.Form("info_konu"), "<script", 1) Or _
	inStr(1, Request.Form("info_mesaj"), "<script", 1) Or _
	inStr(1, Request.Form("info_isim"), "<a", 1) Or _
	inStr(1, Request.Form("info_tel"), "<a", 1) Or _
	inStr(1, Request.Form("info_mail"), "<a", 1) Or _
	inStr(1, Request.Form("info_konu"), "<a", 1) Or _
	inStr(1, Request.Form("info_mesaj"), "<a", 1)

' Kontroller başlıyor
If strKontrol Then
	ajaxCssClass = "warning"
	ajaxMessages = Lang("info_err_html")

ElseIf strName = "" Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_isim")

ElseIf Len(strName) < 3 Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_isim2")

'ElseIf (strTelNo = "") Then  
	'ajaxCssClass = "error"
	'ajaxMessages = Lang("info_err_tel")

ElseIf Not isValidEMail(strMail) Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_mail")

ElseIf strKonu = "" Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_konu")

ElseIf strMesaj = "" Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_mesaj")
End If

If Len(ajaxCssClass) > 0 Then Call ActionPost(ajaxCssClass, ajaxMessages)

strHtmlBody = ""
strHtmlBody = strHtmlBody & "<table style=""width:600px; font-family:Arial; font-size:12px; text-align:left;"" width=""600"" cellpadding=""0"" cellspacing=""0""><tbody><tr><td>"
strHtmlBody = strHtmlBody & "<h2 style=""font-size:16px; font-weight:bold; padding:2px 0;"">" & Replace(Lang("info_mail_isim_title"), "[isimYaz]", "<span style=""color:#ff0000;"">" & strName & "</span>") & "</h2>"
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:12px; padding:5px 0; border-bottom:solid #EEEEEE 2pt;""><span style=""display:block; width:100%;""><b>" & Lang("info_mail_tarih") & " :</b>  " & strMesajTarih & "</span></p>" & vbCrLf
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:12px; padding:5px 0; border-bottom:solid #EEEEEE 2pt;""><span style=""display:block; width:100%;""><b>" & Lang("info_mail_isim") & " :</b>  " & strName & "</span></p>" & vbCrLf
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:12px; padding:5px 0; border-bottom:solid #EEEEEE 2pt;""><span style=""display:block; width:100%;""><b>" & Lang("info_mail_tel") & " :</b>  " & strTelNo & "</span></p>" & vbCrLf
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:12px; padding:5px 0; border-bottom:solid #EEEEEE 2pt;""><span style=""display:block; width:100%;""><b>" & Lang("info_mail_adres") & " :</b>  " & strMail & "</span></p>" & vbCrLf
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:12px; padding:5px 0; border-bottom:solid #EEEEEE 2pt;""><span style=""display:block; width:100%;""><b>" & Lang("info_mail_konu") & " :</b>  " & strKonu & "</span></p>" & vbCrLf
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:12px; padding:5px 0;""><span style=""display:inline-block; width:100%; font-family:Arial; font-size:12px; line-height:20px; padding:3px 0;""><b>" & Lang("info_mail_mesaj") & " :</b>  <br />**********<br /><br />" & strMesaj & "<br /><br />**********<br /></span></p>" & vbCrLf
strHtmlBody = strHtmlBody & "<br />--------------------------------------------------------------------<br />" & vbCrLf
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:11px; padding:2px 0; color:#5f5f5f; line-height:15px;"">Mesajın Gönderildiği Adres : <a style=""font-size:11px; color:#5f5f5f;"" href=""http://" & GlobalConfig("sBase") & """ target=""_blank"">" & GlobalConfig("sDomain") & "</a></p>" & vbCrLf
strHtmlBody = strHtmlBody & "<p style=""width:100%; font-family:Arial; font-size:11px; padding:2px 0; color:#9b9b9b; line-height:15px;""><a style=""font-size:11px; color:#9b9b9b;"" href=""http://www.webtasarimx.net"" target=""_blank"">Energy Web Yazılım &copy; 2010 - 2012</a></p>" & vbCrLf
strHtmlBody = strHtmlBody & "</td></tr></tbody></table>"

'FromName  = "" & infoFormPost01
'Subject   = "" & strKonu
'Response.Write(strHtmlBody)
'Call MailSender("Gönderen strMail", "Gönderen Adı", "Alıcı strMail", "Alıcı Adı", "strMail Konusu", "strMail Body")

If (strBanadaGonder = "OK") Then GlobalConfig("mail_to") = GlobalConfig("mail_to") & "," & strMail ' Else strBanadaGonder = GlobalConfig("mail_to")

'strMail Gönderme Fonksiyonunu Çalıştır
AddReplyToAddress = strMail
Call MailSender( _
	Cstr(GlobalConfig("mail_from")), _
	Cstr(Lang("info_mail_title")), _
	Cstr(GlobalConfig("mail_to")), _
	"", _
	Cstr(strKonu), _
	Cstr(strHtmlBody), _
	1 _
)

%>
