<!--#include file="header.asp"-->

	<div id="ewy_maincolumn" class="content">
		<div class="ewy_nopad">
			<%
			If GlobalConfig("request_option") = GlobalConfig("General_Whois2") Then Response.Clear

'With New DomWhois2
'	.DomainName = GlobalConfig("request_domain")
	'Response.Write "<br/>Domain : "& .DomainName
	'Response.Write "<br/>Domain Uzantısı : "& .DomainUzanti
	'Response.Write "<br/>Domain Whois Server : "& .WhoisServer
	'Response.Write "<br/>Domain Durumu : "& .DomainDurumu
'	strText = .DomainBilgisi
'End With

strTitle = UCase2(GlobalConfig("request_domain") & " WHOIS BİLGİLERİ")
strCDate = Now()

'strText = Replace(strText, "<pre>", "<pre style=""border:0 !important; overflow:auto !important; height:auto !important; max-height:1500px; !important; background:none !important;"">")

strText = "<p><b>" & GlobalConfig("request_domain") & "</b> whois bilgileri" & "</p>"
strText = strText & "<p><b>" & GlobalConfig("request_domain") & "</b> Alan adı kayıt bilgileri" & "</p>"
strText = strText & "<p><br />Şuan bu hizmeti veremmiyoruz, bu durumdam dolayı özür dileriz.</p>"

With Response
	.Write("<div class=""contents"">" & vbCrLf)
	'.Write("	<div class=""sutun clearfix"">" & vbCrLf)
	'.Write("		<div class=""orta"">" & vbCrLf)
	'.Write("			<div class=""background"">" & vbCrLf)

	'strSharedUrl = Replace(Server.UrlEncode(GlobalConfig("site_uri")), "%2E", ".")

	'.Write("			<div class=""share-button clearfix"">" & vbCrLf)
	'.Write("				<div class=""tweet_share""><a href=""#"" onclick=""window.open('http://twitter.com/?status="& Server.UrlEncode(BasHarfBuyuk(strTitle)) &" - "& strSharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Twitter&apos;da Paylaş"" target=""_blank"">Twitter&apos;da Paylaş</a></div>" & vbCrLf)
	'.Write("				<div class=""face_share""><a href=""#"" onclick=""window.open('http://www.facebook.com/sharer.php?u="& strSharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Facebook&apos;da Paylaş"" target=""_blank"">Facebook&apos;da Paylaş</a></div>" & vbCrLf)
	'If Site_REMOTE_ADDR = "127.0.0.1" Then _
	'.Write("				<div class=""face_like""><iframe style=""border:none; overflow:hidden; width:110px; height:21px"" src=""http://www.facebook.com/plugins/like.php?href="& strSharedUrl &"&amp;layout=button_count&amp;show_faces=true&amp;width=110&amp;action=like&amp;colorscheme=light&amp;height=21"" frameborder=""0"" scrolling=""no""></iframe></div>" & vbCrLf)
	'.Write("			</div>" & vbCrLf)

	'.Write("			<h2 class=""title""><a href="""& GlobalConfig("site_uri") &""" title="""& strTitle &""">"& strTitle &"</a></h2>" & vbCrLf) 
	.Write("			<abbr title="""& strCDate &""" class=""date hidden"">"& TarihFormatla( strCDate ) &"</abbr>" & vbCrLf)
	.Write("			<div class=""clr""></div>" & vbCrLf)

	.Write( strText )
	.Write( vbCrLf )

	.Write("				<div class=""clr""></div>" & vbCrLf)
	'.Write("			</div>" & vbCrLf)
	'.Write("		</div>" & vbCrLf)
	'.Write("	</div>" & vbCrLf)
	.Write("</div>" & vbCrLf)
End With


If GlobalConfig("request_option") = GlobalConfig("General_Whois2") Then Response.End

'Set Kontrol = New DomWhois
'	Kontrol.DomainName = Trim(Server.HTMLEncode(task)) ' Request("d")
		'Response.Write "<br/>Domain : "& Kontrol.DomainName
		'Response.Write "<br/>Domain Uzantısı : "& Kontrol.DomainUzanti
		'Response.Write "<br/>Domain Whois Server : "& Kontrol.WhoisServer
		'Response.Write "<br/>Domain Durumu : "& Kontrol.DomainDurumu
'	Response.Write "<pre>"& Kontrol.DomainBilgisi &"</pre>"
'Set Kontrol = Nothing

'Response.Clear
'With New DomWhois2
'	.DomainName = GlobalConfig("request_domain")
	'Response.Write "<br/>Domain : "& .DomainName
	'Response.Write "<br/>Domain Uzantısı : "& .DomainUzanti
	'Response.Write "<br/>Domain Whois Server : "& .WhoisServer
	'Response.Write "<br/>Domain Durumu : "& .DomainDurumu
'	Response.Write .DomainBilgisi
'End With
'Response.End

'Response.Clear
'Response.Write("sf" & "<BR />")
'Response.end
'	Dim myWhois
'	Set myWhois = Server.CreateObject("Dynu.Whois")

	'The below line will display the whois information of domain "microsoft.com" 
	'Exactly as received from whois server without the copyright clause.
	'Response.Write(myWhois.Whois("tekniktrafik.com.tr") & "<br />")
	'Response.Write(myWhois.WhoisHtml("tekniktrafik.com.tr") & "<br />")

	'myWhois.SetAvailableString "This domain is available"

	'The below line will check to see if domain name "dynu.com" is available.
'	If myWhois.isAvailable("tekniktrafik.com") Then
'		Response.Write("Alan Adı Müsait <br />")
'	Else
'		Response.Write("Alan Adı Müsait Değil <br />")
'	End If

	'The below line will set the copyright clause to be shown.
	'myWhois.RemoveCopyright = False
	'myWhois.RemoveCopyright = True

	'myWhois.SetEndCopyright "by this policy."

	'The below line will set the whois server to "whois.tonic.to".
'	Response.Write(myWhois.SetServer("whois.verisign-grs.com"))

	'The below line will set the whois server port to 43.
'	myWhois.SetPort 43

	'The below line will display the whois information for "memory.to" HTML formatted.
	'Response.Write(myWhois.Whois("tekniktrafik.com.tr") & "<br />")
'	Response.Write(vbCrLf & Replace(mywhois.WhoisHtml("tekniktrafik.com"), "PRE>", "pre>") & "<br />")

	'Response.Write(mywhois.GlobalWhois("tekniktrafik.com.tr"))
'	Set myWhois = nothing
'	Response.end
%>
		</div> <!-- .ewy_nopad End -->
	</div> <!-- #ewy_maincolumn End -->

	<div id="ewy_rightcolumn">
		<%
			Call PixModules("sag")
		%>
		<div class="clr"></div>
	</div> <!-- #ewy_rightcolumn End -->

<!--#include file="footer.asp"-->
