<%
Class RequestTracker
	' #### 2 Boyutlu Dizi Anahtarları ####
	Private ClientID, ClientPeriodStart, ClientRequestCount, ClientRequestUrl, Html
	' #### Liste Özellikleri ####
	Public Period, MaxRequestsAllowedPerPeriod, BanFor, ListEntryTimeOut, ListName, Identifier
	
	Private rClientList
	Private Sub Class_Initialize
		' #### 2 Boyutlu Dizi Anahtarı Sabitleri ####
		ClientID = 0
		ClientPeriodStart = 1
		ClientRequestCount = 2
		ClientRequestUrl = 3
		
		' #### Varsayılan Liste Yapılandırması ####
		Period = 2
		MaxRequestsAllowedPerPeriod = 1
		BanFor = 5
		If Not Session Is Nothing Then ListEntryTimeOut = Session.Timeout * 60 Else ListEntryTimeOut = 20 * 60
		
		' #### Varsayılan Tanımlayıcı ####
		Identifier = Request.ServerVariables("REMOTE_ADDR")
	End Sub
	Public Property Get ListCount()
		ListCount = 0
		On Error Resume Next
		ListCount = UBound(Application(ListName), 2) + 1
	End Property
	Private Function AddListEntry(sID, dtmDt, lngCnt, sUrl)
		Dim lngNewUpperBound
		If IsArray(rClientList) Then
			lngNewUpperBound = UBound(rClientList, 2) + 1
			Redim Preserve rClientList(3, lngNewUpperBound)
		Else
			lngNewUpperBound = 0
			Redim rClientList(3, lngNewUpperBound)
		End If
		rClientList(ClientID, lngNewUpperBound) = sID
		rClientList(ClientPeriodStart, lngNewUpperBound) = dtmDt
		rClientList(ClientRequestCount, lngNewUpperBound) = lngCnt
		rClientList(ClientRequestUrl, lngNewUpperBound) = sUrl
		AddListEntry = lngNewUpperBound
	End Function
	
	Sub Track()
		If Len(ListName) < 1 Then Exit Sub
		Application.Lock
		Dim sCurrId, dtmCurrDate, IsBanned, sCurrUrl
			sCurrId = Identifier
			dtmCurrDate = Now
		With Request
			If .ServerVariables("REQUEST_URI").Count Then
				sCurrUrl = .ServerVariables("REQUEST_URI")
			ElseIf .ServerVariables("HTTP_X_ORIGINAL_URL").Count Then
				sCurrUrl = .ServerVariables("HTTP_X_ORIGINAL_URL")
			Else
				sCurrUrl = .ServerVariables("URL") & String(Abs(CBool(.QueryString.Count)), "?") & .QueryString
			End If
		End With
		Dim rTmpClientList
			rTmpClientList = Application(ListName)
		If IsArray(rTmpClientList) Then
			Dim lngFnddIx, lngRecLen, lngCurrIX
			For lngRecLen = 0 To UBound(rTmpClientList, 2)
				If DateAdd("s", ListEntryTimeOut, rTmpClientList(ClientPeriodStart, lngRecLen)) > dtmCurrDate Then
					lngCurrIX = AddListEntry( _ 
						rTmpClientList(ClientID, lngRecLen), _
						rTmpClientList(ClientPeriodStart, lngRecLen), _ 
						rTmpClientList(ClientRequestCount, lngRecLen), _ 
						rTmpClientList(ClientRequestUrl, lngRecLen) _ 
					)
					If rTmpClientList(ClientID, lngRecLen) = sCurrId Then lngFnddIx = lngCurrIX
				End If
			Next
			Erase rTmpClientList
			If IsEmpty(lngFnddIx) Then
				lngFnddIx = AddListEntry(sCurrId, dtmCurrDate, 1, sCurrUrl)
			Else
				If rClientList(ClientPeriodStart, lngFnddIx) > dtmCurrDate Then
					IsBanned = True
				Else
					If DateDiff("s", rClientList(ClientPeriodStart, lngFnddIx), dtmCurrDate) > Period Then
						rClientList(ClientRequestCount, lngFnddIx) = 1
						rClientList(ClientPeriodStart, lngFnddIx) = dtmCurrDate
						rClientList(ClientRequestUrl, lngFnddIx) = sCurrUrl
					Else
						rClientList(ClientRequestCount, lngFnddIx) = rClientList(ClientRequestCount, lngFnddIx) + 1
						rClientList(ClientRequestUrl, lngFnddIx) = sCurrUrl
						If rClientList(ClientRequestCount, lngFnddIx) > MaxRequestsAllowedPerPeriod Then
							rClientList(ClientRequestCount, lngFnddIx) = 0
							rClientList(ClientPeriodStart, lngFnddIx) = DateAdd("s", BanFor, dtmCurrDate)
							IsBanned = True
						End If
					End If
				End If
			End If
		Else
			lngFnddIx = AddListEntry(sCurrId, dtmCurrDate, 1, sCurrUrl)
		End If
		Dim dtmLiftBan, sLastPage
			dtmLiftBan = rClientList(ClientPeriodStart, lngFnddIx)
			sLastPage = rClientList(ClientRequestUrl, lngFnddIx)
		Application(ListName) = rClientList
		Application.Unlock
		Erase rClientList
		If isBanned Then
			Html = Html & "Geçici olarak " & BanFor & " saniyeliğine yasaklandınız.<br />"
			Html = Html & "Sitede her " & Period & " saniyede en fazla "& MaxRequestsAllowedPerPeriod & " istek yapabilirsiniz.<br />"
			Html = Html & "Bu uyarı "& DateDiff("s", dtmCurrDate, dtmLiftBan) &" saniye sonra kalkacaktır.<br />"
			Html = Html & "Son gezilen sayfa : "& sLastPage &""
			Call ErrMsg(Html)
			'With Response
			'	.Clear
			'	.Write "Geçici olarak " & BanFor & " saniyeliğine yasaklandınız.<br />"
			'	.Write "Sitede her " & Period & " saniyede en fazla "& MaxRequestsAllowedPerPeriod & " istek yapabilirsiniz.<br />"
			'	.Write "Bu uyarı "& DateDiff("s", dtmCurrDate, dtmLiftBan) &" saniye sonra kalkacaktır.<br />"
			'	.Write "Son gezilen sayfa : "& sLastPage &"<br />"
			'	.End
			'End With
		End If
	End Sub
End Class



Dim liste
Set liste = New RequestTracker
liste.Period = 10 ' Her 10 saniyede
liste.MaxRequestsAllowedPerPeriod = 20 ' En fazla 20 istek
liste.BanFor = 10 ' Aşılması Halinde 5 saniye uzaklaştırma
liste.ListName = "Genel" ' Liste adı
liste.ListEntryTimeOut = 300 ' 300 saniye boyunca işlem yapmayan IP adresini listeden kaldır
liste.Track ' İzlemeyi başlat
%>
