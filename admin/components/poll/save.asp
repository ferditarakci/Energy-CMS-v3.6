<%
'// Form nesnelerimi alalım

intSira = intYap(Request.Form("sira"), 0)

'CreateDate = DateSqlFormat(Request.Form("cDate"), "yy-mm-dd", 1)
'If Not isDate(CreateDate) Then CreateDate = DateSqlFormat(Now(), "yy-mm-dd", 1)

'ModifiedDate = DateSqlFormat(Request.Form("mDate"), "yy-mm-dd", 1)
'If Not isDate(ModifiedDate) Then ModifiedDate = DateSqlFormat(Now(), "yy-mm-dd", 1)
'ModifiedDate = DateSqlFormat(Now(), "yy-mm-dd", 1)

StartDate = DateSqlFormat(Request.Form("sDate"), "yy-mm-dd", 1)
If Not isDate(StartDate) Then StartDate = "Null" Else StartDate = "'"& StartDate &"'"

EndDate = DateSqlFormat(Request.Form("eDate"), "yy-mm-dd", 1)
If Not isDate(EndDate) Then EndDate = "Null" Else EndDate = "'"& EndDate &"'"

strPostTitle = Temizle(ClearHtml(Request.Form("title_")), 1)
intDurum = intYap(Request.Form("durum"), 0)
strText = Temizle(Request.Form("text"), 0)

strLng = Temizle(Request.Form("lang"), 1) : If strLng = "" Then strLng = GlobalConfig("site_lang")

'// Form kontrollerimizi yapalım
If GlobalConfig("MaxPoll") <= sqlQuery("SELECT Count(id) FROM #___anket WHERE lang = '"& strLng &"';", 0) And pageid = 0 Then
	saveClass = "warning"
	saveMessage = "Maksimun anket ekleme sınırını aştınız. Toplam "& GlobalConfig("MaxPoll") &" adet anket ekleyebilirsiniz."

ElseIf Len(strPostTitle) = 0 Then
	saveClass = "warning"
	saveMessage = "Anket için bir soru girmelisin."' & sqlQuery("SELECT Count(id) FROM #___anket WHERE lang = '"& strLng &"';", 0)

ElseIf Len(strPostTitle) > 150 Then
	saveClass = "warning"
	saveMessage = "Soru çok uzun, lütfen kısaltın."

ElseIf Request.Form("secenek_title[]").Count < 2 Then
	saveClass = "warning"
	saveMessage = "Anket için en az iki seçenek eklemelisin."

ElseIf Len(Request.Form("secenek_title[]")(1)) < 3 Or Len(Request.Form("secenek_title[]")(2)) < 3 Then
	saveClass = "warning"
	saveMessage = "Anket için en az iki seçenek alanını doldurmalısın."

ElseIf intSira < 0 Or intSira > 999 Then
	saveClass = "warning"
	saveMessage = "Geçersiz sıra numarası girdiniz {1} ile {999} arasında bir numara girmelisin."

'ElseIf Not isDate(CreateDate) Then
'	saveClass = "warning"
'	saveMessage = "Lütfen geçerli oluşturma tarihi girin."

'ElseIf Not isDate(ModifiedDate) And pageid > 0 Then
'	saveClass = "warning"
'	saveMessage = "Lütfen geçerli güncelleme tarihi girin."

'ElseIf ozelsayfa = 2 And Len(pass) = 0 Then
'	saveClass = "warning"
'	saveMessage = "Parola Korumalı kayıt için geçerli bir şifre girin."

'ElseIf ozelsayfa = 2 And Len(pass) < 4 Then
'	saveClass = "warning"
'	saveMessage = "Parola minimun 4 karekter olmalı."

