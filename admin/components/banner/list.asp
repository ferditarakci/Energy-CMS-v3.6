<%
Sub arrBannerList(counter, title, sira, resim, tarih, hit, yer, kimlik, durum)
	Set arrJsonListe(Null) = jsObject()
	arrJsonListe(Null)("DT_RowId") = "trid_" & kimlik
	arrJsonListe(Null)("DT_RowClass") = ""
	arrJsonListe(Null)("counter") = "<label style=""display:block;"" for=""cb"& (counter-1) &""">"& counter &"</label>"
	arrJsonListe(Null)("checkbox") = "<input id=""cb"& (counter-1) &""" onclick=""isChecked("& (counter-1) &")"" value="""& kimlik &""" name=""postid[]"" type=""checkbox"" />"
	arrJsonListe(Null)("title") = "<div id=""u"& kimlik &""">" & title & "</div>"
	arrJsonListe(Null)("sira") = "<input class=""inputbox list-order"" id=""order_"& kimlik &""" name=""order[]"" value="""& sira &""" maxlength=""4"" autocomplete=""off"" type=""number"" step=""1"" min=""0"" />"
	arrJsonListe(Null)("resim") = resim
	arrJsonListe(Null)("tarih") = tarih
	arrJsonListe(Null)("hit") = hit
	arrJsonListe(Null)("yer") = yer
	arrJsonListe(Null)("kimlik") = kimlik
	arrJsonListe(Null)("durum") = "<a id=""d"& kimlik &""" class="""& StatusStyle(durum, "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& (counter-1) &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a>"
	arrJsonListe(Null)("edit") = "<a class=""list-edit-icon"" href=""?mod="& GlobalConfig("General_Banner") &"&amp;task=edit&amp;id="& kimlik & sLang & Debug &""" title=""Düzenle"">Düzenle</a>"
	arrJsonListe(Null)("sil") = "<a id=""d"& kimlik &""" class=""list-delete-icon taskListSubmit"" data-number="""& (counter-1) &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a>"
End Sub




'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(strPost("sSearch"), 1))
If inputSearch <> "" Then
	SearchSQL = SearchSQL & " And (t1.title like '%"& inputSearch &"%')"
End If


'// Toplam Kayıt Sayısını Alalım
ToplamCount = Cdbl(sqlQuery("SELECT Count( * ) As Toplam FROM #___banner As t1 WHERE t1.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0))


'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT t1.*, t2.DateTimes As c_date "
SQL = SQL & "FROM #___banner t1 "
SQL = SQL & "LEFT JOIN #___content_revision_date t2 ON t1.id = t2.parent_id And t2.parent = "& GlobalConfig("General_BannerPN") &" And t2.Revizyon = 1 "
SQL = SQL & "WHERE t1.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &" "

'// Ordering
If strPost("iSortCol_0") <> "" Then
	SQL = SQL & " "
	aColumns = Array("", "", "t1.title", "t1.sira", "", "t2.DateTimes", "t1.hit", "t1.yer", "t1.id", "", "", "")

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
		'strTitle2 = ""'objRs("fixed_title")

		'If strTitle2 <> "" Then strTitle2 = " title=""Seo Başlık: "& strTitle2 &"""" Else strTitle2 = " title="""& strTitle &"""" 

		If CBool(objRs("durum")) And CBool(Len(objRs("url"))) Then
			strTitle = "<a"& strDirection &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Redirect"), GlobalConfig("General_Banner"), "", objRs("id"), "", "") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"

		ElseIf Not CBool(objRs("durum")) And CBool(Len(objRs("url"))) Then
			strTitle = "<span class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
		End If

		If Not FilesKontrol(bFolder & "/" & objRs("img")) Then
			imgPath = "<a class=""list-picture-icon tooltip-text none"" href=""#"" title=""Resim Yok"">&nbsp;</a>"
		Else
			imgPath = "<a class=""list-picture-icon tooltip-text"" href=""#"" title="""& Server.HtmlEncode("<img class=""max-width"" src="""& bFolder & "/" & objRs("img") &""" />") &""">&nbsp;</a>"
		End If

		Select Case objRs("yer")
			Case 0 BannerYeri = "Üst"
			Case 1 BannerYeri = "Orta"
			Case 2 BannerYeri = "Alt"
			Case Else BannerYeri = objRs("yer")
		End Select

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

'arrBannerList(counter, title, sira, resim, tarih, hit, yer, kimlik, durum)
arrBannerList _
		intCounter, _
		strTitle & ZamanAsimi, _
		objRs("sira"), _
		imgPath, _
		"<span class=""tooltip-text"" title="""& TarihFormatla(objRs("c_date")) &""">" & CreateDate & "</span>", _
		objRs("hit"), _
		BannerYeri, _
		objRs("id"), _
		objRs("durum")

	objRs.MoveNext() : Loop
End If
Set objRs = Nothing
%>
