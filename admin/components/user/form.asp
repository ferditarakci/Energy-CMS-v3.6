<%
'If (task = "new" And Kuladi <> GlobalConfig("gan")) Then Response.Redirect "?mod="& mods

If (pageid > 0) Then Response.Redirect("?mod="& mods &"&task=edit&id="& pageid & Duzenle(sLang) )

Dim EditYetki, EditTipi, EditCinsiyet, EditDogumTarihi, EditSonGiris, EditKulad, EditAdi, EditSoyadi, EditAdres
Dim EditTcNO, EditMail, EditSifre, EditCepTel, EditisTel, EditFax, Editil, Editilce, EditSemt, EditDogumYeri, EditWeb

EditiD = 0
EditStatus = 1
EditYetki = 1
EditTipi = -1
EditCinsiyet = 1
EditDogumTarihi = Null
EditCreateDate = Now()
EditSonGiris = Null
EditHit = 0

If id > 0 Then
	sqlNotUser = "" : If Not GlobalConfig("admin_username") = GlobalConfig("super_admin") Then sqlNotUser = " And Not kulad = '"& GlobalConfig("super_admin") &"'"
	Set objRs = setExecute("SELECT * FROM #___uyeler WHERE id = "& id & sqlNotUser &";")
		If objRs.Eof Then
			Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Üye bilgileri bulunamadı.</span></div></div></div>")
			'EditiD = 0
		Else
			EditiD = objRs("id")
			EditKulad = objRs("kulad")
			EditStatus = objRs("durum")
			EditYetki = objRs("yetki")
			EditTipi = objRs("uyetipi")
			EditAdi = objRs("adi")
			EditSoyadi = objRs("soyadi")
			EditTcNO = objRs("tcno") : If EditTcNO = 0 Then EditTcNO = ""
			EditMail = objRs("mail")
			EditSifre = objRs("pass")
			EditCinsiyet = objRs("cinsiyet")
			EditDogumTarihi = objRs("dogumtarihi")
			EditCepTel = objRs("telcep")
			EditisTel = objRs("telis")
			EditFax = objRs("telfax")
			Editil = objRs("il")
			Editilce = objRs("ilce")
			EditSemt = objRs("semt")
			EditAdres = objRs("adres")
			EditWeb = objRs("web")
			EditCreateDate = objRs("tarih")
			EditSonGiris = objRs("songiris")
			EditHit = objRs("hit")
			EditDogumYeri = objRs("dogumyeri")
			'EditTilce = objRs("tilce")
			'EditTadres = objRs("tadres")
			'EditTyetkili = objRs("tyetkili")
			'EditFil = objRs("fil")
			'EditFilce = objRs("filce")
			'EditFadres = objRs("tadres")
			'EditFyetkili = objRs("tyetkili")
			'EditFVD = objRs("fvd")
			'EditFVNO = objRs("fvno")
		End If
	Set objRs = Nothing
End If

'If (EditiD = 0) Then EditCreateDate = Now()

%>
<style type="text/css">
<!--
.form-table div.row div.l {width:20%;}
.form-table div.row div.r {width:75%;}
//-->
</style>

<form id="EnergyAdminForm" action="?mod=post&amp;task=<%=mods & sLang%>" method="post">

