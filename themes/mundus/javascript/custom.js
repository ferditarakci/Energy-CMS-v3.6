jQuery(document).ready(function ($)
{
    if ($().polyglotLanguageSwitcher) {
        $(this).polyglotLanguageSwitcher({
            effect: "fade",
            paramSeparator: "#"
        });
    }
    if ($().superfish) {
        $("ul#navlist").superfish({
            delay: 200,
            animation: {
                opacity: "show",
                height: "show"
            },
            speed: "fast",
            autoArrows: false,
            dropShadows: false
        });
    }
    if ($().nivoSlider) {
        $("#slider").nivoSlider({
            effect: "sliceUpDown",
            slices: 15,
            boxCols: 8,
            boxRows: 4,
            animSpeed: 1000,
            pauseTime: 3000,
            captionOpacity: 1
        });
    }
    if ($().carouFredSel) {
        $("#testimonials").carouFredSel({
            circular: true,
            infinite: true,
            direction: "up",
            width: "100%",
            height: "variable",
            align: "left",
            items: 1,
            scroll: {
                items: 1,
                duration: 800,
                pauseOnHover: true
            },
            auto: {
                play: true
            },
            prev: "#testimonial-prev",
            next: "#testimonial-next"
        });
        $("#project-details").carouFredSel({
            circular: true,
            infinite: true,
            direction: "",
            width: "100%",
            height: "variable",
            align: "left",
            items: 1,
            scroll: {
                items: 1,
                fx: "fade",
                duration: 200,
                pauseOnHover: true
            },
            auto: {
                play: false
            },
            prev: "#project-detail-prev",
            next: "#project-detail-next"
        });
    }
    function lightbox() {
        $("a[rel^='prettyPhoto']").prettyPhoto({
            animation_speed: "fast",
            slideshow: 5000,
            autoplay_slideshow: false,
            opacity: 0.8,
            show_title: true,
            allow_resize: true,
            default_width: 500,
            default_height: 344,
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
    if ($().prettyPhoto) {
        lightbox();
    }
    function overlay() {
        $(".entry-thumb a").hover(function () {
            $(this).find(".overlay").stop().animate({
                opacity: 0.5
            }, 300);
        }, function (){
            $(this).find(".overlay").stop().animate(
            {
                opacity: 0
            }, 300);
        });
    }
    overlay();
    if ($().quicksand) {
        var $filterType = $("#filter li.active a").attr("class");
        var $holder = $("ul#gallery");
        var $data = $holder.clone();
        var $preferences = {
            duration: 500,
            easing: "easeInQuad"
        };
        $("#filter li a").click(function (e) {
            $("#filter li").removeClass("active");
            var $filterType = $(this).attr("class");
            $(this).parent().addClass("active");
            if ($filterType == "all") {
                var $filteredData = $data.find("li");
            } else {
                var $filteredData = $data.find("li[data-type~=" + $filterType + "]");
            }
            $holder.quicksand($filteredData, $preferences, function () {
                lightbox();
                overlay();
            });
        });
    }
    $(".notification-close-info").click(function () {
        $(".notification-box-info").fadeOut("slow");
        return false;
    });
    $(".notification-close-success").click(function () {
        $(".notification-box-success").fadeOut("slow");
        return false;
    });
    $(".notification-close-warning").click(function () {
        $(".notification-box-warning").fadeOut("slow");
        return false;
    });
    $(".notification-close-error").click(function () {
        $(".notification-box-error").fadeOut("slow");
        return false;
    });
    if ($().tabs) {
        $(".tabs").tabs({
            fx: {
                opacity: "show"
            }
        });
    }
    if ($().toggle) {
        $(".toggle").each(function () {
            if ($(this).attr("data-id") == "open") {
                $(this).accordion({
                    header: "h4",
                    collapsible: true
                });
            } else {
                $(this).accordion({
                    header: "h4",
                    collapsible: true,
                    active: false
                });
            }
        });
    }
    if ($().accordion) {
        $(".accordion").accordion({
            header: "h4",
            collapsible: true,
            active: false,
            clearStyle: true
        });
    }
    if ($().jPlayer)
    {
        $("#jquery_jplayer_1").jPlayer({
            ready: function () {
                $(this).jPlayer("setMedia", {
                    m4v: "http://www.jplayer.org/video/m4v/Big_Buck_Bunny_Trailer_480x270_h264aac.m4v",
                    ogv: "http://www.jplayer.org/video/ogv/Big_Buck_Bunny_Trailer_480x270.ogv",
                    poster: "http://www.jplayer.org/video/poster/Big_Buck_Bunny_Trailer_480x270.png"
                });
            },
            swfPath: "/js",
            supplied: "m4v, ogv"
        });
    }
    if ($().validate) {
        $("#contact-form, #comment-form").validate();
    }
    if (typeof google.maps.LatLng !== "undefined") {
        $(".map-canvas").each(function () {
            var $canvas = $(this);
            var dataZoom = $canvas.attr("data-zoom") ? parseInt($canvas.attr("data-zoom")) : 8;
            var latlng = $canvas.attr("data-lat") ? new google.maps.LatLng($canvas.attr("data-lat"), $canvas.attr("data-lng")) : new google.maps.LatLng(51.5001524, -0.1262362);
            var myOptions = {
                zoom: dataZoom,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: latlng
            };
            var map = new google.maps.Map(this, myOptions);
            if ($canvas.attr("data-address")) {
                var geocoder = new google.maps.Geocoder;
                geocoder.geocode({
                    address: $canvas.attr("data-address")
                }, function (results, status){
                    if (status == google.maps.GeocoderStatus.OK) {
                        map.setCenter(results[0].geometry.location);
                        var marker = new google.maps.Marker({
                            map: map,
                            position: results[0].geometry.location,
                            title: $canvas.attr("data-mapTitle")
                        });
                    }
                });
            }
        });
    }
});