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

Dim strAltMetin
strAltMetin = Temizle(Request.Form("alt_metin"), 1)

strLink = Temizle(Request.Form("url"), 1)
strText = Temizle(Request.Form("text"), 0)

strLng = Temizle(Request.Form("lang"), 1) : If strLng = "" Then strLng = GlobalConfig("site_lang")

Dim strBannerResim, strBannerTuru, intBannerYeri
strBannerResim = Temizle(Request.Form("images"), 1)
strBannerTuru = Temizle(Request.Form("tur"), 1)
intBannerYeri = intYap(Request.Form("yer"), 0)

'// Form kontrollerimizi yapalım
If GlobalConfig("MaxBanner") <= sqlQuery("SELECT Count(id) FROM #___banner WHERE lang = '"& strLng &"';", 0) And pageid = 0 Then
	saveClass = "warning"
	saveMessage = "Maksimun banner ekleme sınırını aştınız. Toplam "& GlobalConfig("MaxBanner") &" adet banner ekleyebilirsiniz."

ElseIf Len(strPostTitle) = 0 Then
	saveClass = "warning"
	saveMessage = "Lütfen bir başlık girin."

ElseIf Len(strPostTitle) > 150 Then
	saveClass = "warning"
	saveMessage = "Başlık çok uzun, lütfen kısaltın."

ElseIf intSira < 0 Or intSira > 999 Then
	saveClass = "warning"
	saveMessage = "Geçersiz sıra numarası girdiniz {1} ile {999} arasında bir numara girmelisin."

'ElseIf Not isDate(CreateDate) Then
'	saveClass = "warning"
'	saveMessage = "Lütfen geçerli oluşturma tarihi girin."

'ElseIf Not isDate(ModifiedDate) And pageid > 0 Then
'	saveClass = "warning"
'	saveMessage = "Lütfen geçerli güncelleme tarihi girin."

'ElseIf (ozelsayfa = 2 And Len(pass) = 0) Then
'	saveClass = "warning"
'	saveMessage = "Parola Korumalı kayıt için geçerli bir şifre girin."

'ElseIf (ozelsayfa = 2 And Len(pass) < 4) Then
'	saveClass = "warning"
'	saveMessage = "Parola minimun 4 karekter olmalı."

ElseIf Len(strBannerResim) = 0 Then
	saveClass = "warning"
	saveMessage = "Lütfen bir görsel ekleyin."

ElseIf Len(strBannerTuru) = 0 Then
	saveClass = "warning"
	saveMessage = "Lütfen banner türü seçin."

Else

	'// Formdan gelen IDye ait kayıt kontrolü yapıyoruz
	intGetRow = Cdbl(sqlQuery("SELECT id FROM #___banner WHERE id = "& pageid &";", 0))
	If Not CBool(intGetRow) Then

		'// Yeni kayıt oluşturuyoruz
		SQL = ""
		SQL = SQL & "INSERT INTO #___banner "
		SQL = SQL & "("
		SQL = SQL & "lang, title, sira, durum, yer, tur, img, alt, url, s_date, e_date, text "
		SQL = SQL & ") VALUES ("
		SQL = SQL & "'"& strLng &"', '"& strPostTitle &"', "& intSira &", "& intDurum &", '"& intBannerYeri &"', '"& strBannerTuru &"', "
		SQL = SQL & "'"& strBannerResim &"', '"& strAltMetin &"', '"& strLink &"', "& StartDate &", "& EndDate &", '"& strText &"'"
		SQL = SQL & ");"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = Cdbl(sqlQuery("SELECT id FROM #___banner ORDER BY id DESC Limit 1;", 0))
		Call RevisionDate(GlobalConfig("General_BannerPN"), saveid, 1) '// 1 Insert -- 2 Revision

	Else

		'// Yeni kayıt oluşturuyoruz
		SQL = ""
		SQL = SQL & "UPDATE #___banner Set "
		SQL = SQL & "lang = '"& strLng &"', title = '"& strPostTitle &"', sira = "& intSira &", durum = "& intDurum &", "
		SQL = SQL & "yer = '"& intBannerYeri &"', tur = '"& strBannerTuru &"', img = '"& strBannerResim &"', "
		SQL = SQL & "alt = '"& strAltMetin &"', url = '"& strLink &"', s_date = "& StartDate &", e_date = "& EndDate &", "
		SQL = SQL & "text = '"& strText &"' WHERE id = "& intGetRow &";"
		'SQL = setQuery( SQL )
		sqlExeCute( SQL )
		saveid = intGetRow
		Call RevisionDate(GlobalConfig("General_BannerPN"), saveid, 2) '// 1 Insert -- 2 Revision

	End If
	Session("pageid") = saveid

	If Len(saveMessage) = 0 And pageid = 0 Then saveMessage = "Banner Başarıyla Eklendi."
	If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "Banner Başarıyla Güncellendi."

End If
%>