<div class="maincolumn" style="margin-right:-402px">
	<div class="maincolumn-body" style="margin-right:402px">

		<div class="m_box">
			<div class="title"><h3 class="box-title">Hesap Bilgileri</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
					<div class="row clearfix">
						<div class="l"><label for="adi"><span>:</span>Ad Soyad <em class="text red">*</em></label></div>
						<div class="r">
							<input style="width:45%" class="inputbox required" name="adi" id="adi" value="<%=EditAdi%>" maxlength="20" type="text" />
							<input style="width:45%" class="inputbox required" name="soyadi" id="soyadi" value="<%=EditSoyadi%>" maxlength="30" type="text" />
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="mail"><span>:</span>Email Adresi <em class="text red">*</em></label></div>
						<div class="r">
							<input style="width:300px" class="inputbox required mail" name="mail" id="mail" value="<%=EditMail%>" maxlength="80" type="text"<%If (Not GlobalConfig("admin_username") = GlobalConfig("super_admin")) And task = "edit" Then Response.Write(" readonly=""readonly""")%> />
							<a class="tooltip" title="Geçerli bir mail adresi girin. <em>Parola sıfırlamak için gereklidir.</em> Maksimun 80 karekter.">&nbsp;</a>
							<span id="mail_status"></span>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="kuladi"><span>:</span>Kullanıcı Adı <em class="text red">*</em></label></div>
						<div class="r">
							<input style="width:300px" class="inputbox required" name="kuladi" id="kuladi" value="<%=EditKulad%>" maxlength="16" type="text"<%If (Not GlobalConfig("admin_username") = GlobalConfig("super_admin")) And task = "edit" Then Response.Write(" readonly=""readonly""")%> />
							<a class="tooltip" title="Geçerli bir kullanıcı adı girin. Maksimun 16 karekter.">&nbsp;</a>
							<span id="kulad_status"></span>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="pass"><span>:</span>Şifre<%If (task = "new") Then Response.Write(" <em class=""text red"">*</em>")%></label></div>
						<div class="r">
							<input style="width:300px" class="inputbox<%If (task = "new") Then Response.Write(" required")%>" name="pass" id="pass" maxlength="64" type="password" />
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="pass2"><span>:</span>Şifre (Tekrar)<%If (task = "new") Then Response.Write(" <em class=""text red"">*</em>")%></label></div>
						<div class="r">
							<input style="width:300px" class="inputbox<%If (task = "new") Then Response.Write(" required")%>" name="pass2" id="pass2" maxlength="64" type="password" />
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><h3 class="box-title">Adres Bilgileri</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
					<div class="row clearfix">
						<div class="l"><label for="il"><span>:</span>İl / İlçe / Semt</label></div>
						<div class="r">
							<select class="select_location" name="il" id="il" data-prefix="" style="width:110px;">
				<%
				Call iller(Editil)
				%>
							</select> / 
							<select class="select_location" name="ilce" id="ilce" data-prefix="" style="width:120px;">
				<%
				Call ilceler(Editil, Editilce)
				%>
							</select> / 
							<select name="semt" id="semt" style="width:120px;">
				<%
				Call semtler(Editilce, EditSemt)
				%>
							</select>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="adres"><span>:</span>Adres</label></div>
						<div class="r">
							<textarea style="width:95% !important; *width:93% !important; height:75px" name="adres" id="adres"><%=EditAdres%></textarea>
							<a class="tooltip" title="Ev veya iş yeri adresiniz.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="web"><span>:</span>Web Adresi</label></div>
						<div class="r">
							<input class="inputbox" name="web" id="web" value="<%=EditWeb%>" type="text" />
							<a class="tooltip" title="Varsa internet sitesiniz / Bloğunuz.">&nbsp;</a>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>


