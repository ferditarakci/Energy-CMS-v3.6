<%
	If task = "" Then
%>
<!--#include file="../header.asp"-->
<style type="text/css">
	/*html { overflow:auto !important; }*/
	.boxs {float:left; margin-right:16px; margin-bottom:15px; padding:10px 12px; line-height:1; border:1px solid #DFDFDF; background-color:whiteSmoke; -moz-border-radius:5px; -webkit-border-radius:5px; -ms-border-radius:5px; -o-border-radius:5px; border-radius:5px;}
	.boxs.last {margin-right:0px;}
	.boxs h3 {display:block; margin:3px 0 5px 0px; font-size:13px;}
	.boxs h4 {display:block; margin:8px 0 1px 0px; padding-top:5px; font-size:11px;}
	.boxs label {float:left; display:block; margin:3px 10px 8px 0px; line-height:1.5em}
	.boxs .a {margin-right:0;}
	ol.text {margin:0; padding:10px 10px 10px 20px; border:1px solid #DFDFDF; background-color:whiteSmoke; -moz-border-radius:5px; -webkit-border-radius:5px; -ms-border-radius:5px; -o-border-radius:5px; border-radius:5px;}
	ol.text li {margin:0; margin-left:10px; padding:0px 0 0px 0px; font-size:12px;}



	.ie7 .image_files li {float:left; display:block; zoom:1;}
	.image_files {border:none; background:none;}
	.image_files li {width:auto !important; height:auto !important; max-width:320px !important; max-height:300px !important; cursor:default;}
	.image_files li .img img {width:auto !important; height:auto !important; max-width:315px !important; max-height:295px !important;}
</style>
</head>
<body style="min-width:790px;" class="clearfix">
<%
Set objRs = setExecute("SELECT * FROM #___settings WHERE opt_status = 1 And parent = "& GlobalConfig("General_BannerPN") &";")
	If Not objRs.Eof Then
		If GlobalConfig("general_admin") Then
			GlobalConfig("MaxPicture") = intYap(objRs("MaxPicture"), 0)
			GlobalConfig("MaxPictureSize") = intYap(objRs("MaxPictureSize"), 0)
			GlobalConfig("MaxPictureTotalSize") = intYap(objRs("MaxPictureTotalSize"), 0)

			GlobalConfig("MaxFile") = intYap(objRs("MaxFile"), 0)
			GlobalConfig("MaxFileSize") = intYap(objRs("MaxFileSize"), 0)
			GlobalConfig("MaxFileTotalSize") = intYap(objRs("MaxFileTotalSize"), 0)
		End If

		GlobalConfig("SmallSizeW") = intYap(objRs("SmallSizeW"), 120)
		GlobalConfig("SmallSizeH") = intYap(objRs("SmallSizeH"), 100)

		GlobalConfig("MediumSizeW") = intYap(objRs("MediumSizeW"), 250)
		GlobalConfig("MediumSizeH") = intYap(objRs("MediumSizeH"), 200)

		GlobalConfig("LargeSizeW") = intYap(objRs("LargeSizeW"), 600)
		GlobalConfig("LargeSizeH") = intYap(objRs("LargeSizeH"), 450)

		GlobalConfig("SmallTextStatus") = intYap(objRs("SmallTextStatus"), 0)
		GlobalConfig("MediumTextStatus") = intYap(objRs("MediumTextStatus"), 0)
		GlobalConfig("LargeTextStatus") = intYap(objRs("LargeTextStatus"), 0)

		GlobalConfig("SmallLogoStatus") = intYap(objRs("SmallLogoStatus"), 0)
		GlobalConfig("MediumLogoStatus") = intYap(objRs("MediumLogoStatus"), 0)
		GlobalConfig("LargeLogoStatus") = intYap(objRs("LargeLogoStatus"), 0)

		GlobalConfig("LogoWrite") = "" ' "<img src=""" & bFolder & "/" & objRs("LogoWrite") & """ />"

		If objRs("LogoWrite") <> "" Then
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "<li id=""image-id_null"" class=""success"">" & vbCrLf
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "	<div class=""icons tooltip"">" & vbCrLf
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "		<span class=""deleteFile"" title=""Resmi Kalıcı Olarak Sil""><em>&nbsp;</em></span>" & vbCrLf
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "	</div>" & vbCrLf
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "	<div class=""img"">" & vbCrLf
			'GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "		<a rel=""img-show"" href=""/upload/sayfa/logo2-20120623-084515.png"" title="""">" & vbCrLf
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "<img src=""" & bFolder & "/" & objRs("LogoWrite") & """ />"
			'GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "		</a>" & vbCrLf
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "	</div>" & vbCrLf
			GlobalConfig("LogoWrite") = GlobalConfig("LogoWrite") & "</li>" & vbCrLf
		End If
	End If
Set objRs = Nothing
'd.Add "SmallSizeW", 100
'Response.Write d.Exists("SmallSizeW")
%>

<form id="submitForm" action="?mod=<%=mods%>&amp;task=save<%=Debug%>" method="post">

<div style="margin-right:0;" class="maincolumn">
	<div style="margin-right:0;" class="maincolumn-body">
		<div class="m_box">
			<div class="title">
				<span class="refresh"><a href="#" onclick="window.location.reload(); return false;" title="Yenile">Yenile</a></span>
				<span class="save1"><a id="SubmitSave" href="#" title="Yenile">Yenile</a></span>
				<h3 style="font-size:11px;" class="box-title">Görsel Ayarları</h3>
			</div>
			<div class="head clearfix">
				<div class="form-table clearfix">

<div class="clearfix" style="width:770px; padding:10px;">
	<div class="boxs" style="height:230px;">
		<h3><b>Resim Boyutları</b> <a class="tooltip" tabindex="-1" href="#" title="Aşağıda listelenen boyutlarda piksel cinsinden maksimum boyutları belirtin.">&nbsp;</a></h3>
		<h4><b>Küçük Boy</b></h4>
		<label>Width: <input name="SmallSizeW" class="inputbox" value="<%=GlobalConfig("SmallSizeW")%>" style="width:65px;" maxlength="4" type="number" step="1" min="0" max="2000" />&nbsp;px</label><label class="a">Height: <input name="SmallSizeH" class="inputbox" value="<%=GlobalConfig("SmallSizeH")%>" style="width:65px;" maxlength="4" type="number" step="1" min="0" max="2000" />&nbsp;px</label>
		<h4><b>Orta Boy</b></h4>
		<label>Width: <input name="MediumSizeW" class="inputbox" value="<%=GlobalConfig("MediumSizeW")%>" style="width:65px;" maxlength="4" type="number" step="1" min="0" max="2000" />&nbsp;px</label><label class="a">Height: <input name="MediumSizeH" class="inputbox" value="<%=GlobalConfig("MediumSizeH")%>" style="width:65px;" maxlength="4" type="number" step="1" min="0" max="2000" />&nbsp;px</label>
		<h4><b>Büyük Boy</b></h4>
		<label>Width: <input name="LargeSizeW" class="inputbox" value="<%=GlobalConfig("LargeSizeW")%>" style="width:65px;" maxlength="4" type="number" step="1" min="0" max="2000" />&nbsp;px</label><label class="a">Height: <input name="LargeSizeH" class="inputbox" value="<%=GlobalConfig("LargeSizeH")%>" style="width:65px;" maxlength="4" type="number" step="1" min="0" max="2000" />&nbsp;px</label>
		<div class="clr" style="padding:3px 0;"></div>
	</div>

	<div class="boxs" style="height:230px;">
		<h3><b>Resimlere Yazı Baskısı</b> <a class="tooltip" tabindex="-1" href="#" title="Aşağıda listelenen boyutlarda resim üstüne yazı baskısı yapılma durumunu seçin.">&nbsp;</a></h3>
		<h4><b>Küçük Boy</b></h4>
		<label class="a"><span style="float:left; width:60px; margin-top:5px;">Yazı Baskı</span>
		<select name="SmallTextStatus" style="width:145px;">
			<option value="1"<%=eSelected(GlobalConfig("SmallTextStatus") = 1)%>>Evet Baskı Yapılsın</option>
			<option value="0"<%=eSelected(GlobalConfig("SmallTextStatus") = 0)%>>Hayır Baskı Yapılmasın</option>
		</select>
		</label>
		<h4><b>Orta Boy</b></h4>
		<label class="a"><span style="float:left; width:60px; margin-top:5px;">Yazı Baskı</span>
		<select name="MediumTextStatus" style="width:145px;">
			<option value="1"<%=eSelected(GlobalConfig("MediumTextStatus") = 1)%>>Evet Baskı Yapılsın</option>
			<option value="0"<%=eSelected(GlobalConfig("MediumTextStatus") = 0)%>>Hayır Baskı Yapılmasın</option>
		</select>
		</label>
		<h4><b>Büyük Boy</b></h4>
		<label class="a"><span style="float:left; width:60px; margin-top:5px;">Yazı Baskı</span>
		<select name="LargeTextStatus" style="width:145px;">
			<option value="1"<%=eSelected(GlobalConfig("LargeTextStatus") = 1)%>>Evet Baskı Yapılsın</option>
			<option value="0"<%=eSelected(GlobalConfig("LargeTextStatus") = 0)%>>Hayır Baskı Yapılmasın</option>
		</select>
		</label>
		<div class="clr"></div><!--
		<div id="upload" class="smallicon"><span>.TTF Font Seç</span></div>
		<a style="float:right; margin-top:7px;" class="tooltip" tabindex="-1" href="#" title="Yanda ki ikona tıklayarak resim üstüne baskı yaplacak olan <br />yazı için kullanılacak .ttf formatındaki font dosyasını yükleyin.">&nbsp;</a>
		-->
	</div>

	<div class="boxs last" style="height:230px;">
		<h3><b>Resimlere Logo Baskısı</b> <a class="tooltip" tabindex="-1" href="#" title="Aşağıda listelenen boyutlarda resim üstüne logo baskısı yapılma durumunu seçin.">&nbsp;</a></h3>
		<h4><b>Küçük Boy</b></h4>
		<label class="a"><span style="float:left; width:60px; margin-top:5px;">Logo Baskı</span>
		<select name="SmallLogoStatus" style="width:145px;">
			<option value="1"<%=eSelected(GlobalConfig("SmallLogoStatus") = 1)%>>Evet Baskı Yapılsın</option>
			<option value="0"<%=eSelected(GlobalConfig("SmallLogoStatus") = 0)%>>Hayır Baskı Yapılmasın</option>
		</select>
		</label>
		<h4><b>Orta Boy</b></h4>
		<label class="a"><span style="float:left; width:60px; margin-top:5px;">Logo Baskı</span>
		<select name="MediumLogoStatus" style="width:145px;">
			<option value="1"<%=eSelected(GlobalConfig("MediumLogoStatus") = 1)%>>Evet Baskı Yapılsın</option>
			<option value="0"<%=eSelected(GlobalConfig("MediumLogoStatus") = 0)%>>Hayır Baskı Yapılmasın</option>
		</select>
		</label>
		<h4><b>Büyük Boy</b></h4>
		<label class="a"><span style="float:left; width:60px; margin-top:5px;">Logo Baskı</span>
		<select name="LargeLogoStatus" style="width:145px;">
			<option value="1"<%=eSelected(GlobalConfig("LargeLogoStatus") = 1)%>>Evet Baskı Yapılsın</option>
			<option value="0"<%=eSelected(GlobalConfig("LargeLogoStatus") = 0)%>>Hayır Baskı Yapılmasın</option>
		</select>
		</label>
		<div class="clr"></div>
		<div id="upload" class="smallicon"><span>Resim Seç</span></div>
		<a style="float:right; margin-top:7px;" class="tooltip" tabindex="-1" href="#" title="Yanda ki ikona tıklayarak resim üstüne baskı yaplacak olan <br />.PNG formatında ki transparan resmi yükleyin.">&nbsp;</a>
	</div>

	<div class="clr"></div>

	<div class="boxs clearfix" style="width:743px;">
		<a style="float:right; font-size:18px; font-weight:bold; text-decoration:none;" href="#" title="Göster / Gizle" onclick="$(this).parent().find('.handle').toggle('blind', 600); return false;">+</a>
		<h3><b>Upload esnasında baskı yapılacak yazı</b></h3>
		<div class="handle hidden" style="overflow:hidden;">
<%
SQL = ""
SQL = SQL & "SELECT a.title, a.lng, b.imageText" & vbCrLf
SQL = SQL & "FROM #___languages As a" & vbCrLf
SQL = SQL & "LEFT JOIN #___settings_lang As b ON a.lng = b.lang And b.parent = "& GlobalConfig("General_BannerPN") &"" & vbCrLf
SQL = SQL & "WHERE a.durum = 1 ORDER BY a.default_lng DESC, a.sira ASC;" & vbCrLf

Set objRs = setExecute(SQL)
Do While Not objRs.Eof
%>
		<label class="a" style="float:none;">
			<b><%=objRs("title")%></b> Metin<br />
			<textarea name="imageText_<%=objRs("lng")%>" class="inputbox" style="width:710px; height:50px;"><%=ReplaceEditorTag(objRs("imageText"))%></textarea>
			<input name="lang" type="hidden" value="<%=objRs("lng")%>" />
		</label>
		
<%
	objRs.MoveNext() : Loop
Set objRs = Nothing
%>
		<div class="clr"></div>
	</div>

<%
'i = i + 1
'objRs.MoveNext() : Wend
%>
		<div class="clr"></div>
	</div>


	<div class="boxs clearfix" style="width:743px;">
		<h3><b>Upload esnasında baskı yapılacak logo</b></h3>
		<div style="overflow:hidden;">
			<div id="status"></div>
			<ul class="image_files noSortable clearfix" id="files_"><%=GlobalConfig("LogoWrite")%></ul>
		</div>
	</div>

	<div class="clr"></div>

<%If GlobalConfig("general_admin") Then%>
	<div class="boxs" style="height:230px;">
		<h3><b>Resim Özellikleri</b></h3>
		<h4><b>Maksium Resim Adeti</b></h4>
		<label><input name="MaxPicture" class="inputbox" value="<%=GlobalConfig("MaxPicture")%>" style="width:180px;" maxlength="4" type="number" step="1" min="0" max="999" />&nbsp; Adet</label>
		<div class="clr"></div>
		<h4 style="margin:0px 0 1px 0px; padding-top:0px;"><b>Bir Resim İçin Maksium Boyut</b></h4>
		<label><input name="MaxPictureSize" class="inputbox" value="<%=GlobalConfig("MaxPictureSize")%>" style="width:180px;" maxlength="4" type="number" step="1" min="0" />&nbsp; Byte</label>
		<div class="clr"></div>
		<h4 style="margin:0px 0 1px 0px; padding-top:0px;"><b>Tek Seferde Yüklenebilir Maksium Resim Boyutu</b></h4>
		<label><input name="MaxPictureTotalSize" class="inputbox" value="<%=GlobalConfig("MaxPictureTotalSize")%>" style="width:180px;" maxlength="4" type="number" step="1" min="0" />&nbsp; Byte</label>
		<div class="clr"></div>
	</div>

	<div class="boxs" style="height:230px;">
		<h3><b>Dosya Özellikleri</b></h3>
		<h4><b>Maksium Dosya Adeti</b></h4>
		<label><input name="MaxFile" class="inputbox" value="<%=GlobalConfig("MaxFile")%>" style="width:180px;" maxlength="4" type="number" step="1" min="0" max="999" />&nbsp; Adet</label>
		<div class="clr"></div>
		<h4 style="margin:0px 0 1px 0px; padding-top:0px;"><b>Bir Dosya İçin Maksium Boyut</b></h4>
		<label><input name="MaxFileSize" class="inputbox" value="<%=GlobalConfig("MaxFileSize")%>" style="width:180px;" maxlength="4" type="number" step="1" min="0"/>&nbsp; Byte</label>
		<div class="clr"></div>
		<h4 style="margin:0px 0 1px 0px; padding-top:0px;"><b>Tek Seferde Yüklenebilir Maksium Dosya Boyutu</b></h4>
		<label><input name="MaxFileTotalSize" class="inputbox" value="<%=GlobalConfig("MaxFileTotalSize")%>" style="width:180px;" maxlength="4" type="number" step="1" min="0" />&nbsp; Byte</label>
		<div class="clr"></div>
	</div>
<%End If%>

	<div class="clr"></div>

</div>
				</div>
			</div>
		</div>
	</div>
</div>

<input name="parent" type="hidden" value="<%=GlobalConfig("General_BannerPN")%>" />
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
</form>
<%
'End If
'Set objRs = Nothing
%>
	</body>
</html>






<%
ElseIf task = "save" Then
	If Not blnPostMethod Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
	Response.Clear()

OpenRs objRs, "SELECT * FROM #___settings WHERE parent = "& intYap(Request.Form("parent"), 2) &";"
	If objRs.Eof Then objRs.AddNew
	If Not objRs.Eof Then
		If GlobalConfig("general_admin") Then
			objRs("MaxPicture") = intYap(Request.Form("MaxPicture"), 10)
			objRs("MaxPictureSize") = intYap(Request.Form("MaxPictureSize"), 2097152)
			objRs("MaxPictureTotalSize") = intYap(Request.Form("MaxPictureTotalSize"), 10485761)

			objRs("MaxFile") = intYap(Request.Form("MaxFile"), 10)
			objRs("MaxFileSize") = intYap(Request.Form("MaxFileSize"), 10485761)
			objRs("MaxFileTotalSize") = intYap(Request.Form("MaxFileTotalSize"), 10485761)
		End If

		objRs("opt_status") = 1
		objRs("SmallSizeW") = intYap(Request.Form("SmallSizeW"), 120)
		objRs("SmallSizeH") = intYap(Request.Form("SmallSizeH"), 100)

		objRs("MediumSizeW") = intYap(Request.Form("MediumSizeW"), 250)
		objRs("MediumSizeH") = intYap(Request.Form("MediumSizeH"), 200)

		objRs("LargeSizeW") = intYap(Request.Form("LargeSizeW"), 600)
		objRs("LargeSizeH") = intYap(Request.Form("LargeSizeH"), 450)

		objRs("SmallTextStatus") = intYap(Request.Form("SmallTextStatus"), 0)
		objRs("MediumTextStatus") = intYap(Request.Form("MediumTextStatus"), 0)
		objRs("LargeTextStatus") = intYap(Request.Form("LargeTextStatus"), 0)

		objRs("SmallLogoStatus") = intYap(Request.Form("SmallLogoStatus"), 0)
		objRs("MediumLogoStatus") = intYap(Request.Form("MediumLogoStatus"), 0)
		objRs("LargeLogoStatus") = intYap(Request.Form("LargeLogoStatus"), 0)

		'objRs("LogoWrite") = Request.Form("LogoWrite")
	objRs.Update
	End If
CloseRs objRs



	For Each item in Request.Form("lang")

		OpenRs objRs, "SELECT id FROM #___settings_lang WHERE parent = "& intYap(Request.Form("parent"), 2) &" And lang = '"& Temizle(item, 1) &"';"
			If objRs.Eof Then
				If Temizle(Request.Form("imageText_" & item), 1) <> "" Then sqlExecute("INSERT INTO #___settings_lang (imageText, lang, parent) VALUES('"& Temizle(Request.Form("imageText_" & item), 1) &"', '"& Temizle(item, 1) &"', "& intYap(Request.Form("parent"), 2) &");")
			Else
				If Temizle(Request.Form("imageText_" & item), 1) <> "" Then
					sqlExecute("UPDATE #___settings_lang Set imageText = '"& Temizle(Request.Form("imageText_" & item), 1) &"', lang = '"& Temizle(item, 1) &"' WHERE id = "& objRs("id") &";")
				Else
					sqlExecute("DELETE FROM #___settings_lang WHERE id = "& objRs("id") &";")
				End If
			End If
		CloseRs objRs
		'response.write "adsfgh"



	Next


	'If GlobalConfig("admin_yetki") Then
	'	Select Case intYap(Request.Form("val"), 0)
	'		Case 1	strText = "ilkHarfBuyuk"
	'		Case 2	strText = "BasHarfBuyuk"
	'		Case 3	strText = "UCase2"
	'		Case 4	strText = "LCase2"
	'		Case Else strText = ""
	'	End Select

	'	If Request.Form("name") = "ustCase" Then
	'		sqlExecute("UPDATE #___content_menu_type Set strCaseUst = '"& strText &"' WHERE id = "& id &";")

	'	ElseIf Request.Form("name") = "altCase" Then
	'		sqlExecute("UPDATE #___content_menu_type Set strCaseAlt = '"& strText &"' WHERE id = "& id &";")
	'	End If

	'End If

End If
%>
