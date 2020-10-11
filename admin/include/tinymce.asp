
<%
Sub TinyMce2()
%>
<script src="<%=GlobalConfig("sBase")%>javascript/tinymce_4.0b2/tinymce.min.js" type="text/javascript"></script>
<script type="text/javascript">
//tinymce.PluginManager.load('moxiemanager', '<%=GlobalConfig("sBase")%>javascript/tinymce_4.0b2/moxiemanager/plugin.min.js');
tinymce.init({
    selector: "textarea.energy_mce_editor",
	editor_selector:"energy_mce_editor",
    theme: "modern",
	entities:"38,amp,60,lt,62,gt,160,nbsp",
	//language:"tr",
    document_base_url: "<%=GlobalConfig("sBase")%>",
    plugins: [
        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime media nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor"
    ],
    toolbar1: "save | insertfile undo redo | styleselect | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
    toolbar2: "print preview media | forecolor backcolor emoticons",
    /*
	templates: [
        {title: 'Test template 1', content: '<b>Test 1</b>'},
        {title: 'Test template 2', content: '<em>Test 2</em>'}
    ],
	*/
	extended_valid_elements: "html[head|body|meta|title],iframe[src|width|height|name|id|class|align|style|frameborder|border|allowtransparency|scrolling|marginheight|marginwidth],area[alt|href|shape|coords]",
	extended_valid_elements: "object[data|classid|width|height|codebase],embed[src|quality|bgcolor|width|height|name|align|type|pluginpage]",
	extended_valid_elements: "a[name|href|target|title|onclick|onmouseover|onmouseout|rel|id|class],img[id|class|style|border|src|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name]",
	extended_valid_elements: "strong/b[id|class|title],em/i[id|class|title],strike[id|class|title],u[id|class|title],ins[id|class|title],hr[id|class|title|width|size|noshade],font[face|size|color|style],span[id|class|align|style]",
	extended_valid_elements: "article[*],aside[*],audio[*],canvas[*],command[*],datalist[*],details[*],embed[*],figcaption[*],figure[*],footer[*],header[*],hgroup[*],keygen[*],mark[*],meter[*],nav[*],output[*],progress[*],section[*],source[*],summary,time[*],video[*],wbr",
	formats: {
		alignleft: [
			{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-left'},
			{selector:'table', classes:'float-left'},
			{selector:'img', classes:'img-left'} 
		],
		aligncenter: [
			{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-center'},
			{selector:'table', classes:'float-center'},
			{selector:'img', classes:'img-center'}
		],
		alignright: [
			{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-right'},
			{selector:'table', classes:'float-right'},
			{selector:'img', classes:'img-right'}
		],
		alignfull: [
			{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-justify'}
		],
		bold: {inline: 'b'},
		italic: {inline: 'i'},
		underline: {inline:'u'},
		strikethrough: {inline:'del'},
		customformat: {inline: 'span', styles: {color: '#00ff00', fontSize: '20px'}, attributes: {title: 'My custom format'}}
	},
	content_css:"<%=GlobalConfig("sRoot")%>css/common.css?noCache=<%=Session.SessionID%>, <%=GlobalConfig("sRoot")%>css/editor.css?noCache=<%=Session.SessionID%>",
	save_callback: "TinyMCE_Save",
	save_onsavecallback:function() { TinyMCE_Save(tinyMCE.settings["selector"], tinyMCE.get(tinyMCE.settings["selector"]).getContent()); $("#form_submit").click() },
	autosave_ask_before_unload: true,
	emotions_images_url:"<%=GlobalConfig("sRoot")%>images/emotions/",
	media_strict:false,
	paste_remove_styles:true,
	paste_remove_spans:true,
	relative_urls:true,
	remove_script_host:true,
	convert_urls:true,
	paste_text_use_dialog:true,
	apply_source_formatting:true,
	remove_linebreaks:false,
	force_br_newlines:false,
	force_p_newlines:true,
	debug:false,
	cleanup:true,
	cleanup_on_startup:true,
	safari_warning:false,
	paste_strip_class_attributes:"all",
	accessibility_focus:true,
	tabfocus_elements:"major-publishing-actions",
	gecko_spellcheck:true,
	fix_list_elements:true,
	keep_styles:false
});

function TinyMCE_Save(editor_id, content, node) {console.log(editor_id)
	base_url = tinyMCE.settings["document_base_url"];
	if (true == true) {
		content = content.replace(new RegExp("href\s*=\s*\"?'?" + base_url, "gi"), "href=\"\/");
		content = content.replace(new RegExp("src\s*=\s*\"?'?" + base_url, "gi"), "src=\"\/");
		content = content.replace(new RegExp("src\s*=\s*\"?'?" + base_url, "gi"), "src=\"\/");
		content = content.replace(/href=\"\//gi, "href=\"");
		content = content.replace(/src=\"\/upload\//gi,"src=\"upload\/");
		content = content.replace(/mce_real_src\s*=\s*"?/gi, "");
		content = content.replace(/mce_real_href\s*=\s*"?/gi, "");
		content = content.replace(/(<.*?class\s*=\s*?'?"?|<.*?style\s*=\s*?'?"?)([^"]*)('?"?[^>]*>&nbsp;<\/p>)/gi, "<p>&nbsp;</p>");
		content = content.replace(/(<pre.*?>.*?<br.*?\/>.*?<\/pre>)/gi, "");
		content = content.replace(/<span style=\"text-decoration: ?underline;\">(.*?)<\/span>/gi, "<u>$1</u>");
	}
	return content;
}

function jInsertEditorText(text, editor) {
	tinyMCE.execInstanceCommand(editor, 'mceInsertContent', false, text);
}
function insertReadmore(editor) {
	var content = tinyMCE.get(editor).getContent();
	if (content.match(/<hr id="readmore" \/>/)) {
		$.colorbox({html:'<p class="messages warning">Önceden eklediğiniz bir <em class="red">Devamı...</em> bağlantısı bulunmaktadır.<br />Sadece bir bağlantı ekleyebilirsiniz.</p>'});
		return false;
	} else {
		jInsertEditorText('<hr id="readmore" \/><p>&nbsp;<\/p>', editor);
	}
}
function jSelectArticle(title, url, editor) {
	var tag = '<a href="'+ url +'" title="'+ title +'">'+ title +'</a>';
	jInsertEditorText(tag, editor);
	$.colorbox.close();
	return false;
}
</script>

<%
End Sub
%>



<%

Private Sub TinyMce()
	'exit Sub
	With Response
		.Write("<script src="""& GlobalConfig("sBase") &"javascript/tiny_mce_3.5.8/tiny_mce.js"" type=""text/javascript""></script>" & vbCrLf)
		.Write("<script type=""text/javascript"">" & vbCrLf)
		.Write("/* <![CDATA[ */" & vbCrLf)

		.Write("function jInsertEditorText(text, editor) {")
		.Write("tinyMCE.execInstanceCommand(editor, 'mceInsertContent', false, text);")
		'.Write("//tinyMCE.execCommand('mceInsertContent', false, text);" & vbcrlf)
		.Write("}")

		.Write("function insertReadmore(editor) {")
		'.Write("//var content = tinyMCE.getContent();" & vbcrlf)
		.Write("var content = tinyMCE.get(editor).getContent();")
		.Write("if (content.match(/<hr id=""readmore"" \/>/)) {")
		.Write("$.colorbox({html:'<p class=""messages warning"">Önceden eklediğiniz bir <em class=""red"">Devamı...</em> bağlantısı bulunmaktadır.<br />Sadece bir bağlantı ekleyebilirsiniz.</p>'});")
		'.Write("//alert('Önceden eklediğiniz bir Devamı... bağlantısı bulunmaktadır.\nSadece bir bağlantı ekleyebilirsiniz.');" & vbcrlf)
		.Write("return false;")
		.Write("} else {")
		.Write("jInsertEditorText('<hr id=""readmore"" \/><p>&nbsp;<\/p>', editor);")
		.Write("}")
		.Write("}")

		.Write("function jSelectArticle(title, url, editor) {")
		.Write("var tag = '<a href=""'+ url +'"" title=""'+ title +'"">'+ title +'</a>';")
		.Write("jInsertEditorText(tag, editor);")
		.Write("$.colorbox.close();")
		.Write("return false;")
		.Write("}")

		'// tinyMCE init
		.Write("tinyMCE.init({")
		.Write("/* General options */")
		.Write("mode:""textareas"",")
		.Write("theme:""advanced"",")
		.Write("skin:""energy3"",")
		.Write("width:""100%"",")
		.Write("height:""400"",")
		.Write("language:""tr"",")
		.Write("entities:""38,amp,60,lt,62,gt,160,nbsp"",")
		'.Write("entities:""160,nbsp,38,amp,34,quot,162,cent,8364,euro,163,pound,165,yen,169,copy,174,reg,8482,trade,8240,permil,60,lt,62,gt,8804,le,8805,ge,176,deg,8722,minus"",")
		.Write("editor_selector:""energy_mce_editor"",")
		If _
			GlobalConfig("site_lang") = "AR" And _
			(mods = GlobalConfig("General_Poll") Or mods =  GlobalConfig("General_Banner")) _
		Then _
		.Write("directionality:""rtl"",")
		.Write("document_base_url:"""& GlobalConfig("sBase") &""",")
		'.Write("emotions_images_url:"""& GlobalConfig("sBase") &"images/"",")
		.Write("content_css:"""& GlobalConfig("sBase") &"css/common.css?noCache="& Session.SessionID &", "& GlobalConfig("sBase") &"css/editor.css?noCache="& Session.SessionID &""",")
		.Write("theme_advanced_font_sizes: ""8px,10px,12px,13px,14px,16px,18px,20px,22px,24px,26px,28px,30px,32px,34px,36px,38px,40px"",")
		.Write("font_size_style_values : ""8px,10px,12px,13px,14px,16px,18px,20px,22px,24px,26px,28px,30px,32px,34px,36px,38px,40px"",")
		.Write("paste_text_use_dialog:false,")
		'.Write("plugins:""imagemanager,filemanager"",")
		'autoresize,

		.Write("plugins:""wrapper,autolink,lists,tabfocus,pagebreak,style,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,media,searchreplace,paste,directionality,fullscreen,visualchars,nonbreaking,xhtmlxtras,wordcount,advlist,autosave,preelementfix"",")
		.Write("extended_valid_elements: ""html[head|body|meta|title],iframe[src|width|height|name|id|class|align|style|frameborder|border|allowtransparency|scrolling|marginheight|marginwidth],area[alt|href|shape|coords]"",")
		.Write("extended_valid_elements: ""object[data|classid|width|height|codebase],embed[src|quality|bgcolor|width|height|name|align|type|pluginpage]"",")
		.Write("extended_valid_elements: ""a[name|href|target|title|onclick|onmouseover|onmouseout|rel|id|class],img[id|class|style|border|src|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name]"",")
		.Write("extended_valid_elements: ""strong/b[id|class|title],em/i[id|class|title],strike[id|class|title],u[id|class|title],ins[id|class|title],hr[id|class|title|width|size|noshade],font[face|size|color|style],span[id|class|align|style]"",")
		.Write("extended_valid_elements: ""article[*],aside[*],audio[*],canvas[*],command[*],datalist[*],details[*],embed[*],figcaption[*],figure[*],footer[*],header[*],hgroup[*],keygen[*],mark[*],meter[*],nav[*],output[*],progress[*],section[*],source[*],summary,time[*],video[*],wbr"",")

		.Write("formats:{")
			.Write("alignleft:[")
				.Write("{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-left'},") ' /*styles:{textAlign:'left'}*/
				.Write("{selector:'table', classes:'float-left'},")
				.Write("{selector:'img', classes:'img-left'} ")
			.Write("],")
			.Write("aligncenter:[")
				.Write("{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-center'},") ' /*styles:{textAlign:'center'}*/
				.Write("{selector:'table', classes:'float-center'},")
				.Write("{selector:'img', classes:'img-center'}")
			.Write("],")
			.Write("alignright:[")
				.Write("{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-right'},") ' /*styles:{textAlign:'right'}*/
				.Write("{selector:'table', classes:'float-right'},")
				.Write("{selector:'img', classes:'img-right'}")
			.Write("],")
			.Write("alignfull:[")
				.Write("{selector:'div,p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,span,font,strong,b,em,i,u,blockquote,strike,del,s,ins,code', classes:'text-justify'}") ' /*styles:{textAlign:'right'}*/
				'.Write("{selector:'table', classes:'float-right'},")
				'.Write("{selector:'img', classes:'img-right'}")
			.Write("],")
			.Write("underline:{inline:'u'},")
			.Write("strikethrough:{inline:'del'}")
			'.Write("underline:{inline:'ins', attributes : {datetime : ""Header""}}")
		.Write("},")

		'.Write("theme_advanced_buttons1:""save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect"",")
		'.Write("theme_advanced_buttons2:""cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,link,unlink,anchor,image,media,|,insertdate,inserttime,preview,|,forecolor,backcolor"",")
		'.Write("theme_advanced_buttons3:""tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,advhr,|,print,|,ltr,rtl,|,fullscreen"",/*,pagebreak*/") 
		'.Write("theme_advanced_buttons4:""undo,redo,|,insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,|,cleanup,code"",/*,iframe,restoredraft*/")
		
		'.Write("theme_advanced_buttons1: ""save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect"",")
		'.Write("theme_advanced_buttons2: ""cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,link,unlink,anchor,image,media,|,insertdate,inserttime,preview,|,forecolor,backcolor"",")
		'.Write("theme_advanced_buttons3: ""tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,advhr,|,print,|,ltr,rtl,|,fullscreen"",")
		'.Write("theme_advanced_buttons4: ""undo,redo,|,insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,|,cleanup,code"",")
		
		.Write("theme_advanced_buttons1: ""save,pastetext,pasteword,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,link,unlink,anchor,image,media"",")
		.Write("theme_advanced_buttons2: ""search,replace,|,blockquote,|,outdent,indent,|,styleselect,formatselect,fontsizeselect"",")
		.Write("theme_advanced_buttons3: ""styleprops,forecolor,backcolor,|,sub,sup,charmap,emotions,|,removeformat,visualaid,|,advhr,|,ltr,rtl,|,fullscreen"",")
		
		.Write("theme_advanced_buttons4: ""wrapper,undo,redo,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,|,cleanup,code"",")
		.Write("theme_advanced_buttons5: ""tablecontrols"",")
		'.Write("init_instance_callback: function () { $("".mceIframeContainer iframe"").webkitimageresize().webkittableresize().webkittdresize(); },")
		'.Write("save_enablewhendirty:true,")
		.Write("save_callback:""TinyMCE_Save"",")
		.Write("save_onsavecallback:function() {$(""#form_submit"").click();},")
		'.Write("emotions_images_url:"""& GlobalConfig("sRoot") &"images/emotions/"",")
		'.Write("wpeditimage_disable_captions:false,")
		'.Write("autosave:{unload_msg:""Değişiklikleri kaydetmeden bu sayfadan ayrılırsanız yaptığınız değişiklikler kaybolacak.""},")
		.Write("theme_advanced_toolbar_location:""top"",")
		.Write("theme_advanced_toolbar_align:""left"",")
		.Write("theme_advanced_statusbar_location:""bottom"",")



		.Write("force_br_newlines:false,")
		.Write("force_p_newlines:true,")
		'.Write("autosave_ask_before_unload:false,")
		.Write("debug:false,")
		.Write("cleanup:true,")
		.Write("cleanup_on_startup:true,")
		.Write("safari_warning:false,")
		.Write("theme_advanced_resizing:true,")
		.Write("theme_advanced_resize_horizontal:false,")
		.Write("dialog_type:""modal"",")
		.Write("paste_strip_class_attributes:""all"",")
		.Write("accessibility_focus:true,")
		.Write("tabfocus_elements:""major-publishing-actions"",")
		.Write("media_strict:false,")
		.Write("paste_remove_styles:true,")
		.Write("paste_remove_spans:true,")
		.Write("relative_urls:true,") ' http://www.webtasarimx.net/ to /
		.Write("remove_script_host:true,") ' http://www.webtasarimx.net/ remove
		.Write("convert_urls:true,") ' http://www.webtasarimx.net remove
		.Write("paste_text_use_dialog:true,")
		.Write("apply_source_formatting:true,") ' alt satırdan devam etmeyi kaldır
		.Write("remove_linebreaks:false,")
		'.Write("body_class:""content post-type-page"",")
		.Write("gecko_spellcheck:true,")
		.Write("fix_list_elements:true,")
		'.Write("tinyautosave_oninit: ""configAutoSave"",")
		'.Write("file_browser_callback : ""openFileBrowser"",")
		'.Write("theme_advanced_disable:""help"",")
		'.Write("plugin_insertdate_dateFormat:"" %d-%m-%Y "",")
		'.Write("plugin_insertdate_timeFormat:"" %H:%M:%S "",")
		.Write("keep_styles:false")
		.Write("});")

		'.Write("function openFileBrowser(field,url,type,win) {")
		'.Write("	fb_win = new Array();")
		'.Write("	if (type == 'image') {")
		'.Write("			fb_win['file'] = 'http://www.webdizayni2.org/admin/index.asp?mod=img&e_name=text_TR&ewy_lang=tr&data_type=image';")
		'.Write("	}")
		'.Write("	/*if (type == 'link') {")
		'.Write("			fb_win['file'] = '/o.o.i.s?template=../plugin/object/templates/img_link_selector.t&data_type=link';")
		'.Write("	}*/")
		'.Write("	fb_win['width'] = '700';")
		'.Write("	fb_win['height'] = '650';")
		'.Write("	fb_win['close_previous'] = 'no';")
		'.Write("	tinyMCE.openWindow(fb_win, {")
		'.Write("			window : win,")
		'.Write("			input : field,")
		'.Write("			resizable : 'no',")
		'.Write("			inline : 'yes',")
		'.Write("			editor_id : tinyMCE.getWindowArg(""editor_id"")")
		'.Write("	});")
		'.Write("	return false;")
		'.Write("}")


		.Write("function TinyMCE_Save(editor_id, content, node) {")
		.Write("	base_url = tinyMCE.settings['document_base_url'];")
		.Write("	if (true == true) {")
		.Write("		content = content.replace(new RegExp(""href\s*=\s*\""?'?"" + base_url, ""gi""), ""href=\""\/"");")
		.Write("		content = content.replace(new RegExp(""src\s*=\s*\""?'?"" + base_url, ""gi""), ""src=\""\/"");")
		.Write("		content = content.replace(/href=\""\//gi,""href=\"""");")
		.Write("		content = content.replace(/src=\""\/upload\//gi,""src=\""upload\/"");")
		.Write("		content = content.replace(/mce_real_src\s*=\s*""?/gi, """");")
		.Write("		content = content.replace(/mce_real_href\s*=\s*""?/gi, """");")
		.Write("		content = content.replace(/(<.*?class\s*=\s*?'?""?|<.*?style\s*=\s*?'?""?)([^""]*)('?""?[^>]*>&nbsp;<\/p>)/gi, '<p>&nbsp;</p>');")
		.Write("		content = content.replace(/(<pre.*?>.*?<br.*?\/>.*?<\/pre>)/gi, """");")
		.Write("		content = content.replace(/<span style=\""text-decoration: ?underline;\"">(.*?)<\/span>/gi,""<u>$1</u>"");")
		.Write("	}")
		.Write("	return content;")
		.Write("}")

		'.Write("	function configAutoSave() {")
		'.Write("			if (this.id == ""ed1"") {")
		'.Write("				this.onPreSave = ""ed1PreSave"";  /* Assigned with string*/")
		'.Write("			}")
		'.Write("			else if (this.id == ""ed2"") {")
		'.Write("				this.onPostSave = function () {  /* Assigned with function*/")
		'.Write("					alert(""onPostSave occurred in Editor 2."");")
		'.Write("				};")
		'.Write("			}")
		'.Write("		}")
		'.Write("	")

	'	.Write("	function ed1PreSave() {")
	'	.Write("		return confirm(""onPreSave occurred in Editor 1. Do you want to continue with the autosave?"");")
		'.Write("	}")

		'.Write("	function randomChars() {")
		'.Write("		var c = 'a'.charCodeAt(0);")
		'.Write("		for (var x=1; x<3; x++) {")
		'.Write("			var h = [];")
		'.Write("			for (var y=0; y<100; y++) {")
		'.Write("				h[y] = """";")
		'.Write("				for (var z=0, l=Math.ceil(Math.random()*9); z<l; z++) {")
		'.Write("					h[y] += String.fromCharCode(c + Math.floor(Math.random()*26));")
		'.Write("				}")
		'.Write("				tinyMCE.get('ed' + x).setContent(h.join("" ""));")
		'.Write("			}")
		'.Write("		}")
		'.Write("	}")

		.Write(vbCrLf & "/* ]]> */")
		.Write(vbCrLf & "</script>" & vbCrLf)
	End With
End Sub
%>



