<%

intAnketSiD = intYap(Request.Form("aid"), 0)

Set objRs = setExecute("Select anketid FROM #___anket_secenek WHERE secenekid = "& intAnketSiD &";")
	If Not objRs.Eof Then

		strAnketCookieName = CStr("AnketOylama" & objRs("anketid"))

		If Not intYap(Request.Cookies(strAnketCookieName), 0) = 1 Then

			sqlExecute("UPDATE #___anket_secenek Set oy = oy + 1 WHERE secenekid = "& intAnketSiD &";")

			With Response
				.Cookies(strAnketCookieName) = 1
				.Cookies(strAnketCookieName).Path = GlobalConfig("sRoot")
				.Cookies(strAnketCookieName).Expires = Now() + 1
			End With

			ajaxCssClass = "success"
			ajaxMessages = Lang("anket_thankyou_msg")

		Else

			ajaxCssClass = "warning"
			ajaxMessages = Lang("anket_err_02")
		End If

	Else

		ajaxCssClass = "error"
		ajaxMessages = Lang("anket_err_01")

	End If
Set objRs = Nothing

Call ActionPost(ajaxCssClass, ajaxMessages)

%>
