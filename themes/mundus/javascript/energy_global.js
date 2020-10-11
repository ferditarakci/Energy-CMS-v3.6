
/*
$(document).ready(function() {
	$("#meta").html($("meta[name=keywords]").attr("content"));
});

*/



$(document).ready(function() {
	$("body").removeClass("no-js");

	$("#respond").addClass("js");
	$("#respond").find("input[type=text], textarea").attr("placeholder", "");

	$("#respond.js").find("input[type=text], textarea")
	.live("focusin", function() {
		$("#respond label\[for=" + $(this).attr("id") + "\]").fadeTo(350, 0, function() {
			$(this).parent().find("div").addClass("active");
			$(this).css("display", "none");
        });
	})
	.live("focusout", function() {
		if($(this).val() == "") {
			$("#respond label\[for=" + $(this).attr("id") + "\]").fadeTo(350, 1, function() {
				$(this).parent().find("div").removeClass("active");
				$(this).css({"display":"", "opacity":""});
			});
		}
	});


/*
	$("#respond.js").find("input[type=text], textarea")
	.live("focusin", function() {
		$("#respond label\[for=" + $(this).attr("id") + "\]").fadeTo(350, 0, function() {
			//$(this).parents("li").addClass("active");
			$(this).css("display", "none");
        });
	})
	.live("focusout", function() {
		if($(this).val() == "") {
			$("#respond label\[for=" + $(this).attr("id") + "\]").fadeTo(350, 1, function() {
				//$(this).parents("li").removeClass("active");
				$(this).css({"display":"", "opacity":""});
			});
		}
	});

*/

	$("#cancel-comment-reply-link").live("click", function(e){
		e.preventDefault();
		var $id = $(this).attr("id").replace(/comment\-reply\-link\-/g, "");
		//$("#comment-" + $id).find("ol").append("")
		//alert($(this).parents("li.depth-0").attr("id"))
		//$("#comment-" + $id).append( $("#comment-form") )
		$(".comment-form-container").empty();
		$("#comment-form").show();

	});

	$(".comment-reply-link").live("click", function(e){
		e.preventDefault();
		var $id = $(this).attr("id").replace(/comment\-reply\-link\-/g, "");
		//$("#respond").addClass("js");
		//alert($(this).attr("id"))
		//$("#comment-" + $id).find("ol").append("")
		//alert($(this).parents("li.depth-0").attr("id"))
		//$("#comment-" + $id).append( $("#comment-form") )
		$(".comment-form-container").empty();
		$("#comment-form-" + $id).append( $("#comment-form").html() );
		//$("#comment-form-" + $id).find("label").show().css({opacity:1});

		$("#comment-form-" + $id).find("label").show().css({opacity:1});
		$("#comment-form-" + $id).find("input[type=text]").each(function() {
			if($(this).val() != "") {
				$(this).parents(".comment-form-field").find("label").hide().css({opacity:0});
			}
		});

		$("#comment-form-" + $id).find("#comment_parentid").val($id);
		$("#comment-form").hide();
		$("#cancel-comment-reply-link").show();



	});






$("#respond form#commentform").live("submit", function(e){
	e.preventDefault();

	var $this =  $(this);
	var $div = $this.attr("id") + "Msj";

	var $parent = $(this).parents(".comment-form-container").attr("id");
	var $depth = 0;

	$.ajax({
		cache: false,
		dataType: "json",
		type: "POST",
		url: $this.attr("action"),
		data: $this.serialize().replace(/%0D%0A/g, "{ENERGYBR}"),
		beforeSend: function() {
			Messages($div, "loading", ewyLoading);
		},
		error: function() {
			Messages($div, "error", ewyError);
		},
		success: function(o) {
			if (o.htmlForm != "undefined") {
				var f = o.htmlForm[0];

				//$("input#author").val(f.author);
				//$("input#email").val(f.email);
				//$("input#url").val(f.url);
				//$("textarea#comment").text(f.comment)

				if (typeof $parent != "undefined") {
					$depth = parseInt($("#comment-list #" + $parent.replace(/form\-/g, "") ).index()) + 1;
				}

				var html = "";
				html = CommentHTML(html)
					.replace(/\{id\}/gi, f.id)
					.replace(/\{depth\}/gi, $depth)
					.replace(/\{author\}/gi, f.author)
					.replace(/\{email\}/gi, f.email)
					.replace(/\{tarih1\}/gi, f.tarih1)
					.replace(/\{tarih2\}/gi, f.tarih2)
					.replace(/\{comment\}/gi, f.comment)
					.replace(/\{(.*?)\}/gi, "")
				;

				if (typeof $parent == "undefined") {
					$("#comment-list").find("> ol").append(html);
				} else {
					$("#comment-list #" + $parent.replace(/form\-/g, "") ).find("> ol").append(html);
					$("#comment-list #" + $parent).empty();
					$("#comment-form").show();
				}
			}

			setTimeout(function() {
				Messages($div, o.divClass, o.divMsg);
			}, 1000);
		}
	});



	});

function CommentHTML(html) {
//var html = '';
html += '<li class="depth depth-{depth}" id="comment-{id}">\n';
	html += '<div class="comment clearfix" id="div-comment-{id}">\n';
		html += '<div class="avatar-holder">\n';
			html += '<img src="' + ewyThemePath + 'images/avatar_48.png" class="avatar avatar-48 grav-hashed grav-hijack" alt="Avatar" />\n';
		html += '</div>\n';
		html += '<div class="comment-author-and-date">\n';
			html += '<div class="comment-author">{author}</div>\n';
			html += '<div class="commentDate">\n';
				html += '<abbr title="{tarih1}">{tarih2}</abbr>\n';
			html += '</div>\n';
		html += '</div>\n';
		html += '<div class="commentText">\n';
			html += '<p>{comment}</p>\n';
			html += '<!--<p class="edit-comment"></p>-->\n';
			html += '<p class="reply-link"><a id="comment-reply-link-{id}" class="comment-reply-link" href="#yorumYap">Bunu Cevapla</a></p>\n';
		html += '</div>\n';
	html += '</div>\n';
	html += '<div class="clr"></div>\n';
	html += '<div class="comment-form-container" id="comment-form-{id}"></div>\n';
	html += '<ol></ol>\n';
html += '</li>\n';
return html;
}






/*
$(".referans .ewy_lnk:not(.o)").each(function() {
	$("#" + $(this).attr("id").replace("lnk_", "addlnk_")).attr("href", "//" + $(this).text()).attr("rel", "nofollow").attr("target", "_blank").removeAttr("onclick");
	//alert($(this).text())
});
*/


function fbs_click() {
	u = location.href; t = document.title; window.open('http://www.facebook.com/sharer.php?u=' + encodeURIComponent(u) + '&t=' + encodeURIComponent(t), 'sharer', 'toolbar=0,status=0,width=626,height=436');
}

function twt_click() {
    u = location.href; t = document.title; window.open('http://twitter.com/home?status=' + encodeURIComponent(u) + ' ' + encodeURIComponent(t), 'sharer', 'toolbar=0,status=0,width=800,height=600');
}





	if ($().blink) {
		$(".blink").blink({delay:600})
		.hover(function() {
			$(".blink").unblink();
		}, function() {
			$(".blink").blink({delay:600});
		});
	}

	$(".ie6 .inputbox, .ie7 .inputbox")
		.focusin(function() {
			$(this).addClass("focus")
		})
		.focusout(function() {
			$(this).removeClass("focus")
		})
	;

	// ie7 outline fix
	$(".ie a, .ie input:checkbox, .ie input:radio, .ie input:submit, .ie input:button, .ie input:reset")
	.live("focus", function() {
		if (this.blur) this.blur()
	});


	if ($().blend) { //#logo h1 > a, 
		$("#ewy-phone, .social-bookmarks > li > a").blend(500);
	}
/*
	$("#hptc, #main:not(.entry-thumb), #mainfull:not(.entry-thumb)")
	.find("a")
	.hover(function() {
		var $color = $(this).css("color");
		$(this).animate({
			opacity: 0.8,
			color: "#E91A1A"
		}, 200, function(){
			$(this).animate({
				opacity: 1,
				color: $color
			}, 200, function() {
				$(this).dequeue();
				$(this).css("color", "")
			});
		});
	});
*/


	if ($().blend) {
		//if (!($.browser.msie && $.browser.version < 8)) {
			/*
			$(".module h3.title").css({
				"border-radius" : "3px"
			});
			*/
			$(".useful_nav").find("li").blend(500);
		//}

		$("#navlist > li:not(.active):not(ul, ol)").blend(800);
	}

    if ($().superfish) {
        $("ul#navlist").superfish({
            delay: 500,
            animation: {
                opacity: "show",
                height: "show"
            },
            speed: "show",
            autoArrows: false,
            dropShadows: false
        });
	}

	$("ul#navlist ul").each(function() {
		$(this).find("> li:last").css({"border-bottom":"none"});
	});

	$("ul#navlist > li")
	.hover(function () {
		$(this).find("a.topLevel").animate({
			"color": "#fff"
			//"color": "#ffc000"
		}, {queue:false, duration:500});

	}, function () {
		$(this).find("a.topLevel").animate({
			"color": "#ababab"
		}, {queue:false, duration:500});
	});



	//$("#right_sidebar > .module:not(.hidden):last, #left_sidebar > .module:not(.hidden):last").addClass("noneBG");
	$("#right_sidebar > .module:not(.hidden):last, #left_sidebar > .module:not(.hidden):last").addClass("lastNoMargin");


	if ($().lazyload) {
		$("#main, #mainfull")
		.find("img")
		.lazyload({
			threshold : 200,
			placeholder: ewyThemePath + "images/blank.gif",
			effect: "fadeIn"
		});
	}

    if ($().nivoSlider) {
        $("#slider").nivoSlider({
            effect: "sliceUpDown",
            slices: 15,
            boxCols: 8,
            boxRows: 4,
            animSpeed: 1000,
            pauseTime: 8000,
            captionOpacity: 0.8
        });
    };

   $.fn.animateHighlight = function (highlightColor, duration) {
        var highlightBg = highlightColor || "#FFFF9C";
        var animateMs = duration || "fast"; // edit is here
        var originalBg = this.css("background-color");

        if (!originalBg || originalBg == highlightBg)
            originalBg = "#FFFFFF"; // default to white

        jQuery(this)
            .css("backgroundColor", highlightBg)
            .animate({ backgroundColor: originalBg }, animateMs, null, function () {
                jQuery(this).css("backgroundColor", originalBg); 
            });
    };

	$.fn.removeStyle = function(style) {
		var search = new RegExp(style + '[^;]+;?', 'g');
		return this.each(function() {
			$(this).attr('style', function(i, style) {
				return style.replace(search, '');
			});
		});
	};

	$("a[class^='webtasarim-portfolio'], a[class^='lightbox']").each(function() {
		$(this).attr("rel", "webtasarim-portfolio");
	});

    if ($().prettyPhoto) {
        lightbox();
    }

    function lightbox() {
        $("a[rel^='webtasarim-portfolio'], a[rel^='lightbox']").prettyPhoto({
            animation_speed: "fast",
            slideshow: 5000,
            autoplay_slideshow: false,
            opacity: 0.8,
            show_title: true,
            allow_resize: true,
            default_width: 600,
            default_height: 450,
            counter_separator_label: "/",
            theme: "pp_default",
            horizontal_padding: 20,
            hideflash: false,
            wmode: "opaque",
            autoplay: true,
            modal: false,
            deeplinking: true,
            overlay_gallery: true,
            keyboard_shortcuts: true,
            changepicturecallback: function () {},
            callback: function () {},
            ie6_fallback: true,
            social_tools: false
        });
    }

    function overlay() {
		var $portfolio = $(".entry-thumb-wrap a"); //alert($portfolio.length)
		if($portfolio.length > 0) {
			var $w = parseInt($portfolio.parent().outerWidth());
			var $h = parseInt($portfolio.parent().outerHeight());
			$portfolio.find(".overlay, .overlay .zoom-icon").css({
				"width" : ($w - 2),
				"height" : ($h - 2)/*,
				"margin-top": 2,
				"margin-left": 2*/
			});
			$portfolio.hover(function () {
				$(this).find(".overlay").stop().animate({
					opacity: 0.4
				}, 600);
			}, function (){
				$(this).find(".overlay").stop().animate({
					opacity: 0
				}, 600);
			});
		}
    }
    overlay();







	$(window).resize(function() {
		sharedFixedLink("#sharedFixed");
	}).trigger("resize");

});