<div class="rightcolumn" style="width:390px;">

	<div class="m_box">
		<div class="title"><h3 class="box-title">Hesap Tipi</h3></div>
		<div class="head clearfix">
			<div class="form-table clearfix">
				<div class="row clearfix">
					<div class="l"><label for="pageid"><span>:</span>Kimlik</label></div>
					<div class="r">
						<input style="width:135px" class="inputbox readonly" name="pageid" id="pageid" autocomplete="off" value="<%=EditiD%>" type="text" readonly="readonly" />
						<a class="tooltip" title="Bu kaydın veritabanındaki benzersiz kimliğidir. <em>Değiştirilemez.</em>">&nbsp;</a>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="uyetipi"><span>:</span>Kullanıcı Türü <em class="text red">*</em></label></div>
					<div class="r">
						<select class="required" name="uyetipi" id="uyetipi" style="width:150px">
							<option value=""<%=eSelected(EditTipi = -1)%>><%=UyeTipi(-1)%></option>
							<option value="0"<%=eSelected(EditTipi = 0)%>><%=UyeTipi( 0)%></option>
							<option value="1"<%=eSelected(EditTipi = 1)%>><%=UyeTipi( 1)%></option>
							<option value="2"<%=eSelected(EditTipi = 2)%>><%=UyeTipi( 2)%></option>
							<option value="3"<%=eSelected(EditTipi = 3)%>><%=UyeTipi( 3)%></option>
						</select>
						<a class="tooltip" title="Yalnızca &lt;q&gt;yönetici&lt;/q&gt; hesaplarının yönetici arka-uç birimine giriş yetkisi bulunmaktadır.">&nbsp;</a>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="durum"><span>:</span>Durum</label></div>
					<div class="r">
						<select name="durum" id="durum" style="width:100px">
							<option value="1"<%=eSelected(EditStatus = 1)%>>Aktif</option>
							<option value="0"<%=eSelected(EditStatus = 0)%>>Pasif</option>
						</select>
						<a class="tooltip" title="Durumu &lt;q&gt;pasif&lt;/q&gt; olan üyeler sisteme giriş yapamaz.">&nbsp;</a>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="yetki"><span>:</span>Yetki</label></div>
					<div class="r">
						<select name="yetki" id="yetki" style="width:150px;">
							<option value="1"<%=eSelected(EditYetki = 1)%>>Okuma / Yazma</option>
							<option value="0"<%=eSelected(EditYetki = 0)%>>Sadece Okuma</option>
						</select>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="mailgonder"><span>:</span>Onay Maili Gönder</label></div>
					<div class="r" style="padding-top:4px">
						<input class="radioMargin" class="checkbox" name="mailgonder" id="mailgonder" value="1" type="checkbox" disabled="disabled" />
						<a style="margin-top:3px;margin-left:5px" class="tooltip" title="Üyeliğin Onaylandığına Dair E-Posta Gönder.">&nbsp;</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="m_box">
		<div class="title"><h3 class="box-title">Kişisel Bilgiler</h3></div>
		<div class="head clearfix">
			<div class="form-table clearfix">
				<div class="row clearfix">
					<div class="l"><label for="tcno"><span>:</span>TC No</label></div>
					<div class="r">
						<input style="width:180px" class="inputbox" name="tcno" id="tcno" value="<%=EditTcNO%>" maxlength="11" type="text" />
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="cinsiyet"><span>:</span>Cinsiyet <em class="text red">*</em></label></div>
					<div class="r">
						<select class="required" name="cinsiyet" id="cinsiyet" style="width:100px">
							<option value="1"<%=eSelected(EditCinsiyet = 1)%>>Erkek</option>
							<option value="0"<%=eSelected(EditCinsiyet = 0)%>>Bayan</option>
						</select>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="dogumyeri"><span>:</span>Doğum Yeri</label></div>
					<div class="r">
						<select name="dogumyeri" id="dogumyeri" style="width:160px">
							<%
							Call iller(EditDogumYeri)
							%>
						</select>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="tarihgun"><span>:</span>Doğum Tarihi</label></div>
					<div class="r">
