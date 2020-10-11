<%
Sub arrUserList(counter, isim, kulad, mail, tarih, songiris, uyetipi, yetki, hit, kimlik, durum)
	Set arrJsonListe(Null) = jsObject()
	arrJsonListe(Null)("DT_RowId") = "trid_" & kimlik
	arrJsonListe(Null)("DT_RowClass") = ""
	arrJsonListe(Null)("counter") = "<label style=""display:block;"" for=""cb"& (counter-1) &""">"& counter &"</label>"
	arrJsonListe(Null)("checkbox") = "<input id=""cb"& (counter-1) &""" onclick=""isChecked("& (counter-1) &")"" value="""& kimlik &""" name=""postid[]"" type=""checkbox"" />"
	arrJsonListe(Null)("isim") = "<span id=""u"& kimlik &""">" & isim & "</span>"
	arrJsonListe(Null)("kulad") = kulad
	arrJsonListe(Null)("mail") = mail
	arrJsonListe(Null)("tarih") = tarih
	arrJsonListe(Null)("songiris") = songiris
	arrJsonListe(Null)("uyetipi") = uyetipi
	arrJsonListe(Null)("yetki") = yetki
	arrJsonListe(Null)("hit") = hit
	arrJsonListe(Null)("kimlik") = kimlik
	arrJsonListe(Null)("durum") = "<a id=""d"& kimlik &""" class="""& StatusStyle(durum, "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& (counter-1) &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a>"
	arrJsonListe(Null)("edit") = "<a class=""list-edit-icon"" href=""?mod="& GlobalConfig("General_Users") &"&amp;task=edit&amp;id="& kimlik & sLang & Debug &""" title=""Düzenle"">Düzenle</a>"
	arrJsonListe(Null)("sil") = "<a id=""d"& kimlik &""" class=""list-delete-icon taskListSubmit"" data-number="""& (counter-1) &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a>"
End Sub











'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(strPost("sSearch"), 1))
If inputSearch <> "" Then
	SearchSQL = SearchSQL & "WHERE ("
	SearchSQL = SearchSQL & "t1.adi like '%"& inputSearch &"%' Or "
	SearchSQL = SearchSQL & "t1.soyadi like '%"& inputSearch &"%' Or "
	SearchSQL = SearchSQL & "t1.kulad like '%"& inputSearch &"%' Or "
	SearchSQL = SearchSQL & "t1.mail like '%"& inputSearch &"%'"
	SearchSQL = SearchSQL & ")"
End If



'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count( * ) As Toplam FROM #___uyeler As t1 "

If SearchSQL <> "" Then SQL = SQL & SearchSQL

If Not (GlobalConfig("admin_username") = GlobalConfig("super_admin")) Then
	If SearchSQL <> "" Then SQL = SQL & " And" Else SQL = SQL & " WHERE"
	SQL = SQL & " Not kulad = '"& GlobalConfig("super_admin") &"' "
End If

SQL = SQL & ";"
'Clearfix SQL
ToplamCount = Cdbl(sqlQuery(SQL, 0))





'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT t1.id, /*t1.adi, t1.soyadi,*/ Trim(Concat(t1.adi, Concat(' ', t1.soyadi))) As isim, t1.kulad, t1.mail, /*t1.cinsiyet,*/ t1.tarih, t1.songiris, t1.uyetipi, t1.yetki, t1.hit, t1.durum "
SQL = SQL & "FROM #___uyeler As t1 "
If Not (GlobalConfig("admin_username") = GlobalConfig("super_admin")) Then _
	SQL = SQL & "INNER JOIN #___uyeler As t2 ON t1.id = t2.id And Not t2.kulad = '"& GlobalConfig("super_admin") &"' "

If SearchSQL <> "" Then SQL = SQL & SearchSQL

'// Ordering
If strPost("iSortCol_0") <> "" Then
	SQL = SQL & " "
	aColumns = Array("", "", "isim", "t1.kulad", "t1.mail", "t1.tarih", "t1.songiris", "t1.uyetipi", "t1.yetki", "t1.hit", "t1.id", "", "", "")

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
'Clearfix SQL
Set objRs = setExecute( SQL )

If Not objRs.Eof Then

	intCounter = intYap(strPost("iDisplayStart"), 0)
	Do While Not objRs.Eof

		intCounter = intCounter + 1

		If CBool(objRs("yetki")) Then UyeYetki = "Okuma/Yazma" Else UyeYetki = "Okuma"

		'If objRs("cinsiyet") = 0 Then addClass = " bayan" Else addClass = " erkek"
		'If objRs("cinsiyet") = 0 Then addCinsiyet = "Bayan" Else addCinsiyet = "Erkek"

		'If Not ((GlobalConfig("admin_username") <> GlobalConfig("super_admin")) And (objRs("kulad") = GlobalConfig("super_admin"))) Then

		CreateDate = objRs("tarih")
		SonGiris = objRs("songiris")

		If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
		If isDate(SonGiris) Then SonGiris = FormatDateTime(SonGiris, 2)

		'strTitle = objRs("adi") & " " & objRs("soyadi")
		strTitle = objRs("isim")
		If objRs("durum") = 0 Then strTitle = "<span class=""status-false"">"& strTitle &"</span>"


		arrUserList _
				intCounter, _
				strTitle, _
				objRs("kulad"), _
				objRs("mail"), _
				"<span class=""tooltip-text"" title="""& TarihFormatla(objRs("tarih")) &""">" & CreateDate & "</span>", _
				"<span class=""tooltip-text"" title="""& TarihFormatla(objRs("songiris")) &""">" & SonGiris & "</span>", _
				UyeTipi( objRs("uyetipi") ), _
				UyeYetki, _
				objRs("hit"), _
				objRs("id"), _
				objRs("durum")

	objRs.MoveNext() : Loop
End If
Set objRs = Nothing
%>
