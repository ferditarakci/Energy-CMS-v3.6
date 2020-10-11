<%
'Dim strName, strTelNo, strMail, strKonu, strMesaj, strBanadaGonder, strMesajTarih, ajaxCssClass, ajaxMessages, strKontrol, strHtmlBody

strName = Temizle(ClearHtml(Request.Form("author")), -1)
strMail = Temizle(ClearHtml(Request.Form("email")), -1)
strLinks = Temizle(ClearHtml(Request.Form("url")), -1)
strMesaj = TextBR(Temizle(Request.Form("comment"), -1))

parent = intYap(Request.Form("comment_page"), 0)
intid = intYap(Request.Form("comment_page_id"), 0)
parent_id = intYap(Request.Form("comment_parentid"), 0)

'strKonu = Temizle(ClearHtml(Request.Form("info_konu")), -1)
'strBanadaGonder = Request.Form("info_banadayolla")
'strMesajTarih = TarihFormatla(Now())

ajaxCssClass = ""
ajaxMessages = ""

'strKontrol = _
'	inStr(1, Request.Form("info_isim"), "<script", 1) Or _
'	inStr(1, Request.Form("info_tel"), "<script", 1) Or _
'	inStr(1, Request.Form("info_mail"), "<script", 1) Or _
'	inStr(1, Request.Form("info_konu"), "<script", 1) Or _
'	inStr(1, Request.Form("info_mesaj"), "<script", 1) Or _
'	inStr(1, Request.Form("info_isim"), "<a", 1) Or _
'	inStr(1, Request.Form("info_tel"), "<a", 1) Or _
'	inStr(1, Request.Form("info_mail"), "<a", 1) Or _
'	inStr(1, Request.Form("info_konu"), "<a", 1) Or _
'	inStr(1, Request.Form("info_mesaj"), "<a", 1)

' Kontroller başlıyor
'If strKontrol Then
'	ajaxCssClass = "warning"
'	ajaxMessages = Lang("info_err_html")
Set arrListPage = jsArray() : arrListPage2 = "undefined"
If strName = "" Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_isim")

ElseIf Len(strName) < 3 Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_isim2")

ElseIf Not isValidEMail(strMail) Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_mail")

'ElseIf strLinks = "" Then
'	ajaxCssClass = "error"
'	ajaxMessages = Lang("info_err_konu")

ElseIf strMesaj = "" Then
	ajaxCssClass = "error"
	ajaxMessages = Lang("info_err_mesaj")

Else


With Response
	.Cookies("comment")("name") = strName
	.Cookies("comment")("mail") = strMail
	.Cookies("comment")("web") = strLinks
	.Cookies("comment").Path = GlobalConfig("sRoot")
	.Cookies("comment").Expires = Now() + 365
End With


strCDate = Now()

SQL = ""
SQL = SQL & "INSERT INTO #___yorum ("
SQL = SQL & "lang, parent, parent_id,  comment_author, comment_author_email, comment_author_url, "
SQL = SQL & "comment_author_ip, comment_text, comment_status, user_id, comment_parent_id, c_date, m_date, anahtar"
SQL = SQL & ") "
SQL = SQL & "VALUES('"& GlobalConfig("site_lang") &"', '"& parent &"', '"& intid &"', "
SQL = SQL & "'"& strName &"', '"& strMail &"', '"& strLinks &"', '"& Site_REMOTE_ADDR &"', '"& strMesaj &"', 1, "
SQL = SQL & "0, "& parent_id &", '"& DateSqlFormat(strCDate, "yy-mm-dd", 1) &"', Null, '');"
'Clearfix sql
sqlExecute SQL

ajaxCssClass = "success"
ajaxMessages = "Yorumunuz başarıyla eklendi..."

strName = Replace(Lang("comment_list_author"), "[author]", strName)
If strLinks <> "" Then
	strName = Replace(strName, "[url]", "<a href="""& strLinks &""">")
	strName = Replace(strName, "[/url]", "</a>")
Else
	strName = Replace(strName, "[url]", "")
	strName = Replace(strName, "[/url]", "")
End If



	Set arrListPage(Null) = jsObject()
	arrListPage(Null)("id") = sqlQuery("SELECT last_insert_id();", 0)
	arrListPage(Null)("author") = strName
	arrListPage(Null)("email") = strMail
	'arrListPage(Null)("url") = strLinks
	arrListPage(Null)("tarih1") = strCDate
	arrListPage(Null)("tarih2") = TarihFormatla(strCDate)
	arrListPage(Null)("comment") = strMesaj
	arrListPage(Null)("comment_page_id") = parent
	arrListPage(Null)("comment_parentid") = intid
	arrListPage2 = Array(arrListPage)
	Set arrListPage = Nothing

End If
Call CommentPost(ajaxCssClass, ajaxMessages, arrListPage2)

%>
