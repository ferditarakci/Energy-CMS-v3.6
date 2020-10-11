<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	If jBoxChecked = "sort-order" Then jOrder = intYap(Request.Form("order[]")(i), 0)

	OpenRs objRs, "SELECT id, etiket, permalink, status FROM #___etiket WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			jPostid = objRs("id")
			jTitle = objRs("etiket")
			'jUrl = objRs("permalink")

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("status")) Then
					objRs("status") = 1
					jApply2 = "status-true"
					jMessage = i & " Etiket aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("status")) Then
					objRs("status") = 0
					jApply2 = "status-false"
					jMessage = i & " Etiket pasif edildi."
				End If

			'Delete
			ElseIf jBoxChecked = "delete" Then
				sqlExeCute("DELETE FROM #___etiket_id WHERE eid = "& jPostid &";")
				jMessage = i & " Etiket Silindi."
				jApply2 = "delete-true"
				objRs.Delete
			End If

			objRs.Update

			jUrl = ""
			If jApply2 = "status-true" Then jUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", objRs("permalink"), "", "", "")

			jAddClass = "success"
			Call ArrJSON(jPostid, jTitle, jUrl, jApply2)

		End If
	CloseRs objRs
Next
%>
