<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	If jBoxChecked = "sort-order" Then jOrder = intYap(Request.Form("order[]")(i), 0)

	OpenRs objRs, "SELECT id, title, durum, sira FROM #___anket WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			jPostid = objRs("id")
			jTitle = objRs("title")

			jApply2 = ""

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("durum")) Then
					objRs("durum") = 1
					jApply2 = "status-true"
					jMessage = i & " Anket aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("durum")) Then
					objRs("durum") = 0
					jApply2 = "status-false"
					jMessage = i & " Anket pasif edildi."
				End If

			'Sira
			ElseIf jBoxChecked = "sort-order" Then
				objRs("sira") = jOrder
				jMessage = "Anket sıralaması değiştirildi."

			'Delete
			ElseIf jBoxChecked = "delete" Then
				Call ContentDelete(jPostid, GlobalConfig("General_Poll"))
				sqlExeCute("DELETE FROM #___anket_secenek WHERE anketid = "& jPostid &";")
				jMessage = i & " Anket Silindi."
				jApply2 = "delete-true"
				objRs.Delete
			End If

			objRs.Update

			jUrl = ""
			If jApply2 = "status-true" Then jUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Poll"), "", "", jPostid, "", "")

			jAddClass = "success"
			Call ArrJSON(jPostid, jTitle, jUrl, jApply2)

		End If
	CloseRs objRs
Next
%>
