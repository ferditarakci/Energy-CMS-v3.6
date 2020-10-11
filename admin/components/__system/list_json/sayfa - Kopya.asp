<%

Sub ArrPageList2( _
		counter, baslik, sira, _
		tema, tarih, kimlik, hit, _
		yorum, durum _
	)
	Set arrJsonListe(Null) = jsObject()
	arrJsonListe(Null)("DT_RowId") = "trid_" & kimlik
	arrJsonListe(Null)("DT_RowClass") = ""
	arrJsonListe(Null)("counter") = "<label style=""display:block;"" for=""cb"& (counter-1) &""">"& counter &"</label>"
	arrJsonListe(Null)("checkbox") = "<input id=""cb"& (counter-1) &""" onclick=""isChecked("& (counter-1) &")"" value="""& kimlik &""" name=""postid[]"" type=""checkbox"" />"
	arrJsonListe(Null)("baslik") = "<div id=""u"& kimlik &""">" & baslik & "</div>"
	arrJsonListe(Null)("sira") = "<input class=""inputbox list-order"" id=""order_"& kimlik &""" name=""order[]"" value="""& sira &""" maxlength=""4"" autocomplete=""off"" type=""number"" step=""1"" min=""0"" />"
	arrJsonListe(Null)("tema") = tema
	arrJsonListe(Null)("tarih") = tarih
	arrJsonListe(Null)("kimlik") = kimlik
	arrJsonListe(Null)("hit") = hit
	arrJsonListe(Null)("yorum") = "<a class=""comment-icon"" href=""?mod=yorum&amp;parent="& GlobalConfig("General_PagePN") &"&amp;parent_id="& kimlik & sLang & Debug &"""><span>"& yorum &"</span></a>"'"& baslik &"
	arrJsonListe(Null)("link") = "<a class=""url_list"" href=""?mod=url_list&amp;parent="& GlobalConfig("General_PagePN") &"&amp;parent_id="& kimlik & sLang & Debug &""" data-title="""" title=""Permalink Ekle / Düzenle"">Permalink Ekle / Düzenle</a>"
	arrJsonListe(Null)("durum") = "<a id=""d"& kimlik &""" class="""& StatusStyle(durum, "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& (counter-1) &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a>"
	arrJsonListe(Null)("edit") = "<a class=""list-edit-icon"" href=""?mod="& GlobalConfig("General_Page") &"&amp;task=edit&amp;id="& kimlik & sLang & Debug &""" title=""Düzenle"">Düzenle</a>"
	arrJsonListe(Null)("sil") = "<a id=""d"& kimlik &""" class=""list-delete-icon taskListSubmit"" data-number="""& (counter-1) &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a>"
End Sub

'Dim arrListPage3 : Set arrListPage3 = jsArray()
'Sub ArrPageList3(levels)
'	Set arrListPage3(Null) = jsArray()
'	arrListPage3(Null)("levels") = levels
'End Sub



'ViewsiD = intYap(strPost("views"), 0)

'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(strPost("sSearch"), 1))
If inputSearch <> "" Then
	SearchSQL = SearchSQL & " And (t2.title like '%"& inputSearch &"%')"
End If




'// Tree View List
'intCurr = 0
'SQL = ""
'SQL = SQL & "SELECT t1.id FROM #___sayfa t1 "
'SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
'SQL = SQL & "WHERE t1.anaid = {0} And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
'SQL = SQL & "ORDER BY t1.sira ASC, t1.id DESC;"
'Call TreeViewList(SQL, 0, 0)

'If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")












'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count( t1.id ) As Toplam FROM #___sayfa t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
If Not SearchSQL <> "" Then SQL = SQL & "And t1.anaid = 0" & vbCrLf
SQL = SQL & SearchSQL &" "
SQL = SQL & ";"
ToplamCount = Cdbl(sqlQuery(SQL, 0))



'// Bilgisayara Cookie Bırakalım
'Call getAdminCookie(mods & "_sayfa")



Public Sub SayfaListele(ByVal intAnaid, ByVal intLevel, ByVal counters)

