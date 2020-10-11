/*
	Copyright © 2008 - 2012
	Energy Web Yazılım - İstanbul
	www.webtasarimx.net
	bilgi@webtasarimx.net
*/

$(document).ready(function() {

	$("a").bind("focus", function () {
		if (this.blur) this.blur();
	});

	$("#iframe").html('<iframe src="index.asp?mod=img&amp;task=browser" id="imageframe" name="imageframe" framespacing="0" frameborder="0"></iframe>');
});
function EnergyInsertEditor(editor_id) {
	var img_insert = "",
	url = $("#file_url").val(),
	alt = $("#file_alt").val(),
	align = $("#file_align").val(),
	title = $("#file_title").val(),
	width = $("#file_width").val(),
	height = $("#file_height").val(),
	lightbox = $("#file_lightbox").is(":checked");
	if (url != '') {
		if (alt != '') {
			alt = 'alt="'+ alt +'" ';
		} else {
			alt = 'alt="" ';
		}
		if (title != '') {
			title = 'title="'+ title +'" ';
		} else {
			title = '';
		}
		if (width != '') {
			width = 'width="'+ width +'" ';
		} else {
			width = '';
		}
		if (height != '') {
			height = 'height="'+ height +'" ';
		} else {
			height = '';
		}
		if (align != '') {
			align = 'style="float:'+ align +';" ';
		} else {
			align = '';
		}
		if (lightbox === true) {
			img_insert = img_insert + '<a class="vlightbox" href="'+ url +'" '+ title +'>';
		}
		img_insert = img_insert + '<img src="'+ url +'" '+ alt + title + width + height + align +' />';
		if (lightbox === true) {
			img_insert = img_insert + '</a>';
		}
		window.parent.jInsertEditorText(img_insert, editor_id);
		window.parent.$.colorbox.close();
	} else {
		alert("Lütfen resim seçin!");
	}
	return false;
}