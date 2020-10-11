<%
'input = UCase(GlobalConfig("site_lang"))
'If input = "AR" Then LangDir = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
'If input = "AR" Then ClassDir = " style=""direction:rtl !important"""

CookieLang = Request.Cookies("locale_lang")
'Response.Cookies("locale_lang").Expires = Now()-1
'Response.Cookies("locale_lang").Path = "/admin/"

If CookieLang = "" Then CookieLang = GlobalConfig("site_lang")

%><!--#include file="header.asp"-->
<base href="<%=GlobalConfig("sRoot")%>" />
<link href="<%=GlobalConfig("sRoot")%>css/editor.css" rel="stylesheet" type="text/css" />
<link href="<%=GlobalConfig("sRoot")%>css/common.css" rel="stylesheet" type="text/css" />
<style type="text/css"><!--body {padding: 5px; background: #fff;} <%If CookieLang = "AR" Then%>*{direction: rtl;}<%End If%> --></style>
</head>
<body>
	<script type="text/javascript">
	//<![CDATA[
		window.parent.TinymceTriggerSave();
		var title = window.parent.document.getElementById('title_<%=CookieLang%>').value,
		    title_status = eval(window.parent.document.getElementById('title_status').value),
		    text = window.parent.document.getElementById('text_<%=CookieLang%>').value; 
		text = text.replace('<hr id="readmore" />', '');
		if (title_status == 0) {title = '';}
	//]]>
	</script>

	<h1 class="title">
		<script type="text/javascript">document.write(title);</script>
	</h1>
	<div class="clearfix">
		<script type="text/javascript">document.write(text);</script>
	</div>
</body>
</html>
