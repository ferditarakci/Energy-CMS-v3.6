<%
Sub LogActiveUser(ByVal sitePath)
	Dim strActiveUserList
	Dim intUserStart, intUserEnd
	Dim strUser
	Dim strDate

	strActiveUserList = Application("ActiveUserList_" & sitePath)

	If inStr(1, strActiveUserList, Session.SessionID) > 0 Then
		Application.Lock
		intUserStart = inStr(1, strActiveUserList, Session.SessionID)
		intUserEnd = inStr(intUserStart, strActiveUserList, "|")
		strUser = Mid(strActiveUserList, intUserStart, intUserEnd - intUserStart)
		strActiveUserList = Replace(strActiveUserList, strUser, Session.SessionID & ":" & Now())
		Application("ActiveUserList_" & sitePath) = strActiveUserList
		Application.UnLock
	Else
		Application.Lock
		Application("ActiveUsers_" & sitePath) = Cint(Application("ActiveUsers_" & sitePath)) + 1
		Application("ActiveUserList_" & sitePath) = Application("ActiveUserList_" & sitePath) & Session.SessionID & ":" & Now() & "|"
		Application.UnLock
	End If
End Sub

Sub ActiveUserCleanup(ByVal sitePath)
	Dim ix
	Dim intUsers
	Dim strActiveUserList
	Dim aActiveUsers
	Dim intActiveUserCleanupTime
	Dim intActiveUserTimeout

	intActiveUserCleanupTime = 1 
	intActiveUserTimeout = 20

	If Application("ActiveUserList_" & sitePath) = "" Then Exit Sub

	If DateDiff("n", Application("ActiveUsersLastCleanup_" & sitePath), Now()) > intActiveUserCleanupTime Then
		Application.Lock
		Application("ActiveUsersLastCleanup_" & sitePath) = Now()
		Application.Unlock

		intUsers = 0
		strActiveUserList = Application("ActiveUserList_" & sitePath)
		strActiveUserList = Left(strActiveUserList, Len(strActiveUserList) - 1)

		aActiveUsers = Split(strActiveUserList, "|")

		For ix = 0 To UBound(aActiveUsers)
			If DateDiff("n", Mid(aActiveUsers(ix), inStr(1, aActiveUsers(ix), ":") + 1, Len(aActiveUsers(ix))), Now()) > intActiveUserTimeout Then
				aActiveUsers(ix) = "XXXX"
			Else
				intUsers = intUsers + 1
			End If 
		Next

		strActiveUserList = Join(aActiveUsers, "|") & "|"
		strActiveUserList = Replace(strActiveUserList, "XXXX|", "")

		Application.Lock
		Application("ActiveUserList_" & sitePath) = strActiveUserList
		Application("ActiveUsers_" & sitePath) = intUsers
		Application.UnLock

	End If
End Sub
%>
