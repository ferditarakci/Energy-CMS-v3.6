
				<div class="clr"></div>
			</div> <!-- .content End -->
		</section> <!-- #content End -->

	<!-- begin footer -->
	<footer id="footer" class="">
		<div class="border-top"></div>
		<div class="inner">
			<div class="footer_content">
				<%
					Call MundusFooterMenu( 0 )
				%>
				<div class="fl contact-details">
					<p class="phone" style="border-bottom:0px solid #f00;">+90 546 831 2073</p>
					<p class="email" style="border-bottom:0px solid #f00;"><img alt="Email" src="<%=GlobalConfig("General_ThemePath")%>images/mail.png" /></p>
				</div>
				<div class="clr"></div>
			</div>

			<div class="clr"></div>
			<div class="footer_divider">&nbsp;</div>
			<div class="clr"></div>

			<div class="footer_content">
				<%
					Call MundusFooterEtiketMenu( 0 )
				%>
				<div class="fl">
					<p class="copyright"><%=GlobalConfig("copyright")%></p>
				</div>
				<div class="clr"></div>
			</div>
		</div>

		<a href="/" id="toTop">Web Tasarım</a>

		<div class="clr"></div>
	</footer>
	<!-- end footer -->

	</div> <!-- #body End -->
</div> <!-- #page End -->

<%
If Site_REMOTE_ADDR = "127.0.0.1d" Then
%>
<script type="text/javascript">
/*<![CDATA[*/
	window.___gcfg = {lang: 'tr'};
	(function(){
		var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
		po.src = 'https://apis.google.com/js/plusone.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
	})();

	$(document).ready(function() {
		$('#fb_like').html('<div style="text-align:right;" class="fb-like" data-href="<%=GlobalConfig("facebook_url")%>" data-send="false" data-layout="box_count" data-show-faces="false"></div>');
		$('#tweet_shared').html('<a class="twitter-share-button" data-count="vertical" href="http://twitter.com/share">Tweetle</a>');
		$('#g_plusone').html('<g:plusone size="tall"></g:plusone>');
	});
/*]]>*/
</script>
<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>

<div id="sharedFixed">
	<ul>
		<li id="g_plusone">Google Plus</li>
		<li id="fb_like"><a href="<%=GlobalConfig("facebook_url")%>" title="<%=Lang("face_title")%>" target="_blank"><%=Lang("face_title")%></a></li>
		<li id="tweet_shared"><a href="<%=GlobalConfig("twitter_url")%>" title="<%=Lang("twitter_title")%>" target="_blank"><%=Lang("twitter_title")%></a></li>
	</ul>
</div> <!-- shared links end -->

<script type="text/javascript">
/*<![CDATA[*/
$(function(){
	var tempX = 0, tempY = 0, IE = document.all ? true : false;
	if($.cookie("flike") != "true") {
		if (!IE) document.captureEvents(Event.MOUSEMOVE);
		var $frame = $("<iframe />")
			.attr({
				"id" : "like_frame",
				"src" : "http://www.facebook.com/plugins/like.php?href=" + encodeURIComponent("<%=GlobalConfig("facebook_url")%>") + "&amp;layout=standard&amp;show_faces=true&amp;width=10&amp;action=like&amp;colorscheme=light&amp;height=10",
				"scrolling" : "no",
				"frameBorder" : "0",
				"allowTransparency" : "true"
			})
			.css({
				"border" : "0",
				"overflow" : "hidden",
				"cursor" : "pointer",
				"width" : "10px",
				"height" : "10px",
				"margin" : "0",
				"padding" : "0",
				"position" : "absolute",
				"opacity" : "0.05"
			});

		$("body").append($frame);

		window.addEventListener("mousemove", mouseMove, false);

		setTimeout(function(){
			window.removeEventListener("mousemove", mouseMove, false);
			$("#like_frame").remove();
		}, 10000);

	}

	function mouseMove(e) {
		if (IE) {
			tempX = event.clientX + document.body.scrollLeft;
			tempY = event.clientY + document.body.scrollTop;
		} else {
			tempX = e.pageX;
			tempY = e.pageY;
		}

		if (tempX < 0) tempX = 0;
		if (tempY < 0) tempY = 0;
		$("#like_frame").css({
			"top" : (tempY - 5) + "px",
			"left" : (tempX - 5) + "px"
		}).click();
		$.cookie("flike", "true", {expires:365});
		return true;
	}
});
/*]]>*/
</script>
<%
End If
%>
<!--#include file="follow/index.asp"-->

<!--
		<div id="fb-rootss">
			<iframe src="//www.facebook.com/plugins/likebox.php?href=<%=GlobalConfig("facebook_url")%>&amp;width=292&amp;height=258&amp;colorscheme=light&amp;show_faces=true&amp;border_color&amp;stream=false&amp;header=false" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:292px; height:258px;" allowtransparency="true"></iframe>
		</div>
<a href="#fb-rootss" rel="lightbox">asdd</a>
-->

<!--Start of Zopim Live Chat Script-->
<script type="text/javascript">
window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute('charset','utf-8');
$.src='//v2.zopim.com/?1YHaU8wiw0t1La0rD1YTOOuhJDgZr0VH';z.t=+new Date;$.
type='text/javascript';e.parentNode.insertBefore($,e)})(document,'script');
</script>
<!--End of Zopim Live Chat Script-->

