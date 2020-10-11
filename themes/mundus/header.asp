<!DOCTYPE html>
<!--
	* @date		: 19/12/2012
	* @developer 	: Ferdi Tarakcı
	* @web		: www.webtasarimx.net
	* @contact	: bilgi@webtasarimx.net
-->
<html xmlns="http://www.w3.org/1999/xhtml"<%

If Not isTrue("W3C") Then
%> prefix="og: http://ogp.me/ns#"<%

End If
%> lang="<%=LCase(GlobalConfig("site_lang"))%>">
<head <%

If Not isTrue("W3C") Then
%>profile="http://gmpg.org/xfn/11"<%

End If
%>>
<meta charset="utf-8" />
<%

If Not Site_LOCAL_ADDR = "127.0.0.1" And isTrue("MSIE") Then

%><meta http-equiv="X-UA-Compatible" content="IE=edge; chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%

End If

'// Get Header
Call GetHeader()

If Not isTrue("W3C") Then
	With Response
		
		'.Write("<meta property=""fb:app_id"" content=""149987895031362"" />" & vbCrLf)

		If GlobalConfig("googleplus_url") <> "" Then _
			.Write("<link rel=""publisher"" href="""& GlobalConfig("googleplus_url") &""" />" & vbCrLf)

		If GlobalConfig("request_option") = GlobalConfig("General_Page") Then
			.Write("<meta property=""og:type"" content=""article"" />" & vbCrLf)
		Else
			.Write("<meta property=""og:type"" content=""website"" />" & vbCrLf)
		End If

		.Write("<meta property=""og:site_name"" content="""& GlobalConfig("default_site_ismi") &""" />" & vbCrLf)
		.Write("<meta property=""og:url"" content="""& GlobalConfig("site_uri") &""" />" & vbCrLf)
		.Write("<meta property=""og:title"" content="""& GlobalConfig("header_title") &""" />" & vbCrLf)
		If GlobalConfig("description") <> "" Then _
		.Write("<meta property=""og:description"" content="""& GlobalConfig("description") &""" />" & vbCrLf)

		.Write("<meta property=""og:locale"" content=""tr_TR"" />" & vbCrLf)

		'If Site_HTTP_HOST = "www.webtasarimx.net" Or Site_HTTP_HOST = "www.webtasarimx.net" Then
			'.Write("<meta property=""og:image"" content="""& GlobalConfig("sBase") &"images/energy-web-tasarim.jpg"" />" & vbCrLf)
		'	.Write("<meta property=""og:email"" content=""bilgi@webtasarimx.net"" />" & vbCrLf)
		'	.Write("<meta property=""og:phone_number"" content=""+90-546-8312073"" />" & vbCrLf)
			'.Write("<meta property=""og:fax_number"" content=""+90 (546) 831 20 73"" />" & vbCrLf)
		'	.Write("<meta property=""og:street-address"" content=""Doğanevler Cad. Altınşehir Mah."" />" & vbCrLf)
		'	.Write("<meta property=""og:locality"" content=""Ümraniye"" />" & vbCrLf)
		'	.Write("<meta property=""og:region"" content=""İstanbul"" />" & vbCrLf)
		'	.Write("<meta property=""og:country-name"" content=""Turkey"" />" & vbCrLf)
		'	.Write("<meta property=""og:latitude"" content=""41.015316"" />" & vbCrLf)
		'	.Write("<meta property=""og:longitude"" content=""29.139218"" />" & vbCrLf)
		'End If
		.Write("<meta name=""application-name"" content="""& GlobalConfig("header_title") &""" />" & vbCrLf)

	End With
End If

%><script type="text/javascript">
	var ewyThemePath = "<%=GlobalConfig("General_ThemePath")%>";
	var ewyFacebookPage = "<%=GlobalConfig("facebook_url")%>";
</script>
<link href="<%=GlobalConfig("General_ThemePath")%>favicon.ico" rel="shortcut icon" type="image/x-icon" /><%

If Site_LOCAL_ADDR = "127.0.0.1d" Then
%>

<link href="http://fonts.googleapis.com/css?family=Dosis|&amp;subset=latin,latin-ext&amp;v2" rel="stylesheet" type="text/css" />
<style>#latestpost li h2 a, .post h2 a, a, .entry p, h1.title, h3#reply-title {font-family:Dosis}</style>

<link href="http://fonts.googleapis.com/css?family=Terminal+Dosis:400,500,600,700" rel="stylesheet" type="text/css" />
<link href="http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300,300italic,700" rel="stylesheet" type="text/css" />
<link href="http://fonts.googleapis.com/css?family=Happy+Monkey&amp;subset=latin,latin-ext" rel="stylesheet" type="text/css" />
<link href="http://fonts.googleapis.com/css?family=Fondamento" rel="stylesheet" type="text/css" />
<link href="http://themes.googleusercontent.com/fonts/css?kit=vLVN2Y-z65rVu1R7lWdvyIpV-QMqvBCZh8vrjY0FYwI" rel="stylesheet" type="text/css" />
<%
End If


%>
<link href="<%=GlobalConfig("General_ThemePath")%>css/loadStyle.css?load=reset,font,fonts,style,nivo-slider,menu,content,contact,ajax,button,prettyPhoto,common&amp;v=25<%=Debug%>" type="text/css" rel="stylesheet" media="screen" /><%


If GlobalConfig("General_ThemeStyle") <> "" Then
%>
<link href="<%=GlobalConfig("General_ThemePath")%>css/<%=GlobalConfig("General_ThemeStyle")%>" type="text/css" rel="stylesheet" media="screen" /><%
End If


%>
<script src="<%=GlobalConfig("General_ThemePath")%>javascript/loadScript.js?load=jquery-1.7.2,html5shim,jquery-ui,cssBrowserSelector,hoverIntent,easing.1.3,superfish,nivoSlider,scrolltotop,blink,blend,carousel,prettyPhoto,energy_global&amp;v=10<%=Debug%>" charset="utf-8" type="text/javascript"></script><%

If Site_LOCAL_ADDR = "127.0.0.1d" Then
%>
<!--
<script type="text/javascript" src="<%=GlobalConfig("General_ThemePath")%>flash/swfobject.js"></script>
<script type="text/javascript">
	swfobject.embedSWF(
		"<%=GlobalConfig("General_ThemePath")%>flash/banner.swf",
		"slider",
		"930",
		"345",
		"9.0.0",
		"<%=GlobalConfig("General_ThemePath")%>flash/expressInstall.swf",
		{
			//xmlPath: "http://www.webtasarimx.net/flash-xml/"
			xmlPath: "<%=UrlWrite(GlobalConfig("sBase"), GlobalConfig("site_lang"), GlobalConfig("General_Xml"), "flash-slider", "", "", "", "")%>"
		},
		{
			menu:"false",
			wmode:"transparent"
		}
	);
</script>
--><%
End If


'Clearfix GlobalConfig("request_option")
addClass = "" : If GlobalConfig("request_option") = GlobalConfig("General_Home") Then addClass = "homepage "
If GlobalConfig("sayfa_alias") = "iletisim" Then addClass = "contactpage "
If GlobalConfig("sayfa_alias") = "referanslarimiz" Then addClass = "portfolio-page "
%>
</head>
<body class="<%=addClass%>no-js" id="webtasarimx-net">
<div id="page">
	<div id="body"><%

'Response.Write Request.QueryString
'// IE-6 WARNING
If isTrue("MSIE 6") Then
%>
		<div class="ewy_sys_msg warning" style="top:0;">
			<div class="ewy_messages">
				<span>
					<span style="line-height:16px;">
						<strong class="kirmizi"><%=Lang("ie6_title")%></strong>
						<br />
						<%=Lang("ie6_text")%>
						<br />
						<br />
						<a style="padding:0 15px 0 0;" href="http://www.google.com/chrome/?hl=tr" title="Chrome"><b>Chrome</b></a> |
						<a style="padding:0 15px;" href="http://www.mozilla.org/tr/firefox/new/" title="Firefox"><b>Firefox</b></a> |
						<a style="padding:0 15px;" href="http://windows.microsoft.com/tr-TR/internet-explorer/downloads/ie" title="Internet Explorer"><b>Internet Explorer</b></a> |
						<a style="padding:0 15px;" href="http://www.opera.com/download/" title="Opera"><b>Opera</a> |
						<a style="padding:0 0 0 15px;" href="http://www.apple.com/tr/safari/download/" title="Safari"><b>Safari</b></a>
					</span>
				</span>
			</div>
		</div><%
End If

'Clearfix len("Uygun Fiyata PSD to XHTML-CSS Dökümü ve ASP, HTML, CSS, JS işleriniz itinayla yapılır. [URL=""http://www.webtasarimx.net""]Web Programlama[/URL]")
'<div id="meta" class="clearfix"></div>
'clearfix sqlquery("SHOW VARIABLES LIKE 'character_set%';","")
%>
		<header id="header" class="clearfix">
			<div class="border-top"></div>
			<div class="border-bottom"></div>

			<div class="header-warp clearfix">
				<section class="marginFix clearfix">
					<div id="social-bookmarks" class="clearfix">
						<ul class="social-bookmarks">
							<li class="facebook"><a rel="me" href="<%=GlobalConfig("facebook_url")%>" title="<%=Lang("face_title")%>" target="_blank"><%=Lang("face_title")%></a></li>
							<li class="twitter"><a rel="me" href="<%=GlobalConfig("twitter_url")%>" title="<%=Lang("twitter_title")%>" target="_blank"><%=Lang("twitter_title")%></a></li>
							<li class="google"><a rel="me" href="<%=GlobalConfig("googleplus_url")%>" title="<%=Lang("googleplus_title")%>" target="_blank"><%=Lang("googleplus_title")%></a></li>
							<li class="linkedin"><a>LinkedIn</a></li>
							<li class="flickr"><a>Flickr</a></li>
							<li class="rss"><a rel="alternate" href="<%=UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Rss"), "", "", "", "", "")%>" title="<%=Lang("rss_title")%>" target="_blank"><%=Lang("rss_title")%></a></li>
						</ul>
						<div id="ewy-phone" class="clearfix" title="Web Tasarım ve Programlama Hizmeti / 0546 831 2073"><i>Web Tasarım ve Programlama Hizmeti / 0546 831 2073</i></div>

					</div> <!-- #social-bookmarks End -->

					<div id="logo" class="clearfix">
						<a class="logo-text<% If Replace(Site_SERVER_NAME, "www.", "") = "webdizayni.org" Then Response.Write " webdizayni"%>" href="<%=GlobalConfig("sRoot")%>" title="Web Tasarım">web tasarım</a>
						<i><%=GlobalConfig("slogan")%></i>
						<p class="site-description"><strong>WEBTASARIMX.NET</strong>; <u>Freelance olarak profesyonel web tasarım ve web programlama hizmeti</u> veriyor. Tel: +90-546-831-2073</p>
					</div> <!-- #logo End -->
				</section>

				<div class="clr"></div>

				<section style="margin-top:-10px;" class="clearfix">
					<div id="navbar">
						<div id="navbar-inner" class="clearfix">
						
							<%
							'// Search Form
							Call MundusSearchBox()
							%>
							<nav id="nav">
								<%
									Call MundusTopMenu(0)
								%>
							</nav> <!-- #nav End -->
						</div> <!-- #navbar-inner End -->
					</div> <!-- #navbar End -->
				</section>

				<div class="clr"></div>

<%
	If GlobalConfig("request_option") = GlobalConfig("General_Home") & "sss" Then
%>
				<section class="clearfix">

					<div id="slider-wrapper">
						<div id="slider" class="nivoSlider">

<%
Set objRs = setExecute("SELECT id, title, alt, img, url, text FROM #___banner WHERE durum = 1 And yer = 0 And lang = '"& GlobalConfig("site_lang") &"' ORDER BY Rand();")
If Not objRs.Eof Then

	With Response
		'.Write("<div class=""slider"">" & vbCrLf)
		'.Write("<ul id=""fade"">" & vbCrLf)
		
		strSliderHtmlData = ""
		strCaption = ""
		Do While Not objRs.Eof
			strTitle = objRs("title") & ""
			strTitle2 = objRs("alt") & ""
			strText = objRs("text") & ""
			strLinks = objRs("url") & ""


			'.Write("<li>" & vbCrLf)
			'.Write("	<img class=""hidden"" src="""& bFolder & "/" & objRs("img") &""" title="""& objRs("title") &""" alt="""& objRs("alt") &""" width=""720"" height=""280"" />")
			'.Write("	<h5><a rel=""nofollow"" href="""& UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Redirect"), "banhit", "", Cdbl(objRs("id")), "", "") &""" target=""_blank"">"& objRs("title") &"</a></h5>")
			'.Write("	<p><a rel=""nofollow"" href="""& UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Redirect"), "banhit", "", Cdbl(objRs("id")), "", "") &""" target=""_blank"">" & objRs("alt") & "</a></p>")


			If strText <> "" Then
				strSliderHtmlData = strSliderHtmlData & "<div id=""slide-" & objRs("id") & "-caption"" class=""nivo-html-caption"">" & vbCrLf
				strSliderHtmlData = strSliderHtmlData & "	<h3>" & strTitle & "</h3>" & vbCrLf
				strSliderHtmlData = strSliderHtmlData & "	" & strText & vbCrLf
				strSliderHtmlData = strSliderHtmlData & "</div>" & vbCrLf
				strTitle = "#slide-" & objRs("id") & "-caption"
			End If

			If strLinks <> "" Then
				.Write("<a rel=""nofollow"" href="""& UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Redirect"), "banhit", "", Cdbl(objRs("id")), "", "") &""" title="""" target=""_blank"">")
			End If

			.Write("<img src="""& bFolder & "/" & objRs("img") &""" alt=""Slide 3"" title="""& strTitle &""" width=""930"" height=""345"" />")

			If strLinks <> "" Then
				.Write("</a>")

			End If

			
			'.Write("#slide-1-caption	<div class=""text hidden"">"& objRs("text") &"</div>")
			'.Write("	<a class=""call-btn"" rel=""nofollow"" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Redirect"), "banhit", "", Cdbl(objRs("id")), "", "") &""" target=""_blank""><span>Test edin</span></a>")
			'.Write("</li>" & vbCrLf)

		objRs.MoveNext() : Loop

		'.Write("</ul>" & vbCrLf)
		'.Write("</div>" & vbCrLf)
	End With
End If
Set objRs = Nothing
%>
						</div>
						<%=strSliderHtmlData%>
								
					</div> <!-- #slider-wrapper End -->
				</section> <!-- .clearfix End -->

				<div class="clr"></div>
<%
	End If
%>
			</div> <!-- .header-warp End -->
		</header> <!-- #header End -->
<%
If GlobalConfig("request_option") = GlobalConfig("General_Home") Then

	'// Protfolyo listesi 
	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id" & vbCrLf
	SQL = SQL & "	,IFNULL(b.title, '') As title" & vbCrLf
	SQL = SQL & "	,IFNULL(b.text, '') As text" & vbCrLf
	SQL = SQL & "	,IFNULL(b.readmore_text, '') As readmore_text" & vbCrLf
	SQL = SQL & "	,IFNULL(c.resim, '') As fileName" & vbCrLf
	SQL = SQL & "	,IFNULL(c.title, '') As fileTitle" & vbCrLf
	SQL = SQL & "	,IFNULL(c.alt, '') As fileAlt" & vbCrLf
	SQL = SQL & "	,IFNULL(c.url, '') As fileUrl" & vbCrLf
	SQL = SQL & "FROM #___sayfa As a" & vbCrLf
	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "Left JOIN #___files As c ON a.id = c.parent_id And c.file_type = 1 And c.durum = 1 And c.anaresim = 1" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	a.durum = 1" & vbCrLf
	'SQL = SQL & "	And a.anaid = 57212" & vbCrLf
	SQL = SQL & "	And a.anasyfAlias = 'ust_dortlu'" & vbCrLf
	SQL = SQL & "	And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	SQL = SQL & "	And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & ")" & vbCrLf
	SQL = SQL & "ORDER BY a.sira ASC;"
	'Clearfix setQuery(SQL)

	Set objRs = setExecute( SQL )
	If Not objRs.Eof Then
		With Response
			.Write "<!-- Home page top contents -->" & vbCrLf
			.Write "<section id=""hptc"" class=""clearfix"">" & vbCrLf
		i = 0
		While Not objRs.Eof
			'strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", 57212, 0, "")

			intid = objRs("id")
			strTitle = HtmlEncode(objRs("title"))
			'blnTitleStatus = CBool(objRs("titleStatus"))
			'strCDate = objRs("c_date") & ""
			'strMDate = objRs("m_date") & ""
			'If strMDate <> "" Then strCDate = strMDate
			strText = PageBreakReplace(objRs("text"))
			strText = fnPre(strText, GlobalConfig("sBase"))
			strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", intid, "", "")


			PicturePath = sFolder(objRs("id"), 1) & "/" & objRs("fileName")
			'If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"

			PictureTitle = objRs("fileTitle")
			PictureAlt = objRs("fileAlt") : If PictureAlt = "" Then PictureAlt = PictureTitle
			PictureUrl = objRs("fileUrl")
			'PictureText = objRs("fileText")

			.Write "				<div class=""g230"">" & vbCrLf
			.Write "					<div class=""ctnt"">" & vbCrLf

			If FilesKontrol(PicturePath) Then
				.Write "						<div class=""icon"">" & vbCrLf

				'If  objRs("fileUrl") <> "" Then _
				'	.Write "<a href="""& PictureUrl &""" title="""& PictureTitle &""">" & vbCrLf
				.Write "<a href="""& strLinks &""" title="""& strTitle &""">" & vbCrLf
					.Write "<img style=""width:auto; height:auto;"" src="""& PicturePath &""" alt="""& PictureAlt &""" title="""& PictureTitle &""" />" & vbCrLf ' width=""20"" height=""20""
				'If  objRs("fileUrl") <> "" Then _
				.Write "						</a>" & vbCrLf

				.Write "						</div>" & vbCrLf
			End If

			.Write "						<div class=""icon-content"">" & vbCrLf
			.Write "							<h2 class=""title"">" & vbCrLf

			If  strLinks <> "javascript:;" Then _
				.Write "<a href="""& strLinks &""" title="""& strTitle &""">" & vbCrLf

			.Write strTitle & vbCrLf

			If  strLinks <> "javascript:;" Then _
				.Write "						</a>" & vbCrLf

			.Write "							</h2>" & vbCrLf

			'.Write "							<h2>"& strTitle &"</h2>" & vbCrLf
			'.Write "							<p>Energy Web Tasarım şahsınız veya kurumunuza özgün internet çözümleri ile verimliliğinizi arttırmanızı sağlar.</p>" & vbCrLf
			.Write ReadMore("style=""display:none;"" class=""smallbtn2"" rel=""bookmark""", strTitle, ReadMoreText(objRs("readmore_text")), strLinks, strText) & vbCrLf
			'.Write "							<a class=""smallbtn2"" href=""#""><span>Devamı...</span></a>" & vbCrLf
			.Write "						</div> <!-- .icon-content -->" & vbCrLf
			.Write "					</div> <!-- .column-content -->" & vbCrLf
			.Write "				</div> <!-- .g230 -->" & vbCrLf

			varModStatus = True
			If i Mod 4 = 3 Then
				varModStatus = False
				.Write "<div class=""clr""></div>" & vbCrLf
				.Write "<div class=""ewy_hr"" style=""margin:10px;""><hr /></div>" & vbCrLf
				.Write "<div class=""clr""></div>" & vbCrLf
			End If

			i = i + 1
		objRs.MoveNext() : Wend

		If varModStatus Then
			.Write "<div class=""clr""></div>" & vbCrLf
			.Write "<div class=""ewy_hr"" style=""margin:10px;""><hr /></div>" & vbCrLf
			.Write "<div class=""clr""></div>" & vbCrLf
		End If

		.Write "	<div class=""clr""></div>" & vbCrLf
		.Write "</section> <!-- #hptc -->" & vbCrLf
		.Write "<div class=""clr""></div>" & vbCrLf
		.Write "<!-- End home page top contents -->" & vbCrLf
	End With
	End If
	Set objRs = Nothing

End If
%>

		<!-- Begin Content -->
		<section id="content">
			<div class="content">
<%
	If Not GlobalConfig("request_option") = GlobalConfig("General_Home") Then
%>
				<div id="yourpage">
					<div class="page-title">
						<%
							strSharedUrl = Server.UrlEncode( GlobalConfig("site_uri") )
							strSharedUrl = Replace(strSharedUrl, "%2E", ".", 1, -1, 1)
							strTitle = GlobalConfig("PageTitle")
							If GlobalConfig("request_option") = GlobalConfig("General_Home") Then strTitle = "Web Tasarım - Freelance Webmaster"
							Response.Write("			<div class=""shared clearfix"">" & vbCrLf)
							Response.Write("			<ul class=""clearfix"">" & vbCrLf)
							Response.Write("				<li class=""fb""><a href=""http://www.facebook.com/sharer.php?u="& strSharedUrl &""" onclick=""window.open(this.href,'_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title="""& Lang("face_paylas") &""" target=""_blank"">"& Lang("face_paylas") &"</a></li>" & vbCrLf)
							Response.Write("				<li class=""tw""><a href=""http://twitter.com/?status="& Server.UrlEncode(BasHarfBuyuk(strTitle)) &"%20-%20"& strSharedUrl &""" onclick=""window.open(this.href,'_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title="""& Lang("twitter_paylas") &""" target=""_blank"">"& Lang("twitter_paylas") &"</a></li>" & vbCrLf)
							'If Site_REMOTE_ADDR = "z127.0.0.1" Then _
							'Response.Write("				<li class=""face_like""><iframe style=""border:none; overflow:hidden; width:110px; height:21px"" src=""http://www.facebook.com/plugins/like.php?href="& SharedUrl &"&amp;layout=button_count&amp;show_faces=true&amp;width=110&amp;action=like&amp;colorscheme=light&amp;height=21"" frameborder=""0"" scrolling=""no""></iframe></li>" & vbCrLf)
							Response.Write("			</ul>" & vbCrLf)
							Response.Write("			<h6>Paylaş: </h6></div>" & vbCrLf)

							'Response.Write("<ul class=""lang-menu clearfix"">")
							'	Call Languages(GlobalConfig("site_lang"))
							'Response.Write("</ul>")
						%>
						<div class="breadcrumbs">
							<%=GlobalConfig("cpathway")%>
						</div> <!-- #breadcrumbs End -->

						<div class="clr"></div>
					</div> <!-- .page-title End -->
				</div> <!-- #yourpage End -->
<%
	End If
%>

