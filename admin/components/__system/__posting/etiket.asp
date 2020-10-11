<%
'// Form nesnelerimi alalım
strPostTitle = Temizle(ClearHtml(Request.Form("title_")), 1)
strLink = Request.Form("permalink")
If strLink = "" Then strLink = strPostTitle
intDurum = intYap(Request.Form("durum"), 0)
strDesc = Temizle(ClearHtml(Request.Form("description")), 1)
strKeyword = Temizle(ClearHtml(Request.Form("keywords")), 1)
strMeta = Temizle(Request.Form("robots_meta"), 1)

'// Kontroller
If Len(strPostTitle) = 0 Then
	saveClass = "warning"
	saveMessage = "Lütfen bir etiket girin."

ElseIf Len(strPostTitle) > 60 Then
	saveClass = "warning"
	saveMessage = "Lütfen 60 karakterden daha kısa bir etiket girin."

ElseIf Len(strLink) > 60 Then
	saveClass = "warning"
	saveMessage = "Lütfen 60 karakterden daha kısa bir permalink ismi girin."

ElseIf Len(strDesc) > 160 Then
	saveClass = "warning"
	saveMessage = "Lütfen 160 karakterden daha kısa bir açıklama girin."

ElseIf Len(strKeyword) > 200 Then
	saveClass = "warning"
	saveMessage = "Lütfen 200 karakterden daha kısa anahtar kelime girin."

Else

	strLink = SefUrl(strLink)

	'// Formdan gelen IDye ait kayıt kontrolü yapıyoruz
	intGetRow = Cdbl(sqlQuery("SELECT id FROM #___etiket WHERE (etiket = '"& strPostTitle &"' And permalink = '"& strLink &"') Or (id = '"& pageid &"');", 0))
	If Not CBool(intGetRow) Then
		sqlExeCute("INSERT INTO #___etiket (etiket, permalink, status, description, keywords, robots_meta) VALUES ('"& strPostTitle &"', '"& strLink &"', "& intDurum &", '"& strDesc &"', '"& strKeyword &"', '"& strMeta &"');")
		intGetRow = Cdbl(sqlQuery("SELECT id FROM #___etiket ORDER BY id DESC Limit 1;", 0))
		Count = 1
	Else
		sqlExeCute("UPDATE #___etiket Set etiket = '"& strPostTitle &"', permalink = '"& strLink &"', status = "& intDurum &", description = '"& strDesc &"', keywords = '"& strKeyword &"', robots_meta = '"& strMeta &"' WHERE id = "& intGetRow &";")
		Count = 0
	End If

	pageid = intGetRow
	strLink = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", strLink, "", "", "")
End If



If Len(saveMessage) = 0 And pageid = 0 Then saveMessage = "Etiket Başarıyla Eklendi."
If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "Etiket Başarıyla Güncellendi."

Dim AddEtiket
Set AddEtiket = jsObject()
	AddEtiket("yeni") = Count
	AddEtiket("etiket_id") = pageid
	AddEtiket("etiket") = Duzenle(strPostTitle)
	AddEtiket("permalink") = strLink
	AddEtiket("status") = intDurum
	AddEtiket("cssClass") = saveClass
	AddEtiket("mesaj") = saveMessage
	AddEtiket.Flush
Set AddEtiket = Nothing

Response.End
%>
