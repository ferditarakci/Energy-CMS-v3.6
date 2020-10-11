<!--#include file="header.asp"-->

<%
			SQL = ""
			SQL = SQL & "SELECT id, parent_id, resim, title, alt, url, text" & vbCrLf
			SQL = SQL & "FROM #___files" & vbCrLf
			SQL = SQL & "WHERE (" & vbCrLf
			SQL = SQL & "	parent_id IN (57211, 57213)" & vbCrLf
			SQL = SQL & "	And Not id = 986" & vbCrLf
			SQL = SQL & "	And durum = 1" & vbCrLf
			SQL = SQL & "	And file_type = 1" & vbCrLf
			SQL = SQL & "	And parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
			SQL = SQL & "	And lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
			SQL = SQL & ")" & vbCrLf
			SQL = SQL & "ORDER BY Rand() Limit 8;"
			'SQL = setQuery( SQL )
			'Clearfix SQL

			i = 1
			Set objRs2 = setExecute( SQL )
				If Not objRs2.Eof Then
					With Response
%>


			<div class="clr"></div>
			<div class="ewy_hr" style="margin:20px 10px;"><hr /></div>
			<div class="clr"></div>

			<div id="mainfull">
				<!-- begin selected projects -->
				<div class="portfolio">
					<div class="side-content">
						<h2>Web Tasarım Referanslarımız</h2>
						<p>Aliquam nibh dolor, consequat ac porta vitae, sagittis sed lorem. Mauris ultricies neque ac leo aliquet eleifend.</p>
						<p>Aliquam nibh dolor, consequat ac porta vitae, sagittis sed lorem. Mauris ultricies neque ac leo aliquet eleifend.</p>
						<a class="smallbtn2" href="#"><span>Devamı...</span></a>
					</div>
					<ul class="portfolio_list">

