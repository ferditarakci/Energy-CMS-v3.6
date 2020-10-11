<%
	If task = "" Then
%>
<!--#include file="../header.asp"-->
<style type="text/css">
	/*html { overflow:auto !important; }*/
	.boxs {float:left; margin-right:16px; margin-bottom:15px; padding:10px 12px; line-height:1; border:1px solid #DFDFDF; background-color:whiteSmoke; -moz-border-radius:5px; -webkit-border-radius:5px; -ms-border-radius:5px; -o-border-radius:5px; border-radius:5px;}
	.boxs.last {margin-right:0px;}
	.boxs label {display:block; margin:3px 0 5px 5px;}
	ol.text {margin:0; padding:10px 10px 10px 20px; border:1px solid #DFDFDF; background-color:whiteSmoke; -moz-border-radius:5px; -webkit-border-radius:5px; -ms-border-radius:5px; -o-border-radius:5px; border-radius:5px;}
	ol.text li {margin:0 0 5px; margin-left:10px; padding:0px 0 0px 0px; font-size:12px;}
</style>
</head>
<body style="min-width:790px;" class="clearfix">
<%
Set objRs = setExecute("SELECT * FROM #___content_menu_type WHERE durum = 1;")
If objRs.Eof Then

	Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Kayıt bulunamadı.</span></div></div></div>")

Else
%>

<form id="Energy_Form_<%=SifreUret( 10 )%>" action="<%=GlobalConfig("site_uri")%>" method="post">

<div class="maincolumn" style="margin-right:0px">
	<div class="maincolumn-body" style="margin-right:0px">
		<div class="m_box">
			<div class="title"><span class="refresh"><a href="#" onclick="window.location.reload(); return false;" title="Yenile">Yenile</a></span> <h3 style="font-size:11px;" class="box-title">Menülerin "Etiket Metni" Biçimlendirme Ayarları</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">

<div class="clearfix" style="width:770px; padding:10px;">
<%
i = 1
While Not objRs.Eof

'strChecked = ""
'If Cbool(objRs("durum")) Then strChecked = " checked"
%>
	<div class="boxs<%If i Mod 3 = 0 Then Response.Write " last"%>">
		<label><span><b><%=objRs("title")%>:</b> Üst İçerik</span></label>
		<select id="ewyid_<%=objRs("id")%>" name="ustCase" class="SettingsSaveChange" style="width:220px;">
			<option value="0"<%=eSelected(objRs("strCaseUst") = "")%>>Varsayılan</option>
			<option value="1"<%=eSelected(objRs("strCaseUst") = "ilkHarfBuyuk")%>>İlk Harfi Büyük</option>
			<option value="2"<%=eSelected(objRs("strCaseUst") = "BasHarfBuyuk")%>>Baş Harfi Büyük</option>
			<option value="3"<%=eSelected(objRs("strCaseUst") = "UCase2")%>>Tümü Büyük Harf</option>
			<option value="4"<%=eSelected(objRs("strCaseUst") = "LCase2")%>>Tümü Küçük Harf</option>
		</select>
		<div class="clr" style="padding:3px 0;"></div>
		<label><span><b><%=objRs("title")%>:</b> Alt İçerik</span></label>
		<select id="ewyid__<%=objRs("id")%>" name="altCase" class="SettingsSaveChange" style="width:220px;">
			<option value="0"<%=eSelected(objRs("strCaseAlt") = "")%>>Varsayılan</option>
			<option value="1"<%=eSelected(objRs("strCaseAlt") = "ilkHarfBuyuk")%>>İlk Harfi Büyük</option>
			<option value="2"<%=eSelected(objRs("strCaseAlt") = "BasHarfBuyuk")%>>Baş Harfi Büyük</option>
			<option value="3"<%=eSelected(objRs("strCaseAlt") = "UCase2")%>>Tümü Büyük Harf</option>
			<option value="4"<%=eSelected(objRs("strCaseAlt") = "LCase2")%>>Tümü Küçük Harf</option>
		</select>
	</div>

<%
i = i + 1
objRs.MoveNext() : Wend
%>
	<div class="clr"></div>

</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="maincolumn" style="margin-right:0px">
	<div class="maincolumn-body" style="margin-right:0px">
		<div class="m_box">
			<div class="head clearfix">
				<div class="form-table">
					<h3 style="margin-bottom:10px;">Menü Etiketlerini Biçimlendirme Örnekleri</h3>
					<p style="margin-bottom:10px;">Örneğin <b style="color:#f00;">WEB TASARIM HİZMETLERİ</b> &nbsp;&nbsp;isminde bir menümüz var.</p>
					<ol class="text">
						<li><b><u style="color:#3965d5;">Varsayılan</u></b> Şeçilmişse menü etiketleri yazıldığı gibi görünür.</li>
						<li><b><u style="color:#3965d5;">İlk Harfi Büyük</u></b> Şeçilmişse menü etiketi <b style="color:#f00;">Web tasarım hizmetleri</b> gibi görünür.</li>
						<li><b><u style="color:#3965d5;">Baş Harfi Büyük</u></b> Şeçilmişse menü etiketi <b style="color:#f00;">Web Tasarım Hizmetleri</b> gibi görünür. (Önerilir)</li>
						<li><b><u style="color:#3965d5;">Tümü Büyük Harf</u></b> Şeçilmişse menü etiketi <b style="color:#f00;">WEB TASARIM HİZMETLERİ</b> gibi görünür.</li>
						<li><b><u style="color:#3965d5;">Tümü Küçük Harf</u></b> Şeçilmişse menü etiketi <b style="color:#f00;">web tasarım hizmetleri</b> gibi görünür.</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

</form>

<%
End If
Set objRs = Nothing
%>
	</body>
</html>










<%
ElseIf task = "save" Then

	'For Each item in Request.Form("lang")
	'	sqlExecute("UPDATE #___settings Set opt_name = '"& strText &"' WHERE id = "& id &";")
	'Next

	If GlobalConfig("admin_yetki") Then
		Select Case intYap(Request.Form("val"), 0)
			Case 1	strText = "ilkHarfBuyuk"
			Case 2	strText = "BasHarfBuyuk"
			Case 3	strText = "UCase2"
			Case 4	strText = "LCase2"
			Case Else strText = ""
		End Select

		If Request.Form("name") = "ustCase" Then
			sqlExecute("UPDATE #___content_menu_type Set strCaseUst = '"& strText &"' WHERE id = "& id &";")

		ElseIf Request.Form("name") = "altCase" Then
			sqlExecute("UPDATE #___content_menu_type Set strCaseAlt = '"& strText &"' WHERE id = "& id &";")
		End If

	End If

End If
%>
