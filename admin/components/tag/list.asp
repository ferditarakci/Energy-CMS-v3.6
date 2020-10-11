<%
Sub ArrPageList3(counter, etiket, kimlik, durum)
	Set arrJsonListe(Null) = jsObject()
	arrJsonListe(Null)("DT_RowId") = "trid_" & kimlik
	arrJsonListe(Null)("DT_RowClass") = ""
	arrJsonListe(Null)("counter") = "<label style=""display:block;"" for=""cb"& (counter-1) &""">"& counter &"</label>"
	arrJsonListe(Null)("checkbox") = "<input id=""cb"& (counter-1) &""" onclick=""isChecked("& (counter-1) &")"" value="""& kimlik &""" name=""postid[]"" type=""checkbox"" />"
	arrJsonListe(Null)("etiket") = "<div id=""u"& kimlik &""">" & etiket & "</div>"
	arrJsonListe(Null)("kimlik") = kimlik
	arrJsonListe(Null)("durum") = "<a id=""d"& kimlik &""" class="""& StatusStyle(durum, "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& (counter-1) &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a>"
	arrJsonListe(Null)("edit") = "<a class=""list-edit-icon EditEnergyTag"" href=""#"" title=""Düzenle"">Düzenle</a>"
	arrJsonListe(Null)("sil") = "<a id=""d"& kimlik &""" class=""list-delete-icon taskListSubmit"" data-number="""& (counter-1) &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a>"
End Sub





'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(strPost("sSearch"), 1))
If inputSearch <> "" Then
	SearchSQL = SearchSQL & " And (etiket like '%"& inputSearch &"%')"
End If




'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count(id) As Toplam FROM #___etiket "
SQL = SQL & "WHERE hit > -1 "

Select Case ViewsiD
	Case 1 SQL = SQL & "And status = 1 " & vbCrLf
	Case 2 SQL = SQL & "And status = 0 " & vbCrLf
End Select

SQL = SQL & ""& SearchSQL &" "
SQL = SQL & ";"
ToplamCount = Cdbl(sqlQuery(SQL, 0))






'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "id, etiket, permalink, status" & vbCrLf
SQL = SQL & "FROM #___etiket" & vbCrLf
SQL = SQL & "WHERE hit > -1 "& SearchSQL &"" & vbCrLf

'Select Case ViewsiD
'	Case 1 SQL = SQL & "And status = 1 " & vbCrLf
'	Case 2 SQL = SQL & "And status = 0 " & vbCrLf
'End Select





'// Ordering
If strPost("iSortCol_0") <> "" Then
	SQL = SQL & " "
	aColumns = Array("", "", "etiket", "id", "", "", "")

	For i = 0 to intYap(strPost("iSortingCols"), 0)
		iSortCol = intYap(strPost("iSortCol_" & i), 0)
		If strPost("bSortable_" & iSortCol ) = "true" Then
			If i = 0 Then SQL = SQL & "ORDER BY "
				SQL = SQL & aColumns( iSortCol )
			If i > 0 Then SQL = SQL & ", "
			SQL = SQL & " " & strPost("sSortDir_" & i) & " "
		End If
	Next
End If

'// Paging
if strPost("iDisplayStart") <> "" And intYap(strPost("iDisplayLength"), 0) > 0 Then
	SQL = SQL & "Limit " & intYap(strPost("iDisplayStart"), 0) & ", " & intYap(strPost("iDisplayLength"), 0)
End If

SQL = SQL & ";"

Set objRs = setExecute( SQL )

If Not objRs.Eof Then

	intCounter = intYap(strPost("iDisplayStart"), 0)
	Do While Not objRs.Eof

		intCounter = intCounter + 1 : intLevel = 0

		For i = 0 To Ubound(arrTreeView)
				If Cdbl(arrTreeView(i)) = Cdbl(objRs("id")) Then
				intLevel = arrSubLevel(i)
				Exit For
			End If
		Next

		tempSpaces = ""
		For y = 1 To intLevel * 2
			tempSpaces = tempSpaces & "&nbsp;"
		Next
		If intLevel > 0 Then tempSpaces = tempSpaces & "&#8212;&nbsp;"
		strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""

		strTitle = objRs("etiket")
		strTitle2 = ""'objRs("fixed_title")

		If strTitle2 <> "" Then strTitle2 = " title=""Seo Başlık: "& strTitle2 &"""" Else strTitle2 = " title="""& strTitle &"""" 

		If objRs("status") > 0 Then
			strTitle = "<a"& strDirection &""& strTitle2 &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", objRs("permalink"), "", "", "") &""" target=""_blank"">"& strTitle &"</a>"
		Else
			strTitle = "<span"& strDirection &" class=""status-false"""& strTitle2 &">"& strTitle &"</span>"
		End If

		'CreateDate = objRs("c_date")
		'StartDate = objRs("s_date")
		'EndDate = objRs("e_date")

		'If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
		'If Not isDate(StartDate) Then StartDate = Null
		'If Not isDate(EndDate) Then EndDate = Null

		'ZamanAsimi = ""
		'If DateDiff("s", StartDate, Now()) <= 1 Then
		'	ZamanAsimi = "<span class=""red tooltip"" title=""Başlama Tarihi : "& StartDate &"""> ( Tarihi Bekliyor )</span>"
		'ElseIf DateDiff("s", EndDate, Now()) >= 1 Then
		'	ZamanAsimi = "<span class=""red tooltip"" title=""Bitiş Tarihi : "& EndDate &"""> ( Zaman Aşımına Uğradı )</span>"
		'End If

		'typetitle = objRs("typetitle")

		'If objRs("typeTitleHome") <> "" Then _
		'	typetitle = typetitle & "<br /><i class=""red"" style=""display:block; padding:2px 0;"">"& objRs("typetitleHome") &"</i>"

ArrPageList3 _
		intCounter, _
		strTitle, _
		objRs("id"), _
		objRs("status")

	objRs.MoveNext() : Loop
End If
Set objRs = Nothing
%>
