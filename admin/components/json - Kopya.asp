<%
Response.Clear()
Response.ContentType = "text/plain"


Dim arrListPage2 : Set arrListPage2 = jsArray()
Sub ArrPageList2( _
		levels, _
		kimlik, _
		baslik, _
		sira, _
		tema, _
		izin, _
		tarih, _
		hit, _
		yorum, _
		link)

	Set arrListPage2(Null) = jsArray()
	arrListPage2(Null)("levels") = levels
	arrListPage2(Null)("kimlik") = kimlik
	arrListPage2(Null)("baslik") = baslik
	arrListPage2(Null)("sira") = sira
	arrListPage2(Null)("tema") = tema
	arrListPage2(Null)("izin") = izin
	arrListPage2(Null)("tarih") = tarih
	arrListPage2(Null)("hit") = hit
	arrListPage2(Null)("yorum") = yorum
	arrListPage2(Null)("link") = link
End Sub



ViewsiD = intYap(Request.Form("views"), 0)

'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(Request.Form("search"), 1))
If inputSearch <> "" Then
	arrSearch = Split(inputSearch, " ")
	SearchSQL = " And ("
	For Each i in arrSearch : SearchSQL = SearchSQL & "t2.title like '%"& i &"%' Or " : Next
	SearchSQL = Left(SearchSQL, Len(SearchSQL) -4) & ")"
End If

'response.write typename(SearchSQL)

'// Tree View List
intCurr = 0
SQL = ""
SQL = SQL & "SELECT t1.id FROM #___sayfa t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t1.anaid = {0} And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
SQL = SQL & "ORDER BY t1.sira ASC, t1.id DESC;"
Call TreeViewList(SQL, 0, 0)

If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")












'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count( t1.id ) As Toplam FROM #___sayfa t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "

Select Case ViewsiD
	Case 1 SQL = SQL & "And t1.durum = 1 " & vbCrLf
	Case 2 SQL = SQL & "And t1.durum = 0 " & vbCrLf
	Case 3 SQL = SQL & "And t1.remove = 1 " & vbCrLf
End Select

SQL = SQL & ""& SearchSQL &" "
SQL = SQL & ";"
ToplamCount = Cdbl(sqlQuery(SQL, 0))



'// Bilgisayara Cookie Bırakalım
Call getAdminCookie(mods & "_sayfa")



'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "t1.id, t1.sira, t1.ozel, t1.durum, t1.anasyf, /*date_format(t1.c_date, '%d.%m.%Y') As*/ t5.DateTimes As c_date, t1.s_date, t1.e_date," & vbCrLf
SQL = SQL & "t2.title, t2.fixed_title, t2.hit, t3.title As typetitle, IFNULL(t4.title, '') As typeTitleHome" & vbCrLf
SQL = SQL & ", (SELECT Count(id) FROM #___yorum WHERE parent = "& GlobalConfig("General_PagePN") &" And parent_id = t1.id) As yorum" & vbCrLf
SQL = SQL & "FROM #___sayfa t1" & vbCrLf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_template t3 ON t1.typeAlias = t3.alias And (t3.parent = "& GlobalConfig("General_PagePN") &" Or t3.parent = 0)" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_home_template t4 ON t1.anasyfAlias = t4.alias And (t4.parent = "& GlobalConfig("General_PagePN") &")" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_revision_date t5 ON t1.id = t5.parent_id And t5.parent = "& GlobalConfig("General_PagePN") &" And t5.Revizyon = 1" & vbCrLf

SQL = SQL & "WHERE " & vbCrLf
SQL = SQL & "t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_PagePN") &"' "& SearchSQL &"" & vbCrLf

Select Case ViewsiD
	Case 1 SQL = SQL & "And t1.durum = 1" & vbCrLf
	Case 2 SQL = SQL & "And t1.durum = 0" & vbCrLf
	Case 3 SQL = SQL & "And t1.remove = 1" & vbCrLf
End Select

If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(t1.id, "& TreeViewShort &")" & vbCrLf

SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi

SQL = SQL & ";"

'SQL = setQuery( SQL )
'Clearfix SQL

Set objRs = setExecute( SQL )

