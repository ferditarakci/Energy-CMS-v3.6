<%
Sub arrPollList(counter, title, sira, tarih, kimlik, secenek, durum)
	Set arrJsonListe(Null) = jsObject()
	arrJsonListe(Null)("DT_RowId") = "trid_" & kimlik
	arrJsonListe(Null)("DT_RowClass") = ""
	arrJsonListe(Null)("counter") = "<label style=""display:block;"" for=""cb"& (counter-1) &""">"& counter &"</label>"
	arrJsonListe(Null)("checkbox") = "<input id=""cb"& (counter-1) &""" onclick=""isChecked("& (counter-1) &")"" value="""& kimlik &""" name=""postid[]"" type=""checkbox"" />"
	arrJsonListe(Null)("title") = "<div id=""u"& kimlik &""">" & title & "</div>"
	arrJsonListe(Null)("sira") = "<input class=""inputbox list-order"" id=""order_"& kimlik &""" name=""order[]"" value="""& sira &""" maxlength=""4"" autocomplete=""off"" type=""number"" step=""1"" min=""0"" />"
	arrJsonListe(Null)("tarih") = tarih
	arrJsonListe(Null)("kimlik") = kimlik
	arrJsonListe(Null)("secenek") = secenek
	arrJsonListe(Null)("link") = "<a class=""url_list"" href=""?mod=url_list&amp;parent="& GlobalConfig("General_PollPN") &"&amp;parent_id="& kimlik & sLang & Debug &""" data-title="""" title=""Permalink Ekle / Düzenle"">Permalink Ekle / Düzenle</a>"
	arrJsonListe(Null)("durum") = "<a id=""d"& kimlik &""" class="""& StatusStyle(durum, "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& (counter-1) &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a>"
	arrJsonListe(Null)("edit") = "<a class=""list-edit-icon"" href=""?mod="& GlobalConfig("General_Poll") &"&amp;task=edit&amp;id="& kimlik & sLang & Debug &""" title=""Düzenle"">Düzenle</a>"
	arrJsonListe(Null)("sil") = "<a id=""d"& kimlik &""" class=""list-delete-icon taskListSubmit"" data-number="""& (counter-1) &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a>"
End Sub





'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(strPost("sSearch"), 1))
If inputSearch <> "" Then
	SearchSQL = SearchSQL & " And (t1.title like '%"& inputSearch &"%')"
End If


'// Toplam Kayıt Sayısını Alalım
ToplamCount = Cdbl(sqlQuery("SELECT Count( * ) As Toplam FROM #___anket As t1 WHERE t1.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0))


'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT t1.id, t1.title, t1.sira, t1.durum, t1.s_date, t1.e_date, t2.DateTimes As c_date, "
SQL = SQL & "(SELECT Count( secenekid ) FROM #___anket_secenek WHERE anketid = t1.id) As secenek "
SQL = SQL & "FROM #___anket t1 "
SQL = SQL & "LEFT JOIN #___content_revision_date t2 ON t1.id = t2.parent_id And t2.parent = "& GlobalConfig("General_PollPN") &" And t2.Revizyon = 1 "
SQL = SQL & "WHERE t1.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &" "

'// Ordering
If strPost("iSortCol_0") <> "" Then
	SQL = SQL & " "
	aColumns = Array("", "", "t1.title", "t1.sira", "t2.DateTimes", "t1.id", "secenek", "", "", "", "")

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

		intCounter = intCounter + 1' : intLevel = 0

		'For i = 0 To Ubound(arrTreeView)
		'		If Cdbl(arrTreeView(i)) = Cdbl(objRs("id")) Then
		'		intLevel = arrSubLevel(i)
		'		Exit For
		'	End If
		'Next

		'tempSpaces = ""
		'For y = 1 To intLevel * 2
		'	tempSpaces = tempSpaces & "&nbsp;"
		'Next
		'If intLevel > 0 Then tempSpaces = tempSpaces & "&#8212;&nbsp;"
		strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""

		strTitle = objRs("title")
		strTitle2 = ""'objRs("fixed_title")

		If strTitle2 <> "" Then strTitle2 = " title=""Seo Başlık: "& strTitle2 &"""" Else strTitle2 = " title="""& strTitle &"""" 

		If objRs("durum") > 0 Then
			strTitle = "<a"& strDirection &""& strTitle2 &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Poll"), "", "", Cdbl(objRs("id")), "", "") &""" target=""_blank"">"& strTitle &"</a>"
		Else
			strTitle = "<span"& strDirection &" class=""status-false"""& strTitle2 &">"& strTitle &"</span>"
		End If

		If Clng(objRs("secenek")) = 0 Then
			ToplamSecenek = "<span class=""red"">0</span>"
		Else
			ToplamSecenek = "<span class=""green"">"& objRs("secenek") &"</span>"
		End If

		CreateDate = objRs("c_date")
		StartDate = objRs("s_date")
		EndDate = objRs("e_date")

		If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
		If Not isDate(StartDate) Then StartDate = Null
		If Not isDate(EndDate) Then EndDate = Null

		ZamanAsimi = ""
		If DateDiff("s", StartDate, Now()) <= 1 Then
			ZamanAsimi = "<span class=""red tooltip"" title=""Başlama Tarihi : "& StartDate &"""> ( Tarihi Bekliyor )</span>"
		ElseIf DateDiff("s", EndDate, Now()) >= 1 Then
			ZamanAsimi = "<span class=""red tooltip"" title=""Bitiş Tarihi : "& EndDate &"""> ( Zaman Aşımına Uğradı )</span>"
		End If

arrPollList _
		intCounter, _
		strTitle & ZamanAsimi, _
		objRs("sira"), _
		"<span class=""tooltip-text"" title="""& TarihFormatla(objRs("c_date")) &""">" & CreateDate & "</span>", _
		objRs("id"), _
		ToplamSecenek, _
		objRs("durum")

	objRs.MoveNext() : Loop
End If
Set objRs = Nothing
%>
