<%
If (pageid > 0) Then Response.Redirect("?mod="& mods &"&task=edit&id="& pageid & Duzenle(sLang & Debug) )

EditLang = GlobalConfig("default_lang")
EditiD = 0
EditStatus = True
'EditCreateDate = Now()
'EditModifiedDate = DateTimeNull
EditStartDate = DateTimeNull
EditEndDate = DateTimeNull
EditHit = 0
EditYer = 0
EditType = "rek"
EditResim = ""
'Clearfix isNull(EditActiveLink)


If (id > 0) Then
	Set objRs = setExecute("SELECT * FROM #___banner WHERE id = "& id &";")
		If objRs.Eof Then
			Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Kayıt bulunamadı. İsterseniz yeni bir anket ekleyebilirsiniz.</span></div></div></div>")
			'EditiD = 0
		Else
			EditiD = objRs("id")
			EditTitle = objRs("title")
			EditLang = objRs("lang")
			EditType = objRs("tur")
			EditResim = objRs("img")
			EditAltMetin = objRs("alt")
			EditUrl = objRs("url")
			EditSira = objRs("sira")
			EditYer = objRs("yer")
			EditHit = objRs("hit")
			EditStatus = CBool(objRs("durum"))
			'EditCreateDate = objRs("c_date")
			'EditModifiedDate = objRs("m_date")
			EditStartDate = objRs("s_date")
			EditEndDate = objRs("e_date")
			EditAciklama = ReplaceEditorTag(objRs("text"))
		End If
	Set objRs = Nothing
End If

'If (EditiD = 0) Then EditCreateDate = Now()
'If (EditiD > 0) Then EditModifiedDate = Now()
If Not isDate(EditStartDate) Then EditStartDate = DateTimeNull
If Not isDate(EditEndDate) Then EditEndDate = DateTimeNull

If GlobalConfig("site_lang") = "AR" Then strDirection = "dir=""rtl"" lang=""ar"" xml:lang=""ar"" "
If GlobalConfig("site_lang") = "AR" Then strDirection2 = "onclick=""tinymce.get('text_"& GlobalConfig("site_lang") &"').getBody().dir = 'rtl';"" "

%>
<style type="text/css">
<!--
.ie7 .image_files li {float:left; display:block; zoom:1;}
.image_files {border:none; background:none;}
.image_files li {width:auto !important; height:auto !important; max-width:320px !important; max-height:300px !important; cursor:default;}
.image_files li .img img {width:auto !important; height:auto !important; max-width:315px !important; max-height:295px !important;}
-->
</style>

<form id="EnergyAdminForm" action="?mod=post&amp;task=<%=mods & sLang & Debug%>" method="post">
<div class="maincolumn">
	<div class="maincolumn-body">

		<div class="m_box">
			<div class="title"><%=ContentRevizyon(GlobalConfig("General_BannerPN"), EditiD)%><h3 class="box-title">Banner İçeriği</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
					<div class="row">
						<div class="l"><label for="title_"><span>:</span>Başlık</label></div>
						<div class="r">
							<input <%=strDirection%> class="inputbox" name="title_" id="title_" value="<%=EditTitle%>" maxlength="150" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Başlıklar SEO açısından önemlidir. <br />Arama motorlarında başlıklar maksimun 60 karakter ile sınırlıdır, uzun başlıklar girmeniz önerilmez. <br />Maksimun 150 karekter eklenebilir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="alt_metin"><span>:</span>Alternatif Metin</label></div>
						<div class="r">
							<input <%=strDirection%> class="inputbox" name="alt_metin" id="alt_metin" value="<%=EditAltMetin%>" maxlength="150" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Alternatif metinler SEO açısından önemlidir, <br />Resimlerin arama motorlarına tanıtılmasını sağlar. <br />Maksimun 150 karekter eklenebilir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="url"><span>:</span>Gidilecek URL</label></div>
						<div class="r">
							<input class="inputbox" name="url" id="url" value="<%=EditUrl%>" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Resimlere tıklandığında yönlendirilecek web sitesi adresidir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="tur"><span>:</span>Banner Türü</label></div>
						<div class="r">
							<select class="required" name="tur" id="tur" style="width:320px" size="1">
								<!--<option value=""<%=eSelected(EditType = "")%>>Banner Türü Seçiniz</option>-->
								<option value="rek"<%=eSelected(EditType = "rek")%>>Sadece JPG, PNG veya GIF dosyaları</option>
								<!-- <option value="swf"<%=eSelected(EditType = "swf")%>>Flash .SWF Uzantılı</option> -->
							</select>
						</div>
					</div>
					<div class="clr"></div>
				</div>
			</div>
		</div>



		<div class="m_box">
			<div class="title"><h3 class="box-title">Açıklama</h3></div>
			<div class="head clearfix">
				<div style="padding:0;margin:0" class="form-table clearfix">
					<div style="border-top:0;" class="htmleditors clearfix">
						<textarea id="text" name="text" class="energy_mce_editor"><%=EditAciklama%></textarea>
						<div class="ewy_mceBottomBar"></div>
					</div>
				</div>
			</div>
		</div>


	</div>
