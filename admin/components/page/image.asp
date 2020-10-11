
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="<%=xAuthor%>" />
<meta name="generator" content="<%=xGenerator%>" />
<meta name="reply-to" content="<%=xReply%>" />
<meta name="robots" content="noindex, nofollow, noarchive" />
<meta name="copyright" content="&copy; 2008 - <%=Year(Date())%> <%=xGenerator%>" />
<title><%=xGenerator%> - &copy; 2008 - <%=Year(Date())%></title>
<!--#include file="../header.asp"-->
<style type="text/css">
	html { overflow:auto !important; }
	.boxs {float:left; margin-right:10px; margin-bottom:20px; padding:10px; line-height:1; border:1px solid #DFDFDF; background-color:whiteSmoke; -moz-border-radius:5px; -webkit-border-radius:5px; -ms-border-radius:5px; -o-border-radius:5px; border-radius:5px;}
	.boxs h3 {display:block; margin:3px 0 5px 0px; font-size:13px;}
	.boxs h4 {display:block; margin:8px 0 1px 0px; padding-top:5px; font-size:11px;}
	.boxs label {float:left; display:block; margin:3px 10px 8px 0px; line-height:1.5em}
	.boxs .a {margin-right:0;}
	ol.text {margin:0; padding:10px 10px 10px 20px; border:1px solid #DFDFDF; background-color:whiteSmoke; -moz-border-radius:5px; -webkit-border-radius:5px; -ms-border-radius:5px; -o-border-radius:5px; border-radius:5px;}
	ol.text li {margin:0; margin-left:10px; padding:0px 0 0px 0px; font-size:12px;}
</style>
<style type="text/css">
	#file_list {padding:0 6px;}
	#file_list ul {margin:0; padding:5px 0; list-style:none;}
	#file_list .postbox {width:100%;}
	#file_list .postbox .rows {width:600px;}
	#file_list .on_off {padding:13px 14px; background-position:-30px -123px;}
	#file_list .on_off:hover, #file_list .on_off.active {background-position:-30px -220px;}
	#file_list .h3_title {padding:12px 8px; background-color:#dfdfdf;}
	#file_list .rows {clear:none;}
	#file_list .mini_img {float:left; padding:2px 0 0 2px;}
	#file_list .small_img {float:left; margin:0; padding:0; max-width:50px; max-height:30px; -moz-border-radius:3px; -webkit-border-radius:3px; border-radius:3px;}
	#file_list .inputbox, #file_list textarea {width:440px;}

	#file_list .images {float:left; margin-right:20px; width:140px; height:100px;}
	#file_list .medium_image {float:left; max-width:140px; max-height:100px;}

	#file_list .file_text {width:150px; font-weight:bold;}
	#file_list .file_text.normal {font-weight:normal;}
	#file_list .file_text i.nokta {float:right; padding-right:3px; font-style:normal;}
	#file_list .file_text i.ops {font-size:10px; color:#888; padding-right:3px; font-style:normal;}

	#file_list .postbox .file_body {padding:0 0px;}
	#file_list .postbox .file_content {padding:0 5px;}
</style>
	<script>
	$(function() {
	var file_sortable = ".file_sortable";
	if($(file_sortable).length > 0) {
		//file_sortable.sortable({connectWith: "ul", placeholder: "ph", axis: "y", revert: true, cursor: "move"});

		$(file_sortable).sortable({connectWith: "ul", placeholder: "ph", axis: "y", revert: true, cursor: "move"}).disableSelection();

		var $tabs = $( "#tabs" ).tabs();

		var $tab_items = $( "ul:first li", $tabs ).droppable({
			accept: file_sortable + " li",
			hoverClass: "ui-state-hover",
			drop: function( event, ui ) {
				var $item = $( this );
				var $list = $( $item.find( "a" ).attr( "href" ) )
					.find( file_sortable );

				ui.draggable.hide( "slow", function() {
					$tabs.tabs( "select", $tab_items.index( $item ) );
					$( this ).appendTo( $list ).show( "slow" );
				});
			}
		});
	}
});
	</script>
</head>
<body>


<%


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


'// UI Tab Button
uiActiveClass = "" : strCssHidden = ""
If GlobalConfig("site_lang") = strLangCode Then uiActiveClass = " class=""ui-tabs-selected ui-state-active"""
If sTotalLang() = 1 Then strCssHidden = " style=""display:none !important""" : addTitle = "<h3 class=""box-title"">Sayfa İçeriği</h3>"

strTabButton = strTabButton & "<li"& uiActiveClass &" id=""editorid_"& strLangCode &""">" & vbCrLf
strTabButton = strTabButton & "	<a "& strDirection2 &" rel=""languages"" tabindex=""-1"" href=""#tabs_"& strLangCode &""">"& strLangTitle &"</a>" & vbCrLf
strTabButton = strTabButton & "</li>" & vbCrLf


EditiD = 57211
'strLangCode = "TR"
strPictures = ""
Set objRs3 = setExecute("SELECT id, title, alt, url, text, resim, mime_type, anaresim, durum, tarih FROM #___files WHERE (file_type = 1 And parent = "& GlobalConfig("General_PagePN") &" And parent_id = "& EditiD &" And lang = '"& strLangCode &"') ORDER BY sira ASC;")
	Do While Not objRs3.Eof
		If CBool(objRs3("anaresim")) Then strChecked = " checked" Else strChecked = ""
		If CBool(objRs3("durum")) Then strStatusChecked = " checked" : strStatusText = "Resmi Pasif Yap" Else strStatusChecked = "" : strStatusText = "Resmi Aktif Yap"
'		strPictures = strPictures & ("				<li id=""image-id_"& objRs3("id") &""" class=""success"">" & vbCrLf)
'		strPictures = strPictures & ("					<div class=""icons tooltip"">" & vbCrLf)
'		strPictures = strPictures & ("						<span class=""img-default-file"& strChecked &""" title=""Varsayılan Resim Yap""><em>&nbsp;</em></span>" & vbCrLf)
'		strPictures = strPictures & ("						<span class=""img-add-file"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf)
'		strPictures = strPictures & ("						<span class=""img-edit-file"" title=""Resim Bilgilerini Düzenle""><em>&nbsp;</em></span>" & vbCrLf)
'		strPictures = strPictures & ("						<span class=""img-status-file"& strStatusChecked &""" title="""& strStatusText &"""><em>&nbsp;</em></span>" & vbCrLf)
'		strPictures = strPictures & ("						<span class=""img-delete-file"" title=""Resmi Kalıcı Olarak Sil""><em>&nbsp;</em></span>" & vbCrLf)
'		strPictures = strPictures & ("					</div>" & vbCrLf)
'		strPictures = strPictures & ("					<div class=""img"">" & vbCrLf)
'		strPictures = strPictures & ("						<a rel=""img-show"" tabindex=""-1"" href="""& sFolder(EditiD, 0) & "/" & objRs3("resim") &""" title="""& objRs3("title") &""">")
'		strPictures = strPictures & ("<img src="""& sFolder(EditiD, 1) & "/" & objRs3("resim") &""" ")
'		strPictures = strPictures & ("title="""& objRs3("title") &""" alt="""& objRs3("alt") &""" ")
'		strPictures = strPictures & ("data-src="""& Right(sFolder(EditiD, 0) & "/" & objRs3("resim"), Len(sFolder(EditiD, 0) & "/" & objRs3("resim")) - Len(GlobalConfig("sRoot"))) &""" ")
'		strPictures = strPictures & ("data-link="""& objRs3("url") &""" ")
'		strPictures = strPictures & ("data-mimetype="""& objRs3("mime_type") &""" ")
'		strPictures = strPictures & ("data-name="""& objRs3("resim") &""" ")
'		strPictures = strPictures & ("data-date="""& TarihFormatla(objRs3("tarih")) &""" ")
'		strPictures = strPictures & ("data-text="""& objRs3("text") &""" ")
'		strPictures = strPictures & (imgAlign(sFolder(EditiD, 1) & "/" & objRs3("resim"), 110, 90, 110, 90))
'		strPictures = strPictures & (" /></a>" & vbCrLf)
'		strPictures = strPictures & ("					</div>" & vbCrLf)
'		strPictures = strPictures & ("				</li>" & vbCrLf)

		'strPictures = strPictures & "<div id=""file_list"" class=""clearfix"">" & vbCrLf
		'strPictures = strPictures & "	<ul class=""file_sortable file_list"">" & vbCrLf
		strPictures = strPictures & "		<li id=""fileid_"& objRs3("id") &""">" & vbCrLf
		strPictures = strPictures & "			<form id=""EnergyMenuList_"& objRs3("id") &""" class=""EnergyAddMenu"" data_turu=""list"" action=""?mod=list_post&amp;task=menu&amp;menutype=ustmenu&amp;debug=true"" method=""post"">" & vbCrLf
		strPictures = strPictures & "			<div class=""postbox"">" & vbCrLf
		strPictures = strPictures & "				<div class=""handle clearfix"">" & vbCrLf
		strPictures = strPictures & "					<div class=""on_off"" title=""Göster / Gizle"" onclick=""$('#file_toggle_"& objRs3("id") &"').toggle('blind', 600); $(this).toggleClass('active'); return false;"">&nbsp;</div>" & vbCrLf
		strPictures = strPictures & "					<div class=""mini_img""><img class=""small_img"" src="""& sFolder(EditiD, 1) & "/" & objRs3("resim") &""""& imgAlign(sFolder(EditiD, 1) & "/" & objRs3("resim"), 50, 35, 50, 35) &" /></div>" & vbCrLf
		strPictures = strPictures & "					<h3 class=""h3_title"" title="""& objRs3("title") &""">" & vbCrLf
		strPictures = strPictures & "						<a id=""file_remove2_"& objRs3("id") &""" class=""file_remove"" href=""#"" title=""Dosyayı Sunucudan Sil""><i class=""hidden"">Sil</i></a>" & vbCrLf
		strPictures = strPictures & "						<span>"& objRs3("title") &"</span>" & vbCrLf
		strPictures = strPictures & "					</h3>" & vbCrLf
		strPictures = strPictures & "				</div>" & vbCrLf
		strPictures = strPictures & "				<div class=""file_body clearfix"">" & vbCrLf
		strPictures = strPictures & "					<div id=""file_toggle_"& objRs3("id") &""" class=""menu_content hidden"">" & vbCrLf
		strPictures = strPictures & "						<div class=""images""><a rel=""img-show"" tabindex=""-1"" href="""& sFolder(EditiD, 0) & "/" & objRs3("resim") &""" title="""& objRs3("title") &"""><img class=""medium_image"" src="""& sFolder(EditiD, 1) & "/" & objRs3("resim") &""""& imgAlign(sFolder(EditiD, 1) & "/" & objRs3("resim"), 140, 100, 140, 100) &" /></a></div>" & vbCrLf
		strPictures = strPictures & "						<div style=""float:left;"">" & vbCrLf
		strPictures = strPictures & "							<div class=""rows clearfix"" style=""width:440px;"">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Dosya İsmi</span>" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text normal"" style=""width:auto;"">"& objRs3("resim") &"</span>" & vbCrLf
		strPictures = strPictures & "							</div>" & vbCrLf
		strPictures = strPictures & "							<div class=""rows clearfix"" style=""width:440px;"">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Dosya Türü</span>" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text normal"" style=""width:auto;"">"& objRs3("mime_type") &"</span>" & vbCrLf
		strPictures = strPictures & "							</div>" & vbCrLf
		strPictures = strPictures & "							<div class=""rows clearfix"" style=""width:440px;"">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Ekleme Tarihi</span>" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text normal"" style=""width:auto;"">"& TarihFormatla(objRs3("tarih")) &"</span>" & vbCrLf
		strPictures = strPictures & "							</div>" & vbCrLf
		strPictures = strPictures & "							<div class=""rows clearfix"" style=""width:440px;"">" & vbCrLf
		'strPictures = strPictures & "								<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Ekleme Tarihi</span>" & vbCrLf
		'strPictures = strPictures & "								<span class=""file_text normal"" style=""width:auto;"">"& TarihFormatla(objRs3("tarih")) &"</span>" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text normal"" style=""width:auto;"">" & vbCrLf
		strPictures = strPictures & "									<label for=""file_status_"& objRs3("id") &""">" & vbCrLf
		strPictures = strPictures & "										Durum" & vbCrLf
		strPictures = strPictures & "										<input name=""file_status_"& objRs3("id") &""" id=""file_status_"& objRs3("id") &""" type=""checkbox"" value=""1"""& eChecked(CBool(objRs3("durum"))) &" class=""radioMargin"" />" & vbCrLf
		strPictures = strPictures & "									<a class=""tooltip"" tabindex=""-1"" href=""#"" title=""Bu işareti kaldırırsanız resminiz örneğin resim galerisi vb. yerlerde görüntülenmez."">&nbsp;</a>" & vbCrLf
		strPictures = strPictures & "									</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & vbCrLf
		strPictures = strPictures & "									<label for=""file_default_"& objRs3("id") &"_1"">" & vbCrLf
		strPictures = strPictures & "										Normal" & vbCrLf
		strPictures = strPictures & "										<input name=""file_default_"& objRs3("id") &""" id=""file_default_"& objRs3("id") &"_1"" type=""radio"" value=""0"""& eChecked(objRs3("anaresim") = 0) &" class=""radioMargin"" />" & vbCrLf
		strPictures = strPictures & "									</label>&nbsp;&nbsp;&nbsp;" & vbCrLf
		strPictures = strPictures & "									<label for=""file_default_"& objRs3("id") &"_2"">" & vbCrLf
		strPictures = strPictures & "										Default" & vbCrLf
		strPictures = strPictures & "										<input name=""file_default_"& objRs3("id") &""" id=""file_default_"& objRs3("id") &"_2"" type=""radio"" value=""1"""& eChecked(objRs3("anaresim") = 1) &" class=""radioMargin"" />" & vbCrLf
		strPictures = strPictures & "									<a class=""tooltip"" tabindex=""-1"" href=""#"" title=""Örneğin bir resim listesinde görüntülemek için Default olarak seçebilirsiniz."">&nbsp;</a>" & vbCrLf
		strPictures = strPictures & "									</label>&nbsp;&nbsp;&nbsp;" & vbCrLf
		strPictures = strPictures & "									<label for=""file_default_"& objRs3("id") &"_3"">" & vbCrLf
		strPictures = strPictures & "										Öne Çıkarılmış" & vbCrLf
		strPictures = strPictures & "										<input name=""file_default_"& objRs3("id") &""" id=""file_default_"& objRs3("id") &"_3"" type=""radio"" value=""2"""& eChecked(objRs3("anaresim") = 2) &" class=""radioMargin"" />" & vbCrLf
		strPictures = strPictures & "									<a class=""tooltip"" tabindex=""-1"" href=""#"" title=""Bazı Temalarda öne çıkarılmış görseller kullanılır eğer temanız destekliyorsa bunu seçebilirsiniz."">&nbsp;</a>" & vbCrLf
		strPictures = strPictures & "									</label>" & vbCrLf
		strPictures = strPictures & "								</span>" & vbCrLf
		strPictures = strPictures & "							<div class=""clr""></div>" & vbCrLf

'		strPictures = strPictures & "								<span class=""file_text normal"" style=""width:auto;"">" & vbCrLf
'		'strPictures = strPictures & "								<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Boyut</span>" & vbCrLf
'		strPictures = strPictures & "									<b>Editöre Gönder /</b> <label for=""file_insert_boyut_"& objRs3("id") &"_3"" title=""Boyut."">" & vbCrLf
'		strPictures = strPictures & "										Küçük Boy" & vbCrLf
'		strPictures = strPictures & "										<span class=""img-add-file"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "									</label>&nbsp;" & vbCrLf
'		strPictures = strPictures & "									<label for=""file_insert_boyut_"& objRs3("id") &"_3"" title=""Boyut."">" & vbCrLf
'		strPictures = strPictures & "										Orta Boy" & vbCrLf
'		strPictures = strPictures & "										<span class=""img-add-file"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "									</label>&nbsp;" & vbCrLf
'		strPictures = strPictures & "									<label for=""file_insert_boyut_"& objRs3("id") &"_3"" title=""Boyut."">" & vbCrLf
'		strPictures = strPictures & "										Büyük Boy" & vbCrLf
'		strPictures = strPictures & "										<span class=""img-add-file"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "									</label>&nbsp;" & vbCrLf
'		strPictures = strPictures & "								</span>" & vbCrLf

'		strPictures = strPictures & "							<span class=""file_text normal icons tooltip"" style=""width:auto;"">" & vbCrLf
'		strPictures = strPictures & "								<span class=""img-default-file"& strChecked &""" title=""Varsayılan Resim Yap""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "								<span style=""width:50px; text-align:right;"">Küçük Boy</span> <span class=""img-add-file"" style=""margin-right:8px;"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "								<span style=""width:50px; text-align:right;"">Orta Boy</span> <span class=""img-add-file"" style=""margin-right:8px;"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "								<span style=""width:50px; text-align:right;"">Büyük Boy</span> <span class=""img-add-file"" style=""margin-right:8px;"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "								<span class=""img-edit-file"" title=""Resim Bilgilerini Düzenle""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "								<span class=""img-status-file"& strStatusChecked &""" title="""& strStatusText &"""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "								<span class=""img-delete-file"" title=""Resmi Kalıcı Olarak Sil""><em>&nbsp;</em></span>" & vbCrLf
'		strPictures = strPictures & "							</span>" & vbCrLf


		strPictures = strPictures & "							</div>" & vbCrLf
		strPictures = strPictures & "						</div>" & vbCrLf
		strPictures = strPictures & "						<div class=""clr""></div>" & vbCrLf
		strPictures = strPictures & "						<div class=""rows clearfix"">" & vbCrLf
		strPictures = strPictures & "							<label class=""lb"" for=""file_path_"& objRs3("id") &""" title=""Örneğin: &quot;http://www.webtasarimx.net/&quot; şeklinde bir bağlantı girmelisiniz. — &quot;http://&quot; veya &quot;https://&quot; protokolünü yazmayı unutmayın."">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text""><i class=""nokta"">:</i> Dosya URL'si</span>" & vbCrLf
		strPictures = strPictures & "								<span class=""relative clearfix"">" & vbCrLf
		strPictures = strPictures & "									<input disabled=""disabled"" name=""file_path"" id=""file_path_"& objRs3("id") &""" value="""& Right(sFolder(EditiD, 0) & "/" & objRs3("resim"), Len(sFolder(EditiD, 0) & "/" & objRs3("resim")) - Len(GlobalConfig("sRoot"))) &""" class=""inputbox"" type=""text"" onblur=""if($(this).val() == '') $(this).val('http:\/\/').css('color', '#aaa');"" onfocus=""if($(this).val() == 'http:\/\/') $(this).val('').css('color', '#2F3032');"" />" & vbCrLf
		strPictures = strPictures & "									<span class=""insert_file_editor"" style=""position:absolute; right: 0px; top: -4px; z-index:2; width:20px; height:20px;"" title=""Editöre Ekle""><em>&nbsp;</em></span>" & vbCrLf
		strPictures = strPictures & "								</span>" & vbCrLf
		strPictures = strPictures & "							</label>" & vbCrLf
		strPictures = strPictures & "						</div>" & vbCrLf
		strPictures = strPictures & "						<div class=""rows clearfix"">" & vbCrLf
		strPictures = strPictures & "							<label class=""lb"" for=""file_title_"& objRs3("id") &""" title=""Örneğin: &quot;Energy Web Tasarım&quot; şeklinde bir bağlantı etiketi girebilirsiniz."">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text""><i class=""nokta"">:</i> Dosya Başlığı</span>" & vbCrLf
		strPictures = strPictures & "								" & vbCrLf
		strPictures = strPictures & "								<input name=""file_tag"" id=""file_title_"& objRs3("id") &""" value="""& objRs3("title") &""" class=""inputbox"" type=""text"" />" & vbCrLf
		strPictures = strPictures & "							</label>" & vbCrLf
		strPictures = strPictures & "						</div>" & vbCrLf
		strPictures = strPictures & "						<div class=""rows clearfix"">" & vbCrLf
		strPictures = strPictures & "							<label class=""lb"" for=""file_alttext_"& objRs3("id") &""" title=""Kullanıcı fareyi bağlantı üzerine getirdiğinde tercihinize bağlı olarak bağlantının üzerinde ya da altında gözükecektir. Boş bırakıldığında &quot;Navigasyon Etiketi&quot; geçerli olacaktır."">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text""><i class=""nokta"">:</i> Alternatif Metin</span>" & vbCrLf
		strPictures = strPictures & "								" & vbCrLf
		strPictures = strPictures & "								<input name=""file_alttext"" id=""file_alttext_"& objRs3("id") &""" value="""& objRs3("alt") &""" class=""inputbox"" type=""text"" />" & vbCrLf
		strPictures = strPictures & "							</label>" & vbCrLf
		strPictures = strPictures & "						</div>" & vbCrLf
		strPictures = strPictures & "						<div class=""rows clearfix"">" & vbCrLf
		strPictures = strPictures & "							<label class=""lb"" for=""file_private_text_"& objRs3("id") &""" title=""Web tasarımınız destekliyorsa, açıklama menüde görüntülenir."">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text""><i class=""nokta"">:</i> Özel Açıklama <i class=""ops"" title=""Opsiyonal"">(ops.)</i></span>" & vbCrLf
		strPictures = strPictures & "								" & vbCrLf
		strPictures = strPictures & "								<textarea name=""file_private_text"" id=""file_private_text_"& objRs3("id") &""">"& objRs3("text") &"</textarea>" & vbCrLf
		strPictures = strPictures & "							</label>" & vbCrLf
		strPictures = strPictures & "						</div>" & vbCrLf
		strPictures = strPictures & "						<div class=""rows clearfix"">" & vbCrLf
		strPictures = strPictures & "							<label class=""lb"" for=""file_privateurl_"& objRs3("id") &""" title=""Örneğin arama motorlarının eklediğiniz bir bağlantıyı takip etmesini engellemek için &quot;nofollow&quot; değerini girebilirisiz."">" & vbCrLf
		strPictures = strPictures & "								<span class=""file_text""><i class=""nokta"">:</i> Özel Bağlantı Adresi <i class=""ops"" title=""Opsiyonal"">(ops.)</i></span>" & vbCrLf
		strPictures = strPictures & "								<input name=""file_private_url"" id=""file_privateurl_"& objRs3("id") &""" value="""& objRs3("url") &""" class=""inputbox"" type=""text"" />" & vbCrLf
		strPictures = strPictures & "							</label>" & vbCrLf
		strPictures = strPictures & "						</div>" & vbCrLf
		strPictures = strPictures & "						<div class=""rows submit_btn clearfix"">" & vbCrLf
		strPictures = strPictures & "							<span class=""a"">" & vbCrLf
		strPictures = strPictures & "								<img class=""loading_img"" src=""/admin/images/loading.gif"" alt=""Lütfen Bekleyin..."" />" & vbCrLf
		strPictures = strPictures & "								<span class=""ie_btn""><input type=""submit"" class=""addFileSubmit btn"" value=""Kaydet"" title=""Değişiklikleri Kaydet"" /></span>" & vbCrLf
		strPictures = strPictures & "							</span>" & vbCrLf
		strPictures = strPictures & "							<span class=""b"">" & vbCrLf
		strPictures = strPictures & "								<a id=""file_remove_"& objRs3("id") &""" class=""file_remove"" href=""#"" title=""Dosyayı Sunucudan Sil"">Bunu Sil</a>" & vbCrLf
		strPictures = strPictures & "							</span>" & vbCrLf
		strPictures = strPictures & "						</div>" & vbCrLf
		strPictures = strPictures & "						<div class=""clr""></div>" & vbCrLf
		strPictures = strPictures & "					</div>" & vbCrLf
		strPictures = strPictures & "					<div class=""clr""></div>" & vbCrLf
		strPictures = strPictures & "				</div>" & vbCrLf
		strPictures = strPictures & "			</div>" & vbCrLf
		strPictures = strPictures & "			<input type=""hidden"" name=""id"" value="""& objRs3("id") &""" />" & vbCrLf
		strPictures = strPictures & "			<input type=""hidden"" name=""file_anaid"" value=""0"" />" & vbCrLf
		strPictures = strPictures & "			<input type=""hidden"" name=""file_lang"" value=""TR"" />" & vbCrLf
		strPictures = strPictures & "			<input type=""hidden"" name=""file_parent"" value=""0"" />" & vbCrLf
		strPictures = strPictures & "			<input type=""hidden"" name=""file_parentid"" value=""0"" />" & vbCrLf
		strPictures = strPictures & "			</form>" & vbCrLf
		strPictures = strPictures & "		</li>" & vbCrLf
		'strPictures = strPictures & "	</ul>" & vbCrLf
		'strPictures = strPictures & "</div>" & vbCrLf




	objRs3.MoveNext() : Loop
Set objRs3 = Nothing

strAppendPictures = strAppendPictures & "		<div id=""tabs_"& strLangCode &""">" & vbCrLf

'If sTotalLang() > 1 Then strAppendPictures = strAppendPictures & "<h3 style=""margin-top:10px; padding:1px 0;"" class=""box-title"">"& strLangTitle &"Sayfa Görselleri</h3>"
'strAppendPictures = strAppendPictures & "<div style=""padding:10px 0; padding-left:2px; border: 1px solid #DFDFDF; -moz-box-shadow: inset 0 1px 0 #fff; -webkit-box-shadow: inset 0 1px 0 white; box-shadow: inset 0 1px 0 white; -moz-border-radius: 3px; -webkit-border-radius: 3px; border-radius: 3px; background-color: whiteSmoke;""><ul class=""image_files clearfix"" id=""files_"& strLangCode &""">" & vbCrLf & strPictures & "</ul></div><div class=""clr""></div>" & vbCrLf

'strAppendPictures = strAppendPictures & "<div id=""file_list"" class=""clearfix"">" & vbCrLf
strAppendPictures = strAppendPictures & "	<ul class=""file_sortable file_list clearfix"" id=""files_"& strLangCode &""">" & vbCrLf
strAppendPictures = strAppendPictures & strPictures & vbCrLf
strAppendPictures = strAppendPictures & "	</ul>" & vbCrLf
'strAppendPictures = strAppendPictures & "</div>" & vbCrLf

'###################################
strAppendPictures = strAppendPictures & "		</div>" & vbCrLf

	objRs.MoveNext() : Loop
Set objRs = Nothing
%>

<div class="energy-tabs">
	<div class="m_box" id="tabs">
		<div class="title">
			<ul <%=strCssHidden%>>
				<%
					Response.Write( vbCrLf & strTabButton)
				%>
			</ul>
		</div>
		<div class="head">
			<div class="form-table" style="margin:0;">
				<%
					'Response.Write( strTabContent )
				%>
				<div id="file_list" class="clearfix">
					<div id="image-files" class="clearfix" style="margin-bottom:10px;">
						<div id="status"></div>
					</div>
					<%
						Response.Write( strAppendPictures )
					%>
					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
		</div>
	</div>
</div>



</body>
</html>

