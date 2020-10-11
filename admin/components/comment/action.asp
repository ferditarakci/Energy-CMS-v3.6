<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	OpenRs objRs, "SELECT id, comment_author, comment_author_url, comment_status FROM #___yorum WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			jPostid = objRs("id")
			jTitle = objRs("comment_author")

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("comment_status")) Then
					objRs("comment_status") = 1
					jApply2 = "status-true"
					jMessage = i & " Yorum aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("comment_status")) Then
					objRs("comment_status") = 0
					jApply2 = "status-false"
					jMessage = i & " Yorum pasif edildi."
				End If

			'Delete
			ElseIf jBoxChecked = "delete" Then
				SQL = "SELECT id FROM #___yorum WHERE comment_parent_id = {0};"
				Call TreeViewList(SQL, jPostid, 0)
				If Ubound(arrTreeView) >= 0 Then
					TreeViewShort = Join(arrTreeView, ", ")
					'sqlExeCute("DELETE FROM #___yorum WHERE id IN ("& TreeViewShort &");")
					sqlExeCute("UPDATE #___yorum SET comment_parent_id = 0 WHERE id IN ("& TreeViewShort &");")
				End If
				jMessage = i & " Yorum Silindi."
				jApply2 = "delete-true"
				objRs.Delete
			End If

			objRs.Update



			jUrl = ""
			If jApply2 = "status-true" Then jUrl = objRs("comment_author_url")

			jAddClass = "success"
			Call ArrJSON(jPostid, jTitle, jUrl, jApply2)

		End If
	CloseRs objRs
Next


%>
