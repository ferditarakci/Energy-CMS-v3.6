<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	If jBoxChecked = "sort-order" Then jOrder = intYap(Request.Form("order[]")(i), 0)

	OpenRs objRs, "SELECT id, title, img, url, sira, durum FROM #___banner WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			jPostid = objRs("id")
			jTitle = objRs("title")
			jUrl = objRs("url")

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("durum")) Then
					objRs("durum") = 1
					jApply2 = "status-true"
					jMessage = i & " Banner aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("durum")) Then
					objRs("durum") = 0
					jApply2 = "status-false"
					jMessage = i & " Banner pasif edildi."
				End If

			'Sira
			ElseIf jBoxChecked = "sort-order" Then
				objRs("sira") = jOrder
				jMessage = "Banner sıralaması değiştirildi."

			'Delete
			ElseIf jBoxChecked = "delete" Then
				Call DeleteFile(bFolder & "/" & objRs("img"))
				jMessage = i & " Banner Silindi."
				jApply2 = "delete-true"
				objRs.Delete
			End If

			objRs.Update

			jUrl = ""
			If jApply2 = "status-true" Then jUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Redirect"), GlobalConfig("General_Banner"), "", jPostid, "", "")

			jAddClass = "success"
			Call ArrJSON(jPostid, jTitle, jUrl, jApply2)

		End If
	CloseRs objRs
Next
%>
