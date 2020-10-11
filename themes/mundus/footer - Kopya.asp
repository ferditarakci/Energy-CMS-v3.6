				<div class="clr"></div>
			</div> <!-- #content End -->
		</div> <!-- #content-bg End -->
		<div id="ewy_content-bottom"></div> <!-- #content-bottom End -->

		<div id="ewy_footer" class="clearfix">
			<div id="ewy_footer_top"></div>
			<div class="ewy_content">
				<div class="ewy_links">
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Tasarım"><strong><em>web tasarım</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Yazılım"><strong><em>web yazılım</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Freelance Web Tasarım"><strong><em>freelance web tasarım</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Asp Yazılım"><strong><em>asp yazılım</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Freelance Webmaster"><strong><em>freelance webmaster</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Dizayn"><strong><em>web dizayn</em></strong></a></h4>
					<div class="clr"></div>
					<%If Not GlobalConfig("request_option") = GlobalConfig("General_Home") Then%>
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Tasarımı"><strong><em>web tasarımı</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Tasarimi"><strong><em>web tasarimi</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Dizayn"><strong><em>web design</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Freelance Web Dizaynı"><strong><em>freelance web dizayn</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Dizaynı"><strong><em>web dizaynı</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>" title="Web Dizayni"><strong><em>web dizayni</em></strong></a></h4>
					<%End If%>
				</div> <!-- .links End -->

				<div class="ewy_info">
					Mail: bilgi@webtasarimx.net &nbsp;-&nbsp; Tel: 0546 831 20 73
				</div> <!-- .info End -->

				<div class="clr"></div> <!-- Clear End -->
				<div class="fdivider"></div> <!-- Divider End -->

				<div class="ewy_copyright"><%=GlobalConfig("copyright")%></div> <!-- Copy End -->

				<div class="ewy_social_wrapper">
					<ul class="ewy_social_network clearfix">
						<li class="fb nm ls"><a href="<%=GlobalConfig("facebook_url")%>" title="<%=Lang("face_title")%>" target="_blank"><%=Lang("face_title")%></a></li>
						<li class="tw nm"><a href="<%=GlobalConfig("twitter_url")%>" title="<%=Lang("twitter_title")%>" target="_blank"><%=Lang("twitter_title")%></a></li>
						<li class="gp nm"><a href="<%=GlobalConfig("sRoot")%>" title="Google Plus">Google Plus</a></li><!--
						<li class="fl hidden"><a href="javascript:;" title="Flickr">Flickr</a></li>		
						<li class="yt hidden"><a href="javascript:;" title="Youtube">Youtube</a></li>-->
						<li class="rs nm"><a href="<%=UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Rss"), "", "", "", "", "")%>" title="<%=Lang("rss_title")%>" target="_blank"><%=Lang("rss_title")%></a></li>
					</ul>
				</div>

				<div class="clr"></div> <!-- Clear End -->
				<div class="fdivider"></div> <!-- Divider End -->

				<div class="ewy_design">
					<p>
						Bu sitede <a href="http://www.webtasarimx.net/" title="Energy içerik yönetim sistemi">Energy içerik yönetim sistemi</a> kullanılmıştır.
					</p>
				</div> <!-- .design End -->

				<div class="ewy_links">
					<h4><a href="<%=GlobalConfig("sRoot")%>arama/freelance+webmaster" title="Freelance Webmaster"><strong><em>freelance webmaster</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>arama/freelance+web+tasar%c4%b1m" title="Freelance Web Tasarım"><strong><em>freelance web tasarım</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>arama/web+tasar%c4%b1m%c4%b1" title="Web Tasarımı"><strong><em>web tasarımı</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>arama/web+tasarimi" title="Web Tasarimi"><strong><em>web tasarimi</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>arama/web+dizayn%c4%b1" title="Web Dizaynı"><strong><em>web dizaynı</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>arama/web+dizayn" title="Web Dizayn"><strong><em>web dizayn</em></strong></a></h4> |
					<h4><a href="<%=GlobalConfig("sRoot")%>arama/freelance+web+design" title="Freelance Web Design"><strong><em><ins class="hidden">freelance </ins>web design</em></strong></a></h4>
				</div> <!-- .links End -->

			</div> <!-- .content End -->
		</div> <!-- #footer End -->

	</div> <!-- #body End -->
</div> <!-- #page End -->


<%
'If Not Site_REMOTE_ADDR = "127.0.0.1" Then
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
		$('#fb_like').html('<div style="text-align:right;" class="fb-like" data-href="http://www.facebook.com/webdizayni.org" data-send="false" data-layout="box_count" data-show-faces="false"></div>');
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
<%
'End If


If Not GlobalConfig("description") = "" Then _
	Response.Write("<p class=""hidden"">" & GlobalConfig("description") & "</p>" & vbCrLf)

If Not GlobalConfig("keyword") = "" Then _
	Response.Write("<p class=""hidden"">" & GlobalConfig("keyword") & "</p>" & vbCrLf)

If Not (Site_LOCAL_ADDR = "127.0.0.1" Or inStr(1, Site_HTTP_REFERER, "webdizaynis.org", 1) > 0) Then _
	Response.Write("<div class=""hidden"">" & vbCrLf & GlobalConfig("analytics") & vbCrLf & "</div>" & vbCrLf)


iEndTime = Timer
%>

<!-- Bu sayfa <%Response.Write( FormatNumber((iEndTime - iStartTime), 2) )%> saniyede yorumlandı -->
</body>
</html>
