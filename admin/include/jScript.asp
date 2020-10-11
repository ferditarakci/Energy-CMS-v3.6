<script runat="server" charset="utf-8" language="javascript">
	String.prototype.Trim = function() {
		return this.replace(/^\s+|\s+$/g, "");
	}

	String.prototype.lTrim = function() {
		return this.replace(/^\s+/, "");
	}

	String.prototype.rTrim = function() {
		return this.replace(/\s+$/, "");
	}

	function TrimFix(s) {
		s = s + ""; s = String(s);
		if(s == "undefined" || s == "null") return;
		//s = s.replace(/([\s]{2,})/g, " ");
		s = s.replace(/([ ]{2,})/g, " ");
		s = s.Trim();
		return s;
	}

	function fnPre(s, p) {
		s = s + ""; s = String(s);
		if(s == "undefined" || s == "null") return;
		/*
		var sdomain = Request.ServerVariables("SERVER_NAME");
		sdomain = String(sdomain).replace(/www\./g, "");

		if (!(sdomain == "webtasarimx.net" || sdomain == "webtasarimx.net")) {
			s = s.replace("webtasarımx.net", "webdizaynı.org")
			s = s.replace("webtasarimx.net", "webdizayni.org")
			s = s.replace("Webtasarımx.net", "Webdizaynı.org")
			s = s.replace("Webtasarimx.net", "Webdizayni.org")
			s = s.replace("webtasarımx", "webdizaynı")
			s = s.replace("webtasarimx", "webdizayni")
		}
		*/

		return s
			.replace(/(<img.*?src='?"?|<a.*?href='?"?)([^'"]*)('?"?[^>]*>)/gi,
				function(m, a, b, c) {
					return (/^(ht|f)tps?:\/\/|(^\/\/)/gi.test(b)) || (/(^mailto:)/gi.test(b)) ? a + b + c : a + (p + b).replace(/\/?#ewy_home|\/?undefined\/?/gi, "/").replace(/\/{2,}/gi, "/").replace(/:\//gi, "://") + c;
				}
			)
		;
	}

	function DuzenleHTML(s) {
		s = s + ""; s = String(s);
		if(s == "undefined" || s == "null") return; // Null String Exit Function
		return s
			.replace(/&lt;/ig, "<")
			.replace(/&gt;/ig, ">")
			.replace(/&quot;/ig, "\"")
		;
	}

	function Duzenle(s) {
		s = s + ""; s = String(s);
		//return String.fromCharCode(72, 69, 76, 76, 79);
		if(s == "undefined" || s == "null") return; // Null String Exit Function

		return s
		.replace(/(&|&amp;)#(\d+);/ig, function(s, a, b) {
			return String.fromCharCode(b);
		})
			.replace(/\\'|&apos;|&#0?39;/ig, "'")
			.replace(/\\"|&quot;|&#0?34;/ig, "\"")
			.replace(/&gt;|&amp;gt;/ig, ">")
			.replace(/&lt;|&amp;lt;/ig, "<")
			.replace(/&amp;amp;|&amp;/ig, "&")
		;
		//return str;
	}

	function URLEncode(s) {
		s = s + ""; s = String(s);
		if(s == "undefined" || s == "null") return;
		s = URLDecode(s);
		s = s.replace(/\s/gi, "+")

		return encodeURIComponent(s)
		//return encodeURI(s)
			//.replace(/%25/gi, "%")
			.replace(/%2F/gi, "/")
			.replace(/%3F/gi, "?")
			.replace(/%3D/gi, "=")
			.replace(/'/gi, "%27")
			.replace(/%3A/gi, ":")
			.replace(/%3B/gi, ";")
			.replace(/%23/gi, "#")
			.replace(/%2B/gi, "+")
			.replace(/%26/gi, "&")
			.replace(/&amp%3B/gi, "&amp;")
			.replace(/%5Bbase%5D/gi, "[base]")
			.replace(/%5Broot%5D/gi, "[root]")
			.toLowerCase()
		;
	}

	function URLDecode(s) {
		s = s + ""; s = String(s);
		if(s == "undefined" || s == "null") return;
		return decodeURIComponent(s); //.replace(/\+/gi, " ");
		//return decodeURI(s.replace(/\+/gi, " "));
	}

	function sortVBArray(arr, srt){
		js_arr = new VBArray(arr).toArray();
		js_arr.sort(function(a, b){
		
			if (srt == "asc")
				return a - b
			else
				return b - a
		});
		return js_arr;
	}
</script>

<%
'Response.clear
'Dim r_VBArray, sayi
'	r_VBArray = Array(9138, 20, 30, 10, 40, 155)
'	
'Response.Write sortVBArray(r_VBArray, "desc") ' virgülle ayrılmış direk JS çıktısı
'Response.Write "<hr />"
'For Each sayi In sortVBArray(r_VBArray, "asc") ' dönerek
'	Response.Write sayi & "<br />"
'Next
'Response.end
%>