If Not objRs.Eof Then

	intCounter = intLimitStart
	Do While Not objRs.Eof

		intCounter = intCounter + 1 : intLevel = 0

		'For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

		'tempSpaces = ""
		'For y = 1 To intLevel * 3
		'	tempSpaces = tempSpaces & "&nbsp;"
		'Next
		'If intLevel > 0 Then tempSpaces = tempSpaces & "&#8211;"

		For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

		spaces = 1 * intLevel


		'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
		strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""


		strTitle = Cstr(objRs("title")) ': If strTitle = "" Then strTitle = "( Başlık yok )"
		'strTitle2 = Cstr(objRs("fixed_title")) ': If strTitle = "" Then strTitle = "( Başlık yok )"
		
		'If strTitle2 = "" Then strTitle2 = strTitle
		'If CBool(objRs("durum")) Then
			'strTitle = "<a"& strDirection &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", "") &""" title="""& strTitle2 &""" target=""_blank"">"& strTitle &"</a>"
		'Else
			'strTitle = "<span"& strDirection &" class=""status-false"" title="""& strTitle2 &""">"& strTitle &"</span>"
		'End If

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

		'Response.Write("<tr id=""trid_"& objRs("id") &""" class="""& TabloModClass(intCounter) &""">" & vbcrlf)
		'Response.Write("		<td><label style=""display:block;"" for=""cb"& intCounter-1 &""">"& intCounter &"</label></td>" & vbcrlf)
		'Response.Write("		<td><input id=""cb"& intCounter-1 &""" onclick=""isChecked("& intCounter-1 &")"" name=""postid[]"" value="""& objRs("id") &""" type=""checkbox"" /></td>" & vbcrlf) 
		'Response.Write("		<td class=""left"">"& tempSpaces &" <div"& strDirection &" style=""display:inline;"" id=""u"& objRs("id") &""">"& strTitle &"</div>"& ZamanAsimi &"</td>" & vbcrlf) 
		'Response.Write("		<td><input class=""inputbox list-order"" id=""order_"& objRs("id") &""" name=""order[]"" value="""& objRs("sira") &""" maxlength=""4"" autocomplete=""off"" type=""text"" /></td>" & vbcrlf) 
		'Response.Write("		<td class=""left nowrap"">"& objRs("typetitle") )
		'If objRs("typeTitleHome") <> "" Then _
		'Response.Write("<br /><span class=""red"" style=""display:block; padding:2px 0;"">"& objRs("typetitleHome") &"</span>")
		'Response.Write("</td>" & vbcrlf)
		'Response.Write("		<td class=""nowrap"">"& Gorunurluk(objRs("ozel")) &"</td>" & vbcrlf)
		'Response.Write("		<td class=""nowrap""><span class=""tooltip-text"" title="""& TarihFormatla(objRs("c_date")) &""">"& CreateDate &"</span></td>" & vbcrlf) 
		'Response.Write("		<td>"& objRs("id") &"</td>" & vbcrlf)
		'Response.Write("		<td>"& objRs("hit") &"</td>" & vbcrlf)
		'Response.Write("		<td><a class=""comment-icon"" href=""?mod=yorum&amp;parent="& GlobalConfig("General_PagePN") &"&amp;parent_id="& objRs("id") & sLang & Debug &"""><span>"& objRs("yorum") &"</span></a></td>" & vbcrlf) ' onclick=""listItemTask("& intCounter-1 &", 'durum', '')""
		'Response.Write("		<td><a class=""url_list"" href=""?mod=url_list&amp;parent="& GlobalConfig("General_PagePN") &"&amp;parent_id="& objRs("id") & sLang & Debug &""" data-title="""& objRs("title") &""" title=""Permalink Ekle / Düzenle"">Permalink Ekle / Düzenle</a></td>" & vbcrlf) ' onclick=""listItemTask("& intCounter-1 &", 'durum', '')""
		'Response.Write("		<td id=""d"& objRs("id") &"""><a class="""& StatusStyle(objRs("durum"), "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a></td>" & vbcrlf) 
		'Response.Write("		<td><a class=""list-edit-icon"" href=""?mod="& mods &"&amp;task=edit&amp;id="& objRs("id") & sLang & Debug &""" title=""Düzenle"">Düzenle</a></td>" & vbcrlf) 
		'Response.Write("		<td><a class=""list-delete-icon taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a></td>" & vbcrlf) ' onclick=""if(confirm('Dikkat! #"& intCounter &" Numaralı Kayıt Silinecektir. Devam Edilsin mi?')){listItemTask("& intCounter-1 &", 'delete', '');}""
		'Response.Write("	</tr>" & vbcrlf)

		ArrPageList2 _
			intCounter, _
			objRs("id"), _
			BasHarfBuyuk(strTitle), _
			objRs("sira"), _
			objRs("typetitle"), _
			Gorunurluk(objRs("ozel")), _
			CreateDate, _
			objRs("hit"), _
			objRs("yorum"), _
			UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", "")

	objRs.MoveNext() : Loop
End If
Set objRs = Nothing 

	If (ToplamCount/intSayfaSayisi = int(ToplamCount/intSayfaSayisi)) Then
		ToplamCount = int(ToplamCount/intSayfaSayisi)
	Else
		ToplamCount = int(ToplamCount/intSayfaSayisi) + 1
	End If

	'If intSayfaNumarasi > intToplamSayfaSayisi Then intSayfaNumarasi = intToplamSayfaSayisi


Set oJSon = jsObject()
	'oJSon("sEcho") = ToplamCount
	'oJSon("iTotalRecords") = ToplamCount
	'oJSon("iTotalDisplayRecords") = intLimitStart
	'oJSon("PageStart") = intLimitStart
	oJSon("aaData") = Array(arrListPage2)
	oJSon.Flush



%>
