<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<%=GlobalConfig("locale_lang")%>" lang="<%=GlobalConfig("locale_lang")%>">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="author" content="<%=xAuthor%>" />
		<meta name="reply-to" content="<%=xReply%>" />
		<meta name="generator" content="<%=xGenerator%>" />
		<meta name="identifier-URL" content="<%=GlobalConfig("sDomain")%>" />
		<meta name="robots" content="noindex, nofollow, noarchive" />
		<title><%=Server.HtmlEncode(Lang("anket_popup_title"))%></title>
		<link href="<%=GlobalConfig("sBase")%>favicon.ico" rel="shortcut icon" type="image/x-icon" title="<%=Server.HtmlEncode(Lang("default_site_ismi"))%>" />
		<style type="text/css">
		<!--
			body {margin: 5px;padding: 0;font-family: Arial, Tahoma;font-size: 12px;background:#fff}
			span.error {width:100%;margin: 0 0 10px;font-size: 14px;font-weight: 700;color: red}
			.anket-tablo {width:100%;margin: 0 0 10px;font-size: 12px}
			.anket-tablo h2.title {margin: 0; padding: 8px 5px;font-size: 18px;border-bottom: 1px solid #ccc;border-right: 1px solid #ccc; background-color: #eee}
			.anket-tablo h3.title {margin: 20px 0 0; padding: 0;font: bold italic 13px/16px Georgia;}
			.anket-tablo .close {float:right;margin:4px 3px 0 3px;padding:0 2px 0 2px}
			.anket-tablo .close a {;font-size: 11px;color: #444;font-weight: bold;text-decoration: none}
			.anket-tablo .close a:hover {color: #000}
			.anket-tablo .oylama {position:relative;background:#daf7ff url(<%=GlobalConfig("sBase")%>images/images/anket.png) repeat-x;border-radius: 3px !important;-moz-border-radius: 3px !important;-webkit-border-radius: 3px !important;-khtml-border-radius:3px !important;height: 30px;margin: 10px 0 3px;border:solid 1px #b3b3b3;}
			.anket-tablo .oylama .sonuc{float:left;height: 30px;text-align:left;background-image:url(<%=GlobalConfig("sBase")%>images/images/anket.png); background-repeat: repeat-x}
			.anket-tablo .oylama .sonuc span{padding-left:10px}
			.anket-tablo .y{padding-top:3px;padding-left:10px;color:#111;font-weight:bold;}
			.anket-tablo .secenek {font: normal italic 14px/16px;position:absolute;left:10px;padding:7px 0 0px 0}
		//-->
		</style>
	</head>
	<body><%

If GlobalConfig("request_sayfaid") = 0 Then
	'Response.Write("<span class=""error"">" & Lang("anket_hatali_url") & "</span>")
	'ErrMsg Lang("anket_hatali_url")
	ErrMsg Lang("anket_yok")
	'Response.Status = "404 Not Found"

ElseIf GlobalConfig("request_sayfaid") > 0 Then
%>
		<div class="anket-tablo">
			<h2 class="title"><div class="close"><a href="javascript:window.close();" title="<%=Server.HtmlEncode(Lang("anket_pencereyi_kapat"))%>"><%=Server.HtmlEncode(Lang("anket_pencereyi_kapat"))%></a></div><%=Server.HtmlEncode(Lang("anket_popup_title"))%></h2>
<%
Set objRs = setExecute("SELECT id, title FROM #___anket WHERE durum = 1 And id = "& GlobalConfig("request_sayfaid") &" ORDER BY sira ASC;")
	If objRs.Eof Then
		Response.Write("			<h3 class=""title"" style=""color:red"">&ldquo; " & Lang("anket_yok") & " &rdquo;</h3>" & vbcrlf) 

	Else

		Response.Write("			<h3 class=""title"">&ldquo; " & BasHarfBuyuk(objRs("title")) & " &rdquo;</h3>" & vbcrlf) 

			intTotalOy = Cdbl(sqlQuery("SELECT Sum(oy) FROM #___anket_secenek WHERE anketid = "& objRs("id") &";", 1))
			'If intTotalOy = 0 Then intTotalOy = 1

			Set objRs2 = setExecute("SELECT secenek, oy FROM #___anket_secenek WHERE anketid = "& objRs("id") &";") 'ORDER BY oy DESC, secenek ASC
				Do While Not objRs2.Eof

					intOy = intYap(objRs2("oy"), 1) : If intOy = 0 Then intOy = 1
					intSecenekOy = ((intOy / intTotalOy) * 100)
					SecenekOyTitle = Lang("anket_mesaj")
					SecenekOyTitle = Replace(SecenekOyTitle, "[Title]", "<strong>" & objRs2("secenek") & "</strong>")
					SecenekOyTitle = Replace(SecenekOyTitle, "[Count]", intOy)
					SecenekOyTitle = Replace(SecenekOyTitle, "[Yuzde]", FormatNumber(intSecenekOy, 1))

					'intSecenekOy = int(intSecenekOy)


Response.Write("			<div class=""oylama"">" & vbcrlf) 
Response.Write("				<div class=""secenek"">"& (SecenekOyTitle) &"</div>" & vbcrlf) 
Response.Write("				<div class=""sonuc"" style=""width:"& int(intSecenekOy) &"%; background-color:#"& Reklendir(intSecenekOy) &"""></div>" & vbcrlf) 
Response.Write("			</div>" & vbcrlf) 

				objRs2.MoveNext() : Loop
			Set objRs2 = Nothing

	End If
Set objRs = Nothing

Response.Write("			<div>" & vbcrlf) 
Response.Write("				<div class=""secenek""><strong>" & Replace(Lang("anket_toplam_oy_kullanan"), "[Count]", intTotalOy) & "</strong></div>" & vbcrlf) 
Response.Write("			</div>" & vbcrlf) 

Response.Write("		</div>") 
End If
%>
	</body>
</html>