</div>

	<div class="rightcolumn">
		<div class="m_box">
			<div class="title"><h3 class="box-title">Yayımla</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
					<div class="row clearfix">
						<div class="l"><label for="pageid" style="color:green"><span>:</span>Kimlik</label></div>
						<div class="r">
							<input style="width:135px;" class="inputbox readonly" id="pageid" name="pageid" value="<%=EditiD%>" type="text" readonly="readonly" />
							<a class="tooltip" tabindex="-1" href="#" title="Bu kaydın veritabanındaki benzersiz kimliğidir. <em>Değiştirilemez.</em>">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="durum"><span>:</span>Göster / Gizle</label></div>
						<div class="r">
							<select class="required inputbox" name="durum" id="durum" size="1" style="width:180px">
								<option value="1"<%=eSelected(EditStatus)%>>Aktif (Sitede görünecek)</option>
								<option value="0"<%=eSelected(Not EditStatus)%>>Pasif (Sitede görünmeyecek)</option>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Görseli tamamen silmek yerine durumunu pasif yaparak sitenizde göstermeme şansına sahipsiniz.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="yer"><span>:</span>Yayınlanacak Yer</label></div>
						<div class="r">
							<select class="required" name="yer" id="yer" style="width:180px" size="1">
								<option value="">Seçiniz</option>
								<option value="0"<%=eSelected(EditYer = 0)%>>Banner Alanı 1 (Varsayılan)</option>
								<option value="1"<%=eSelected(EditYer = 1)%>>Banner Alanı 2</option>
								<option value="2"<%=eSelected(EditYer = 2)%>>Banner Alanı 3</option>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Sitenizde birden fazla banner slider alanı mevcut ise buradan görüntülenecek kısmı seçebilirsiniz. <br />Bu özellik tamamıyla önsayfada olmayabilir.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="sira"><span>:</span>Sıralama</label></div>
						<div class="r">
							<input class="inputbox list-order required number" name="sira" id="sira" value="<%=EditSira%>" maxlength="3" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Görseller genellikle alfabetik olarak sıralanır, <br />fakat isterseniz bu alana sayı girerek (birinci için 1 ) <br />şeklinde kendiniz de belirleyebilirsiniz.">&nbsp;</a>
						</div>
					</div><!--
					<div class="row clearfix">
						<div class="l"><label for="cDate"><span>:</span>Oluşturuldu</label></div>
						<div class="r">
							<input style="width:130px" class="inputbox required date" name="cDate" id="cDate" value="<%=EditCreateDate%>" maxlength="19" autocomplete="off" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Bu kaydın oluşturulduğu zamanı belirtir. Farklı bir tarih ve saat girmek veya istenilen tarihi bulmak için takvim simgesini tıklayın.">&nbsp;</a>
						</div>
					</div>
					<div class="row<%If (task = "new") Then Response.Write(" hidden")%>">
						<div class="l"><label for="mDate"><span>:</span>Düzenlendi</label></div>
						<div class="r">
							<input style="width:130px;" class="inputbox required readonly" name="mDate" id="mDate" value="<%=EditModifiedDate%>" maxlength="19" readonly="readonly" autocomplete="off" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Bu kaydın son güncelleme tarihi program tarafından belirlenir.">&nbsp;</a>
						</div>
					</div>-->
					<div class="row clearfix">
						<div class="l"><label for="sDate"><span>:</span>Yayımla</label></div>
						<div class="r">
							<input style="width:130px" class="inputbox required date" name="sDate" id="sDate" value="<%=EditStartDate%>" maxlength="19" autocomplete="off" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="İleri bir tarihte otomatik olarak yayınlamayı başlatmak isterseniz <br />bir tarih girin veya istenilen tarihi bulmak için takvim simgesini tıklayın.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="eDate"><span>:</span>Yayımlamayı Bitir</label></div>
						<div class="r">
							<input style="width:130px" class="inputbox date" name="eDate" id="eDate" value="<%=EditEndDate%>" maxlength="19" autocomplete="off" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="İleri bir tarihte yayınlamayı sona erdirmek için geçerli tarih girin <br />veya istenilen tarihi bulmak için takvim simgesini tıklayın.">&nbsp;</a>
						</div>
					</div><%
