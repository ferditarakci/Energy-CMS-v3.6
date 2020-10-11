<%
Dim Lang, EnergyLangCookie
Set Lang = Server.CreateObject("Scripting.Dictionary")

Select Case GlobalConfig("site_lang")
	Case "", "TR"
	%>
		<!--#include file="tr/genel.asp"-->
		<!--#include file="tr/iletisim.asp"-->
		<!--#include file="tr/anket.asp"-->
		<!--#include file="tr/sayfa.asp"-->
		<!--#include file="tr/yorum.asp"-->
		<!--#include file="tr/kategori.asp"-->

	<%
	'Case Else
		'Response.Write("<div style=""display:block; text-align:center; background-color:#ff0; color:000;"">Bir Hata Oluştu...<br />Statik Dil Dosyası Yüklenemedi.</div>")

End Select







Select Case GlobalConfig("request_option")

	Case GlobalConfig("General_Tags")
		'// Etiket Title Write
		GlobalConfig("cpathway") = Replace(GlobalConfig("cpathway"), "[EtiketTitle]", UCase2(Lang("EtiketTitle")))

	Case GlobalConfig("General_Search")
		'// Search Title Write
		GlobalConfig("cpathway") = Replace(GlobalConfig("cpathway"), "[AramaTitle]", UCase2(Lang("ara_title")))

End Select












%>