function sharedFixedLink( id ) {
	var $width = $(window).width(); //alert($width)
	if($width < 1160) {
		$( id ).css({"display" : "none"});
	} else {
		$( id ).css({"display" : "block"});
	}
}




function EnergyFormSubmit( fid ) {
	var $fid =  $("#" + fid);
	var $div = fid + "Msj";
	$.ajax({
		cache: false,
		dataType: "json",
		type: "POST",
		url: $fid.attr("action"),
		data: $fid.serialize().replace(/%0D%0A/g, "{ENERGYBR}"),
		beforeSend: function() {
			Messages($div, "loading", ewyLoading);
		},
		error: function() {
			Messages($div, "error", ewyError);
		},
		success: function(o) {
			//alert(o)
			setTimeout(function() {
				Messages($div, o.divClass, o.divMsg);
			}, 1000);
		}
	});
	return false;
}





function Messages(insertiD, cssClass, insertMessage) {
	var sysMsg = $("#" + insertiD);
	sysMsg.animate({
		top: 0,
		opacity: 1
	}, 100, function() {
		$(this).slideDown(600);
	})
	.removeClass("success warning error info loading")
	.addClass("ewy_sys_msg")
	.addClass( cssClass )
	.html("<div class=\"ewy_messages\"><span>" + insertMessage + "</span></div>");
	return false;
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












$(window).load(function(){
/*
	$("#facelike_click").bind("click", function() {
		$("#facelike_click").remove();
	});
*/

	var tX = 0, tY = 0, IE = document.all ? true : false;
	if($.cookie("flike") != "true") {
		if (!IE) document.captureEvents(Event.MOUSEMOVE);

		$("html > body").append(
			$("<div />")
			.attr("id", "facelike_click")
			.css({
				"border" : "0",
				"overflow" : "hidden",
				"cursor" : "pointer",
				"width" : "35px",
				"height" : "30px",
				"margin" : "0",
				"padding" : "0",
				"position" : "absolute",
				"opacity" : "0"
			})
		);

		$("html > body > #facelike_click").append(
			$("<iframe />")
			.attr({
				"id" : "like_frame",
				"style" : "margin-left:-25px;",
				"src" : "http://www.facebook.com/plugins/like.php?href=" + encodeURIComponent( ewyFacebookPage ) + "&amp;layout=standard&amp;show_faces=true&amp;width=10&amp;action=like&amp;colorscheme=light&amp;height=10",
				"scrolling" : "no",
				"frameBorder" : "0",
				"allowTransparency" : "true"
			})
		);

		window.addEventListener("mousemove", mouseMove, false);

		setTimeout(function(){
			window.removeEventListener("mousemove", mouseMove, false);
			$("#facelike_click").remove();
		}, 8000);
	}

	function mouseMove(e) {
		if (IE) {
			tX = event.clientX + document.body.scrollLeft;
			tY = event.clientY + document.body.scrollTop;
		} else {
			tX = e.pageX;
			tY = e.pageY;
		}

		if (tX < 0) tX = 0;
		if (tY < 0) tY = 0;
		$("#facelike_click").css({
			"top" : (tY - 8) + "px",
			"left" : (tX - 10) + "px"
		});
		$.cookie("flike", "true", {expires:365, path:"/"});
		return true;
	}
});
















