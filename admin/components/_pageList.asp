<%
If Not blnPostMethod Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
Response.Clear()
Response.ContentType = "text/plain"

Dim arrListPage : Set arrListPage = jsArray()
Sub ArrPageList(ByVal strLevel, ByVal strTitle, ByVal strUrl)
	Set arrListPage(Null) = jsObject()
	arrListPage(Null)("levels") = strLevel
	arrListPage(Null)("title") = strTitle
	arrListPage(Null)("url") = strUrl
End Sub


ViewsiD = intYap(Request.Form("views"), 0)
'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(Request.Form("search"), 1))
If inputSearch <> "" Then
	'arrSearch = Split(inputSearch, " ")
	'SearchSQL = " And ("
	'For Each i in arrSearch : SearchSQL = SearchSQL & "t2.title like '%"& i &"%' Or " : Next
	'SearchSQL = Left(SearchSQL, Len(SearchSQL) -4) & ")"
	SearchSQL = " And (t2.title like '%"& inputSearch &"%')"
End If
'response.write typename(SearchSQL)


'// Tree View List
intCurr = 0
SQL = ""
SQL = SQL & "SELECT t1.id FROM #___sayfa t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t1.anaid = {0} And t1.durum = 1 And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
SQL = SQL & "ORDER BY t1.sira ASC, t1.id DESC;"
Call TreeViewList(SQL, 0, 0)

If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")



'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count( t1.id ) As Toplam FROM #___sayfa t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t1.durum = 1 And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "

'Select Case ViewsiD
'	Case 1 SQL = SQL & "And t1.durum = 1 " & vbCrLf
'	Case 2 SQL = SQL & "And t1.durum = 0 " & vbCrLf
'	Case 3 SQL = SQL & "And t1.remove = 1 " & vbCrLf
'End Select

SQL = SQL & ""& SearchSQL &" "
SQL = SQL & ";"
ToplamCount = Cdbl(sqlQuery(SQL, 0))



'// Bilgisayara Cookie Bırakalım
Call getAdminCookie(mods)


'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT " & vbCrLf
SQL = SQL & "t1.id, t2.title" & vbCrLf
SQL = SQL & "FROM #___sayfa t1 " & vbCrLf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id " & vbCrLf
'SQL = SQL & "LEFT JOIN #___content_template t3 ON t1.typeAlias = t3.alias And (t3.nerde = "& GlobalConfig("General_PagePN") &" Or t3.nerde = 0) " & vbCrLf
'SQL = SQL & "LEFT JOIN #___content_revision_date t4 ON t1.id = t4.parent_id And t4.parent = "& GlobalConfig("General_PagePN") &" And t4.Revizyon = 1 " & vbCrLf
'SQL = SQL & "INNER JOIN #___languages t5 ON (t5.durum = -1 Or t5.durum = 1) And t2.lang = t5.lng " & vbCrLf

SQL = SQL & "WHERE " & vbCrLf
SQL = SQL & "t1.durum = 1 And /*t5.lng = '"& GlobalConfig("site_lang") &"' And*/ t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = "& GlobalConfig("General_PagePN") &" "& SearchSQL &" " & vbCrLf

'Select Case ViewsiD
	'Case 1 SQL = SQL & "And (t1.durum = -1 Or t1.durum = 1) " & vbCrLf
'	Case 2 SQL = SQL & "And t1.durum = 0 " & vbCrLf
'	Case 3 SQL = SQL & "And (t1.remove = -1 Or t1.remove = 1) " & vbCrLf
'End Select

If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(t1.id, "& TreeViewShort &") " & vbCrLf

SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi

SQL = SQL & ";"

'SQL = setQuery( SQL )
'Clearfix SQL
Set objRs = setExecute( SQL )

	If Not objRs.Eof Then

		intCounter = intLimitStart
		Do While Not objRs.Eof

			intCounter = intCounter + 1 : intLevel = 0

			For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

			spaces = 1 * intLevel ': tempSpaces = ""

			'For y = 1 To spaces : tempSpaces = tempSpaces & "&ndash;&ndash;" : Next : If intLevel > 0 Then tempSpaces = tempSpaces & "&nbsp;"

			'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
			'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""

			strTitle = Cstr(objRs("title")) ': If strTitle = "" Then strTitle = "( Başlık yok )"

			strLink = URLDecode(UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", ""))

			Call ArrPageList(spaces, BasHarfBuyuk(strTitle), strLink)

		objRs.MoveNext() : Loop

'Response.Write( Sayfala(ToplamCount, intSayfaSayisi, intSayfaNo) )
End If
Set objRs = Nothing
'arrListPage.Flush
'Response.Write Err.Description


	If (ToplamCount/intSayfaSayisi = int(ToplamCount/intSayfaSayisi)) Then
		ToplamCount = int(ToplamCount/intSayfaSayisi)
	Else
		ToplamCount = int(ToplamCount/intSayfaSayisi) + 1
	End If

	'If intSayfaNumarasi > intToplamSayfaSayisi Then intSayfaNumarasi = intToplamSayfaSayisi


Dim oJSon, xcfddg
Set oJSon = jsObject()
	oJSon("PageNumber") = ToplamCount
	oJSon("PageStart") = intLimitStart
	oJSon("PageList") = Array(arrListPage)
	oJSon.Flush
'Response.end


%>