If sTotalLang() > 1 Then
%>
					<div class="row clearfix">
						<div class="l"><label for="lang"><span>:</span>Dil</label></div>
						<div class="r">
							<select class="required" name="lang" id="lang" size="1" style="width:180px">
								<%
Set objRs = setExecute("SELECT title, lng, default_lng, IF(lng = '"& EditLang &"', ' selected=""selected""', '') As strSelected FROM #___languages WHERE durum = 1 ORDER BY default_lng DESC, sira ASC;")
Do While Not objRs.Eof
	Response.Write("<option"& objRs("strSelected") &" value="""& objRs("lng") &""">"& objRs("title") &"</option>")
objRs.MoveNext() : Loop
Set objRs = Nothing
								%>
							</select>
							<a class="tooltip" tabindex="-1" href="#" title="Görselin yayınlanacağı dili seçin.">&nbsp;</a>
						</div>
					</div>
<%
End If
%>
					<div class="row clearfix">
						<div class="l"><label for="hit_<%=EditiD%>"><span>:</span>Tıklanma</label></div>
						<div class="r">
							<span class="relative">
								<input style="width:130px;" class="inputbox" name="hit[]" id="hit_<%=EditiD%>" value="<%=EditHit%>" type="text" />
								<%If EditHit > 0 Then%><span><a class="tooltip hit_reset" tabindex="-1" href="#" id="hit_reset[<%=EditiD%>]" href="?mod=redirect&amp;task=bannerhit&amp;id=<%=EditiD%>" title="Oylamayı Sıfırla">Oylamayı Sıfırla</a></span><%End If%>
							</span>
						</div>
					</div>

				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><h3 style="float:right; margin-right:5px; margin-top:3px;" class="box-title">Yayımla</h3><div style="float:left; margin-left:5px; margin-top:3px;" id="upload" class="smallicon"><span>Resim Seç</span></div></div>
			<div class="head clearfix">
				<div class="form-table clearfix">

					<div id="image-files" class="clearfix">
						<div id="status"></div>
						<ul class="image_files noSortable clearfix" id="files_" data_lang="<%=EditLang%>">
							<%If EditResim <> "" Then%><li id="image-id_<%=EditiD%>" class="success">
								<%
								If UCase(Right(EditResim, 3)) = "SWF" Or UCase(EditType) = "SWF" Then
								%>
									<script type="text/javascript">
									AC_FL_RunContent('codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0','width','<%=biWidth%>','height','<%=biHeight%>','src','<%=bFolder & "/" & Replace(EditResim, ".swf", "", 1, -1, 1)%>','quality','high','pluginspage','http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash','movie','<%=bFolder & "/" & Replace(EditResim, ".swf", "", 1, -1, 1)%>'); //end AC code
									</script>
									<noscript>
										<object width="<%=biWidth%>" height="<%=biHeight%>" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0">
											<param name="movie" value="<%= bFolder & "/" & EditResim%>" />
											<param name="quality" value="high" />
											<embed src="<%=bFolder & "/" & EditResim%>" width="<%=biWidth%>" height="<%=biHeight%>" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"></embed>    
										</object>
									</noscript>
								
								<%Else%>
									<div class="icons tooltip">
										<span class="deleteFile" title="Resmi Kalıcı Olarak Sil"><em>&nbsp;</em></span>
									</div>
									<div class="img">
										<a rel="img-show" tabindex="-1" href="<%= bFolder & "/" & EditResim %>" title="<%= EditResim %>"><img src="<%= bFolder & "/" & EditResim %>" alt="<%= EditResim %>" /></a>
									</div>

								<%End If%>

							</li><%End If%>
						</ul>
					</div>
					<ul class="clearfix">
						<li><span style="width:auto;" class="text green">Yeni bir resim eklediğinizde varolan resim sunucudan kalıcı olarak silinecektir.</span></li>
						<li><span style="width:auto;" class="text blue"><span class="red">Not:</span> Yüklenecek resim boyutları yayınlacak yere uygun olmalıdır.</span></li>
						<li><span style="width:auto;" class="text red"><em>Maksimun <%=int(MaxBytes(BannerMaxSize))%> MB (<%=FormatNumber(BannerMaxSize, 0)%> Byte) dosya yükleyebilirsiniz.</em></span></li>
					</ul>
				</div>
			</div>
		</div>

</div>
<input type="hidden" name="images" id="images" value="<%=EditResim%>" />
<input name="energy" id="energy" value="1" type="hidden" />
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
</form>
