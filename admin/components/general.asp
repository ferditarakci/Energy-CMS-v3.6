<%
Dim varCss, varCss2, VarJs, VarJs2
Dim jQueryLibrary, jQueryUiLibrary, EnergyCss, EnergyJs
Dim AdminTitle

Public Sub Ust_Bolge()



%>
<!--#include file="header.asp"-->
</head>
<body>

<div id="body">

	<div id="header" class="clearfix">

		<div class="ust clearfix">

			<div class="logo">
				<a tabindex="-1" href="http://www.webtasarimx.net/" title="Energy Web Yazılım" target="_blank">Energy Web Yazılım</a>
			</div>

			<div class="title"><span>Energy İçerik Yönetim Sistemi</span></div>

			<%If Not mods = "login" Then%>
			<div id="module-status">
				<span class="login-user">Hoşgeldin <%=GlobalConfig("admin_name")%> (<%=GlobalConfig("admin_username")%>)</span>
				<span class="login-time">Son oturum: <%=TarihFormatla(GlobalConfig("admin_login_time"))%></span>
				<span class="info"><a class="iframe" tabindex="-1" href="?mod=sistem_info<%=Debug%>" title="Sistem Bilgileri" target="_blank">Sistem Bilgileri</a></span>
				<span class="help"><a tabindex="-1" href="http://www.webtasarimx.net/" title="Energy Web Yazılım" target="_blank">Yardım</a></span>
				<span class="viewsite"><a href="<%=UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", "", "", "")%>" target="_blank">Site önizleme</a></span>
				<span class="logout"><a tabindex="-1" href="?mod=<%=GlobalConfig("General_Login")%>&amp;task=logout<%=Debug%>">Oturum kapat</a></span>
			</div>
			<%End If%>
			
			<div class="clr"></div>
		</div>

		<!--#include file="header_nav.asp"-->
		<div class="clr"></div>
	</div>

<div class="clr"></div>

<div class="body-content clearfix">
<%
If Not mods = "login" Then
%>
<noscript>
	<div class="notepad clearfix">
		<div class="warning">
			<div class="messages">
				<span>Yönetici arka-uç biriminin düzgün çalışabilmesi için tarayıcınızın <em class="red">&rdquo;Javascript&rdquo;</em> özelliğini aktif ediniz.</span>
			</div>
		</div>
	</div>
</noscript>
<%
'Clearfix BasHarfBuyuk("ARAMA MOTORU OPTİMİZASYONUNDA TEMELLER")
'Clearfix "<a href=""http://www.webtasarimx.net/test/upload/upload.asp%3Ftask%3Dsay fa%26id%3D57227%26admin"">aaa</a>"

'Clearfix session("ssd")
'Clearfix Newid("sayfa", SefUrl("sayfa&العربية=     %"), "sayfa", 57227, GlobalConfig("site_lang"))
If inStr(1, Site_HTTP_USER_AGENT, "MSIE 6", 1) Then
%>
	<div class="notepad clearfix">
		<div class="warning">
			<div class="messages">
				<span>
					<span style="line-height:16px;">
						<strong class="red">Eski sürüm web tarayıcısı (Internet Explorer 6) kullanıyorsunuz!</strong><br />
						Web sitemizi sorunsuz görüntülemeniz ve internette daha hızlı dolaşabilmeniz için önerdiğimiz popüler web tarayıcılarından bazıları.<br /> 
						<a href="http://www.google.com/chrome/?hl=tr" title="Chrome"><img src="<%=GlobalConfig("vBase")%>images/browser/chrome.png" alt="Chrome" /></a>
						<a style="margin-left:10px;" href="http://www.mozilla.org/tr/firefox/new/" title="Firefox"><img src="<%=GlobalConfig("vBase")%>images/browser/firefox.png" alt="Firefox" /></a>
						<a style="margin-left:10px;" href="http://windows.microsoft.com/tr-TR/internet-explorer/downloads/ie" title="Internet Explorer"><img src="<%=GlobalConfig("vBase")%>images/browser/ie.png" alt="Internet Explorer" /></a>
						<a style="margin-left:10px;" href="http://www.opera.com/download/" title="Opera"><img src="<%=GlobalConfig("vBase")%>images/browser/opera.png" alt="Opera" /></a>
						<a style="margin-left:10px;" href="http://www.apple.com/tr/safari/download/" title="Safari"><img src="<%=GlobalConfig("vBase")%>images/browser/safari.png" alt="Safari" /></a>
					</span>
				</span>
			</div>
		</div>
	</div>
<%
End If

End If
%>
<div class="content clearfix">
<%
	End Sub



	'// Contents



	Public Sub Alt_Bolge()
%>
<div class="clr"></div>
</div>
<%
'// Tinymce Editör
If (mods = GlobalConfig("General_Page") Or mods = GlobalConfig("General_Categories") Or _
	mods = GlobalConfig("General_Products") Or mods = GlobalConfig("General_Poll") Or _
	mods = GlobalConfig("General_Banner") Or mods = "ayar") And (task = "new" Or task = "edit") Then TinyMce()
%>
</div>
</div>

<div id="energy-copy">
	<ul>
		<li><a class="scroll-top-icon" href="#" onclick="$('html, body').animate({scrollTop:0}, 1500); return false">Sayfa Başı</a></li>
		<li style="margin-right:6px;"><a class="copyright" href="http://www.webtasarimx.net/" title="<%=xGenerator%>" target="_blank">&copy; 2008 - <%=Year(Date()) & " " & xGenerator%></a></li>
	</ul>
	<div class="clr"></div>
</div>

<div id="appTo" class="hidden"></div>

<div id="system-message" class="hidden">
	<div class="messages">
		<span>Energy Web Yazılım</span>
		<div class="close"></div>
	</div>
</div>
<%
iEndTime = Timer
%>
<!-- Bu sayfa <%=FormatNumber((iEndTime - iStartTime), 4)%> saniyede yorumlandı -->
<!-- Revizyon 19-06-2012 -->
<script type="text/javascript">/*<![CDATA[*/var _gaq=_gaq||[];_gaq.push(['_setAccount','UA-23038491-5']);/*_gaq.push(['_setDomainName','webdizayni.org']);*/_gaq.push(['_setAllowLinker',true]);_gaq.push(['_trackPageview']);(function(){var ga=document.createElement('script');ga.type='text/javascript';ga.async=true;ga.src=('https:'==document.location.protocol?'https://ssl':'http://www')+'.google-analytics.com/ga.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(ga,s);})();/*]]>*/</script>
</body>
</html>
<%
End Sub
%>