'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "t1.id, t1.sira, t1.ozel, t1.durum, t1.anasyf, t5.DateTimes As c_date, t1.s_date, t1.e_date," & vbCrLf
SQL = SQL & "t2.title, t2.fixed_title, t2.hit, t3.title As typetitle, IFNULL(t4.title, '') As typeTitleHome" & vbCrLf
SQL = SQL & ", (SELECT Count(id) FROM #___yorum WHERE parent = "& GlobalConfig("General_PagePN") &" And parent_id = t1.id) As yorum" & vbCrLf
SQL = SQL & "FROM #___sayfa t1" & vbCrLf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_template t3 ON t1.typeAlias = t3.alias And (t3.parent = "& GlobalConfig("General_PagePN") &" Or t3.parent = 0)" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_home_template t4 ON t1.anasyfAlias = t4.alias And (t4.parent = "& GlobalConfig("General_PagePN") &")" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_revision_date t5 ON t1.id = t5.parent_id And t5.parent = "& GlobalConfig("General_PagePN") &" And t5.Revizyon = 1" & vbCrLf

SQL = SQL & "WHERE " & vbCrLf
SQL = SQL & "t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_PagePN") &"'" & vbCrLf
If Not SearchSQL <> "" Then SQL = SQL & "And t1.anaid = "& intAnaid &"" & vbCrLf
SQL = SQL & SearchSQL &" "

'// Ordering
If strPost("iSortCol_0") <> "" Then
	SQL = SQL & " "
	aColumns = Array("", "", "t2.title", "t1.sira", "t3.title", "t5.DateTimes", "t1.id", "t2.hit", "yorum", "", "", "", "")

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




'Clearfix strPost("iDisplayStart")



'// Paging
if strPost("iDisplayStart") <> "" And intYap(strPost("iDisplayLength"), 0) > 0 Then
	SQL = SQL & "Limit " & intYap(strPost("iDisplayStart"), 0) & ", " & intYap(strPost("iDisplayLength"), 0)
End If
'SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi

SQL = SQL & ";"

'SQL = setQuery( SQL )
'Clearfix setQuery( SQL )
'For Each item in strPost()
'	a = a & item & " : " & Request.Form(item) & "" & vbCrLf
'Next
'Clearfix a
Dim objRs
Set objRs = setExecute( SQL )

If Not objRs.Eof Then

	intCounter = counters + intYap(Request.Form("iDisplayStart"), 0)
	Do While Not objRs.Eof

		intCounter = intCounter + 1 ': intLevel = 0

		'For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

		tempSpaces = ""
		For y = 1 To intLevel * 3
			tempSpaces = tempSpaces & "&nbsp;"
		Next
		If intLevel > 0 Then tempSpaces = tempSpaces & "&#8211;&nbsp;"

		'For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

		'spaces = 1 * intLevel

		strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
		'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""

		strTitle = Cstr(objRs("title"))
		If objRs("durum") > 0 Then 'tempSpaces & 
			strTitle = "<a"& strDirection &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", "") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"
		Else
			strTitle = "<span"& strDirection &" class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
		End If

		CreateDate = objRs("c_date")
		'StartDate = objRs("s_date")
		'EndDate = objRs("e_date")

		If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
		'If Not isDate(StartDate) Then StartDate = Null
		'If Not isDate(EndDate) Then EndDate = Null

		'ZamanAsimi = ""
		'If DateDiff("s", StartDate, Now()) <= 1 Then
		'	ZamanAsimi = "<span class=""red tooltip"" title=""Başlama Tarihi : "& StartDate &"""> ( Tarihi Bekliyor )</span>"
		'ElseIf DateDiff("s", EndDate, Now()) >= 1 Then
		'	ZamanAsimi = "<span class=""red tooltip"" title=""Bitiş Tarihi : "& EndDate &"""> ( Zaman Aşımına Uğradı )</span>"
		'End If
'UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", "")



typetitle = objRs("typetitle")

If objRs("typeTitleHome") <> "" Then _
	typetitle = typetitle & "<br /><i class=""red"" style=""display:block; padding:2px 0;"">"& objRs("typetitleHome") &"</i>"

'If Not inputSearch <> "" Then strTitle = strTitle & AltSayfa(objRs("id"), 0, 0)