<%
							'// Günler
							Response.Write( String(6, vbTab) & "<select name=""tarihgun"" id=""tarihgun"" style=""width:60px"">" & vbCrLf )
							Response.Write( String(7, vbTab) & "<option"& eSelected( isNull(EditDogumTarihi) ) &" value="""">Gün</option>" & vbCrLf )
							For i = 1 To 31 Step 1
								Response.Write( String(7, vbTab) & "<option"& eSelected( (Not isNull(EditDogumTarihi)) And (Day(EditDogumTarihi) = i) ) &" value="""& i &""">"& i &"</option>" & vbCrLf )
							Next
							Response.Write( String(6, vbTab) & "</select> / " & vbCrLf )


							'// Aylar
							Response.Write( String(6, vbTab) & "<select name=""tarihay"" id=""tarihay"" style=""width:70px"">" & vbCrLf )
							Response.Write( String(7, vbTab) & "<option"& eSelected( isNull(EditDogumTarihi) ) &" value="""">Ay</option>" & vbCrLf )
							Dim arrAylar
							arrAylar = Array("", "Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık")
							For i = 1 To 12 Step 1
								Response.Write( String(7, vbTab) & "<option"& eSelected( (Not isNull(EditDogumTarihi)) And (Month(EditDogumTarihi) = i) ) &" value="""& i &""">"& arrAylar(i) &"</option>" & vbCrLf )
							Next
							Response.Write( String(6, vbTab) & "</select> / " & vbCrLf )


							'// Yıllar
							Response.Write( String(6, vbTab) & "<select name=""tarihyil"" id=""tarihyil"" style=""width:55px"">" & vbCrLf )
							Response.Write( String(7, vbTab) & "<option"& eSelected( isNull(EditDogumTarihi) ) &" value="""">Yıl</option>" & vbCrLf )
							For i = 1923 To Clng(Year(Date()) -18) Step 1
								Response.Write( String(7, vbTab) & "<option"& eSelected( (Not isNull(EditDogumTarihi)) And (Year(EditDogumTarihi) = i) ) &" value="""& i &""">"& i &"</option>" & vbCrLf )
							Next
							Response.Write( String(6, vbTab) & "</select>" & vbCrLf )
%>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="telcep"><span>:</span>Cep Telefonu</label></div>
					<div class="r">
						<input style="width:180px" class="inputbox" name="telcep" id="telcep" value="<%=EditCepTel%>" maxlength="15" type="text" />
						<a class="tooltip" title="Örnek: <em>05468312073</em>">&nbsp;</a>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="telis"><span>:</span>İş Telefonu</label></div>
					<div class="r">
						<input style="width:180px" class="inputbox" name="telis" id="telis" value="<%=EditisTel%>" maxlength="15" type="text" />
						<a class="tooltip" title="Örnek: <em>05468312073</em>">&nbsp;</a>
					</div>
				</div>
				<div class="row clearfix">
					<div class="l"><label for="telfax"><span>:</span>Fax Numarası</label></div>
					<div class="r">
						<input style="width:180px" class="inputbox" name="telfax" id="telfax" value="<%=EditFax%>" maxlength="15" type="text" />
						<a class="tooltip" title="Örnek: <em>05468312073</em>">&nbsp;</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="m_box">
		<div class="title"><h3 class="box-title">Kayıt Bilgileri</h3></div>
		<div class="head clearfix">
			<div class="form-table clearfix">
				<div class="row clearfix">
					<div class="l"><label for="tarih"><span>:</span>Kayıt Tarihi <em class="red">*</em></label></div>
					<div class="r">
						<input style="width:135px" class="inputbox required date" name="tarih" id="tarih" value="<%=EditCreateDate%>" maxlength="19" autocomplete="off" type="text" />
					</div>
				</div>
				<div class="row<%If Not (EditiD > 0) Then Response.Write(" hidden")%>">
					<div class="l"><label for="sonziyaret"><span>:</span>Son Ziyaret Tarihi</label></div>
					<div class="r">
						<input style="width:135px" class="inputbox required disabled" name="sonziyaret" id="sonziyaret" value="<%=EditSonGiris%>" disabled="disabled" maxlength="19" autocomplete="off" type="text" />
					</div>
				</div>
				<div class="row<%If Not (EditiD > 0) Then Response.Write(" hidden")%>">
					<div class="l"><label for="hit"><span>:</span>Ziyaret Sayısı</label></div>
					<div class="r">
						<span class="relative">
							<input style="width:135px" class="inputbox required disabled" name="hit" id="hit_<%=EditiD%>" value="<%=FormatNumber(EditHit, 0)%>" disabled="disabled" type="text" />
							<%If (EditHit > 0) Then%><span><a class="hit_reset" id="hit_reset[<%=EditiD%>]" href="?mod=redirect&amp;task=uyehit&amp;id=<%=EditiD%>" title="Sıfırla">Sıfırla</a></span><%End If%>
						</span>
						<a class="tooltip" title="Bu üyenin toplam giriş sayısı.">&nbsp;</a>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<input name="energy" id="energy" value="1" type="hidden" />
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
</form>

<%If (task = "newsss") Then%>
<script type="text/javascript">
//<![CDATA[
$(document).ready(function() {
	/*$("#kuladi").checkAvailability({
		target: '#kulad_status',
		ajaxSource: 'index.asp?mod=redirect&task=username_kontrol'
	});
	$("#mail").checkAvailability({
		target: '#mail_status',
		ajaxSource: 'index.asp?mod=redirect&task=usermail_kontrol'
	});*/
/*	$("#adminForm").validate({
		rules: {
			uname: {
				required: true,
				minlength: 4,
				maxlength: 16
			},
			pass: {
				required: true,
				minlength: 4,
				maxlength: 16
			},
			pass2: {
				//required: true,
				equalTo: "#pass"
			}
		},
		messages: {
			uname: {
				required: "Lütfen kullanıcı adınızı giriniz",
				minlength: "Kullanıcı adınız minimun 4 karekterden az olamaz",
				maxlength: "Kullanıcı adınız maksimun 16 karekterden fazla olamaz"
			},
			pass: {
				required: "Lütfen şifrenizi girin",
				minlength: "Şifreniz minimun 4 karakter olmalıdır",
				maxlength: "Şifreniz maksimun 16 karakter olmalıdır"
			},
			pass2: {
				//required: "Lütfen şifrenizi tekrar girin",
				equalTo: "Şifre ile şifre tekrarı eşleşmiyor"
			}
		}
	});*/
});
//]]>
</script><%End If%>
