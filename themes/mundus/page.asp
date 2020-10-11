<!--#include file="header.asp"-->
<%
Select Case GlobalConfig("sayfa_alias")

Case "default"
%>
	<script type="text/javascript">
	/*<![CDATA[*/
	var ewyError = '<%=Duzenle(Lang("ewyError"))%>',
		ewyLoading = '<%=Duzenle(Lang("ewyLoading"))%>';
	/*]]>*/
	</script>
	<div id="main" class="ewy_content default_page">
	<%
		Call featuredFile(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"))
	%>
		<!--#include file="files/sayfa_sablon/default.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<%
			'Call MundusModules("sag")
			Call MundusHizmetlerMenu(0)
			If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->


<%
Case "hizmetlerimiz"
%>
	<div id="main" class="ewy_content">
	<%
		Call featuredFile(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"))
	%>
		<!--#include file="files/sayfa_sablon/default.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<% 'clearfix GlobalConfig("request_sayfaid")
			'Call MundusModules("sag")
			Call MundusHizmetlerMenu(0)
			If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->
	

<%
Case "faydali-blog"
%>
	<div id="main" class="ewy_content">
		<!--#include file="files/sayfa_sablon/faydali-blog.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<% 'clearfix GlobalConfig("request_sayfaid")
			'Call MundusModules("sag")
			'Call MundusHizmetlerMenu(0)
			Call MundusFaydaliMenu(0)
			If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->
	

<%
Case "faydali"
%>
	<div id="main" class="ewy_content">
	<%
		Call featuredFile(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"))
	%>
		<!--#include file="files/sayfa_sablon/default.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<% 'clearfix GlobalConfig("request_sayfaid")
			'Call MundusModules("sag")
			Call MundusFaydaliMenu(0)
			If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->
	

<%
Case GlobalConfig("General_Design")
%>
	<div id="main" class="ewy_content">
	<%
		Call featuredFile(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"))
	%>
		<!--#include file="files/sayfa_sablon/webtasarim.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<%
			Call MundusModules("sag")
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->
	

<%
Case "programlist"
%>
	<div id="main" class="ewy_content">
		<!--#include file="files/sayfa_sablon/programlama.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<%
			'Call MundusModules("sag")
			Call MundusProgramMenu(0)
			If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->
	

<%
Case "programlama"
%>
	<div id="main" class="ewy_content">
	<%
		Call featuredFile(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"))
	%>
		<!--#include file="files/sayfa_sablon/default.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<%
			'Call MundusModules("sag")
			Call MundusProgramMenu(0)
			If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->
	

<%
Case "haberler"
%>
	<div id="main" class="ewy_content">
		<!--#include file="files/sayfa_sablon/haberler.asp"-->
	</div> <!-- #main End -->

	<aside id="right_sidebar">
		<%
			Call MundusModules("sag")
		%>
		<div class="clr"></div>
	</aside> <!-- #right_sidebar End -->
	
<%
Case "referanslarimiz"
%>
	<div id="mainfull">
		<!--#include file="files/sayfa_sablon/referanslarimiz.asp"-->
	</div> <!-- #mainfull End -->

<%
Case "referans"
%>
	<div id="mainfull">
		<!--#include file="files/sayfa_sablon/referans.asp"-->
	</div> <!-- #mainfull End -->

<%
Case "iletisim"
%>
<script type="text/javascript">
/*<![CDATA[*/
var ewyError = '<%=Duzenle(Lang("ewyError"))%>',
    ewyLoading = '<%=Duzenle(Lang("ewyLoading"))%>';
/*]]>*/
</script>
	<div id="mainfull">
		<!--#include file="files/sayfa_sablon/iletisim.asp"-->
	</div> <!-- #mainfull End -->


<%
Case "hazir-paket"
%>
	<div id="mainfull">
		<!--#include file="files/sayfa_sablon/paketler.asp"-->
	</div> <!-- #mainfull End -->

<!--
<script type="text/javascript">
/*<![CDATA[*/
	$(function() {
		$(".menu li a, .topMenu li a").click(function(e) {
			e.preventDefault();
			$(".menu li, .topMenu li").removeClass("active");
			$(this).parent().parent().addClass("active");
			$.ajax({
				cache: false,
				type: "POST",
				url: $(this).attr("href"),
				data: "ewy_type=1",
				beforeSend: function() {
					$("#ewy_write").html('<div class="loading" style="background:url(<%=GlobalConfig("General_ThemePath")%>images/loading.gif) no-repeat center; width:100%; height:500px;">&nbsp;</div>')
				},
				error: function() {
					$("#ewy_write").html('<div class="messagebox warning"><span class="message-title">Üzgünüz... Bir hata algılandı.</span></div>')
				},
				success: function(veri) {
					$("#ewy_write").html(veri)
					.hide()
					.fadeIn(1000, function() {
						$("#ewy_write");
					});
				}
			});
		});
		return false;
	});
/*]]>*/
</script>
-->

<%
Case Else

	Response.Write("<div class=""warning""><div class=""messages""><span>Not Found</span></div></div>")

End Select
%>
<!--#include file="footer.asp"-->
