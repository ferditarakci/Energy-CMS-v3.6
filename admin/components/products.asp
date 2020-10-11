<%
If Not GlobalConfig("urun_yonetimi") Then _
	Response.Redirect("index.asp")
%>

<%
'If Not (GlobalConfig("urun_yonetimi")) Then
'	Response.Write("<div class=""message warning block"" style=""margin-top:3em""><div class=""content""><span>Bu Özelliği Kullanabilmeniz İçin Bir Üst Pakete Geçmeniz Gerekiyor.</span></div></div>")
'Else
%>
<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo product">Ürün yönetimi<%
	If task = "new" Then
		Response.Write("<small> &raquo; Yeni kayıt</small>")
	ElseIf task = "edit" Then
		Response.Write("<small> &raquo; Kayıt düzenle</small>")
	End If
%></td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
<%If task = "" Then%>
					<li><a href="?mod=<%=mods%>&amp;task=new<%=sLang & Debug%>" title="Yeni ürün ekle"><span class="product_add"></span>Yeni Ürün</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan ürünleri yayınla"><span class="product_activate"></span>Yayınla</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan ürünleri yayından kaldır"><span class="product_deactivate"></span>Kaldır</a></li><!--
					<li><a onclick="listItemTask('all', 'anasayfa', 'true')" title="Seçili olan ürünleri anasayfada yayınla"><span class="icon-32-frontpage"></span>Vitrin</a></li>
					<li><a onclick="listItemTask('all', 'anasayfa', 'false')" title="Seçili olan ürünleri anasayfadan kaldır"><span class="icon-32-frontpage pasif"></span>Vitrin</a></li>-->
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan ürünleri sil"><span class="product_delete"></span>Sil</a></li>
<%ElseIf task = "new" Or task = "edit" Then%>
					<li><a class="iframe2" href="?mod=preview<%=sLang & Debug%>" title="Önizleme"><span class="preview"></span>Önizleme</a></li>
					<li><a id="form_submit" href="#" title="Ürünü kaydet"><span class="save"></span>Kaydet</a></li>
					<li><a href="?mod=<%=mods & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>    
<%End If%>
					<li><a id="settings" href="?mod=<%=mods%>_settings<%=Debug%>" title="Ayarlar"><span class="settings"></span>Ayarlar</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>
<%
If task = "" Then

ViewsiD = intYap(Request.Form("views"), 0)

'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(Request.Form("search"), 1))
If inputSearch <> "" Then
	arrSearch = Split(inputSearch, " ")
	SearchSQL = " And ("
	For Each i in arrSearch : SearchSQL = SearchSQL & "t2.title like '%"& i &"%' Or t1.kodu like '%"& i &"%' Or " : Next
	SearchSQL = Left(SearchSQL, Len(SearchSQL) -4) & ")"
End If

'response.write typename(SearchSQL)



