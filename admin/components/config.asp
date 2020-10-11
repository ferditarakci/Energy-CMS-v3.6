<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo settings">Site genel ayarları</td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
					<li><a id="form_submit" href="#" title="Site ayarlarını kaydet"><span class="save"></span>Kaydet</a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Page") & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>

<form id="EnergyAdminForm" action="?mod=post&amp;task=<%=mods & sLang & Debug%>" method="post">
<input id="pageid" name="pageid" type="hidden" value="1" />

<div class="maincolumn">
	<div class="maincolumn-body">
<%
strLangTitle = "" '// Lang Title
strLangCode = "" '// Lang Code
strLC = "" '// Lang input Code
strLT = "" '// Lang input Title
strST = "" '// Short Title
strTabContent = "" '// Content Text
strHits = "" '// Hit input
strFiles = ""
strContentiD = 0

Dim strGlobalConfig, strGlobalConfigResimYazi, parent_logo_alt_text, parent_copyright, parent_resim_yazi
strGlobalConfig = ""
strGlobalConfigResimYazi = ""

Set objRs = setExecute("SELECT title, lng FROM #___languages WHERE durum = 1 ORDER BY default_lng DESC, sira ASC;")
Do While Not objRs.Eof
	strContentiD = strContentiD + 1
	If sTotalLang() > 1 Then strLangTitle = objRs("title") &" "
	strLangCode = objRs("lng")
	strContentTitle = ""
	strContentShortTitle = ""
	parent_logo_alt_text = ""
	parent_copyright = ""
	strContentLink = ""
	strContentText = ""
	strContentShortText = ""
	strContentKeyword = ""
	strContentDescription = ""
	strContentHit = 0
	strDirection = ""
	strDirection2 = ""
	If strLangCode = "AR" Then strDirection = "dir=""rtl"" lang=""ar"" xml:lang=""ar"" "
	'If strLangCode = "AR" Then strDirection2 = "onclick=""tinymce.get('text_"& strLangCode &"').getBody().dir = 'rtl';"" "



	Set objRs2 = setExecute("SELECT site_ismi, slogan, logo_alt_text, copyright, description, keyword FROM #___ayar_langs WHERE lang = '"& strLangCode &"';")
	If Not objRs2.Eof Then
		'parent_id = objRs("id")
		strContentTitle = HtmlEncode(objRs2("site_ismi"))
		strContentShortTitle = HtmlEncode(objRs2("slogan"))
		parent_logo_alt_text = HtmlEncode(objRs2("logo_alt_text"))
		parent_copyright = HtmlEncode(objRs2("copyright"))
		strContentDescription = HtmlEncode(objRs2("description"))
		strContentKeyword = HtmlEncode(objRs2("keyword"))
		'parent_resim_yazi = HtmlEncode(objRs2("resim_yazi"))
	End If
	Set objRs2 = Nothing


If sTotalLang() > 1 Then
	uiActiveClass = ""
	If GlobalConfig("site_lang") = strLangCode Then uiActiveClass = " class=""ui-tabs-selected ui-state-active"""
	strTabButton = strTabButton & "			<li"& uiActiveClass &"><a "& strDirection2 &" rel=""languages"" tabindex=""-1"" href=""#tabs_"& strLangCode &""" title="""& strLangTitle &"Sayfa Ayarları"">"& strLangTitle &"</a></li>" & vbcrlf
End If