<%
i = 0
While Not objRs2.Eof

	addClass = "" : If i Mod 4 = 0 Then addClass = " alpha"
	If i Mod 4 = 3 Then addClass = " omega"

	Pictureid = objRs2("id")
	PicturePath = sFolder(objRs2("parent_id"), 1) & "/" & objRs2("resim") & ""
	PictureTitle = objRs2("title") & ""
	PictureAlt = objRs2("alt") & ""' : If PictureAlt = "" Then PictureAlt = PictureTitle
	PictureUrl = objRs2("url") & ""
	PictureText = objRs2("text") & ""

	If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"


	.Write("<li class="""& addClass &""">" & vbcrlf) 
	.Write("	<div class=""entry-thumb"">" & vbcrlf) 
	.Write("		<div class=""entry-thumb-wrap"">" & vbcrlf) 

	If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<span id=""ewy_lnk_"& Pictureid &""" class=""ewy_lnk"& addClass &" hidden"">"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "//", "") &"</span>" & vbCrLf)
	If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<a id=""ewy_addlnk_"& Pictureid &""" href=""#"& SefURL(PictureTitle) &""" title="""& PictureTitle &""">")
	If Not PictureUrl = "" And Not Left(PictureUrl, 2) = "//" Then .Write("<a href="""& PictureUrl &""" title="""& PictureTitle &""" rel=""prettyPhoto[gallery]"" target=""_blank"">")

	'.Write("		<a href=""http://www.webtasarimx.net/themes/mundus/images/entries/full-size/image-8.jpg"" rel=""prettyPhoto[gallery]"" title=""Project Title"">" & vbcrlf) 
	.Write("			<span class=""overlay image""></span>" & vbcrlf) 
	.Write("			<img"& imgAlign(PicturePath, 146, 88, 142, 84) &" src="""& PicturePath &""" title="""& PictureTitle &""" alt="""& PictureTitle &""" />" & vbcrlf) 
	If PictureUrl <> "" Then .Write("		</a>" & vbcrlf)  ' imgAlign(PicturePath, 206, 116, 206, 116)
	.Write("		</div>" & vbcrlf) 
	.Write("	</div>" & vbcrlf) 
	.Write("	<h3 class=""entry-title"">" & vbcrlf) 
	.Write("		<a href=""#"">"& PictureTitle &"</a>" & vbcrlf) 
	.Write("	</h3>" & vbcrlf) 
	.Write("	<div class=""entry-description"">" & vbcrlf) 
	.Write("		<p>"& TextBR(PictureText) &"</p>" & vbcrlf) 
	.Write("	</div>" & vbcrlf) 
	.Write("</li>") 

		i = i + 1
	objRs2.MoveNext() : Wend
%>
				</ul>
				<div class="clr"></div>
			</div>
			<!-- end selected projects -->

<%		End With
	End If
Set objRs2 = Nothing
%>
		</div>


		<div class="clr"></div>
		<div class="ewy_hr" style="margin:20px 10px;"><hr /></div>
		<div class="clr"></div>


		<div id="main">
<%
Call MundusGetPages("ust_tekli", "a.sira ASC Limit 2", "OKs", 2, 1)
%>
		</div>
		<aside id="right_sidebar">
			<%
				'Call MundusModules("sag")
				Call MundusFacebook()
				Call MundusTags("", "", GlobalConfig("site_lang"))
			%>
			<div class="clr"></div>
		</aside> <!-- #right_sidebar End -->




<div class="clr"></div>


<%
	If GlobalConfig("request_option") = "ss" Then
%>
<%
	strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", 57204, "", "")
%>
			<div class="ewy_rek  hidden">
				<div class="rek noLM">
					<h4 class="title"><a href="<%=strLinks%>" title="Web Tasarım">WEB TASARIM</a></h4>
					<p>
						<img class="img-left" src="<%=GlobalConfig("General_ThemePath")%>images/anasayfa-icon/icon-1.png" title="Web tasarım" alt="Web tasarım" width="48" height="48" />
						<a href="<%=GlobalConfig("sBase")%>"><strong style="font-weight:normal;">Energy Web Tasarım</strong></a> şahsınız veya kurumunuza <strong style="font-weight:normal;">özgün internet çözümleri</strong> ile verimliliğinizi arttırmanızı sağlar.
					</p>
					<p class="button">
						<a class="smallbtn2" href="<%=strLinks%>" title="Web tasarım"><span><strong class="hidden">web tasarım </strong>Devamı...</span></a>
					</p>
				</div>
				<div class="rek">
					<h4 class="title blink"><a href="<%=GlobalConfig("sRoot")%>demo/cms/v3.6/panel/" title="Energy içerik yönetim sistemi" target="_blank">ENERGY <abbr title="İÇERİK YÖNETİM SİSTEMİ">CMS</abbr> (DEMO)</a></h4>
					<p>
						<img class="img-left" src="<%=GlobalConfig("General_ThemePath")%>images/anasayfa-icon/icon-2.png" title="Energy içerik yönetim sistemi" alt="Energy içerik yönetim sistemi" width="48" height="48" />
						<strong style="font-weight:normal;">Energy içerik yönetim sistemi</strong>&#39;yle sınırsız sayıda içerik, resim, video, haber, anket eklemenin keyfini yaşayın.
					</p>
					<p class="button">
						<a class="smallbtn2" href="<%=GlobalConfig("sRoot")%>demo/cms/v3.6/panel/" title="Demo Energy Cms&#39;yi Test Edin" target="_blank"><span>Test Edin</span></a>
					</p>
				</div>
				<div class="rek">
					<h4 class="title"><a href="<%=GlobalConfig("sRoot")%>web-tasarim-hizmetleri" title="Sunduğumuz Hizmetler">HİMETİMİZ</a></h4>
					<p>
						<img class="img-left" src="<%=GlobalConfig("General_ThemePath")%>images/anasayfa-icon/tools_icon.png" title="7/24 Online destek" alt="7/24 Online destek" width="48" height="48" />
						Freelancer olarak İstanbul içi ve online olarak her yere <a href="<%=GlobalConfig("sBase")%>"><em>web tasarım</em></a>, <a href="<%=GlobalConfig("sBase")%>"><em>web yazılım</em></a>, <a href="<%=GlobalConfig("sBase")%>"><em>xhtml css arayüz geliştirme</em></a> hizmeti sunuyoruz.
					</p>
					<!--<p>
						<img class="img-left" src="<%=GlobalConfig("General_ThemePath")%>images/anasayfa-icon/tools_icon.png" title="7/24 Online destek" alt="7/24 Online destek" width="48" height="48" />
						<strong style="font-weight:normal;">Energy Web Yazılım</strong> 7/24 online destek ile kesin ve doğru çözümler üretir.
					</p>-->
					<p class="button">
						<a class="smallbtn2" href="<%=GlobalConfig("sRoot")%>webtasarim-iletisim-bilgileri" title="7/24 Bizi arayabilirsiniz"><span>Bizi Arayın</span></a>
					</p>
				</div>
				<div class="rek noRM">
					<h4 class="title"><a href="<%=GlobalConfig("sRoot")%>webtasarim-iletisim-bilgileri" title="Bizimle irtibata geçin">İLETİŞİM</a></h4>
					<p>
						<img class="img-left" src="<%=GlobalConfig("General_ThemePath")%>images/anasayfa-icon/email_icon.png" title="Bizimle iletişim kurun" alt="Bizimle iletişim kurun" width="48" height="48" />
						<strong style="font-weight:normal;">Energy Web Yazılım</strong> 7/24 online destek ile kesin ve doğru çözümler üretir. Bizimle iletişime geçerek istediğiniz konuda bilgi edinebilirsiniz.
					</p>
					<p class="button">
						<a class="smallbtn2" href="<%=GlobalConfig("sRoot")%>webtasarim-iletisim-bilgileri" title="Bizimle iletişim kurun"><span>İletişime Geçin</span></a>
					</p>
				</div>
				<div class="clr"></div>
			</div> <!-- .ewy_rek End -->

			<div class="clr"></div>








	<div id="ewy_maincolumn" class="content hidden">
		<div class="ewy_nopad">
<%
'			Response.Write(Server.HtmlEncode("" & _
'			"					İstanbul Web Tasarım, Ümraniye Web Tasarım, " & vbcrlf & _ 
'			"					ASP Yazılım, Asp Web Yazılım, Asp Programlama, Asp 404 Seolink, Asp Web Tasarım, Css Web Tasarım, Web Tasarım İstanbul, Web Tasarım Ümraniye, Web Tasarım Kadıköy, " & vbcrlf & _ 
'			"					Html Css Asp Web Tasarım, Web Tasarımı Yapılır, Web Tasarımcılar, İnternet Sitesi Kurulumu, Kadıköy Web Tasarım, " & vbcrlf & _ 
'			"					İnternet Sitesi Tasarımı, Kurumsal Web Sitesi, kurumsal İnternet Sitesi, İstanbul Web Tasarım Firmaları, Kadıköy Web Tasarım, Dinamik Web Sitesi, " & vbcrlf & _ 
'			"					Web Sitesi Nasıl Yapılır, Active Server Pages Nedir, Asp Nedir, İçerik Yönetim Sistemi, CMS Nedir, " & vbcrlf & _ 
'			"					Energy CMS Nedir, Admin Panelli Siteler Nasıl Yapılır, Admin Panelli Site Yapanlar, Web Site Yönetimi, " & vbcrlf & _ 
'			"					Ürün Tanıtım Siteleri, Kartvizit Web Sayfaları, Kartvizit Web Sayfası, Kartvizit İnternet Sitesi, " & vbcrlf & _ 
'			"					Windows Hosting Hizmetleri, Seo Link Nasıl Yapılır, Seflink Nasıl Yapılır, Web Dizayn, " & vbcrlf & _ 
'			"					Web Dizayni, Web Dizaynı, İnternet Sitesi Yapımı, İnternet Sitesi Kurulumu, Kurumsal Web Sitesi Yapımı, Web Design, Anadolu Yakası Web Tasarım"))

	With Response
		.Write("	<div class=""divider"" style=""margin-top:0;""></div>" & vbCrLf)
		strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", 57212, 0, "")
		.Write("	<div class=""contents clearfix"" style=""margin:0;"">" & vbCrLf)
		'.Write("		<div class=""sutun"">" & vbCrLf)
		'.Write("			<div class=""orta"">" & vbCrLf)
		.Write("				<h2 class=""title"" id=""webtasarim-yazilim-calismalari""><a href="""& strLinks &""" title=""Web Tasarım ve Yazılım Çalışmalarım"">ÇALIŞMALARIMDAN BAZILARI</a></h2>" & vbCrLf)
		.Write("				<ol class=""referans home clearfix"">" & vbCrLf)

			SQL = ""
			SQL = SQL & "SELECT id, parent_id, resim, title, alt, url" & vbCrLf
			SQL = SQL & "FROM #___files" & vbCrLf
			SQL = SQL & "WHERE (" & vbCrLf
			SQL = SQL & "	parent_id IN (57211, 57213)" & vbCrLf
			SQL = SQL & "	And Not id = 986" & vbCrLf
			SQL = SQL & "	And durum = 1" & vbCrLf
			SQL = SQL & "	And file_type = 1" & vbCrLf
			SQL = SQL & "	And parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
			SQL = SQL & "	And lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
			SQL = SQL & ")" & vbCrLf
			SQL = SQL & "ORDER BY Rand() Limit 8;"
			'SQL = setQuery( SQL )
			'Clearfix SQL

			i = 1
			Set objRs2 = setExecute( SQL )
				While Not objRs2.Eof

					Pictureid = objRs2("id")
					PicturePath = sFolder(objRs2("parent_id"), 1) & "/" & objRs2("resim") & ""
					PictureTitle = objRs2("title") & ""
					PictureAlt = objRs2("alt") & ""' : If PictureAlt = "" Then PictureAlt = PictureTitle
					PictureUrl = objRs2("url") & ""


					If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"

					addClass = "" : If i Mod 4 = 1 Then addClass = " class=""no-margin"""

					.Write("						<li"& addClass &">" & vbCrLf)
					.Write("							<div class=""grid"">" & vbCrLf)
					.Write("								<h5 id="""& SefURL(PictureTitle) &""" title="""& PictureTitle &""">"& PictureTitle &"</h5>" & vbCrLf)
					.Write("								")

					'If PictureUrl <> "" And Left(PictureUrl, 2) = "//" Then .Write("<a rel=""nofollow"" href="""& PictureUrl &""" title="""& PictureTitle &""" target=""_blank"">")
					'If PictureUrl <> "" And Not Left(PictureUrl, 2) = "//" Then .Write("<a href="""& PictureUrl &""" title="""& PictureTitle &""" target=""_blank"">")

					addClass = "" : If inStrBot() Then addClass = " o"
					If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<span id=""ewy_lnk_"& Pictureid &""" class=""ewy_lnk"& addClass &" hidden"">"& Replace(Replace(Replace(PictureUrl, "http://", ""), "https://", ""), "//", "") &"</span>" & vbCrLf)
					If Not PictureUrl = "" And Left(PictureUrl, 2) = "//" Then .Write("<a id=""ewy_addlnk_"& Pictureid &""" href=""#"& SefURL(PictureTitle) &""" title="""& PictureTitle &""">")
					If Not PictureUrl = "" And Not Left(PictureUrl, 2) = "//" Then .Write("<a href="""& PictureUrl &""" title="""& PictureTitle &""" target=""_blank"">")

					'Clearfix "<div style=""border:1px solid; width:138px; height:74px;""><img" & imgAlign(PicturePath, 138, 74, 134, 70) & " src="""& PicturePath &""" /></div>"
					.Write("<span class=""img_bg""><img"& imgAlign(PicturePath, 144, 86, 140, 84) &" src="""& PicturePath &""" title="""& PictureTitle &""" alt="""& PictureTitle &""" /></span>")

					'.Write("<span>" & Replace(PictureTitle, " - ", " <br />") & "</span>")

					If PictureUrl <> "" Then .Write("</a>")
					.Write("								" & vbCrLf)
					'.Write("		<p>"& TextBR(PictureText) &"</p>")
					.Write("							</div>" & vbCrLf)
					.Write("						</li>" & vbCrLf)

					i = i + 1
				objRs2.MoveNext() : Wend
			Set objRs2 = Nothing

		.Write("				</ol>" & vbCrLf)
		.Write("				<div class=""clr""></div>" & vbCrLf)
		.Write("				<div style=""float:right; margin-top:0px; margin-right:3px;""><a class=""smallbtn2"" href="""& strLinks &""" title=""Diğer Web Tasarım ve Yazılım Çalışmalarım""><span>Diğer Çalışmalarım</span></a></div>" & vbCrLf)
		.Write("				<div class=""clr""></div>" & vbCrLf)
		'.Write("			</div> <!-- .orta End -->" & vbCrLf)
		'.Write("		</div> <!-- .sutun End -->" & vbCrLf)
		.Write("	</div> <!-- .contents End -->" & vbCrLf)
	End With

	'Response.Clear
	'Response.contenttype = "text/plain"
	'Response.Write("	<div id=""home-makale"">")
	'Call PixGetPages("ust", "sira ASC", "OKs", 3, 1)
	'Response.Write("	</div> <!-- #home-makale End -->")
	'Response.end

	'Response.Clear
	'Response.contenttype = "text/plain"

	'// Sayfa ikili içerik
	Response.Write("	<div class=""divider""></div>")
	'Response.Write("	<div id=""homeGrid"">")
	'If inStrBot() Then
	'	Call PixGetPages("ust", "a.sira ASC Limit 4", "OKs", 1, 0)
	'	Response.Write("	<div class=""clr divider""></div>")
	'	Call PixGetPages("genel", "a.sira Limit 2", "OKs", 1, 0)
	'Else
		Call MundusGetPages("ust_tekli", "a.sira ASC Limit 2", "OKs", 2, 1)
	'End If
	Response.Write("	<div class=""clr""></div>")
	'Response.Write("	</div> <!-- #homeGrid End -->")
	'Response.end

%>

<div class="clr"></div>

<%
	'// Sayfa içerik
	'Call PixGetPages("genel", "Rand() Limit 1", "OKs", 1, 1)
If Not GlobalConfig("description") = "" Then _
	Response.Write("<p>&nbsp;</p><p class=""text-justify hidden"">" & TrimFix(Replace(GlobalConfig("description"), ",", " ")) & "</p>" & vbCrLf)

If Not GlobalConfig("keyword") = "" Then _
	Response.Write("<p>&nbsp;</p><p class=""text-justify hidden"">" & TrimFix(Replace(GlobalConfig("keyword"), ",", " ")) & "</p>" & vbCrLf)
%>


		</div> <!-- .nopad End -->
	</div> <!-- #maincolumn End -->

		<%
			end if
		%>


<!--#include file="footer.asp"-->
