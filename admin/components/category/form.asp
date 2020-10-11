<!--#include file="EbeveynMenu.asp"--><%

If (pageid > 0) Then Response.Redirect("?mod="& mods &"&task=edit&id="& pageid & Duzenle(sLang & Debug) )


Set objRs = setExecute("SELECT MaxPictureSize, MaxPictureTotalSize, MaxFileSize, MaxFileTotalSize FROM #___settings WHERE opt_status = 1 And parent = "& GlobalConfig("General_CategoriesPN") &";")
	If Not objRs.Eof Then
		'GlobalConfig("MaxPicture") = intYap(objRs("MaxPicture"), 0)
		GlobalConfig("MaxPictureSize") = intYap(objRs("MaxPictureSize"), 0)
		GlobalConfig("MaxPictureTotalSize") = intYap(objRs("MaxPictureTotalSize"), 0)

		'GlobalConfig("MaxFile") = intYap(objRs("MaxFile"), 0)
		GlobalConfig("MaxFileSize") = intYap(objRs("MaxFileSize"), 0)
		GlobalConfig("MaxFileTotalSize") = intYap(objRs("MaxFileTotalSize"), 0)
	End If
Set objRs = Nothing
'd.Add "SmallSizeW", 100
'Response.Write d.Exists("SmallSizeW")


EditiD = 0
EditAnaiD = 0
EditTitleStatus = True
EditStatus = True
EditAnasyf = False
EditAnasyfAlias = ""
EditActiveLink = True
EditTypeAlias = ""
EditYorumizin = False
'EditCreateDate = Now()
'EditModifiedDate = DateTimeNull
EditStartDate = DateTimeNull
EditEndDate = DateTimeNull
EditHit = 0
'EditYazar = GlobalConfig("admin_username")
'Clearfix isNull(EditActiveLink)


SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	MaxPicture, MaxPictureSize, MaxPictureTotalSize," & vbCrLf
SQL = SQL & "	MaxFile, MaxFileSize, MaxFileTotalSize" & vbCrLf
SQL = SQL & "FROM #___settings WHERE opt_status = 1 And parent = "& GlobalConfig("General_CategoriesPN") &";" & vbCrLf
Set objRs = setExecute( SQL )
	If Not objRs.Eof Then
		GlobalConfig("MaxPicture") = intYap(objRs("MaxPicture"), 0)
		GlobalConfig("MaxPictureSize") = intYap(objRs("MaxPictureSize"), 0)
		GlobalConfig("MaxPictureTotalSize") = intYap(objRs("MaxPictureTotalSize"), 0)

		GlobalConfig("MaxFile") = intYap(objRs("MaxFile"), 0)
		GlobalConfig("MaxFileSize") = intYap(objRs("MaxFileSize"), 0)
		GlobalConfig("MaxFileTotalSize") = intYap(objRs("MaxFileTotalSize"), 0)
	End If
Set objRs = Nothing

If id > 0 Then
	Set objRs = setExecute("SELECT * FROM #___kategori WHERE id = "& id &";")
		If objRs.Eof Then
			Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Kayıt bulunamadı. İsterseniz yeni bir sayfa ekleyebilirsiniz.</span></div></div></div>")
			'EditiD = 0
		Else
			EditiD = objRs("id")
			EditAnaiD = objRs("anaid")
			'EditTitleStatus = CBool(objRs("titleStatus"))
			EditStatus = CBool(objRs("durum"))
			'EditAnasyf = CBool(objRs("anasyf"))
			'EditAnasyfAlias = objRs("anasyfAlias")
			EditSira = objRs("sira")
			EditActiveLink = CBool(objRs("activeLink"))
			EditTypeAlias = objRs("typeAlias")
			'EditYorumizin = CBool(objRs("yorumizin"))
			'EditCreateDate = objRs("c_date")
			'EditModifiedDate = objRs("m_date")
			'EditStartDate = objRs("s_date")
			'EditEndDate = objRs("e_date")
			EditOzelSayfa = objRs("ozel")
			EditPass = objRs("pass")
			'EditYazar = objRs("yazar")
			strMeta = objRs("robots_meta")
		End If
	Set objRs = Nothing
End If

'Clearfix cdbl("1E+148")

If Not isDate(EditCreateDate) Then EditCreateDate = Now()
'If (EditiD > 0) Then EditModifiedDate = Now()
If Not isDate(EditStartDate) Then EditStartDate = DateTimeNull
If Not isDate(EditEndDate) Then EditEndDate = DateTimeNull

'Response.Write DateDiff("n", EditStartDate, EditEndDate)
'Response.Write SefUrl("ما هو تصميم الويب؟")
%>
<form id="EnergyAdminForm" action="?mod=post&amp;task=<%=mods & sLang & Debug%>" method="post">

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
strAppendPictures = ""

Set objRs = setExecute("SELECT title, lng FROM #___languages WHERE durum = 1 ORDER BY default_lng DESC, sira ASC;")
Do While Not objRs.Eof
	strContentiD = strContentiD + 1
	If sTotalLang() > 1 Then strLangTitle = objRs("title") &" "
	strLangCode = objRs("lng")
	strContentTitle = ""
	strContentFixedTitle = ""
	strContentLink = ""
	strContentText = ""
	strContentShortText = ""
	strContentKeyword = ""
	strContentDescription = ""
	strContentHit = 0
	strDirection = ""
	strDirection2 = ""
	If strLangCode = "AR" Then strDirection = "dir=""rtl"" lang=""ar"" xml:lang=""ar"" "
	If strLangCode = "AR" Then strDirection2 = "onclick=""tinymce.get('text_"& strLangCode &"').getBody().dir = 'rtl';"" "


	'// Content
	SQL = ""
	SQL = SQL & "SELECT t1.id, t1.title, t1.fixed_title, t2.seflink, t1.text, t1.short_text, t1.keyword, t1.description, t1.hit "
	SQL = SQL & "FROM #___content t1 "
	SQL = SQL & "LEFT JOIN #___content_url t2 ON (t1.parent_id = t2.parent_id And t2.durum = 1 And t2.lang = '"& strLangCode &"') "
	SQL = SQL & "WHERE (t1.lang = '"& strLangCode &"' And t1.parent = "& GlobalConfig("General_CategoriesPN") &" And t1.parent_id = "& EditiD &");"
	'SQL = setQuery( SQL )
	Set objRs2 = setExecute( SQL )
	If Not objRs2.Eof Then
		strContentiD = objRs2("id")
		strContentTitle = HtmlEnCode(objRs2("title"))
		strContentFixedTitle = HtmlEnCode(objRs2("fixed_title"))
		strContentLink = URLDecode(objRs2("seflink"))
		strContentText = ReplaceEditorTag(objRs2("text"))
		strContentShortText = HtmlEnCode(objRs2("short_text"))
		strContentKeyword = HtmlEnCode(objRs2("keyword"))
		strContentDescription = HtmlEnCode(objRs2("description"))
		strContentHit = objRs2("hit")
	End If
	Set objRs2 = Nothing


