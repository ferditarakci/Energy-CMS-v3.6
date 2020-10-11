<%
'Mailist Kayıt Bağlantısı
strMail = Temizle(ClearHtml(Request.Form("mailist_email")), 1)
strName = Temizle(ClearHtml(Request.Form("mailist_isim")), 1)

If (strName = "" Or strName = Lang("mailist_isim_gir")) Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("mailist_err_01")

ElseIf Len(strName) < 3 Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("mailist_err_02")

ElseIf Not isValidEMail(strMail) Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("mailist_err_03")
End If

If Len(ajaxCssClass) > 0 Then Call ActionPost(ajaxCssClass, ajaxMessages)

Set objRs = setExecute("SELECT email FROM #___mailist WHERE lang = '"& GlobalConfig("site_lang") &"' And email = '"& strMail &"';")
If objRs.Eof Then

	sqlExecute("INSERT INTO #___mailist (lang, email, isim, tarih) VALUES('"& GlobalConfig("site_lang") &"', '"& strMail &"', '"& strName &"', Now());")
	ajaxCssClass = "success"
	ajaxMessages = Lang("mailist_err_04")

Else

	If objRs("email") = strMail then
		ajaxCssClass = "error"
		ajaxMessages = Lang("mailist_err_05")
	End If

End If
Set objRs = Nothing

Call ActionPost(ajaxCssClass, ajaxMessages)
%>
