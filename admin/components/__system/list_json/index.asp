﻿<%
'If Not blnPostMethod Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
'On Error Resume Next

Response.Clear()
Response.ContentType = "text/plain"

Dim arrJsonListe
Set arrJsonListe = jsArray()

Dim aColumns, iSortCol, typetitle

'// Yetki kotrolü yapalım
If Not GlobalConfig("admin_yetki") Then

	Response.Clear()
	jMessage = GlobalConfig("admin_yetki_message")
	jAddClass = "warning"

	Call ArrJSON(0, "", "", "")
	'Call JsonFlush(arrListPost)
	'Call CloseDatabase(data)
	'Response.End()

End If

jPostid = 0
jCount = 0
jOrder = 0

jBoxChecked = Request.Form("boxchecked")
jApply = Request.Form("apply")
jApply2 = ""

jUrl = ""
'jAddClass = "success"
'jMessage = ""
jTitle = ""
If task = "menu" Then jBoxChecked = "menu"
'clearfix Request.Form("menuid").Count
If jBoxChecked <> "" Or GlobalConfig("admin_yetki") Then

	Select Case task

		Case GlobalConfig("General_Categories")

		%><!--#include file="categories.asp"--><%

		Case GlobalConfig("General_Products")

		%><!--#include file="products.asp"--><%

		Case GlobalConfig("General_Page")

		%><!--#include file="sayfa.asp"--><%

		Case GlobalConfig("General_Poll")

		%><!--#include file="poll.asp"--><%

		Case GlobalConfig("General_Banner")

		%><!--#include file="banner.asp"--><%

		Case GlobalConfig("General_Mailist")

		%><!--#include file="mailist.asp"--><%

		Case GlobalConfig("General_Users")

		%><!--#include file="user.asp"--><%

		Case GlobalConfig("General_Tags")

		%><!--#include file="etiket.asp"--><%

		Case GlobalConfig("General_Whois")

		%><!--#include file="whois.asp"--><%

		Case "menu"

		%><!--#include file="menu.asp"--><%

		Case "yorum"

		%><!--#include file="yorum.asp"--><%

		Case Else

			Response.Clear()
			jMessage = "Üzgünüm :( Bir hata oluştu, belirtilen yol bulunamadı."
			jAddClass = "warning"
			Call ArrJSON(0, "", "", "")
			'Call JsonFlush(arrListPost)
			'Call CloseDatabase(data)
			'Response.End()

	End Select

End If


If Err <> 0 Then

	Response.Clear()
	jMessage = "Üzgünüm :( Bir hata oluştu, Hata Kodu: " & Err.Description
	jAddClass = "error"
	'Call ArrJSON(0, "", "", "")
	'Call JsonFlush(arrListPost)
	'Response.End()

End If

'If task = "menu" Then jBoxChecked = "menu"
On Error GoTo 0


Set oJSon = jsObject()
	oJSon("sEcho") = intYap(Request.Form("sEcho"), 0)
	oJSon("iTotalRecords") = ToplamCount
	oJSon("iTotalDisplayRecords") = ToplamCount'Cdbl(sqlQuery("SELECT FOUND_ROWS()", 0))
	'oJSon("PageStart") = intLimitStart
	oJSon("aaData") = Array(arrJsonListe)
	oJSon.Flush
%>






