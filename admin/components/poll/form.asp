<%
Dim intOy

If (pageid > 0) Then Response.Redirect("?mod="& mods &"&task=edit&id="& pageid & Duzenle(sLang & Debug) )


EditLang = GlobalConfig("default_lang")
EditiD = 0
EditStatus = True
'EditCreateDate = Now()
'EditModifiedDate = DateTimeNull
EditStartDate = DateTimeNull
EditEndDate = DateTimeNull
EditAciklama = ""
'Clearfix isNull(EditActiveLink)


If (id > 0) Then
	SQL = ""
	SQL = SQL & "SELECT t1.*, t2.seflink FROM #___anket t1 "
	SQL = SQL & "LEFT JOIN  #___content_url t2 ON t1.id = t2.parent_id And t2.durum = 1 "
	SQL = SQL & "WHERE t1.id = "& id &";"
	'SQL = setQuery( SQL )
	Set objRs = setExecute( SQL )
		If objRs.Eof Then
			Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Kayıt bulunamadı. İsterseniz yeni bir anket ekleyebilirsiniz.</span></div></div></div>")
			'EditiD = 0
		Else
			EditiD = objRs("id")
			EditTitle = objRs("title")
			EditSeflink = URLDecode(objRs("seflink"))
			EditLang = objRs("lang")
			EditStatus = CBool(objRs("durum"))
			EditSira = objRs("sira")
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
<form id="EnergyAdminForm" action="?mod=post&amp;task=<%=mods & sLang & Debug%>" method="post">
<div class="maincolumn">
	<div class="maincolumn-body">

		<div class="m_box">
			<div class="title"><%=ContentRevizyon(GlobalConfig("General_PollPN"), EditiD)%><h3 class="box-title">Anket Sorusu</h3></div>
			<div class="head clearfix">
				<div class="form-table clearfix">
					<div class="row clearfix">
						<div class="l"><label for="title_"><span>:</span>Soru</label></div>
						<div class="r">
							<span class="relative">
								<input <%=strDirection%>style="width:95%;" class="inputbox title" name="title_" id="title_" value="<%=EditTitle%>" maxlength="150" type="text" />
								<span><a class="tooltip slink" tabindex="-1" href="#" title="Permalink ekle/düzenle." onclick="$('#anket_seflink').toggle('blind'); $(this).toggleClass('active'); return false;">Permalink düzenle.</a></span>
							</span>
							<a class="tooltip" tabindex="-1" href="#" title="Başlıklar SEO açısından önemlidir. <br />Arama motorlarında başlıklar maksimun 60 karakter ile sınırlıdır, uzun başlıklar girmeniz önerilmez. <br />Maksimun 150 karekter eklenebilir.">&nbsp;</a>
						</div>
					</div>		
					<div id="anket_seflink" class="row clearfix hidden">
						<div class="l"><label for="seflink_"><span>:</span>Permalink</label></div>
						<div class="r">
							<input style="width:95%;" class="inputbox seflink" name="seflink_" id="seflink_" value="<%=EditSeflink%>" autocomplete="off" maxlength="200" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Permalink sayfanın kalıcı bağlantısıdır. <br />Tümü küçük harflerden oluşur, sadece harf, rakam ve tire içerir, kısa ve okunaklı bağlantı isimleri önerilir. <br />Maksimun 200 karekter eklenebilir.">&nbsp;</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><span style="float:right;padding-top:2px;"><button tabindex="-1" id="secenek_ekle" class="btn" type="button">Seçenek Ekle</button></span><h3 class="box-title">Seçenekler</h3></div>
			<div class="head clearfix"><div class="clr"></div>
				<div class="form-table clearfix"><div id="anketSecenek"><%
