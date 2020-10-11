<link href="<%=GlobalConfig("General_ThemePath")%>follow/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function () {
	$("#facebook_box, #twitter_box, #google_box").hover(function() {
		$(this).stop(true, false).animate({
			left: -293
		}, 500);
	}, function() {
		$(this).stop(true, false).animate({
			left: 0
		}, 500);
	});
});
/*]]>*/
</script>

<div id="box-content" style="z-index:100;">
	<div id="pointer">
<%
If GlobalConfig("facebook_url") <> "" Then
%>
		<div id="facebook_box" style="height:290px;">
			<img id="facebook_box_img" src="<%=GlobalConfig("General_ThemePath")%>follow/smtabs_facebook_right.png" alt="facebook" />
			<div id="fb-roots"></div>
			<script type="text/javascript" src="http://connect.facebook.net/tr_TR/all.js#xfbml=1"></script>
		</div>
		<div class="clr"></div>
		<script type="text/javascript">
		/*<![CDATA[*/
		$(document).ready(function() {
			$("#fb-roots")
				.css({"overflow": "hidden", "height" : "290px"})
				.append('<fb:like-box href="<%=GlobalConfig("facebook_url")%>" colorscheme="light" width="292" height="315" show_faces="true" stream="false" header="false"></fb:like-box>')
			;
		});
		/*]]>*/
		</script>
<%
End If

If GlobalConfig("twitter_url") <> "" Then
%>
		<div id="twitter_box" style="height:230px;">
			<img id="twitter_box_img" src="<%=GlobalConfig("General_ThemePath")%>follow/smtabs_twitter_right.png" alt="Twitter" />
			<div id="mytwitterfollowbox" class="follow-box-container"> </div>
		</div>
		<div class="clr"></div>
		<script type="text/javascript" src="<%=GlobalConfig("General_ThemePath")%>follow/followbox-min.js"></script>
		<script type="text/javascript">
		/*<![CDATA[*/
		$(document).ready(function(){
			$("#mytwitterfollowbox").followbox({"user" : "<%
			
			Response.Write(Replace(Replace(Replace(Replace(GlobalConfig("twitter_url"), "twitter.com/", ""), "//www.", ""), "http:", ""), "https:", ""))
			
			%>"});
		});
		/*]]>*/
		</script>
<%
End If

If GlobalConfig("googleplus_url") <> "" Then
%>

		<div id="google_box">
			<img id="google_box_img" src="<%=GlobalConfig("General_ThemePath")%>follow/smtabs_googleplus_right.png" alt="google plus" />
			<div id="g-plus" class="g-plus"></div>
		</div>
		<div class="clr"></div>
		<script type="text/javascript">
		/*<![CDATA[*/
			window.___gcfg = {lang: 'tr'};
			(function(){
				var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
				po.src = 'https://apis.google.com/js/plusone.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
			})();
			$(document).ready(function() {
				$('#g-plus').html('<g:plusone size="tall" data-href="<%=GlobalConfig("googleplus_url")%>"></g:plusone>');
			});
		/*]]>*/
		</script>
<%
End If
%>
	</div>
</div>
