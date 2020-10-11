<%
'// Form nesnelerimi alalım
strPostTitle = Temizle(ClearHtml(Request.Form("comment_author")), 1)
strMailAdres = Temizle(ClearHtml(Request.Form("comment_author_email")), 1)
intDurum = intYap(Request.Form("comment_status"), 0)
strLink = Temizle(ClearHtml(Request.Form("comment_author_url")), 1)
strText = Temizle(ClearHtml(Request.Form("comment_text")), 1)

'// Kontroller
If Len(strPostTitle) = 0 Then
	saveClass = "warning"
	saveMessage = "Lütfen bir etiket girin."

ElseIf Len(strPostTitle) > 100 Then
	saveClass = "warning"
	saveMessage = "Lütfen 100 karakterden daha kısa bir isim girin."

ElseIf Len(strLink) > 250 Then
	saveClass = "warning"
	saveMessage = "Lütfen 250 karakterden daha kısa bir URL girin."

ElseIf Not isValidEMail(strMailAdres) Then
	saveClass = "warning"
	saveMessage = "Lütfen geçerli bir mail adresi girin."

Else

	'// Formdan gelen IDye ait kayıt kontrolü yapıyoruz
	intGetRow = Cdbl(sqlQuery("SELECT id FROM #___yorum WHERE id = '"& pageid &"';", 0))
	If Not CBool(intGetRow) Then
		'Response.Write "<script>alert('asdf')</script>"
		'Response.Clear
		sqlExeCute("UPDATE #___yorum Set comment_author = '"& strPostTitle &"', comment_author_email = '"& strMailAdres &"', comment_author_url = '"& strLink &"', comment_status = "& intDurum &", comment_text = '"& strText &"' WHERE id = "& intGetRow &";")
	End If

	'strLink = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", strLink, "", "", "")
End If

If Len(saveMessage) = 0 And pageid = 0 Then saveMessage = "Yorum Başarıyla Eklendi."
If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "Yorum Başarıyla Güncellendi."

Dim EditComment
Set EditComment = jsObject()
	EditComment("idno") = pageid
	EditComment("comment_author") = Duzenle(strPostTitle)
	'EditComment("comment_author_email") = strMailAdres
	EditComment("comment_author_url") = strLink
	EditComment("comment_status") = intDurum
	'EditComment("comment_text") = saveMessage
	EditComment("cssClass") = saveClass
	EditComment("mesaj") = saveMessage
	EditComment.Flush
Set EditComment = Nothing

Response.End
%>