Secenekid = ""
Count = 0
Set objRs2 = Server.CreateObject("ADODB.Recordset")
objRs2.Open(setQuery("SELECT * FROM #___anket_secenek WHERE anketid = "& EditiD &" ORDER BY secenekid ASC;")),data,1,3
If objRs2.Eof Then
	intCounter = 3
	For Count = 1 To intCounter
	Secenekid = Secenekid & "<input id=""secenekid_"& Count &""" name=""secenekid[]"" value=""0"" type=""hidden"" />" & vbCrLf
%>
					<div class="row clearfix">
						<div class="l"><label for="secenek_title_<%=Count%>"><span>:</span>Seçenek <%=Count%><%If Not (Count > 2) Then%><em class="red"> *</em><%End If%></label></div>
						<div class="r">
							<span class="relative">
							<input <%=strDirection%>style="width:82%;" class="inputbox" name="secenek_title[]" id="secenek_title_<%=Count%>" value="" maxlength="100" type="text" />
								<span><a class="tooltip secenek_sil" tabindex="-1" href="#" id="secenek_id[<%=Count%>]" tabindex="-1" href="#" title="Seçeneği sil">Sil</a></span>
							</span>
							<span class="relative">
								<input style="width:7%;" class="inputbox" name="hit[]" id="hit_<%=Count%>" value="0" type="text" />
							</span>
							<a class="tooltip" tabindex="-1" href="#" title="Anket için seçenekler giriniz. Maksimun 100 karekter eklenebilir.">&nbsp;</a>
						</div>
					</div><%
Next

Else
intCounter = objRs2.RecordCount
For Count = 1 To intCounter
	If objRs2.Eof Then Exit For
	Secenekid = Secenekid & "<input id=""secenekid_"& Count &""" name=""secenekid[]"" value="""& objRs2("secenekid") &""" type=""hidden"" />" & vbNewLine

	intOy = Clng(objRs2("oy"))
%>
					<div class="row clearfix">
						<div class="l"><label for="secenek_title_<%=Count%>"><span>:</span>Seçenek <%=Count%><%If Not (Count > 2) Then%><em class="red"> *</em><%End If%></label></div>
						<div class="r">
							<span class="relative">
							<input <%=strDirection%>style="width:82%;" class="inputbox<%If Not (Count > 2) Then%> required<%End If%>" name="secenek_title[]" id="secenek_title_<%=Count%>" value="<%=objRs2("secenek")%>" maxlength="100" type="text" />
								<span><a class="tooltip secenek_sil" tabindex="-1" href="#" id="secenek_id[<%=objRs2("secenekid")%>]" tabindex="-1" href="#" title="Seçeneği sil">Sil</a></span>
							</span>
							<span class="relative">
								<input style="width:7%;" class="inputbox" name="hit[]" id="hit_<%=objRs2("secenekid")%>" value="<%=intOy%>" type="text" />
								<%If intOy > 0 Then%><span><a class="tooltip hit_reset" tabindex="-1" id="hit_reset[<%=objRs2("secenekid")%>]" href="?mod=redirect&amp;task=anket_secenek_oy_sifirla&amp;id=<%=objRs2("secenekid")%>" title="Oylamayı Sıfırla">Oylamayı Sıfırla</a></span><%End If%>
							</span>
							<a class="tooltip" tabindex="-1" href="#" title="Anket için seçenekler giriniz. Maksimun 100 karekter eklenebilir.">&nbsp;</a>
						</div>
					</div><%
objRs2.Movenext() : Next
End If
objRs2.Close : Set objRs2 = Nothing
%>
					</div>
					<div class="clr"></div>
				</div>
			</div>
		</div>

		<div class="m_box">
			<div class="title"><h3 class="box-title">Açıklama</h3></div>
			<div class="head clearfix">
				<div style="padding:0; margin:0;" class="form-table clearfix">
					<div style="border-top:0;" class="htmleditors clearfix">
						<textarea style="height:200px;" id="text" name="text" class="energy_mce_editor"><%=EditAciklama%></textarea>
						<div class="ewy_mceBottomBar"></div>
					</div>
					<div class="clr"></div>
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
							<input style="width:135px" class="inputbox readonly" id="pageid" name="pageid" value="<%=EditiD%>" type="text" readonly="readonly" />
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
							<a class="tooltip" tabindex="-1" href="#" title="Anketi tamamen silmek yerine durumunu pasif yaparak sitenizde göstermeme şansına sahipsiniz.">&nbsp;</a>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="sira"><span>:</span>Sıralama</label></div>
						<div class="r">
							<input class="inputbox list-order required number" name="sira" id="sira" value="<%=EditSira%>" maxlength="3" type="text" />
							<a class="tooltip" tabindex="-1" href="#" title="Anketler genellikle alfabetik olarak sıralanır, <br />fakat isterseniz bu alana sayı girerek (birinci için 1 ) <br />şeklinde kendiniz de belirleyebilirsiniz.">&nbsp;</a>
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
							<input style="width:130px" class="inputbox required readonly" name="mDate" id="mDate" value="<%=EditModifiedDate%>" maxlength="19" readonly="readonly" autocomplete="off" type="text" />
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
							<a class="tooltip" tabindex="-1" href="#" title="Anketin yayınlanacağı dili seçin.">&nbsp;</a>
						</div>
					</div>
<%
End If
%>
				</div>
			</div>
		</div>

</div>
<input name="energy" id="energy" value="1" type="hidden" />
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
<input id="sCount" name="sCount" value="<%=intCounter%>" type="hidden" />
<%=Secenekid%>
</form>
