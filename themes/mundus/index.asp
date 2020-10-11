<!--#include file="function.asp"--><%

'Clearfix GlobalConfig("request_option")
Select Case GlobalConfig("request_option")

	Case GlobalConfig("General_Default"), GlobalConfig("General_Home")

		If GlobalConfig("General_introPage") And GlobalConfig("request_option") = GlobalConfig("General_Default") Then

			%><!--#include file="intro.asp"--><%

		Else

			%><!--#include file="home.asp"--><%

		End If

	Case GlobalConfig("General_Page")
	%><!--#include file="page.asp"--><%

	Case GlobalConfig("General_Tags")
	%><!--#include file="etiketler.asp"--><%


	Case GlobalConfig("General_Categories")
	%><!--#include file="kategori.asp"--><%


	Case GlobalConfig("General_Products")
	%><!--#include file="urun.asp"--><%


	Case GlobalConfig("General_Search")
	%><!--#include file="search.asp"--><%


	Case GlobalConfig("General_Poll")
	%><!--#include file="anket.asp"--><%


	Case GlobalConfig("General_Post")
	%><!--#include file="files/post.asp"--><%


	Case GlobalConfig("General_Redirect")
	%><!--#include file="files/redirect.asp"--><%


	Case GlobalConfig("General_Rss")
	%><!--#include file="files/rss.asp"--><%


	Case GlobalConfig("General_Sitemap")
	
	%><!--#include file="files/sitemap.asp"--><%

	Case GlobalConfig("General_Whois"), GlobalConfig("General_Whois2")
	%><!--#include file="whois.asp"--><%

	Case GlobalConfig("General_Xml")
	%><!--#include file="flash/flash-xml.asp"--><%


	Case Else
	%><!--#include file="404.asp"--><%

End Select

%>