strST = strST & "<div class=""row clearfix"">" & vbCrLf
strST = strST & "		<div class=""l""><label for=""s_title_"& strLangCode &"""><span>:</span>"& strLangTitle &"Menü İsmi</label></div>" & vbCrLf
strST = strST & "		<div class=""r"">" & vbCrLf
strST = strST & "			<input style=""width:180px;"" class=""inputbox"" name=""s_title_"& strLangCode &""" id=""s_title_"& strLangCode &""" value="""& strContentShortTitle &""" maxlength=""30"" type=""text"" />" & vbCrLf
strST = strST & "			<a class=""tooltip"" title=""Menü bağlantı isimleri menülerde uzun ve çirkin görüntüden kaçınmak için kullanılır, boş bırakıldığında genel yazı başlığı geçerli olacaktır. <br />Maksimun 30 karekter eklenebilir."">&nbsp;</a>" & vbCrLf
strST = strST & "		</div>" & vbCrLf
strST = strST & "		<div class=""clr""></div>" & vbCrLf
strST = strST & "	</div>"


'###################################


'// UI Tab Button
uiActiveClass = "" : strCssHidden = ""
If GlobalConfig("site_lang") = strLangCode Then uiActiveClass = " class=""ui-tabs-selected ui-state-active"""
If sTotalLang() = 1 Then strCssHidden = " style=""display:none !important""" : addTitle = "<h3 class=""box-title"">Sayfa İçeriği</h3>"

strTabButton = strTabButton & "<li"& uiActiveClass &" id=""editorid_"& strLangCode &""">" & vbCrLf
strTabButton = strTabButton & "	<a "& strDirection2 &" rel=""languages"" tabindex=""-1"" href=""#tabs_"& strLangCode &""">"& strLangTitle &"</a>" & vbCrLf
strTabButton = strTabButton & "</li>" & vbCrLf


'###################################