'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count( t1.id ) As Toplam FROM #___products t1" & vbCrLf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
SQL = SQL & "WHERE t2.parent = "& GlobalConfig("General_ProductsPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf

Select Case ViewsiD
	Case 8 SQL = SQL & "And t1.durum = 1" & vbCrLf
	Case 9 SQL = SQL & "And t1.durum = 0" & vbCrLf
'	Case 11 SQL = SQL & "And t1.remove = 1" & vbCrLf
End Select

SQL = SQL & SearchSQL & vbCrLf
SQL = SQL & ";"
'Clearfix SQL
ToplamCount = Cdbl(sqlQuery(SQL, 0))



'// Bilgisayara Cookie Bırakalım
Call getAdminCookie(mods)




'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT " & vbCrLf
SQL = SQL & "t1.id, t1.anaid, t1.sira, t1.ozel, t1.durum, t1.anasyf, t1.kodu, t1.fiyat, t1.para, t4.DateTimes As c_date, t1.s_date, t1.e_date," & vbCrLf
SQL = SQL & "t2.title, t2.short_text, t2.hit, t3.title As typetitle, t5.title As img_title, t5.alt, t5.resim" & vbCrLf
SQL = SQL & "FROM #___products t1" & vbCrLf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_template t3 ON t1.typeAlias = t3.alias And (t3.parent = "& GlobalConfig("General_ProductsPN") &" Or t3.parent = 0)" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_revision_date t4 ON t1.id = t4.parent_id And t4.parent = "& GlobalConfig("General_ProductsPN") &" And t4.Revizyon = 1" & vbCrLf
SQL = SQL & "LEFT JOIN #___files t5 ON t5.anaresim = 1 And t1.id = t5.parent_id And t5.parent = "& GlobalConfig("General_ProductsPN") &" And t5.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf

SQL = SQL & "WHERE" & vbCrLf
SQL = SQL & "t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = "& GlobalConfig("General_ProductsPN") & " " & SearchSQL & vbCrLf

Select Case ViewsiD
	Case 0 SQL = SQL & "ORDER BY t1.sira ASC, t1.id DESC" & vbCrLf
	Case 1 SQL = SQL & "ORDER BY t2.title ASC" & vbCrLf
	Case 2 SQL = SQL & "ORDER BY t2.title DESC" & vbCrLf
	Case 3 SQL = SQL & "ORDER BY t1.kodu ASC" & vbCrLf
	Case 4 SQL = SQL & "ORDER BY t1.kodu DESC" & vbCrLf
	Case 5 SQL = SQL & "And t1.anasyf = 1 ORDER BY t1.id DESC" & vbCrLf
	Case 6 SQL = SQL & "And t1.yeni = 1 ORDER BY t1.id DESC" & vbCrLf
	'Case 7 SQL = SQL & "And t1.stok = 1 ORDER BY t1.id DESC" & vbCrLf
	Case 8 SQL = SQL & "And t1.durum = 1 ORDER BY t1.id DESC" & vbCrLf
	Case 9 SQL = SQL & "And t1.durum = 0 ORDER BY t1.id DESC" & vbCrLf
	Case 10 SQL = SQL & "ORDER BY t2.hit DESC" & vbCrLf
End Select

If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(t1.id, "& TreeViewShort &") " & vbCrLf

SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi

SQL = SQL & ";"

'SQL = setQuery( SQL )
'Clearfix SQL

Set objRs = setExecute( SQL )
%>

<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri")%>" method="post">
<div class="notepad clearfix">
<table>
	<tr>
		<td><%

intDurumTumu = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___products t1 LEFT JOIN #___content t2 ON t1.id = t2.parent_id WHERE t2.parent = "& GlobalConfig("General_ProductsPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
intDurumAktif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___products t1 LEFT JOIN #___content t2 ON t1.id = t2.parent_id WHERE t1.durum = 1 And t2.parent = "& GlobalConfig("General_ProductsPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
intDurumPasif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___products t1 LEFT JOIN #___content t2 ON t1.id = t2.parent_id WHERE t1.durum = 0 And t2.parent = "& GlobalConfig("General_ProductsPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)
'intDurumCop = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___products t1 LEFT JOIN #___content t2 ON t1.id = t2.parent_id WHERE t1.remove = 1 And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
%>
			<span style="float:right;">
				<a <%If ViewsiD = 0 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(0); submitform(); return false;" href="#">Tümü (<%=intDurumTumu%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 8 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(8); submitform(); return false;" href="#">Sadece Aktifler (<%=intDurumAktif%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 9 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(9); submitform(); return false;" href="#">Sadece Pasifler (<%=intDurumPasif%>)</a><!-- &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 11 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(11); submitform(); return false;" href="#">Çöptekiler (<%=intDurumCop%>)</a> -->
				<select name="views" id="views" size="1" style="width:200px" onchange="submitform()">
					<option value="0"<%=eSelected(ViewsiD = 0)%>>  ----Sırala----  </option>
					<option value="1"<%=eSelected(ViewsiD = 1)%>>A&#39;dan Z&#39;ye sırala</option>
					<option value="2"<%=eSelected(ViewsiD = 2)%>>Z&#39;den A&#39;ya sırala</option>
					<option value="3"<%=eSelected(ViewsiD = 3)%>>Koduna göre A&#39;dan Z&#39;ye sırala</option>
					<option value="4"<%=eSelected(ViewsiD = 4)%>>Koduna göre Z&#39;den A&#39;ya sırala</option>
					<option value="5"<%=eSelected(ViewsiD = 5)%>>Vitrinde olanlar</option>
					<option value="6"<%=eSelected(ViewsiD = 6)%>>Yeni olanlar</option>
					<!-- <option value="7"<%=eSelected(ViewsiD = 7)%>>Stokta olanlar</option> -->
					<option value="8"<%=eSelected(ViewsiD = 8)%>>Sadece aktif olanlar</option>
					<option value="9"<%=eSelected(ViewsiD = 9)%>>Sadece pasif olanlar</option>
					<option value="10"<%=eSelected(ViewsiD = 10)%>>En fazla görüntülenenler</option>
				</select>
			</span>
			Süzgeç :
			<input class="inputbox" name="search" id="search" value="<%=inputSearch%>" type="text" size="30" />
			<button class="btn" onclick="window.onbeforeunload = null; this.form.submit();" type="button">Ara</button>
			<button class="btn" onclick="$('#search').val(''); window.onbeforeunload = null; this.form.submit();" type="button">Temizle</button>
		</td>
	</tr>
</table>
</div>

<div class="notepad clearfix">
<%
If objRs.Eof Then

	Response.Write("<div class=""warning""><div class=""messages""><span>Kayıt bulunamadı</span></div></div>")

Else
%>

<style type="text/css">
<--
	.table_list td {height:50px !important;}
-->
</style>

<table class="table_list">
	<thead>
		<tr>
			<th style="width:3% !important"><label style="display:block" for="toggle">#</label></th>
			<th style="width:3% !important"><input id="toggle" type="checkbox" /></th>
			<th style="width:4% !important">Fotoğraf</th>
			<th style="width:36% !important">Ürün Adı</th>
			<th style="width:6% !important">Ürün Kodu</th>
			<th style="width:5% !important">Fiyatı</th>
			<th style="width:5% !important"><a class="taskListSubmit" data-number="multi-selected" data-status="sort-order" data-apply="" href="#">Sırala</a></th>
			<th style="width:7% !important">Görünürlük</th>
			<th style="width:7% !important">Tarih</th>
			<th style="width:3% !important">Kimlik</th>
			<th style="width:3% !important">Hit</th>
			<th style="width:3% !important">Link</th>
			<th style="width:3% !important">Durum</th>
			<th style="width:3% !important">Vitrin</th>
			<th style="width:3% !important">Düzenle</th>
			<th style="width:3% !important">Sil</th>
		</tr>
	</thead>
	<tbody>
<%
Dim intUid, strUrunKodu, strShortText, intFiyat, intKatid, intStatus, intVitrin, strKategoriTitle
Dim strTypeTitle, intUrunHit, strPictureTitle, strPictureAlt, strPictureFull, OzelUrunName, CreateDate2

	intCounter = intLimitStart
	Do While Not objRs.Eof

		intCounter = intCounter + 1

		intUid = objRs("id")
		strTitle = KacKarekter(Cstr(objRs("title")), 80) ': If strTitle = "" Then strTitle = "( Başlık yok )"
		strUrunKodu = objRs("kodu")
		strShortText = objRs("short_text")
		intFiyat = objRs("fiyat")
		strPara = objRs("para")
		intKatid = objRs("anaid")
		intSiraNo = objRs("sira")
		intStatus = CBool(objRs("durum"))
		intVitrin = CBool(objRs("anasyf"))
		strTypeTitle = objRs("typetitle")' & ""
		If strTypeTitle = "" Then strTypeTitle = "Varsayılan"
		strTypeTitle = "<strong>Şablon :</strong> "& strTypeTitle '& varType(objRs("typetitle"))
		'intYeni = objRs("yeni")
		'strStok = objRs("stok")
		'strFlash = objRs("flash")
		intUrunHit = objRs("hit")
		strPictureTitle = objRs("img_title")
		strPictureAlt = objRs("alt")
		strPictureFull = pFolder(intUid, 0) & "/" & objRs("resim")
		strPicture = pFolder(intUid, 1) & "/" & objRs("resim")


		If FilesKontrol(strPicture) Then
			strPicture = "<a rel=""img-show"" href="""& strPictureFull &""" title="""& strPictureTitle &"""><img class=""products_image"" src="""& strPicture &""" title="""& strPictureTitle &""" alt="""& strPictureAlt &""" /></a>"
		Else
			strPicture = "<img class=""products_image"" src=""/images/blank.gif"" alt="""" style=""height:60px;"" />"
		End If


		'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
		strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""


		'// Title And Url
		If intStatus Then
			strTitle = "<a"& strDirection &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Products"), "", "", intUid, "", "") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"
		Else
			strTitle = "<span"& strDirection &" class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
		End If


		CreateDate = objRs("c_date")
		StartDate = objRs("s_date")
		EndDate = objRs("e_date")

		If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
		If Not isDate(StartDate) Then StartDate = Null
		If Not isDate(EndDate) Then EndDate = Null


		ZamanAsimi = ""
		If DateDiff("s", StartDate, Now()) <= 1 Then
			ZamanAsimi = "<span class=""red tooltip"" title=""Başlama Tarihi : "& StartDate &"""> ( Tarihi Bekliyor )</span>"
		ElseIf DateDiff("s", EndDate, Now()) >= 1 Then
			ZamanAsimi = "<span class=""red tooltip"" title=""Bitiş Tarihi : "& EndDate &"""> ( Zaman Aşımına Uğradı )</span>"
		'ElseIf isDate(objRs("s_date")) = False Then
		'    ZamanAsimi = "Başlangıç Belirtilmedi"
		'ElseIf isDate(objRs("e_date")) = False Then
		'    ZamanAsimi = "Bitiş Belirtilmedi"
		'ElseIf isDate(objRs("s_date")) = False And isDate(objRs("e_date")) = False Then
		'	ZamanAsimi = "Tarih Belirtilmedi"
		'Else
		'	ZamanAsimi = "Yayında"
		End If

		'If DateDiff("s", datem, Now()) <= 1 Then
		'	ZamanAsimi = "zamanı bekliyor"
		'ElseIf DateDiff("s", datem2, Now()) <= 1 Then
		'    ZamanAsimi = "zamanı bitti"
		'Else
		'    ZamanAsimi = "eski"
		'End If

		strKategoriTitle = ProductCategories(intKatid, 0, "")

		If strKategoriTitle <> "" Then
			strKategoriTitle = "<strong>Kategori :</strong> "& strKategoriTitle
		Else
			strKategoriTitle = "<strong class=""red"">Kategorize Edilmemiş</strong>"
		End If

Response.Write("	<tr id=""trid_"& intUid &""" class="""& TabloModClass(intCounter) &""">" & vbcrlf) 
Response.Write("		<td><label style=""display:block;"" for=""cb"& intCounter-1 &""">"& intCounter &"</label></td>" & vbcrlf) 
Response.Write("		<td><input id=""cb"& intCounter-1 &""" onclick=""isChecked("& intCounter-1 &")"" name=""postid[]"" value="""& intUid &""" type=""checkbox"" /></td>" & vbcrlf) 
Response.Write("		<td>"& strPicture &"</td>" & vbcrlf) 
Response.Write("		<td style=""height:70px !important"" class=""left"">" & vbcrlf)
Response.Write("			<div style=""height:70px !important; position: relative;"">" & vbcrlf) 
Response.Write("				<div style=""position: absolute; top: 3px;""><div"& strDirection &" style=""display:inline; font-size:12px;"" id=""u"& intUid &""">"& strTitle &"</div></div>" & vbcrlf) 
Response.Write("				<div style=""position: absolute; bottom: 3px;"">"& strTypeTitle &" <br />"& strKategoriTitle &"</div>" & vbcrlf) 
Response.Write("			</div>" & vbcrlf) 
'Response.Write("			<table style=""height:100% !important"">" & vbcrlf) 
'Response.Write("				<tr>" & vbcrlf) 
'Response.Write("					<td class=""left"" style=""height:50% !important; border:none !important""><div "& parent_dir &"style=""display:inline;"" id=""u"& intUid &""">"& strTitle &"</div></td>" & vbcrlf) 
'Response.Write("				</tr>" & vbcrlf) 
'Response.Write("				<tr>" & vbcrlf) 
'Response.Write("					<td class=""left"" style=""height:50% !important; border:none !important"">"& strKategoriTitle &"</td>" & vbcrlf) 
'Response.Write("				</tr>" & vbcrlf) 
'Response.Write("			</table>" & vbcrlf) 
Response.Write("		</td>" & vbcrlf) 
Response.Write("		<td>"& strUrunKodu &"</td>" & vbcrlf) 
Response.Write("		<td>"& intFiyat & " " & strPara &"</td>" & vbcrlf) 
Response.Write("		<td><input class=""inputbox list-order"" id=""order_"& intUid &""" name=""order[]"" value="""& intSiraNo &""" maxlength=""3"" type=""text"" /></td>" & vbcrlf) 
Response.Write("		<td>"& Gorunurluk(objRs("ozel")) &"</td>" & vbcrlf) 
Response.Write("		<td class=""left""><span class=""tooltip-text"" title="""& TarihFormatla(CreateDate2) &""">"& CreateDate &"</span></td>" & vbcrlf) 
Response.Write("		<td>"& intUid &"</td>" & vbcrlf) 
Response.Write("		<td>"& intUrunHit &"</td>" & vbcrlf)
Response.Write("		<td><a class=""url_list"" href=""?mod=url_list&amp;parent="& GlobalConfig("General_ProductsPN") &"&amp;parent_id="& objRs("id") & sLang & Debug &""" data-title="""& objRs("title") &""" title=""Permalink Ekle / Düzenle"">Permalink Ekle / Düzenle</a></td>" & vbcrlf) 
Response.Write("		<td id=""d"& intUid &"""><a class="""& StatusStyle(intStatus, "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a></td>" & vbcrlf) 
Response.Write("		<td id=""a"& intUid &"""><a class="""& StatusStyle(intVitrin, "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""frontpage"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a></td>" & vbcrlf) 
Response.Write("		<td><a class=""list-edit-icon"" href=""?mod="& mods &"&amp;task=edit&amp;id="& objRs("id") & sLang & Debug &""" title=""Düzenle"">Düzenle</a></td>" & vbcrlf) 
Response.Write("		<td><a class=""list-delete-icon taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a></td>" & vbcrlf) 
Response.Write("	</tr>" & vbcrlf) 

objRs.MoveNext() : Loop

%>	</tbody>
	<tfoot>
		<tr class="tfoot">
			<td colspan="16">
				<div>
					<span><label style="display:inline" for="limit">Görüntüle</label></span>
					<select name="limit" id="limit" size="1" onchange="submitform()" style="width:120px">
						<option value=""<%=eSelected(SayfaLimiti = "")%>>İşlem Seçiniz</option>
						<option value="5"<%=eSelected(SayfaLimiti = "5")%>>5</option>
						<option value="10"<%=eSelected(SayfaLimiti = "10")%>>10</option>
						<option value="25"<%=eSelected(SayfaLimiti = "25")%>>25</option>
						<option value="50"<%=eSelected(SayfaLimiti = "50")%>>50</option>
						<option value="100"<%=eSelected(SayfaLimiti = "100")%>>100</option>
						<option value="250"<%=eSelected(SayfaLimiti = "250")%>>250</option>
						<option value="500"<%=eSelected(SayfaLimiti = "500")%>>500</option>
					</select>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<%
Response.Write( Sayfala(ToplamCount, intSayfaSayisi, intSayfaNo) )
End If
%>

</div>
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
</form>
<%
Set objRs = Nothing
%>




<%ElseIf (task = "new" Or task = "edit") Then%>
<!--#include file="product/form.asp"-->


<%Else%>
	<div class="notepad clearfix">
		<div class="warning"><div class="messages"><span>Sayfa bulunamadı!</span></div></div>
	</div>


<%
End If

'End If
%>
