<!--#include file="header.asp"-->
		<style type="text/css">
			/*html { overflow:auto !important; }*/
			ol.text {margin:0 0 0 10px; padding:4px 0 4px 20px;}
			ol.text li {margin:0; padding:0px 0 0px 0px; font-size:12px; font-weight:700;}
		</style>
	</head>
	<body style="min-width:780px;" class="clearfix">
		<%
		'Set objRs = setExecute("SELECT id, isim, durum, yer FROM #___modul ORDER BY sira_no ASC;")
		OpenRs objRs, "SELECT id, isim, durum, yer FROM #___modul ORDER BY sira ASC;"
		If objRs.Eof Then

			Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Üye bilgileri bulunamadı.</span></div></div></div>")

		Else
		%>
		<div class="maincolumn clearfix" style="margin-right:-4px">
			<div class="maincolumn-body clearfix" style="margin-right:4px">
				<div class="m_box clearfix">
					<div class="title"><span class="refresh"><a href="#" onclick="window.location.reload(); return false;" title="Yenile">Yenile</a></span><h3 class="box-title">Modül Yerleşimi</h3></div>
					<div class="head clearfix">
						<div class="form-table clearfix" style="padding:0;">
							<div class="clearfix" style="padding:10px;">
								<div id="width_ver" class="x_frame clearfix">
										<h3>Header Alanı</h3>
								</div>
								<div class="x_frame clearfix">
									<h3 style="font-size:14px;">Üst Modül Bölümü</h3>
									<ul id="left_modules" class="modules noSortable clearfix" data-section="ust">
										<%
										objRs.Filter = "yer = 'ust'"
										While Not objRs.Eof

											strChecked = "" : If CBool(objRs("durum")) Then strChecked = " checked"

											Response.Write("	<li style=""display:block !important; width:auto;"" id=""modul_id_"& objRs("id") &""">" & vbcrlf)
											Response.Write("		<a href=""#"" title=""Modülü Aktif/Pasif Yap"" class=""modul_status"& strChecked &""">Modülü Aktif/Pasif Yap</a>" & vbcrlf)
											Response.Write("		<span>"& objRs("isim") &"</span>" & vbcrlf)
											Response.Write("	</li>" & vbcrlf)

										objRs.MoveNext() : Wend
										%>
									</ul>
								</div>
								<div class="clr"></div>
								<div style="min-height:450px;" class="x_frame x_left clearfix">
									<h3 style="font-size:14px; padding-bottom:5px; text-align:center;">Sol Modül Bölümü</h3>
									<ul style="height:100%;" id="left_modules" class="modules clearfix" data-section="sol">
										<%
										objRs.Filter = "yer = 'sol'"
										While Not objRs.Eof

											strChecked = "" : If CBool(objRs("durum")) Then strChecked = " checked"

											Response.Write("	<li id=""modul_id_"& objRs("id") &""">" & vbcrlf)
											Response.Write("		<a href=""#"" title=""Modülü Aktif/Pasif Yap"" class=""modul_status"& strChecked &""">Modülü Aktif/Pasif Yap</a>" & vbcrlf)
											Response.Write("		<span>"& objRs("isim") &"</span>" & vbcrlf)
											Response.Write("	</li>" & vbcrlf)

										objRs.MoveNext() : Wend
										%>
									</ul>
								</div>
								<div style="min-height:450px;" id="width_ekle" class="x_frame x_left o clearfix">
										<h3 style="margin-top:60px !important;">Orta İçerik Alanı</h3>
								</div>
								<div style="min-height:450px;" class="x_frame x_left r clearfix">
									<h3 style="font-size:14px; padding-bottom:5px; text-align:center;">Sağ Modül Bölümü</h3>
									<ul style="height:100%;" id="right_modules" class="modules clearfix" data-section="sag">
									<%
									objRs.Filter = "yer = 'sag'"
									While Not objRs.Eof

										strChecked = "" : If CBool(objRs("durum")) Then strChecked = " checked"

										Response.Write("	<li id=""modul_id_"& objRs("id") &""">" & vbcrlf)
										Response.Write("		<a href=""#"" title=""Modülü Aktif/Pasif Yap"" class=""modul_status"& strChecked &""">Modülü Aktif/Pasif Yap</a>" & vbcrlf)
										Response.Write("		<span>"& objRs("isim") &"</span>" & vbcrlf)
										Response.Write("	</li>" & vbcrlf)

									objRs.MoveNext() : Wend

									%>
									</ul>
								</div>

								<div class="clr"></div>

								<div class="x_frame clearfix">
									<h3 style="font-size:14px;">Alt Modül Bölümü</h3>
									<ul id="left_modules" class="modules noSortable clearfix" data-section="alt">
										<%
										objRs.Filter = "yer = 'alt'"
										While Not objRs.Eof

											strChecked = "" : If CBool(objRs("durum")) Then strChecked = " checked"

											Response.Write("	<li style=""float:left;"" id=""modul_id_"& objRs("id") &""">" & vbcrlf)
											Response.Write("		<a href=""#"" title=""Modülü Aktif/Pasif Yap"" class=""modul_status"& strChecked &""">Modülü Aktif/Pasif Yap</a>" & vbcrlf)
											Response.Write("		<span>"& objRs("isim") &"</span>" & vbcrlf)
											Response.Write("	</li>" & vbcrlf)

										objRs.MoveNext() : Wend
										%>
									</ul>
								</div>
								<div class="x_frame clearfix">
										<h3>Footer Alanı</h3>
								</div>
								<div class="clr"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%
		End If
		CloseRs objRs
		%>
		<div class="maincolumn clearfix" style="margin-right:-4px">
			<div class="maincolumn-body clearfix" style="margin-right:4px">
				<div class="m_box clearfix">
					<div class="head clearfix">
						<div class="form-table clearfix">
							<ol class="text clearfix">
								<li>Modül yerleşimleri seçtiğiniz temaya göre farklılıklar gösterebilir, henüz tema seçimi yapmadıysanız önce tema seçimi yapmanızı öneririz.</li>
								<li>Modülün bulunduğu yeri değiştirmek için modülü tutup sürükleyerek görünmesini istediğiniz alana bırakın.</li>
								<li>Modülleri pasif duruma getirmek için üstünde ki aktif/pasif ikonuna tıklayın.</li>
								<li>Modül yerleşim ayarları tüm temalarda geçerli olmayabilir.</li>
							</ol>
						</div>
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">
/*<![CDATA[*/
jQuery(function( $ ) {
	$(window).on("resize", function() {
		var w = $("#width_ver").outerWidth();
		
		 $("#width_ekle").css("width", (w - 551) );
	}).trigger("resize");
});
/*]]>*/
</script>
	</body>
</html>