<script type="text/javascript"> 
$zopim( function() {
	$zopim.livechat.setLanguage('tr');
	$zopim.livechat.setName('Ziyaretçi');
	//$zopim.livechat.setEmail('');
	$zopim.livechat.button.setPosition('br');
	//$zopim.livechat.window.setTheme('plastic');
	//$zopim.livechat.window.setColor('#cc0000');
	$zopim.livechat.bubble.setTitle('Nasıl Yardımcı Olabiliriz.');
	$zopim.livechat.bubble.setText('Müşteri Hizmetleri');
	$zopim.livechat.bubble.hide(true);
	$zopim.livechat.setGreetings({
		'online' : ['Online Sohbete Başlayın', 'Merak ettiğiniz tüm konularda online yardım alabilirsiniz.'],
		'offline': ['Mesaj Bırakabilirsiniz!', 'Lütfen mesajınızı ve iletişim bilgilerinizi bırakın, en kısa sürede size ulaşalım.'],
		'away'   : ['Online Sohbete Başlayın', 'Merak ettiğiniz tüm konularda online yardım alabilirsiniz. Müşteri Temsilcilerimiz müsait olduğunda size cevap verecek.']  
	});
});
</script>


<%
If Not (Request.ServerVariables("REMOTE_ADDR") = "127.0.0.1" Or Request.ServerVariables("REMOTE_ADDR") = "::1") Then

If Request.ServerVariables("HTTP_HOST") = "www.webtasarimx.net" Then
%>
		<script type="text/javascript">
		/*<![CDATA[*/
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-36578915-1']);
			_gaq.push(['_trackPageview']);
			(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();
		/*]]>*/
		</script>

		<!-- Yandex.Metrika counter -->
		<script type="text/javascript">
		/*<![CDATA[*/
			(function (d, w, c) {
			 (w[c] = w[c] || []).push(function() {
			 try {
			 w.yaCounter18543298 = new Ya.Metrika({id:18543298,
			 webvisor:true,
			 clickmap:true,
			 trackLinks:true,
			 accurateTrackBounce:true,
			 trackHash:true});
			 } catch(e) { }
			 });

			 var n = d.getElementsByTagName("script")[0],
			 s = d.createElement("script"),
			 f = function () { n.parentNode.insertBefore(s, n); };
			 s.type = "text/javascript";
			 s.async = true;
			 s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

			 if (w.opera == "[object Opera]") {
			 d.addEventListener("DOMContentLoaded", f, false);
			 } else { f(); }
			})(document, window, "yandex_metrika_callbacks");
		/*]]>*/
		</script>

		<noscript>
			<div><img src="http://mc.yandex.ru/watch/18543298" style="position:absolute; left:-9999px;" alt="Yandex Metrika" width="0" height="0" /></div>
		</noscript>
		<!-- /Yandex.Metrika counter -->
<%
ElseIf Request.ServerVariables("HTTP_HOST") = "www.webtasarimx.net" Then
%>
		<script type="text/javascript">
			/*<![CDATA[*/
				var _gaq = _gaq || [];
				_gaq.push(['_setAccount', 'UA-23038491-1']);
				/*_gaq.push(['_setDomainName', '.webdizayni.org']);*/
				_gaq.push(['_trackPageview']);
				(function() {
					var ga = document.createElement('script');
					ga.type = 'text/javascript';
					ga.async = true;
					ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
					var s = document.getElementsByTagName('script')[0];
					s.parentNode.insertBefore(ga, s);
				})();
			/*]]>*/
		</script>

		<!-- Yandex.Metrika counter -->
		<script type="text/javascript">
		/*<![CDATA[*/
		(function (d, w, c) {
		 (w[c] = w[c] || []).push(function() {
		 try {
		 w.yaCounter14089750 = new Ya.Metrika({id:14089750, enableAll: true});
		 } catch(e) {}
		 });
		 
		 var n = d.getElementsByTagName("script")[0],
		 s = d.createElement("script"),
		 f = function () { n.parentNode.insertBefore(s, n); };
		 s.type = "text/javascript";
		 s.async = true;
		 s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

		 if (w.opera == "[object Opera]") {
		 d.addEventListener("DOMContentLoaded", f);
		 } else { f(); }
		})(document, window, "yandex_metrika_callbacks");
		/*]]>*/
		</script>
		<noscript><div><img src="http://mc.yandex.ru/watch/14089750" style="position:absolute; left:-9999px;" title="Yandex Metrika" alt="Yandex Metrika" width="0" height="0" /></div></noscript>
		<!-- /Yandex.Metrika counter -->
<%
	End If

End If
%>



<%
'If Not (Site_LOCAL_ADDR = "127.0.0.1" Or GlobalConfig("admin_login") Or inStr(1, Site_HTTP_REFERER, "webdizaynis.org", 1) > 0) Then
'	Response.Write("<div class=""hidden"">" & vbCrLf & GlobalConfig("analytics") & vbCrLf & "</div>" & vbCrLf)
'End If

iEndTime = Timer
%>
	<!--
		Bu site "webtasarimx.net / Ferdi Tarakcı" tarafından oluşturulmuştur. //www.webtasarimx.net
		Sayfa <%Response.Write( FormatNumber((iEndTime - iStartTime), 2) )%> saniyede yorumlandı.
		Created Date : <%=TarihFormatla(Now())%>
	-->
</body>
</html>