Else

	'If ozelsayfa < 2 Then pass = ""

	'// Formdan gelen IDye ait kayıt kontrolü yapıyoruz
	intGetRow = Cdbl(sqlQuery("SELECT id FROM #___anket WHERE id = "& pageid &";", 0))
	If Not CBool(intGetRow) Then

		'// Yeni kayıt oluşturuyoruz
		SQL = ""
		SQL = SQL & "INSERT INTO #___anket "
		SQL = SQL & "("
		SQL = SQL & "lang, title, sira, durum, s_date, e_date, text "
		SQL = SQL & ") VALUES ("
		SQL = SQL & "'"& strLng &"', '"& strPostTitle &"', "& intSira &", "& intDurum &", "& StartDate &", "& EndDate &", '"& strText &"'"
		SQL = SQL & ");"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = Cdbl(sqlQuery("SELECT id FROM #___anket ORDER BY id DESC Limit 1;", 0))
		Call RevisionDate(GlobalConfig("General_PollPN"), saveid, 1) '// 1 Insert -- 2 Revision

		'sqlExeCute("INSERT INTO #___content (lang, parent, parent_id, title) VALUES ('"& GlobalConfig("default_lang") &"', '"& GlobalConfig("General_PollPN") &"', "& saveid &", '( Başlık yok )');")

	Else

		'// Yeni kayıt oluşturuyoruz
		SQL = ""
		SQL = SQL & "UPDATE #___anket Set "
		SQL = SQL & "lang = '"& strLng &"', "
		SQL = SQL & "title = '"& strPostTitle &"', "
		SQL = SQL & "sira = "& intSira &", "
		SQL = SQL & "durum = "& intDurum &", "
		SQL = SQL & "s_date = "& StartDate &", "
		SQL = SQL & "e_date = "& EndDate &", "
		SQL = SQL & "text = '"& strText &"' "
		SQL = SQL & "WHERE id = "& intGetRow &";"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = intGetRow
		Call RevisionDate(GlobalConfig("General_PollPN"), saveid, 2) '// 1 Insert -- 2 Revision

	End If
	Session("pageid") = saveid

	'// *********************************************************** //'

	strLink = Request.Form("seflink_")

	'// Permalink
	'If Not LCase(Left(strLink, 4)) = "url=" Then

		If strLink = "" Then strLink = strPostTitle

		'strLink = SefUrl( strLink )

		'If strLink = "" Then
		'	If Not _
		'		GlobalConfig("default_lang") = "AR" Or _
		'		GlobalConfig("default_lang") = "JA" Or _
		'		GlobalConfig("default_lang") = "CN" _
		'	Then _
		'	strLink = Trim(AjaxTurkish(Request.Form("seflink_"& UCase(GlobalConfig("default_lang")))))
			'If strLink = "" Then strLink = strPostTitle
		'End If

		'If strLng = "AR" And strLink = "" Then strLink = "ewy-arabic-page-" & saveid
		'If strLng = "JA" And strLink = "" Then strLink = "ewy-japanese-page-" & saveid
		'If strLng = "CN" And strLink = "" Then strLink = "ewy-chinese-page-" & saveid

		strLink = SefUrl( strLink )
		'If strLink = "" Then strLink = "ewy-" & GlobalConfig("General_Poll") & "-" & saveid

		strLink = Newid("anket", strLink, GlobalConfig("General_PollPN"), saveid, strLng)

	'End If

	'// Permalink işlemleri
	sqlExeCute("UPDATE #___content_url Set durum = 0 WHERE (durum = 1 And parent_id = "& saveid &" And parent = "& GlobalConfig("General_PollPN") &" And lang = '"& strLng &"');")

	If Not strPostTitle = "" Then
		intGetLinkRow = CdbL(sqlQuery("SELECT id FROM #___content_url WHERE (parent_id = "& saveid &" And parent = "& GlobalConfig("General_PollPN") &" And lang = '"& strLng &"' And seflink = '"& strLink &"');", 0))
		If intGetLinkRow = 0 Then
			sqlExeCute("INSERT INTO #___content_url (parent, parent_id, lang, seflink, durum) VALUES ("& GlobalConfig("General_PollPN") &", "& saveid &", '"& strLng &"', '"& strLink &"', 1);")
		Else
			sqlExeCute("UPDATE #___content_url Set durum = 1 WHERE id = "& intGetLinkRow &";")
		End If
	End If

	'// *********************************************************** //'

	Dim strSoruSecenek, arrSecenekid
	arrSecenekid = Array()
	Count = 1
	For Each item in Request.Form("secenekid[]")

		strSoruSecenek = Temizle(Request.Form("secenek_title[]")(Count), 1)
		intOy = intYap(Request.Form("hit[]")(Count), 1)

		If strSoruSecenek = "" Then sqlExeCute("DELETE FROM #___anket_secenek WHERE secenekid = "& item &";")

		If Not strSoruSecenek = "" Then

			intGetContentRow = CdbL(sqlQuery("SELECT secenekid, anketid, secenek, oy FROM #___anket_secenek WHERE secenekid = "& item &";", 0))

			If intGetContentRow = 0 Then

				sqlExeCute("INSERT INTO #___anket_secenek (anketid, secenek, oy) VALUES ("& saveid &", '"& strSoruSecenek &"', "& intOy &");")
				intCurr = UBound(arrSecenekid) + 1
				Redim Preserve arrSecenekid( intCurr )
				arrSecenekid( intCurr ) = CdbL(sqlQuery("SELECT secenekid FROM #___anket_secenek WHERE anketid = "& saveid &" ORDER BY secenekid DESC Limit 1;", 0))

			Else

				sqlExeCute("UPDATE #___anket_secenek Set secenek = '"& strSoruSecenek &"', oy = "& intOy &" WHERE secenekid = "& item &";")
				intCurr = UBound(arrSecenekid) + 1
				Redim Preserve arrSecenekid( intCurr )
				arrSecenekid( intCurr ) = item

			End If

		End If

		Count = Count + 1
	Next

	If Len(saveMessage) = 0 And pageid = 0 Then saveMessage = "Anket Başarıyla Oluşturuldu." & " {---} " & Join(arrSecenekid, ", ")
	If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "Anket Başarıyla Güncellendi." & " {---} " & Join(arrSecenekid, ", ")

End If
%>
