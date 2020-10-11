<%

If Not Len(Request.Form()) > 0 Then
	'Call RedirectToUrl(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("request_option"), GlobalConfig("request_task"), GlobalConfig("request_title"), GlobalConfig("request_globalid"), "", ""))
	ErrMsg Lang("post_err")
End If


Response.Clear()
Response.ContentType = "text/plain"


Select Case GlobalConfig("request_task")

	Case "anket"
	%><!--#include file="post/anket_html.asp"--><%



	Case "mail-ekle"
	%><!--#include file="post/mailist_html.asp"--><%



	Case "comment-post"
	%><!--#include file="post/comment_html.asp"--><%	



	Case "iletisim"
	%><!--#include file="post/iletisim_html.asp"--><%	



	'Case Else
		'Response.Redirect(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", "", "", ""))
		'ErrMsg Lang("post_err")
		
End Select
%>