If sTotalLang() > 1 Then
	strGlobalConfig = strGlobalConfig & ("	<div id=""tabs_"& strLangCode &""">" & vbcrlf)
	strGlobalConfig = strGlobalConfig & ("		<div class=""head"">" & vbcrlf)
	strGlobalConfig = strGlobalConfig & ("		<h3 style=""margin-top:5px; font-size:19px; font-weight:bold; text-shadow:none;"" class=""head-box-title"">"& strLangTitle &"Sayfa Ayarları</h3>" & vbcrlf)
Else
	strGlobalConfig = strGlobalConfig & ("	<div class=""m_box"">" & vbcrlf)
	strGlobalConfig = strGlobalConfig & ("		<div class=""title""><h3 class=""box-title"">Genel Sayfa Ayarları</h3></div>" & vbcrlf)
strGlobalConfig = strGlobalConfig & ("		<div class=""head"">" & vbcrlf)
End If


strGlobalConfig = strGlobalConfig & ("			<div class=""form-table"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				<div class=""row clearfix"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""l""><label for=""site_title_"& strLangCode &"""><span>:</span>Site İsmi (Title)</label></div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""r"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<input "& strDirection &"style=""width:95%; *width:93%;"" class=""inputbox required"" name=""site_title_"& strLangCode &""" id=""site_title_"& strLangCode &""" value="""& strContentTitle &""" maxlength=""100"" type=""text"" />" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<a class=""tooltip"" title=""Web tarayıcısında ve arama motorları sonuçlarında görüntülenecek site ismi. <br /> Site ismi SEO için önem arz eder, <br />Arama motorlarında başlıklar maksimun 60 karakter ile sınırlıdır, uzun başlıklar girmeniz önerilmez. <br />Maksimun 100 karekter."">&nbsp;</a>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				<div class=""row clearfix"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""l""><label for=""site_slogan_"& strLangCode &"""><span>:</span>Slogan</label></div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""r"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<input "& strDirection &"style=""width:95%; *width:93%;"" class=""inputbox"" name=""site_slogan_"& strLangCode &""" id=""site_slogan_"& strLangCode &""" value="""& strContentShortTitle &""" maxlength=""150"" type=""text"" />" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<a class=""tooltip"" title=""Firmanızın bir sloganı var ise buraya girin. <br />Maksimun 150 karekter."">&nbsp;</a>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				<div class=""row clearfix"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""l""><label for=""site_logo_alt_"& strLangCode &"""><span>:</span>Logo Alt Text</label></div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""r"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<input "& strDirection &"style=""width:95%; *width:93%;"" class=""inputbox"" name=""site_logo_alt_"& strLangCode &""" id=""site_logo_alt_"& strLangCode &""" value="""& parent_logo_alt_text &""" maxlength=""150"" type=""text"" />" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<a class=""tooltip"" title=""Site Logosunun üstüne geldiğinizde görüntülenecek olan kısa yazı. <br />Maksimun 150 karekter."">&nbsp;</a>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				<div class=""row clearfix"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""l""><label for=""site_copyright_"& strLangCode &"""><span>:</span>Copyright &copy;</label></div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""r"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<input "& strDirection &"style=""width:95%; *width:93%;"" class=""inputbox"" name=""site_copyright_"& strLangCode &""" id=""site_copyright_"& strLangCode &""" value="""& parent_copyright &""" maxlength=""150"" type=""text"" />" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<a class=""tooltip"" title=""Sitenizin telif hakkı yazısı. <br />Maksimun 150 karekter."">&nbsp;</a>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				<div class=""row clearfix"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""l""><label for=""site_description_"& strLangCode &"""><span>:</span>Description</label></div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""r"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<textarea "& strDirection &"style=""width:95% !important; *width:93% !important; height:60px;"" class=""min3 inputbox"" name=""site_description_"& strLangCode &""" id=""site_description_"& strLangCode &""" maxlength=""160"">"& strContentDescription &"</textarea>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<a class=""tooltip"" title=""Arama motorlarının temel aldığı, SEO için önem arz eden, <br />site hakkında bilgi veren temel bir kısa açıklama yazısı. <br />Maksimun 160 karekter."">&nbsp;</a>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				<div class=""row clearfix"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""l""><label for=""site_keyword_"& strLangCode &"""><span>:</span>Keyword</label></div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					<div class=""r"">" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<textarea "& strDirection &"style=""width:95% !important; *width:93% !important; height:60px;"" class=""min3 inputbox"" name=""site_keyword_"& strLangCode &""" id=""site_keyword_"& strLangCode &""" maxlength=""200"">"& strContentKeyword &"</textarea>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("						<a class=""tooltip"" title=""Yine arama motorlarının temel aldığı, SEO için önem arz eden, <br />sitenizin içeriğini oluşturan yazılardan seçilmiş olan kelimeler. <br />Kelimeleri <q style=&quot;text-decoration: underline;&quot;>virgül</q> ile ayırınız. Örnek: <q style=&quot;text-decoration: underline;&quot;>web tasarım, web yazılım</q> <br />Maksimun 200 karekter."">&nbsp;</a>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("					</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("				</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("			</div>" & vbcrlf) 
strGlobalConfig = strGlobalConfig & ("		</div>" & vbcrlf) 

strGlobalConfig = strGlobalConfig & ("	</div>" & vbcrlf) 

'If sTotalLang() > 1 Then _
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("			<h3><a href=""#"">"& strLangTitle &"Görsel Yazısı</a></h3>" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("			<div class=""form-table"">" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("				<div class=""row clearfix"">" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("					<div><label for=""site_resim_yazi_"& strLangCode &""">"& strLangTitle &"Görsel Yazısı <a class=""tooltip"" title=""Resim üstüne uygulanacak olan "& strLangTitle &"yazıyı buraya girin. <br />Maksimun 200 karekter."">&nbsp;</a></label></div>" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("					<div>" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("						<textarea style=""width:95% !important;"" "& eReadonly(Not GlobalConfig("general_admin")) &" class=""min"" name=""site_resim_yazi_"& strLangCode &""" id=""site_resim_yazi_"& strLangCode &""" maxlength=""200"">"& parent_resim_yazi &"</textarea>" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("					</div>" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("				</div>" & vbcrlf) 
'strGlobalConfigResimYazi = strGlobalConfigResimYazi & ("			</div>" & vbcrlf) 



strLC = strLC & "<input name=""languages"" value="""& strLangCode &""" type=""hidden"" />" & vbCrLf
strLT = strLT & "<input name=""lang_title_"& strLangCode &""" value="""& Trim(strLangTitle) &""" type=""hidden"" />" & vbCrLf

	objRs.MoveNext() : Loop
Set objRs = Nothing


If sTotalLang() > 1 Then
	Response.Write("<div class=""energy-tabs""><div id=""tabs"">")
	Response.Write("<ul>")
	Response.Write( vbCrLf & strTabButton )
	Response.Write("</ul>")
End If

Response.Write( strGlobalConfig )
If sTotalLang() > 1 Then Response.Write("</div></div>" & vbCrLf)


Response.Write( strLC )
Response.Write( strLT )

%>
		<div class="m_box">
			<div class="title"><h3 class="box-title">Seo Ayarları</h3></div>
			<div class="head">
				<div class="form-table">
					<div class="row clearfix">
						<div class="l"><label for="site_domain"><span>:</span>Domain</label></div>
						<div class="r">
							<input class="inputbox" name="site_domain" id="site_domain" value="<%=GlobalConfig("domain")%>" type="text" />
							<a class="tooltip" title="Sitenizin alan adını belirtin. Birden Fazla alan adı kullanıyorsanız alan adlarını <q style=&quot;text-decoration: underline;&quot;>virgül</q> ile ayırınız.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_verify"><span>:</span>Google Verify</label></div>
						<div class="r">
							<textarea style="width:95% !important; *width:93% !important; height:80px;" class="min3 inputbox" name="site_verify" id="site_verify"><%=HtmlEncode(GlobalConfig("verify"))%></textarea>
							<a class="tooltip" title="Google, Alexa, Yahoo, Bing vb. arama motorlarının <br />web sitesi sahiblerine sunduğu <q style=&quot;text-decoration: underline;&quot;>Site Yöneticisi Araçları</q> hizmetinden yararlananlar için <br />sitelerine eklenmek üzere tanımlanmış bir onay kodudur.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_analytics"><span>:</span>Google Analytics</label></div>
						<div class="r">
							<textarea style="width:95% !important; *width:93% !important; height:80px;" class="min3 inputbox" name="site_analytics" id="site_analytics"><%=HtmlEncode(GlobalConfig("analytics"))%></textarea>
							<a class="tooltip" title="Google&apos;ın web sitesi sahiblerine sunduğu <q style=&quot;text-decoration: underline;&quot;>Ziyaretçi izleme</q> hizmetinden yararlananlar için <br />sitelerine eklenmek üzere tanımlanmış bir ziyaretçi takip kodudur.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_seflink"><span>:</span>Permalink</label></div>
						<div class="r">
							<select name="site_seflink" id="site_seflink" style="width:200px;">
								<option <%If GlobalConfig("seo_url") Then Response.Write("selected=""selected"" ")%>value="1">Permalink Aktif</option>
								<option <%If Not GlobalConfig("seo_url") Then Response.Write("selected=""selected"" ")%>value="0">Permalink Pasif</option>
							</select>
							<a class="tooltip" title="Bu özelliği aktif ettiğiniz taktirde web sayfanızda ki tüm bağlantılar <br /><q style=&quot;font-style:normal; text-decoration: underline;&quot;>ARAMA MOTORU DOSTU</q>  bağlantı olarak oluşturulacaktır. <br />Bu özelliği kullanabilmeniz için sunucunuzda özel <q style=&quot;font-style:normal; text-decoration: underline;&quot;>404 hata sayfası</q> tanımlı olmalıdır.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="r"><%Dim SeflinkDurum : SeflinkDurum = GlobalConfig("seo_url")%>
							<ul>
								<li><span style="width:auto; margin:0; padding-top:5px" class="text blue">Normal Link: <span class="red"><%GlobalConfig("seo_url") = False%><%=UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "iletisim-bilgileri", "", "", "")%></span></span></li>
								<li><span style="width:auto; margin:0; padding-top:5px" class="text blue">Örnek Permalink: <span class="green"><%GlobalConfig("seo_url") = True%><%=UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "iletisim-bilgileri", "", "", "")%></span></span></li>
							</ul>
						</div><%GlobalConfig("seo_url") = SeflinkDurum%>
					</div>
				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><h3 class="box-title">Sosyal Ağlar</h3></div>
			<div class="head">
				<div class="form-table">
					<div class="row clearfix">
						<div class="l"><label for="facebook_url"><span>:</span>Facebook Link</label></div>
						<div class="r">
							<input class="inputbox" name="facebook_url" id="facebook_url" value="<%=GlobalConfig("facebook_url")%>" type="text" />
							<a class="tooltip" title="Temanız destekliyorsa bu bağlantıyı eklediğinizde Facebook sayfanız için bir buton belirecektir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="twitter_url"><span>:</span>Twitter Link</label></div>
						<div class="r">
							<input class="inputbox" name="twitter_url" id="twitter_url" value="<%=GlobalConfig("twitter_url")%>" type="text" />
							<a class="tooltip" title="Temanız destekliyorsa bu bağlantıyı eklediğinizde Twitter sayfanız için bir buton belirecektir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="googleplus_url"><span>:</span>Google+ Link</label></div>
						<div class="r">
							<input class="inputbox" name="googleplus_url" id="googleplus_url" value="<%=GlobalConfig("googleplus_url")%>" type="text" />
							<a class="tooltip" title="Temanız destekliyorsa bu bağlantıyı eklediğinizde Google Plus sayfanız için bir buton belirecektir.">&nbsp;</a>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>
<style type="text/css">
.image_files.noSortable {
	padding:5px 0;
	margin:3px 0px;
	border:none;
	background-color:none;
}
.image_files.noSortable li {
	width:auto;
	height:auto;
	margin:0 !important;
	padding:2px !important;
}
.image_files.noSortable li .icons {
	right:-5px;
}
.image_files.noSortable li .img img {
	width:auto;
	height:auto;
	max-width:330px;
	max-height:330px;
}
</style>
<div class="rightcolumn">

		<div class="m_box">
			<div class="title">
				<div style="float:left; margin-top:2px; margin-left:4px;" id="upload" class="smallicon"><span>Resim Seç</span></div>
				<a style="float:left; margin-top:10px;" class="tooltip" tabindex="-1" href="#" title="Yanda ki ikona tıklayarak sitede görüntülenecek logonuzu yükleyebilirsiniz <br /> Desteklenen uzantılar .JPG, .GIF ve .PNG'dir.<br /> Ancak daha temiz bir görüntü için .PNG formatında transparan logo yüklemenizi öneririz. <br />Logo boyutlarının kaç piksel olması gerektiğini seçtiğiniz tema özelliklerinde görebiliriziniz.">&nbsp;</a>
				<h3 style="float:right; margin-right:8px;" class="box-title">Site Logosu</h3>
			</div>
			<div class="head">
				<div class="form-table">
					<div class="row clearfix">
						<h4 style="font-size: 11px;">Sitede Görüntülenecek Logo</h4>
						<div style="overflow:hidden;">
							<div id="status"></div>
							<ul class="image_files noSortable clearfix" id="files_"><%
							If GlobalConfig("logoName") <> "" Then
							%>
								<li id="image-id_1" class="success">
									<div class="icons tooltip">
										<span class="deleteFile" title="Resmi Kalıcı Olarak Sil"><em>&nbsp;</em></span>
									</div>
									<div class="img">
										<a rel="img-show" href="<%=GlobalConfig("logoPath") & "/" & GlobalConfig("logoName")%>" title="">
											<img src="<%=GlobalConfig("logoPath") & "/" & GlobalConfig("logoName")%>" title="" alt="">
										</a>
									</div>
								</li><%
								End If
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="m_box">
			<div class="title"><h3 class="box-title">Mail Ayarları</h3></div>
			<div class="head">
				<div class="form-table">
					<div class="row clearfix">
						<div class="l"><label for="site_domain"><span>:</span>Mail Sunucu</label></div>
						<div class="r">
							<input style="width:180px;" class="inputbox" name="site_mail_host" id="site_mail_host" value="<%=GlobalConfig("mail_host")%>" maxlength="100" type="text" />
							<a class="tooltip" title="Siteniz üzerinden iletişim formları aracılığıyla mail gönderebilmek için gerekli mail sunucusu.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_mail_from"><span>:</span>Gön. Mail Adresi</label></div>
						<div class="r">
							<input style="width:180px;" class="inputbox" name="site_mail_from" id="site_mail_from" value="<%=GlobalConfig("mail_from")%>" maxlength="100" type="text" />
							<a class="tooltip" title="Mail gönderebilmek için gerekli aktif mail adresi.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_mail_username"><span>:</span>Mail Kullanıcı Adı</label></div>
						<div class="r">
							<input style="width:180px;" class="inputbox" name="site_mail_username" id="site_mail_username" value="<%=GlobalConfig("mail_user_name")%>" maxlength="100" type="text" />
							<a class="tooltip" title="Mail adresinin kullanıcı adı.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_mail_password"><span>:</span>Mail Şifre</label></div>
						<div class="r">
							<input style="width:180px;" class="inputbox" name="site_mail_password" id="site_mail_password" value="<%=GlobalConfig("mail_pwrd")%>" autocomplete="off" maxlength="50" type="<%If GlobalConfig("general_admin") Then Response.Write("text") Else Response.Write("password")%>" />
							<a class="tooltip" title="Mail adresinin şifresi.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_mail_to"><span>:</span>Gidecek Mail</label></div>
						<div class="r">
							<input style="width:180px;" class="inputbox" name="site_mail_to" id="site_mail_to" value="<%=GlobalConfig("mail_to")%>" maxlength="250" type="text" />
							<a class="tooltip" title="Siteniz üzerinden gönderilen mailleri alacak olan mail adresi. <br />Birden fazla alıcı adresi eklemek için <q style=&quot;text-decoration: underline;&quot;>virgül</q> ile ayırınız. <br />Örnek: bilgi@webtasarimx.net, bilgi@webtasarimx.net">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix"> 
						<div class="l"><label for="site_mail_type"><span>:</span>Bileşen</label></div>
						<div class="r">
							<%
								Dim arrMailBilesen
								arrMailBilesen = Array("Persits Asp Mail", "CDOSYS Mail", "JMail", "CDONTS Mail")

								Response.Write("<select name=""site_mail_type"" id=""site_mail_type"" style=""width:180px;"">")
								Response.Write("<option value="""">Seçiniz</option>")
								For i = 0 To UBound(arrMailBilesen)
									Response.Write("<option"& eSelected(GlobalConfig("mail_type") = arrMailBilesen(i) Or (GlobalConfig("mail_type") = "" And i = 0)) &" value="""& arrMailBilesen(i) &""">" & arrMailBilesen(i) & "</option>")
								Next
								Response.Write("</select>")
							%>
							<a class="tooltip" title="Mail gönderebilmek için sunucunuzda yüklü olan E-Mail bileşeni. <br />Persits.MailSender Önerilir.">&nbsp;</a>
						</div>
					</div>
				</div>
			</div>
		</div>



<%If GlobalConfig("general_admin") Then%>
		<div class="m_box">
			<div class="title"><h3 class="box-title">Diğer Ayarlar</h3></div>
			<div class="head">
				<div class="form-table">
					<div class="row clearfix">
						<div class="l"><label for="site_status"><span>:</span>Siteyi Yayınla</label></div>
						<div class="r">
							<select name="site_status" id="site_status" style="width:180px;">
								<option <%=eSelected(GlobalConfig("site_status"))%>value="1">Evet Yayınlandı</option>
								<option <%=eSelected(Not GlobalConfig("site_status"))%>value="0">Hayır Kapalı</option>
							</select>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="MaxPage"><span>:</span>Maksimun Sayfa</label></div>
						<div class="r">
							<input name="MaxPage" id="MaxPage" class="inputbox" value="<%=GlobalConfig("MaxPage")%>" style="width:100px;" type="number" step="1" min="0" max="9999" />
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="MaxCategory"><span>:</span>Maksimun Kategori</label></div>
						<div class="r">
							<input name="MaxCategory" id="MaxCategory" class="inputbox" value="<%=GlobalConfig("MaxCategory")%>" style="width:100px;" type="number" step="1" min="0" max="9999" />
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="MaxProduct"><span>:</span>Maksimun Ürün</label></div>
						<div class="r">
							<input name="MaxProduct" id="MaxProduct" class="inputbox" value="<%=GlobalConfig("MaxProduct")%>" style="width:100px;" type="number" step="1" min="0" max="9999" />
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="MaxBanner"><span>:</span>Maksimun Banner</label></div>
						<div class="r">
							<input name="MaxBanner" id="MaxBanner" class="inputbox" value="<%=GlobalConfig("MaxBanner")%>" style="width:100px;" type="number" step="1" min="0" max="9999" />
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="MaxPoll"><span>:</span>Maksimun Anket</label></div>
						<div class="r">
							<input name="MaxPoll" id="MaxPoll" class="inputbox" value="<%=GlobalConfig("MaxPoll")%>" style="width:100px;" type="number" step="1" min="0" max="9999" />
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_urun_yonetimi"><span>:</span>Ürün Yönetimi</label></div>
						<div class="r">
							<select name="site_urun_yonetimi" id="site_urun_yonetimi" style="width:180px;">
								<option <%=eSelected(GlobalConfig("urun_yonetimi"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("urun_yonetimi"))%>value="0">Pasif</option>
							</select>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_doviz_kurlari"><span>:</span>Döviz Kurları</label></div>
						<div class="r">
							<select name="site_doviz_kurlari" id="site_doviz_kurlari" style="width:180px;">
								<option <%=eSelected(GlobalConfig("doviz_modul"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("doviz_modul"))%>value="0">Pasif</option>
							</select>
							<a class="tooltip" title="Bu özelliği aktif ederek Merkez Bankası döviz kurlarını anlık olarak sitenizde gösterebilirsiniz. <em style=&quot;text-decoration: underline;&quot;>Özel sayfa tasarımı gerektirir.</em>">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_vitrin_urunleri"><span>:</span>Vitrin Ürünleri</label></div>
						<div class="r">
							<select name="site_vitrin_urunleri" id="site_vitrin_urunleri" style="width:180px;">
								<option <%=eSelected(GlobalConfig("vitrin_modul"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("vitrin_modul"))%>value="0">Pasif</option>
							</select>
							<a class="tooltip" title="Bu özelliği aktif ederek anasayfada ürünlerinizi sergileyebilirsiniz. <em style=&quot;text-decoration: underline;&quot;>Özel sayfa tasarımı gerektirir.</em>">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_vitrin_kategori"><span>:</span>Vitrin Kategorileri</label></div>
						<div class="r">
							<select name="site_vitrin_kategori" id="site_vitrin_kategori" style="width:180px;">
								<option <%=eSelected(GlobalConfig("vitrin_kategori"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("vitrin_kategori"))%>value="0">Pasif</option>
							</select>
							<a class="tooltip" title="Bu özelliği aktif ederek anasayfada kategorilerinizi resimli olarak sergileyebilirsiniz. <em style=&quot;text-decoration: underline;&quot;>Özel sayfa tasarımı gerektirir.</em>">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_vitrin_alt_kategori"><span>:</span>V. Alt Kategorileri</label></div>
						<div class="r">
							<select name="site_vitrin_alt_kategori" id="site_vitrin_alt_kategori" style="width:180px;">
								<option <%=eSelected(GlobalConfig("vitrin_alt_kategori"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("vitrin_alt_kategori"))%>value="0">Pasif</option>
							</select>
							<a class="tooltip" title="Yine aynı şekilde bu özelliği aktif ederek kategorilerinize bağlı alt kategorilerinizi resimli olarak sergileyebilirsiniz. <em style=&quot;text-decoration: underline;&quot;>Özel sayfa tasarımı gerektirir.</em>">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_uye_modul"><span>:</span>Üyelik Modülü</label></div>
						<div class="r">
							<select name="site_uye_modul" id="site_uye_modul" style="width:180px;">
								<option <%=eSelected(GlobalConfig("uye_modul"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("uye_modul"))%>value="0">Pasif</option>
							</select>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_sepet_modul"><span>:</span>Sepet Modülü</label></div>
						<div class="r">
							<select name="site_sepet_modul" id="site_sepet_modul" style="width:180px;">
								<option <%=eSelected(GlobalConfig("sepet_modul"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("sepet_modul"))%>value="0">Pasif</option>
							</select>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="site_siparis_modul"><span>:</span>Sipariş Modülü</label></div>
						<div class="r">
							<select name="site_siparis_modul" id="site_siparis_modul" style="width:180px;">
								<option <%=eSelected(GlobalConfig("sip_modul"))%>value="1">Aktif</option>
								<option <%=eSelected(Not GlobalConfig("sip_modul"))%>value="0">Pasif</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
<%End If%>
</div>
<div class="clr"></div>
<br />
<br />
<br />
<br />
<input name="energy" id="energy" value="1" type="hidden" />
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
</form>