ArrPageList2 _
		intCounter, _
		tempSpaces & strTitle, _
		objRs("sira"), _
		typetitle, _
		"<span class=""tooltip-text"" title="""& TarihFormatla(objRs("c_date")) &""">"& CreateDate &"</span>", _
		objRs("id"), _
		objRs("hit"), _
		objRs("yorum"), _
		objRs("durum")


		If Not SearchSQL <> "" Then  Call SayfaListele(objRs("id"), intLevel +1, intCounter + 1)

	objRs.MoveNext() : Loop
End If
Set objRs = Nothing






End Sub




Call SayfaListele(0, 0, 0)





Private Function AltSayfa(ByVal intAnaid, ByVal intLevel, ByVal counters)
	Dim sSQL, objSubRs, i, y, tempSpaces, strSelected, strDisabled, counter, strSubTitle, subtypetitle
'	sSQL = ""
'	'sSQL = sSQL & "SELECT t1.id, t1.durum, t2.title, 0 As c_date FROM #___sayfa t1 "
'	sSQL = sSQL & "SELECT "
'	sSQL = sSQL & "t1.id, t1.sira, t1.ozel, t1.durum, t1.anasyf, Now() As c_date, t1.s_date, t1.e_date," & vbCrLf
'	sSQL = sSQL & "t2.title, t2.fixed_title, t2.hit, '' As typetitle, '' As typeTitleHome" & vbCrLf
'	sSQL = sSQL & "FROM #___sayfa t1 "
'	sSQL = sSQL & "LEFT JOIN #___content t2 ON t1.id = t2.parent_id "
'	sSQL = sSQL & "WHERE t1.anaid = "& intAnaid &" And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
'	sSQL = sSQL & "ORDER BY t1.sira ASC, t1.id DESC;"

sSQL = ""
sSQL = sSQL & "SELECT" & vbCrLf
sSQL = sSQL & "t1.id, t1.sira, t1.ozel, t1.durum, t1.anasyf, t5.DateTimes As c_date, t1.s_date, t1.e_date," & vbCrLf
sSQL = sSQL & "t2.title, t2.fixed_title, t2.hit, t3.title As typetitle, IFNULL(t4.title, '') As typeTitleHome" & vbCrLf
sSQL = sSQL & ", (SELECT Count(id) FROM #___yorum WHERE parent = "& GlobalConfig("General_PagePN") &" And parent_id = t1.id) As yorum" & vbCrLf
sSQL = sSQL & "FROM #___sayfa t1" & vbCrLf
sSQL = sSQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
sSQL = sSQL & "LEFT JOIN #___content_template t3 ON t1.typeAlias = t3.alias And (t3.parent = "& GlobalConfig("General_PagePN") &" Or t3.parent = 0)" & vbCrLf
sSQL = sSQL & "LEFT JOIN #___content_home_template t4 ON t1.anasyfAlias = t4.alias And (t4.parent = "& GlobalConfig("General_PagePN") &")" & vbCrLf
sSQL = sSQL & "LEFT JOIN #___content_revision_date t5 ON t1.id = t5.parent_id And t5.parent = "& GlobalConfig("General_PagePN") &" And t5.Revizyon = 1" & vbCrLf
sSQL = sSQL & "WHERE t1.anaid = "& intAnaid &" And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
'sSQL = sSQL & "ORDER BY t1.sira ASC, t1.id DESC;"

'// Ordering
If strPost("iSortCol_0") <> "" Then
	sSQL = sSQL & " "
	aColumns = Array("", "", "t2.title", "t1.sira", "t3.title", "t5.DateTimes", "t1.id", "t2.hit", "yorum", "", "", "", "")

	For i = 0 to intYap(strPost("iSortingCols"), 0)
		iSortCol = intYap(strPost("iSortCol_" & i), 0)
		If strPost("bSortable_" & iSortCol ) = "true" Then
			If i = 0 Then sSQL = sSQL & "ORDER BY "
				sSQL = sSQL & aColumns( iSortCol )
			If i > 0 Then sSQL = sSQL & ", "
			sSQL = sSQL & " " & strPost("sSortDir_" & i) & " "
		End If
	Next
End If



	'sSQL = setQuery( sSQL )
	Set objSubRs = setExecute( sSQL )
		Do While Not objSubRs.Eof
			counters = counters + 1
			tempSpaces = ""
			For y = 1 To intLevel * 5
				tempSpaces = tempSpaces & "&nbsp;"
			Next
			'If intLevel > 0 Then tempSpaces = tempSpaces & "&#8211;"


		CreateDate = objSubRs("c_date")
		'StartDate = objRs("s_date")
		'EndDate = objRs("e_date")

		If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)

			strSubTitle = Cstr(objSubRs("title"))
			If objSubRs("durum") > 0 Then 'tempSpaces & 
				strSubTitle = "<a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objSubRs("id"), "", "") &""" title="""& strSubTitle &""" target=""_blank"">"& strSubTitle &"</a>"
			Else
				strSubTitle = "<span class=""status-false"" title="""& strSubTitle &""">"& strSubTitle &"</span>"
			End If

subtypetitle = objSubRs("typetitle")

'If objSubRs("typeTitleHome") <> "" Then _
'	subtypetitle = subtypetitle & "<br /><i class=""red"" style=""display:block; padding:2px 0;"">"& objSubRs("typetitleHome") &"</i>"


			'ArrPageList2 _
			'		intCounter, _
			'		strSubTitle, _
			'		objSubRs("sira"), _
			'		subtypetitle, _
			'		"<span class=""tooltip-text"" title="""& TarihFormatla(objSubRs("c_date")) &""">"& CreateDate &"</span>", _
			'		objSubRs("id"), _
			'		0, _
			'		0, _
			'		objSubRs("durum")

			AltSayfa = AltSayfa & "<div class=""toggle_sublist "& TabloModClass(counters) &""" id=""sub_"& objSubRs("id") &""" style=""overflow:hidden; padding:1px 0 1px;"">"
				AltSayfa = AltSayfa & "<div style=""float:left; padding:1px 0 1px;"">"& tempSpaces &"<label><input value="""& objSubRs("id") &""" name=""postid[]"" type=""checkbox"" /></label></div>"
				AltSayfa = AltSayfa & "<div style=""padding:1px 0 1px;"">"
					AltSayfa = AltSayfa & "<div style=""float:right; padding:1px 0 1px;"">"
						AltSayfa = AltSayfa & "<a class=""comment-icon"" href=""?mod=yorum&amp;parent="& GlobalConfig("General_PagePN") &"&amp;parent_id="& objSubRs("id") & sLang & Debug &"""><span>"& objSubRs("yorum") &"</span></a>&nbsp;"
						AltSayfa = AltSayfa & "<a class=""url_list"" href=""?mod=url_list&amp;parent="& GlobalConfig("General_PagePN") &"&amp;parent_id="& objSubRs("id") & sLang & Debug &""" data-title="""" title=""Permalink Ekle / Düzenle"">Permalink Ekle / Düzenle</a>&nbsp;"
						AltSayfa = AltSayfa & "<a id=""d"& objSubRs("id") &""" class="""& StatusStyle(objSubRs("durum"), "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& (counter-1) &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a>&nbsp;"
						AltSayfa = AltSayfa & "<a class=""list-edit-icon"" href=""?mod="& GlobalConfig("General_Page") &"&amp;task=edit&amp;id="& objSubRs("id") & sLang & Debug &""" title=""Düzenle"">Düzenle</a>&nbsp;"
						AltSayfa = AltSayfa & "<a id=""d"& objSubRs("id") &""" class=""list-delete-icon taskListSubmit"" data-number="""& (counter-1) &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a>"
					AltSayfa = AltSayfa & "</div>"
					AltSayfa = AltSayfa & "<div style=""float:left; padding:1px 0 1px;"">" & strSubTitle & "</div>"
				AltSayfa = AltSayfa & "</div>"
			AltSayfa = AltSayfa & "</div>"
			'Response.Write("<option"& strDisabled & strSelected &" value="""& objSubRs("id") &""">"& tempSpaces & " " & BasHarfBuyuk(objSubRs("title")) &"</option>")

			AltSayfa = AltSayfa & AltSayfa(objSubRs("id"), intLevel +1, counters + 1)

		objSubRs.MoveNext() : Loop
	Set objSubRs = Nothing
End Function
%>