strPictures = ""
Set objRs3 = setExecute("SELECT id, IFNULL(title, '') As title, IFNULL(alt, '') As alt, resim, anaresim, featuredFile, durum FROM #___files WHERE (file_type = 1 And parent = "& GlobalConfig("General_CategoriesPN") &" And parent_id = "& EditiD &" And lang = '"& strLangCode &"') ORDER BY sira ASC;")
	Do While Not objRs3.Eof
		strChecked = "" : If objRs3("anaresim") = 1 Then strChecked = " checked"
		strStatusChecked = " checked" : strStatusText = "Pasif Yap" : If objRs3("durum") = 0 Then strStatusChecked = "" : strStatusText = "Aktif Yap"
		strPictures = strPictures & ("				<li id=""image-id_"& objRs3("id") &""" class=""success"">" & vbCrLf)
		strPictures = strPictures & ("					<div class=""icons tooltip"">" & vbCrLf)
		strPictures = strPictures & ("						<span class=""defaultFile"& strChecked &""" title=""Varsayılan Görsel""><em>&nbsp;</em></span>" & vbCrLf)
		strPictures = strPictures & ("						<span class=""editorAppendFile"" title=""Yazıya Dahil Et""><em>&nbsp;</em></span>" & vbCrLf)
		strPictures = strPictures & ("						<span class=""editFile"" title=""Düzenle""><em>&nbsp;</em></span>" & vbCrLf)
		strPictures = strPictures & ("						<span class=""statusFile"& strStatusChecked &""" title="""& strStatusText &"""><em>&nbsp;</em></span>" & vbCrLf)
		strPictures = strPictures & ("						<span class=""deleteFile"" title=""Kalıcı Olarak Sil""><em>&nbsp;</em></span>" & vbCrLf)
		strPictures = strPictures & ("					</div>" & vbCrLf)
		strChecked = "" : If objRs3("featuredFile") = 1 Then strChecked = " checked"
		strPictures = strPictures & ("					<div class=""icons icon_bottom tooltip"">" & vbCrLf)
		strPictures = strPictures & ("						<span class=""featuredFile "& strChecked &""" title=""Öne Çıkarılmış Görsel""><em>&nbsp;</em></span>" & vbCrLf)
		strPictures = strPictures & ("					</div>" & vbCrLf)
		strPictures = strPictures & ("					<div class=""img"">" & vbCrLf)
		strPictures = strPictures & ("						<a rel=""img-show"" tabindex=""-1"" href="""& kFolder(EditiD, 0) & "/" & objRs3("resim") &""" title="""& objRs3("title") &""">")
		strPictures = strPictures & ("<img src="""& kFolder(EditiD, 1) & "/" & objRs3("resim") &""" title="""& objRs3("title") &""" alt="""& objRs3("alt") &""""& imgAlign(kFolder(EditiD, 1) & "/" & objRs3("resim"), 110, 90, 110, 90) & " /></a>" & vbCrLf)
		strPictures = strPictures & ("					</div>" & vbCrLf)
		strPictures = strPictures & ("				</li>" & vbCrLf)
	objRs3.MoveNext() : Loop
Set objRs3 = Nothing

If sTotalLang() > 1 Then strAppendPictures = strAppendPictures & "<h3 class=""h3Title"">"& strLangTitle &"Sayfa Görselleri</h3>"
'strAppendPictures = strAppendPictures & "<div style=""padding:10px 0; padding-left:2px; border: 1px solid #DFDFDF; -moz-box-shadow: inset 0 1px 0 #fff; -webkit-box-shadow: inset 0 1px 0 white; box-shadow: inset 0 1px 0 white; -moz-border-radius: 3px; -webkit-border-radius: 3px; border-radius: 3px; background-color: whiteSmoke;""><ul class=""image_files clearfix"" id=""files_"& strLangCode &""">" & vbCrLf & strPictures & "</ul></div><div class=""clr""></div>" & vbCrLf

strAppendPictures = strAppendPictures & "<div class=""borderBottom clearfix"">" & vbCrLf
strAppendPictures = strAppendPictures & "	<ul class=""image_files clearfix"" id=""files_"& strLangCode &""" data_lang="""& strLangCode &""">" & vbCrLf
strAppendPictures = strAppendPictures & strPictures & vbCrLf
strAppendPictures = strAppendPictures & "	</ul>" & vbCrLf
strAppendPictures = strAppendPictures & "</div>" & vbCrLf

'###################################


'uiActiveClass = "" : If Not GlobalConfig("site_lang") = strLangCode Then uiActiveClass = " hidden"

'Set objRs3 = setExecute("SELECT id, title, alt, resim, anaresim, durum FROM #___files WHERE (file_type = 2 And parent = "& GlobalConfig("General_CategoriesPN") &" And parent_id = "& EditiD &" And lang = '"& strLangCode &"') ORDER BY sira ASC;")
'	strFiles = strFiles & ("			<div class=""other_files"& uiActiveClass &""" id=""other_files_"& strLangCode &""">" & vbCrLf)
'	strFiles = strFiles & ("				<ul class=""clearfix"" data_lang="""& strLangCode &""">" & vbCrLf)
'	Do While Not objRs3.Eof
'		FileExt = Right(objRs3("resim"), (Len(objRs3("resim")) - inStrRev(objRs3("resim"), ".") +1))
'		If CBool(objRs3("anaresim")) Then strChecked = " checked" Else strChecked = ""
'		If CBool(objRs3("durum")) Then strStatusChecked = " checked" : strStatusText = "Resmi Pasif Yap" Else strStatusChecked = "" : strStatusText = "Resmi Aktif Yap"
'		strFiles = strFiles & ("				<li id=""other_file_id_"& objRs3("id") &""" class="""& FileAddClass(FileExt) &"clearfix"">" & vbCrLf)
'		strFiles = strFiles & ("					<a class=""other_file_delete"" tabindex=""-1"" href=""#"">Sil</a>" & vbCrLf)
'		strFiles = strFiles & ("					<a class=""other_file_edit"" tabindex=""-1"" href="""& kFolder(EditiD, 3) & "/" & objRs3("resim") &""" title="""& objRs3("title") &""">" & KacKarekter(objRs3("resim"), 47) & "</a>")
'		strFiles = strFiles & ("				</li>" & vbCrLf)
'	objRs3.MoveNext() : Loop
'	strFiles = strFiles & ("				</ul>" & vbCrLf)
'	strFiles = strFiles & ("			</div>" & vbCrLf)
'Set objRs3 = Nothing


'###################################


strTabContent = strTabContent & "		<div id=""tabs_"& strLangCode &""">" & vbCrLf

strTabContent = strTabContent & vbCrLf
strTabContent = strTabContent & "<div class=""row clearfix"">" & vbCrLf
strTabContent = strTabContent & "	<div class=""l""><label for=""title_"& strLangCode &"""><span>:</span><i style=""padding-left:5px; font-style:normal;"">Başlık</i></label></div>" & vbCrLf
strTabContent = strTabContent & "	<div class=""r"">" & vbCrLf
strTabContent = strTabContent & "		<span class=""relative"">" & vbCrLf
strTabContent = strTabContent & "			<input "& strDirection &"class=""inputbox title"" name=""title_"& strLangCode &""" id=""title_"& strLangCode &""" value="""& strContentTitle &""" title=""Bu alana sayfa içeriğinde görünecek başlığı girin. Maks. 200 karakter eklenebilir."" maxlength=""200"" type=""text"" />" & vbCrLf
strTabContent = strTabContent & "			<span><a class=""tooltip slink"" tabindex=""-1"" href=""#"" title="""& strLangTitle &"Permalink ekle/düzenle."" onclick=""$('#seflink_id_"& strLangCode &"').toggle('blind', 300); $(this).toggleClass('active'); return false;"">"& strLangTitle &"Permalink düzenle.</a></span>" & vbCrLf
strTabContent = strTabContent & "			<a style=""position: absolute; top: 2px; right:-18px; *top: 10px;"" class=""tooltip"" tabindex=""-1"" href=""#"" title=""Başlıklar SEO açısından önemlidir. <br />Sayfa içeriğiyle alakalı içinde anahtar kelimeler geçen başlıklar girmenizi öneririz. <br />Arama motorlarında başlıklar maksimun 60 karakter ile sınırlıdır, uzun başlıklar girmeniz önerilmez."">&nbsp;</a>" & vbCrLf
strTabContent = strTabContent & "		</span>" & vbCrLf
strTabContent = strTabContent & "	</div>" & vbCrLf
strTabContent = strTabContent & "</div>" & vbCrLf

strTabContent = strTabContent & "<div class=""row clearfix"">" & vbCrLf
strTabContent = strTabContent & "	<div class=""l""><label for=""title_"& strLangCode &"""><span>:</span><i style=""padding-left:5px; font-style:normal;"">Seo Başlık</i></label></div>" & vbCrLf
strTabContent = strTabContent & "	<div class=""r"">" & vbCrLf
strTabContent = strTabContent & "		<span class=""relative"">" & vbCrLf
strTabContent = strTabContent & "			<input "& strDirection &"class=""inputbox"" name=""fixtitle_"& strLangCode &""" id=""fixtitle_"& strLangCode &""" value="""& strContentFixedTitle &""" title=""Bu alana arama motorları (Google, Yandex, Yahoo, Bing vb.) arama sonuçlarında çıkacak olan sayfa başlığı girin. Maks. 60 karakter eklenebilir."" maxlength=""70"" type=""text"" />" & vbCrLf
strTabContent = strTabContent & "			<a style=""position: absolute; top: 2px; right:-18px; *top: 10px;"" class=""tooltip"" tabindex=""-1"" href=""#"" title=""Bu alan opsiyoneldir. <br />Buraya arama motorları (Google, Yandex, Yahoo, Bing vb.) <br />arama sonuçlarında görüntülenecek olan başlık girebilirsiniz. <br />Arama motorlarında başlıklar maksimun 60 karakter ile sınırlıdır, uzun başlıklar girmeniz önerilmez."">&nbsp;</a>" & vbCrLf
strTabContent = strTabContent & "		</span>" & vbCrLf
strTabContent = strTabContent & "	</div>" & vbCrLf
strTabContent = strTabContent & "</div>" & vbCrLf

strTabContent = strTabContent & "<div id=""seflink_id_"& strLangCode &""" class=""row clearfix hidden"">" & vbCrLf
strTabContent = strTabContent & "	<div class=""l""><label for=""seflink_"& strLangCode &"""><span>:</span><i style=""padding-left:5px; font-style:normal;"">Permalink</i></label></div>" & vbCrLf
strTabContent = strTabContent & "	<div class=""r"">" & vbCrLf
strTabContent = strTabContent & "		<span class=""relative"">" & vbCrLf
strTabContent = strTabContent & "			<input class=""inputbox seflink"" name=""seflink_"& strLangCode &""" id=""seflink_"& strLangCode &""" value="""& strContentLink &""" autocomplete=""off"" maxlength=""200"" type=""text"" />" & vbCrLf
strTabContent = strTabContent & "			<a style=""position: absolute; top: 2px; right:-18px; *top: 10px;"" class=""tooltip"" tabindex=""-1"" href=""#"" title=""Permalink sayfanın kalıcı bağlantısıdır. <br />Tümü küçük harflerden oluşur, sadece harf, rakam ve tire içerir, kısa ve okunaklı bağlantı isimleri önerilir. <br />Maksimun 200 karekter eklenebilir."">&nbsp;</a>" & vbCrLf
strTabContent = strTabContent & "		</span>" & vbCrLf
strTabContent = strTabContent & "	</div>" & vbCrLf
strTabContent = strTabContent & "</div>" & vbCrLf

strTabContent = strTabContent & "			<div class=""clr"" style=""height:15px;""></div>" & vbCrLf

strTabContent = strTabContent & "			<div class=""editor-xbuttons clearfix"">" & vbCrLf
strTabContent = strTabContent & "				<ul class=""clearfix"">" & vbCrLf
If GlobalConfig("admin_username") = GlobalConfig("super_admin") Then _
strTabContent = strTabContent & "					<li class=""media""><a class=""iframe"" tabindex=""-1"" href=""?mod=maps&amp;e_name=text_"& strLangCode &"&amp;"& ewy_queryLang &"=" & LCase(strLangCode) & Debug &""" title=""Google haritası ekle"">Google Haritası Ekle</a></li>" & vbCrLf
strTabContent = strTabContent & "					<li class=""media""><a class=""iframe"" tabindex=""-1"" href=""?mod=img&amp;e_name=text_"& strLangCode &"&amp;"& ewy_queryLang &"=" & LCase(strLangCode) & Debug &""" title=""Görsel ekle"">Görsel Ekle</a></li>" & vbCrLf
strTabContent = strTabContent & "					<li class=""link""><a class=""iframe2"" tabindex=""-1"" href=""?mod=popup_" & GlobalConfig("General_Page") &"&amp;e_name=text_"& strLangCode &"&amp;"& ewy_queryLang &"=" & LCase(strLangCode) & Debug &""" title=""Sayfa bağlantısı ekle"">Bağlantı Ekle</a></li>" & vbCrLf
strTabContent = strTabContent & "					<li class=""more""><a tabindex=""-1"" href=""javascript:;"" onclick=""javascript:insertReadmore('text_"& strLangCode &"'); return false"" title=""Devamını oku... bağlantısı ekle"">Devamı... Ekle</a></li>" & vbCrLf
strTabContent = strTabContent & "					<li class=""break""><a class=""iframe-pagebreak"" tabindex=""-1"" href=""?mod=pagebreak&amp;e_name=text_"& strLangCode &"&amp;"& ewy_queryLang &"=" & LCase(strLangCode) & Debug &""" title=""Sayfa sonu ekle"">Sayfa sonu</a></li>" & vbCrLf
strTabContent = strTabContent & "					<li class=""html""><a class=""editor"" tabindex=""-1"" href=""javascript:;"" id=""editor_id_"& strLangCode &""" title=""Html Göster"">Html Göster</a></li>" & vbCrLf
strTabContent = strTabContent & "				</ul>" & vbCrLf
strTabContent = strTabContent & "			</div>" & vbCrLf
strTabContent = strTabContent & "			<div class=""clr""></div>" & vbCrLf




strTabContent = strTabContent & "		<div class=""m_box"">" & vbCrLf
strTabContent = strTabContent & "			<div class=""title"">" & vbCrLf
'strTabContent = strTabContent & "				<div class=""upload_insert""><a style="""" class=""iframe"" tabindex=""-1"" href=""?mod="& GlobalConfig("General_Page") & "_images" &"&amp;task=file_list&amp;e_name=text_"& strLangCode &"&amp;"& ewy_queryLang &"=" & LCase(strLangCode) & Debug &""" title=""Görsel Yükle / Ekle"">Görsel Yükle / Ekle</a></div>" & vbCrLf
strTabContent = strTabContent & "				<h3 class=""box-title"">"& strLangTitle &"İçerik</h3>" & vbCrLf
strTabContent = strTabContent & "			</div>" & vbCrLf
strTabContent = strTabContent & "			<div class=""head"">" & vbCrLf
strTabContent = strTabContent & "				<div style=""padding:0; margin:0;"" class=""form-table clearfix"">" & vbCrLf

strTabContent = strTabContent & "			<div style=""border:0;"" class=""htmleditors clearfix"">" & vbCrLf
strTabContent = strTabContent & "				<textarea id=""text_"& strLangCode &""" name=""text_"& strLangCode &""" class=""energy_mce_editor"">"& strContentText &"</textarea>" & vbCrLf

strTabContent = strTabContent & "				<div class=""ewy_mceBottomBar""></div>" & vbCrLf
'strTabContent = strTabContent & "				<table class=""post-status-info"" cellspacing=""0"">" & vbCrLf
'strTabContent = strTabContent & "					<tbody>" & vbCrLf
'strTabContent = strTabContent & "						<tr>" & vbCrLf
'strTabContent = strTabContent & "							<td>Kelime sayısı: <span id=""text_"& strLangCode &"-word-count"">0</span></td>" & vbCrLf
'strTabContent = strTabContent & "							<td class=""autosave-info""></td>" & vbCrLf
'strTabContent = strTabContent & "						</tr>" & vbCrLf
'strTabContent = strTabContent & "					</tbody>" & vbCrLf
'strTabContent = strTabContent & "				</table>" & vbCrLf

strTabContent = strTabContent & "			</div>" & vbCrLf

strTabContent = strTabContent & "					<div class=""clr""></div>" & vbCrLf
strTabContent = strTabContent & "				</div>" & vbCrLf
strTabContent = strTabContent & "			</div>" & vbCrLf
strTabContent = strTabContent & "		</div>" & vbCrLf


'strTabContent = strTabContent & "			<div style=""padding: 5px;"" class=""form-table clearfix"">" & vbCrLf
'strTabContent = strTabContent & "				<div class=""row clearfix"">" & vbCrLf
'strTabContent = strTabContent & "					<div><label for=""s_text_"& strLangCode &""">"& strLangTitle &"Özet <a class=""tooltip"" title=""Özet; temanız içinde yer aldığında kullanabileceğiniz özel bölümlerdir."">&nbsp;</a></label></div>" & vbCrLf
'strTabContent = strTabContent & "					<div>" & vbCrLf
'strTabContent = strTabContent & "						<textarea style=""width:99% !important; *width:98% !important; height:90px !important;"" class=""min2"" name=""s_text_"& strLangCode &""" id=""s_text_"& strLangCode &""">"& strContentShortText &"</textarea>" & vbCrLf
'strTabContent = strTabContent & "					</div>" & vbCrLf
'strTabContent = strTabContent & "				</div>" & vbCrLf
'strTabContent = strTabContent & "			</div>" 
strTabContent = strTabContent & "			<div style=""padding: 5px;"" class=""form-table clearfix"">" & vbCrLf
strTabContent = strTabContent & "				<div class=""row clearfix"" style=""clear:none; float:left !important; width:50%; *width:49%;"">" & vbCrLf
strTabContent = strTabContent & "					<div><label for=""description_"& strLangCode &""">Kısa Açıklama (description) <a class=""tooltip"" title=""Arama motorları için kısa bir "& strLangTitle &"açıklama girin. <br />Maksimun 160 karekter."">&nbsp;</a></label></div>" & vbCrLf
strTabContent = strTabContent & "					<div>" & vbCrLf
strTabContent = strTabContent & "						<textarea style=""margin-top:3px; width:100%; height:70px;"" class=""min"" name=""description_"& strLangCode &""" id=""description_"& strLangCode &""" maxlength=""160"">"& strContentDescription &"</textarea>" & vbCrLf
strTabContent = strTabContent & "					</div>" & vbCrLf
strTabContent = strTabContent & "				</div>" & vbCrLf
strTabContent = strTabContent & "				<div class=""row clearfix"" style=""clear:none; float:left !important; *margin-left:12px; width:50%; *width:49%;"">" & vbCrLf
strTabContent = strTabContent & "					<div><label for=""keyword_"& strLangCode &""">Anahtar Kelimeler (keywords) <a class=""tooltip"" title=""Arama motorları için "& strLangTitle &"anahtar kelimeler girin. <em>(Örnek: hp laptop, casper laptop)</em> <br />Maksimun 200 karekter."">&nbsp;</a></label></div>" & vbCrLf
strTabContent = strTabContent & "					<div>" & vbCrLf
strTabContent = strTabContent & "						<textarea style=""margin-top:3px; width:100%; height:70px;"" class=""min"" name=""keyword_"& strLangCode &""" id=""keyword_"& strLangCode &""" maxlength=""200"">"& strContentKeyword &"</textarea>" & vbCrLf
strTabContent = strTabContent & "					</div>" & vbCrLf
strTabContent = strTabContent & "				</div>" & vbCrLf

strEtiket = ""
Set objRs2 = setExecute("SELECT a.etiket FROM #___etiket As a INNER JOIN #___etiket_id As b ON a.id = b.eid WHERE b.parent = "& GlobalConfig("General_CategoriesPN") &" And b.parent_id = "& EditiD &" And b.lang = '"& strLangCode &"';")
Do While Not objRs2.Eof
		strEtiket = strEtiket & objRs2(0) & ","
	objRs2.MoveNext() : Loop
Set objRs2 = Nothing
If strEtiket <> "" Then strEtiket = Left(strEtiket, Len(strEtiket)-1)


strTabContent = strTabContent & "				<div class=""row clearfix"" style=""clear:none; float:left !important;  margin-top:5px; *margin-left:12px;"">" & vbCrLf
strTabContent = strTabContent & "					<div><label for=""etiket_"& strLangCode &""">Etiketler (tags) <a class=""tooltip"" title=""Bu alana "& strLangTitle &"etiketler girebilirsiniz. <br />Etiketler arama motorlarında daha fazla indeks oluşturarak <br />internet kullanıcılarının içeriklerinizi daha kolay bulmasına yardımcı olmak amacıyla oluşturlmuştur. <br />Etiketlerinizi virgül ile ayrınız."">&nbsp;</a></label></div>" & vbCrLf
strTabContent = strTabContent & "					<div style=""overflow:hidden;"">" & vbCrLf
'strTabContent = strTabContent & "						<textarea autofocus style=""margin-top:3px; width:100%; height:70px;"" class=""min etiket"" name=""etiket_"& strLangCode &""" id=""etiket_"& strLangCode &""" maxlength=""200"">"& strContentKeyword &"</textarea>" & vbCrLf
strTabContent = strTabContent & "						<input style=""width:120px; margin-top:3px;"" class=""etiketler inputbox"" name=""etiket_"& strLangCode &""" id=""etiket_"& strLangCode &""" value="""& strEtiket &""" type=""text"" />" & vbCrLf
strTabContent = strTabContent & "					</div>" & vbCrLf
strTabContent = strTabContent & "				</div>" & vbCrLf
strTabContent = strTabContent & "			</div>"
strTabContent = strTabContent & "		</div>"


'###################################

If EditiD > 0 Then
	strHits = strHits & " <div class=""row clearfix"">" & vbCrLf
	strHits = strHits & "	<div class=""l""><label for=""hit_"& strContentiD &"""><span>:</span>"& strLangTitle &"Sayfa Hit</label></div>" & vbCrLf
	strHits = strHits & "	<div class=""r"">" & vbCrLf
	strHits = strHits & "		<span class=""relative"">" & vbCrLf
	strHits = strHits & "		<input style=""width:130px;"" class=""inputbox"" name=""hit[]"" id=""hit_"& strContentiD &""" value="""& strContentHit &""" disabled=""disabled"" type=""text"" />" & vbCrLf
	If (strContentHit > 0) Then _
	strHits = strHits & "		<span><a class=""hit_reset"" id=""hit_reset["& strContentiD &"]"" tabindex=""-1"" href=""?mod=redirect&amp;task=hit_reset&amp;id="& strContentiD &""" title=""Sayacı Sıfırla"">Sıfırla</a></span>" & vbCrLf
	'strHits = strHits & "		<span class=""text info"" title=""Bu alan pasiftir, bu sayfayı görüntüleyen ziyaretçi sayısını bildirir.""></span>" & vbCrLf
	strHits = strHits & "		</span>" & vbCrLf
	strHits = strHits & "	</div>" & vbCrLf
	strHits = strHits & "	<div class=""clr""></div>" & vbCrLf
	strHits = strHits & "</div>" & vbCrLf
End If


'###################################


strLC = strLC & "<input name=""languages"" value="""& strLangCode &""" type=""hidden"" />" & vbCrLf
strLT = strLT & "<input name=""lang_title_"& strLangCode &""" value="""& Trim(strLangTitle) &""" type=""hidden"" />" & vbCrLf

	objRs.MoveNext() : Loop
Set objRs = Nothing

Response.Write( vbCrLf & strLC & strLT )
%>

<div class="energy-tabs">
	<div class="m_box" id="tabs">
		<div class="title"><%=ContentRevizyon(GlobalConfig("General_CategoriesPN"), EditiD) & addTitle%>
			<ul <%=strCssHidden%>>
				<%
					Response.Write( vbCrLf & strTabButton)
				%>
			</ul>
		</div>
		<div class="head clearfix">
			<div class="form-table clearfix" style="margin:0;">
				<%
					Response.Write( strTabContent )
				%>
				<div class="clr"></div>
			</div>
		</div>
	</div>
</div>

<div class="m_box">
	<div class="title"><div style="margin-right:5px; margin-top:3px;" id="upload" class="smallicon"><span>Resim Seç</span></div> <h3 class="box-title">Bu Sayfaya Ait Görseller</h3></div>
	<div class="head clearfix">
		<div class="form-table auto">
			<div id="file_lists" class="clearfix">
				<div id="image-files" class="clearfix" style="margin-bottom:10px;">
					<div id="status"></div>
				</div>
					<%
					Response.Write( strAppendPictures )
					%>
				<div class="clr"></div>
			</div>

			<ul class="clearfix">
				<li><span class="text green">Sürükle bırak yöntemiyle resimleri sıralayabilirsiniz.</span></li>
				<li><span class="text blue">Web sayfanız destekliyorsa resim sıralaması foto galeri, referanslar vb. gibi sayfalarda kullanılabilir.</span></li>
				<li><span class="text blue">Resimleri yazı editörü içinde kullanmak için, resim üstündeki &ldquo;<span class="red">(+) Yazıya Dahil Et</span>&rdquo; butonuna tıklayın.</span></li>
				<li><span class="text blue">İsterseniz editörün üst kısmında bulunan &ldquo;<span class="red">Görsel Ekle</span>&rdquo; butonuna tıklayarak &ldquo;<span class="red"><%=GlobalConfig("CategoriesUploadFolder")%></span>&rdquo; klasörü içindeki &ldquo;<span style="font-weight:bold;" class="green"><%=Left(GlobalConfig("CategoriesUploadFolder"), 1)%>_<span id="pgid" class="red"><%If EditiD > 0 Then Response.Write(EditiD) Else Response.Write("{kimlik}")%></span></span>&rdquo; isimli klasörden ilgili dosyayı seçin.</span></li>
				<li><span class="text red"><span class="green">Not:</span> Tek seferde maksimun <%=int(MaxBytes(GlobalConfig("MaxPictureTotalSize")))%> MB (<%=FormatNumber(GlobalConfig("MaxPictureTotalSize"), 0)%> Byte) dosya başına maksimun <%=int(MaxBytes(GlobalConfig("MaxPictureSize")))%> MB (<%=FormatNumber(GlobalConfig("MaxPictureSize"), 0)%> Byte) yükleme yapabilirsiniz.</span></li>
				<li><span class="text red">Sildiğiniz resimler sunucudan kalıcı olarak silinecektir.</span></li>
			</ul>

		</div>
	</div>
</div>


	</div>
</div>

	<div class="rightcolumn">

		<div class="m_box clearfix">
			<div class="title"><h3 class="box-title">Yayımla</h3></div>
			<div class="head clearfix clearfix">
				<div class="form-table clearfix">
					<div class="row clearfix">
						<div class="l"><label for="durum"><span>:</span>Göster / Gizle</label></div>
						<div class="r">
							<select name="durum" id="durum" size="1" style="width:180px;">
								<option value="1"<%=eSelected(EditStatus)%>>Aktif (Sitede görünecek)</option>
								<option value="0"<%=eSelected(Not EditStatus)%>>Pasif (Sitede görünmeyecek)</option>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Bu kaydı tamamen silmek yerine durumunu pasif yaparak sitenizde göstermeme şansına sahipsiniz. <br />Not: Alt öğeler ve ürünler etkilenebilir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label style="font-size:10px;" for="title_status"><span>:</span>Başlık Göster / Gizle</label></div>
						<div class="r">
							<select name="title_status" id="title_status" size="1" style="width:180px">
								<option value="1"<%=eSelected(EditTitleStatus)%>>Aktif (Sitede görünecek)</option>
								<option value="0"<%=eSelected(Not EditTitleStatus)%>>Pasif (Sitede görünmeyecek)</option>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Bunu pasif olarak seçtiğinizde içerik sayfanızda başlığı göstermeyeceğiz.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l" style="width:20%;"><label for="robots_meta"><span>:</span>Robotlar</label></div>
						<div class="r" style="width:78%;">
							<select name="robots_meta" id="robots_meta" size="1" style="width:230px;">
								<option value=""<%=eSelected(strMeta = "")%>>Genel Ayarları Kullan</option>
								<option value="index, follow"<%=eSelected(strMeta = "index, follow")%>>İndeksle, Takip et &quot;index, follow&quot;</option>
								<option value="noindex, follow"<%=eSelected(strMeta = "noindex, follow")%>>İndeksleme, takip et &quot;noindex, follow&quot;</option>
								<option value="index, nofollow"<%=eSelected(strMeta = "index, nofollow")%>>İndeksle, Takip etme &quot;index, nofollow&quot;</option>
								<option value="noindex, nofollow"<%=eSelected(strMeta = "noindex, nofollow")%>>İndeksleme, takip etme &quot;noindex, nofollow&quot;</option>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Arama motorları / Google'ın sayfanızda nasıl davranması gerektiğini belirleyin.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="active_home"><span>:</span>Önsayfada Göster</label></div>
						<div class="r" style="padding-top:6px;">
							<label class="label_inline" for="active_home1"><input class="radioMargin" onclick="$('#home_page_alias_bar').slideDown(500);" name="active_home" id="active_home1" value="1" type="radio"<%=eChecked( EditAnasyf )%> /> Evet</label>
							<label class="label_inline" for="active_home2"><input class="radioMargin" onclick="$('#home_page_alias_bar').slideUp(500);" name="active_home" id="active_home2" value="0" type="radio"<%=eChecked( Not EditAnasyf )%> /> Hayır</label> &nbsp;&nbsp;
							<a class="tooltip" tabindex="-1" href="#" title="Eğer site şablonununz destekliyorsa bunu sitenizin ana sayfasında gösterebiliriz.">&nbsp;</a>
						</div>
					</div>

					<div id="home_page_alias_bar" class="row<%If Not EditAnasyf Then Response.Write(" hidden")%> clearfix">
						<div class="l clearfix"><label for="home_page_alias"><span>:</span>Önsayfa Şablon</label></div>
						<div class="r clearfix">
							<select class="required" name="home_page_alias" id="home_page_alias" size="1" style="width:180px">
								<%
SQL = ""
SQL = SQL & "SELECT t1.alias, t1.title "
SQL = SQL & "FROM #___content_home_template t1 "
'SQL = SQL & "LEFT JOIN (SELECT menuid, sayfaid FROM #___sayfa_menu WHERE sayfaid = "& EditiD &") t2 ON t1.menutypeid = t2.menuid "
SQL = SQL & "WHERE durum = 1 And (parent = "& GlobalConfig("General_CategoriesPN") &" Or parent = 0) "
SQL = SQL & "ORDER BY t1.sira ASC;"
'SQL = setQuery( SQL )
Set objRs = setExecute(SQL)
	While Not objRs.Eof
		Response.Write("<option"& eSelected(EditAnasyfAlias = objRs("alias")) &" value="""& objRs("alias") &""">"& objRs("title") &"</option>" & vbCrLf)
	objRs.MoveNext() : Wend
Set objRs = Nothing
								%>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Önsayfada gösterilecek alanı seçiniz. <br />Not: Eğer temanız destekliyorsa bu özellik çalışacaktır.">&nbsp;</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><h3 class="box-title">Kategori Özellikleri</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
					<div class="row clearfix">
						<div class="l"><label for="pageid" style="color:green"><span>:</span>Kimlik</label></div>
						<div class="r">
							<input style="width:135px;" class="inputbox readonly" id="pageid" name="pageid" value="<%=EditiD%>" type="text" readonly="readonly" />
							<a class="tooltip" tabindex="-1" href="#" title="Bu kayda ait benzersiz bir kimlik numarasıdır. <em>Değiştirilemez.</em>">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="sira"><span>:</span>Sıralama</label></div>
						<div class="r">
							<input style="width:70px;" class="inputbox list-order required number" name="sira" id="sira" value="<%=EditSira%>" maxlength="3" type="number" step="1" min="0" max="999" />
							<a class="tooltip" tabindex="-1" href="#" title="Kategoriler genellikle alfabetik olarak sıralanır, <br />fakat isterseniz bu alana sayı girerek (birinci için 1 ) <br />şeklinde kendiniz de belirleyebilirsiniz.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div style="margin-bottom: 5px;"><label for="anaid">Ebeveyn
							<a class="tooltip" tabindex="-1" href="#" title="Kategorilerinizi hiyerarşik olarak düzenleyebilirsiniz. <br />Örneğin &ldquo;Devam eden projeler&rdquo; ve &ldquo;Biten Projeler&rdquo; şeklinde iki kategoriye sahip bir &ldquo;Referanslar&rdquo; kategoriniz olabilir.<br /> Alt alta kaç seviye oluşturacağınız konusunda limitsizsiniz.">&nbsp;</a>
						</label></div>
						<div>
							<select style="width:100%;" name="anaid" id="anaid" size="1">
								<option value="0"<%=eSelected(EditAnaiD = 0)%>>Üst</option>
									<%Call EbeveynKategori(0, 0, EditAnaiD)%>
							</select>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="alias"><span>:</span>Şablon</label></div>
						<div class="r">
							<select name="alias" id="alias" size="1" style="width:180px">
<%
SQL = ""
SQL = SQL & "SELECT title, alias FROM #___content_template "
SQL = SQL & "WHERE durum = 1 And (parent = "& GlobalConfig("General_CategoriesPN") &" Or parent = 0) ORDER BY sira ASC;"
'SQL = setQuery( SQL )
Set objRs = setExecute( SQL )
	While Not objRs.Eof
		strSelected = ""

		If EditTypeAlias = "" And objRs("alias") = "default" Then
			strSelected = " selected=""selected"""

		ElseIf objRs("alias") = EditTypeAlias Then
			strSelected = " selected=""selected"""

		End If
		'If Not objRs("durum") Then Selected = Selected & " disabled=""disabled"""
		Response.Write("<option value="""& objRs("alias") &""""& strSelected &">"& objRs("title") &"</option>" & vbCrLf)
	objRs.MoveNext() : Wend
Set objRs = Nothing
%>							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Bazı tasarımlar ek özellikleri ya da özel yerleşimleri olan şablonlara sahip olabilir. <br />Eğer varsa bunları kendi özel sayflarında göreceksiniz.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="active_link"><span>:</span>Tıklanabilir Menü</label></div>
						<div class="r">
							<select class="required" name="active_link" id="active_link" size="1" style="width:180px;">
								<option value="1"<%=eSelected(EditActiveLink)%>>Aktif (Bağlantı adresi ekle)</option>
								<option value="0"<%=eSelected(Not EditActiveLink)%>>Pasif (Bağlantı adresi ekleme)</option>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Bu özellik pasif değildiğinde bu içeriğe ait bağlantılar devre dışı bırakılacaktır.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="menu"><span>:</span>Eklenecek Menü</label></div>
						<div class="r">
							<select class="required inputbox" name="menu" id="menu" size="4" style="width:180px" multiple="multiple">
								<%
SQL = ""
SQL = SQL & "SELECT t1.id, t1.title," & vbCrLf
SQL = SQL & "IF((SELECT id FROM #___content_menu WHERE (menu_id = t1.id And parent = "& GlobalConfig("General_CategoriesPN") &" And parent_id = "& EditiD &") Limit 1) Is Null, '', ' selected=""selected""') As strSelected" & vbCrLf
SQL = SQL & "FROM #___content_menu_type t1 WHERE t1.durum = 1 ORDER BY t1.sira ASC;"
'SQL = setQuery( SQL )
'Clearfix SQL
Set objRs = setExecute(SQL) : OptionWrite = "" : Count = 0
Do While Not objRs.Eof : Count = Count + 1
	OptionWrite = OptionWrite & "<option"& objRs("strSelected") &" value="""& objRs("id") &""">"& objRs("title") &"</option>"
objRs.MoveNext() : Loop
Set objRs = Nothing

If inStr(1, OptionWrite, "selected=""selected""") = 0 Then strSelectedNone = " selected=""selected"""
Response.Write("<option"& strSelectedNone &" value=""0"">Menüde Gösterme</option>" & OptionWrite)
								%>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Sayfa bağlantısını isterseniz menülere ekleyebilirsiniz.<br /> Birden fazla menü seçmek için CTRL'ye basılı tutarak seçim yapabilirsiniz. <br />Daha fazla seçenek için Menü Yönetimi sayfasına gidin. <br />Bazı menüler ön sayfada olmayabilir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="yorumizin"><span>:</span>Yorum İzin</label></div>
						<div class="r">
							<select class="required" name="yorumizin" id="yorumizin" size="1" style="width:170px">
								<option value="1"<%=eSelected(EditYorumizin)%>>Evet (Yorum yapılsın)</option>
								<option value="0"<%=eSelected(Not EditYorumizin)%>>Hayır (Yorum yapılmasın)</option>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Bu sayfa hakkında yorum yapılmasına izin vermek istiyorsanız yandaki kutucuktan evet&apos;i seçin. <br />Yorum; web sayfanıza isteğiniz doğrultusunda eklenecek bir özelliktir.">&nbsp;</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><h3 class="box-title">Erişim Seviyesi</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
					<div class="row clearfix">
						<div style="text-align:center;">
							<label class="label_inline" for="ozel0"><input class="radioMargin" name="ozel" id="ozel0" value="0" type="radio"<%=eChecked(EditOzelSayfa = 0)%> /> Herkese&nbsp;Açık</label> --- 
							<label class="label_inline" for="ozel1"><input class="radioMargin" name="ozel" id="ozel1" value="1" type="radio"<%=eChecked(EditOzelSayfa = 1) & eDisabled( Not CBool(GlobalConfig("uye_modul")) )%> /> Üyelere&nbsp;Özel</label> --- 
							<label class="label_inline" for="ozel2"><input class="radioMargin" name="ozel" id="ozel2" value="2" type="radio"<%=eChecked(EditOzelSayfa = 2)%> /> Parola&nbsp;Korumalı</label>
						</div>
					</div>
					<div style="text-align:center;" id="pass-div" class="row<%If (EditOzelSayfa < 2) Then Response.Write(" hidden")%>">
						<div>
							<label class="label_inline" for="pass">Parola&nbsp;Girin <input style="width:130px" class="inputbox required2" name="pass" id="pass" value="<%=EditPass%>" maxlength="20" autocomplete="off" type="text" /></label>
							<a class="tooltip" tabindex="-1" href="#" title="Bu özellik kategorinizin belirli kullanıcılar tarıfından <br />görüntülenmesini sağlamak amacıyla oluşturulmuştur, <br />kendi belirleyeceğiniz maksimun 16 karekter uzunluğunda <br />bir parolayı girdiğiniz taktirde sayfa görüntülenecektir.">&nbsp;</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><h3 class="box-title">Sayfa İstatistikleri</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
<%
Response.Write( strHits )
%>

				</div>
			</div>
		</div>

	</div>
<input name="energy" id="energy" value="1" type="hidden" />
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
</form>
