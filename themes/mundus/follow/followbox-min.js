(function (a) {
    a.fn.followbox = function (b) {
        function f(a, b) {
            if (a > 100) a = 100;
            var c = new Array;
            for (var d = 0; d < a; d++) {
                c.push(b[d])
            }
            var e = c.join();
            return e
        }
        var c = a(this);
        var d = ewyThemePath + "follow/icon_twitter.png";
        var e = a.extend({
            user: "energycms",
            lang: "tr",
            width: 342,
            height: 255,
            theme: "light",
            border_color: "#fff",
            bg_color: "#fff",
            bg_image: "",
            title_color: "#3B5998",
            total_count_color: "#333",
            follower_name_color: "#BBB"
        }, b);
        a.ajax({
            url: "https://api.twitter.com/1/users/lookup.json?screen_name=" + e.user + "&include_entities=true&lang="+ e.lang,
            dataType: "jsonp",
            success: function (b) {
                var g = e.width - 2;
                var h = e.height - 2;
                var i = e.height - 115;
                var j = parseInt(e.width / 55);
                var k = parseInt(i / 69) + 1;
                var l = j * k;
                c.html('<div class="follow_box_main" style="overflow:hidden; border:0; width: ' + g + "px; height: " + h + 'px;"><div class="follow_box_widget"><div class="follow_box"><div><div class="follow_top clearfix"><a href="http://www.twitter.com/' + e.user + '" target="_blank"><img class="profileimage img" src="' + b[0].profile_image_url_https + '" alt="' + b[0].name + '"></a><div class="follow_action"><div class="name_block"><a href="http://www.twitter.com/' + e.user + '" target="_blank"><span class="name titlecase">' + b[0].name.toLowerCase() + "</span> @" + b[0].screen_name + '</a></div><div class="follow_button"><iframe allowtransparency="true" frameborder="0" scrolling="no" src="//platform.twitter.com/widgets/follow_button.html?screen_name=' + e.user + '&show_count=false&show_screen_name=false&lang='+ e.lang +'" style="width:100px; height:20px;"></iframe></div></div></div><div class="connections"><span class="total"><b class="titlecase">' + b[0].name.toLowerCase() + '</b>&#39;&#305; <span class="follow_box_follower_count">' + b[0].followers_count + '</span> ki&#351;i takip ediyor.</span><div class="connections_grid clearfix" style="height:' + i + 'px;"></div></div></div></div></div></div>'); /*
				<div style="height: 23px"><div class="follow_widget_footer"><div class="footer_border"><div class="clearfix uiImageBlock"><a class="footer_logo" target="_blank" href="http://www.bloggermodifiye.com/search/label/twitter%20eklentileri?max-results=8"><img src="' + d + '"/></a><div class="footer_text"><a class="footer_text_link" target="_blank" href="http://www.bloggermodifiye.com/search/label/twitter%20eklentileri?max-results=8">Twitter Social Plugin</a></div></div></div></div></div>
				*/
                if (e.theme == "dark") {
                    c.find(".follow_box_main").addClass("dark")
                }
                c.find(".follow_box_follower_count").text(c.find(".follow_box_follower_count").text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                if (a.browser.msie && !a.support.boxModel) a(".follow_box .connections").css("padding-bottom", "14px");
                if (e.theme == "custom") {
                    c.find(".follow_box_main").css({
                        "border-color": e.border_color,
                        "background-color": e.bg_color,
                        "background-image": "url(" + e.bg_image + ")"
                    });
                    c.find(".follow_box a").css({
                        color: e.title_color
                    });
                    c.find(".follow_box .total").css({
                        color: e.total_count_color
                    })
                }
                a.ajax({
                    url: "https://api.twitter.com/1/followers/ids.json?cursor=-1&screen_name=" + e.user + "&lang="+ e.lang,
                    dataType: "jsonp",
                    success: function (b) {
                        var d = f(l, b.ids);
                        a.ajax({
                            url: "https://api.twitter.com/1/users/lookup.json?user_id=" + d + "&include_entities=true",
                            dataType: "jsonp",
                            success: function (b) {
                                for (var d = 0; d < b.length; d++) {
                                    var f = a.trim(b[d].name);
                                    var g = f.split(" ");
                                    var h = '<div class="grid_item"><a href="http://www.twitter.com/' + b[d].screen_name + '" target="_blank"><img class="img" src="' + b[d].profile_image_url + '" alt=""><div class="name titlecase">' + g[0].toLowerCase() + "</div></a></div>";
                                    c.find(".connections_grid").append(h)
                                }
                                if (e.theme == "custom") {
                                    c.find(".connections .connections_grid .grid_item .name").css({
                                        color: e.follower_name_color
                                    })
                                }
                            }
                        })
                    }
                })
            }
        })
    }
})(jQuery)