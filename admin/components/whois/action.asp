<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	If jBoxChecked = "delete" Then
		sqlExeCute("DELETE FROM #___whois WHERE id = "& jPostid &";")
		jApply2 = "delete-true"
		jAddClass = "success"
		jMessage = i & " Alan adı silindi."
	End If

	Call ArrJSON(jPostid, "", "", jApply2)

Next
%>
