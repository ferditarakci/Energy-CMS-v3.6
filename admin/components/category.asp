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
		<td width="50%" class="pageinfo category">Kategori yönetimi<%
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
					<li><a href="?mod=<%=mods%>&amp;task=new<%=sLang & Debug%>" title="Yeni kategori ekle"><span class="category_add"></span>Yeni Kategori</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan kategorileri yayınla"><span class="category_activate"></span>Yayınla</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan kategorileri yayından kaldır"><span class="category_deactivate"></span>Kaldır</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan kategorileri sil"><span class="category_delete"></span>Sil</a></li>
<%ElseIf task = "new" Or task = "edit" Then%>
					<li><a class="iframe2" href="?mod=preview<%=sLang & Debug%>" title="Önizleme"><span class="preview"></span>Önizleme</a></li>
					<li><a id="form_submit" href="#" title="Kategoriyi kaydet"><span class="save"></span>Kaydet</a></li>
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
	For Each i in arrSearch : SearchSQL = SearchSQL & "t2.title like '%"& i &"%' Or " : Next
	SearchSQL = Left(SearchSQL, Len(SearchSQL) -4) & ")"
End If

'response.write typename(SearchSQL)




'// Tree View List
intCurr = 0
SQL = ""
SQL = SQL & "SELECT t1.id FROM #___kategori t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t1.anaid = {0} And t2.parent = "& GlobalConfig("General_CategoriesPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
SQL = SQL & "ORDER BY t1.sira ASC, t1.id DESC;"
Call TreeViewList(SQL, 0, 0)

If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")

%>
<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri")%>" method="post">

<div class="notepad clearfix">
<table>
	<tr>
		<td align="left"><%

intDurumTumu = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___kategori t1 INNER JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE t2.parent = "& GlobalConfig("General_CategoriesPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
intDurumAktif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___kategori t1 INNER JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE t1.durum = 1 And t2.parent = "& GlobalConfig("General_CategoriesPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
intDurumPasif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___kategori t1 INNER JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE t1.durum = 0 And t2.parent = "& GlobalConfig("General_CategoriesPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)
'intDurumCop = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___kategori t1 INNER JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE (t1.remove = -1 Or t1.remove = 1) And t2.lang = '"& GlobalConfig("site_lang") &"';", 0)	

%>
			<span style="float:right; margin-top:7px;">
				<a <%If ViewsiD = 0 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(0); submitform(); return false;" href="#">Tümü (<%=intDurumTumu%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 1 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(1); submitform(); return false;" href="#">Sadece Aktifler (<%=intDurumAktif%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 2 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(2); submitform(); return false;" href="#">Sadece Pasifler (<%=intDurumPasif%>)</a><!-- &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 3 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(3); submitform(); return false;" href="#">Çöptekiler (<%=intDurumCop%>)</a> -->
				<!--
					<select style="display:none;" name="views" id="views" size="1" style="width:250px" onchange="submitform()">
						<option value="0"<%=eSelected(ViewsiD = 0)%>>  --- Listele ---  </option>
						<option value="1"<%=eSelected(ViewsiD = 1)%>>A&#39;dan Z&#39;ye Sırala</option>
						<option value="2"<%=eSelected(ViewsiD = 2)%>>Z&#39;den A&#39;ya Sırala</option>
						<option value="3"<%=eSelected(ViewsiD = 3)%>>Anasayfa Olanlar</option>
						<option value="4"<%=eSelected(ViewsiD = 4)%>>Sadece Aktifler (<%=intDurumAktif%>)</option>
						<option value="5"<%=eSelected(ViewsiD = 5)%>>Sadece Pasifler (<%=intDurumPasif%>)</option>
						<option value="6"<%=eSelected(ViewsiD = 6)%>>Tarihe Göre Yeniden Eskiye</option>
						<option value="7"<%=eSelected(ViewsiD = 7)%>>Tarihe Göre Eskiden Yeniye</option> 
						<option value="8"<%=eSelected(ViewsiD = 8)%>>Çöptekiler (<%=intDurumCop%>)</option>
					</select>
				-->
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

'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count( t1.id ) As Toplam FROM #___kategori t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t2.parent = "& GlobalConfig("General_CategoriesPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "

Select Case ViewsiD
	Case 1 SQL = SQL & "And t1.durum = 1 " & vbCrLf
	Case 2 SQL = SQL & "And t1.durum = 0 " & vbCrLf
	Case 3 SQL = SQL & "And t1.remove = 1 " & vbCrLf
End Select

SQL = SQL & ""& SearchSQL &" "
SQL = SQL & ";"
ToplamCount = Cdbl(sqlQuery(SQL, 0))



'// Bilgisayara Cookie Bırakalım
Call getAdminCookie(mods)




'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "t1.id, t1.sira, t1.ozel, t1.durum, t1.activeLink, /*date_format(t1.c_date, '%d.%m.%Y') As*/ t4.DateTimes As c_date," & vbCrLf
SQL = SQL & "t2.title, t2.hit, t3.title As typetitle, (SELECT Count(id) FROM #___products WHERE anaid = t1.id) As ToplamUrun" & vbCrLf
SQL = SQL & "FROM #___kategori t1" & vbCrLf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_template t3 ON t1.typeAlias = t3.alias And (t3.parent = "& GlobalConfig("General_CategoriesPN") &" Or t3.parent = 0)" & vbCrLf
SQL = SQL & "LEFT JOIN #___content_revision_date t4 ON t1.id = t4.parent_id And t4.parent = "& GlobalConfig("General_CategoriesPN") &" And t4.Revizyon = 1" & vbCrLf
SQL = SQL & "WHERE " & vbCrLf
SQL = SQL & "t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = "& GlobalConfig("General_CategoriesPN") &" "& SearchSQL &"" & vbCrLf

Select Case ViewsiD
	Case 1 SQL = SQL & "And t1.durum = 1" & vbCrLf
	Case 2 SQL = SQL & "And t1.durum = 0" & vbCrLf
	Case 3 SQL = SQL & "And t1.remove = 1" & vbCrLf
End Select

If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(t1.id, "& TreeViewShort &") " & vbCrLf

SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi

SQL = SQL & ";"

'SQL = setQuery( SQL )

Set objRs = setExecute( SQL )





If objRs.Eof Then

	Response.Write("<div class=""warning""><div class=""messages""><span>Kayıt bulunamadı</span></div></div>")

Else

	Response.Write("<table class=""table_list"">" & vbcrlf) 
	Response.Write("	<thead>" & vbcrlf) 
	Response.Write("		<tr>" & vbcrlf) 
	Response.Write("			<th style=""width:3% !important""><label style=""display:block;"" for=""toggle"">#</label></th>" & vbcrlf) 
	Response.Write("			<th style=""width:3% !important""><input id=""toggle"" type=""checkbox"" /></th> " & vbcrlf) 
	Response.Write("			<th style=""width:38% !important"">Başlık</th>" & vbcrlf) 
	Response.Write("			<th style=""width:5% !important""><a class=""taskListSubmit"" data-number=""multi-selected"" data-status=""sort-order"" data-apply="""" href=""#"">Sırala</a></th>" & vbcrlf) 
	Response.Write("			<th style=""width:14% !important"">Şablon</th>" & vbcrlf) 
	Response.Write("			<th style=""width:6% !important"">Görünürlük</th>" & vbcrlf) 
	Response.Write("			<th style=""width:8% !important"">Tarih</th>" & vbcrlf) 
	Response.Write("			<th style=""width:3% !important"">Kimlik</th>" & vbcrlf) 
	Response.Write("			<th style=""width:3% !important"">Ürün</th>" & vbcrlf) 
	Response.Write("			<th style=""width:3% !important"">Hit</th>" & vbcrlf) 
	Response.Write("			<th style=""width:3% !important"">Link</th>" & vbcrlf) 
	'If ViewsiD <> 8 Then _
	Response.Write("			<th style=""width:3% !important"">Durum</th>" & vbcrlf) 
	'If ViewsiD = 8 Then _
	'Response.Write("			<th style=""width:3% !important"">Geri&nbsp;Yükle</th>" & vbcrlf) 
	'Response.Write("			<th style=""width:3% !important"">Ön&nbsp;Sayfa</th>" & vbcrlf) 
	Response.Write("			<th style=""width:3% !important"">Düzenle</th>" & vbcrlf) 
	'If ViewsiD <> 8 Then _
	'Response.Write("			<th style=""width:5% !important"">Çöp</th>" & vbcrlf) 
	'If ViewsiD = 8 Then _
	Response.Write("			<th style=""width:5% !important"">Sil</th>" & vbcrlf) 
	Response.Write("		</tr>" & vbcrlf) 
	Response.Write("	</thead>" & vbcrlf) 
	Response.Write("	<tbody>") 

	Dim ToplamUrun
	intCounter = intLimitStart
	Do While Not objRs.Eof

		intCounter = intCounter + 1 : intLevel = 0

		For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

		spaces = 1 * intLevel : tempSpaces = ""

		For y = 1 To spaces : tempSpaces = tempSpaces & "&ndash;&ndash;" : Next : If intLevel > 0 Then tempSpaces = tempSpaces & "&nbsp;"


		'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
		strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""

		strTitle = Cstr(objRs("title")) ': If strTitle = "" Then strTitle = "( Başlık yok )"

		If CBool(objRs("durum")) Then
			strTitle = "<a"& strDirection &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Categories"), "", "", Cdbl(objRs("id")), "", "") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"
		Else
			strTitle = "<span"& strDirection &" class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
		End If


		CreateDate = objRs("c_date")
		'StartDate = objRs("s_date")
		'EndDate = objRs("e_date")

		If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
		'If Not isDate(StartDate) Then StartDate = Null
		'If Not isDate(EndDate) Then EndDate = Null


		'ZamanAsimi = ""
		'If DateDiff("s", StartDate, Now()) <= 1 Then
		'	ZamanAsimi = "<span class=""red tooltip"" title=""Başlama Tarihi : "& StartDate &"""> ( Tarihi Bekliyor )</span>"
		'ElseIf DateDiff("s", EndDate, Now()) >= 1 Then
		'	ZamanAsimi = "<span class=""red tooltip"" title=""Bitiş Tarihi : "& EndDate &"""> ( Zaman Aşımına Uğradı )</span>"
		'ElseIf isDate(objRs("s_date")) = False Then
		'    ZamanAsimi = "Başlangıç Belirtilmedi"
		'ElseIf isDate(objRs("e_date")) = False Then
		'    ZamanAsimi = "Bitiş Belirtilmedi"
		'ElseIf isDate(objRs("s_date")) = False And isDate(objRs("e_date")) = False Then
		'	ZamanAsimi = "Tarih Belirtilmedi"
		'Else
		'	ZamanAsimi = "Yayında"
		'End If

		'If DateDiff("s", datem, Now()) <= 1 Then
		'	ZamanAsimi = "zamanı bekliyor"
		'ElseIf DateDiff("s", datem2, Now()) <= 1 Then
		'    ZamanAsimi = "zamanı bitti"
		'Else
		'    ZamanAsimi = "eski"
		'End If



		If objRs("ToplamUrun") = 0 Then 
			ToplamUrun = "<span class=""red"">0</span>"
		Else
			ToplamUrun = "<span class=""green"">"& objRs("ToplamUrun") &"</span>"
		End If


		Response.Write("<tr id=""trid_"& objRs("id") &""" class="""& TabloModClass(intCounter) &""">" & vbcrlf) 
		Response.Write("		<td><label style=""display:block;"" for=""cb"& intCounter-1 &""">"& intCounter &"</label></td>" & vbcrlf) 
		Response.Write("		<td><input id=""cb"& intCounter-1 &""" onclick=""isChecked("& intCounter-1 &")"" name=""postid[]"" value="""& objRs("id") &""" type=""checkbox"" /></td>" & vbcrlf) 
		Response.Write("		<td class=""left"">"& tempSpaces &" <div "& strDirection &"style=""display:inline;"" id=""u"& objRs("id") &""">"& strTitle &"</div></td>" & vbcrlf) 
		Response.Write("		<td><input class=""inputbox list-order"" id=""order_"& objRs("id") &""" name=""order[]"" value="""& objRs("sira") &""" maxlength=""3"" type=""text"" /></td>" & vbcrlf) 
		Response.Write("		<td class=""left nowrap"">"& objRs("typetitle") &"</td>" & vbcrlf) 
		Response.Write("		<td class=""nowrap"">"& Gorunurluk(objRs("ozel")) &"</td>" & vbcrlf) 
		Response.Write("		<td class=""nowrap""><span class=""tooltip-text"" title="""& TarihFormatla(objRs("c_date")) &""">"& CreateDate &"</span></td>" & vbcrlf) 
		Response.Write("		<td>"& objRs("id") &"</td>" & vbcrlf) 
		Response.Write("		<td>"& ToplamUrun &"</td>" & vbcrlf) 
		Response.Write("		<td>"& objRs("hit") &"</td>" & vbcrlf)
		Response.Write("		<td><a class=""url_list"" href=""?mod=url_list&amp;parent="& GlobalConfig("General_CategoriesPN") &"&amp;parent_id="& objRs("id") & sLang & Debug &""" data-title="""& objRs("title") &""" title=""Permalink Ekle / Düzenle"">Permalink Ekle / Düzenle</a></td>" & vbcrlf) ' onclick=""listItemTask("& intCounter-1 &", 'durum', '')""
		Response.Write("		<td id=""d"& objRs("id") &"""><a class="""& StatusStyle(objRs("durum"), "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a></td>" & vbcrlf) 
		Response.Write("		<td><a class=""list-edit-icon"" href=""?mod="& mods &"&amp;task=edit&amp;id="& objRs("id") & sLang & Debug &""" title=""Düzenle"">Düzenle</a></td>" & vbcrlf) 
		Response.Write("		<td><a class=""list-delete-icon taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a></td>" & vbcrlf) ' onclick=""if(confirm('Dikkat! #"& intCounter &" Numaralı Kayıt Silinecektir. Devam Edilsin mi?')){listItemTask("& intCounter-1 &", 'delete', '');}""
		Response.Write("	</tr>" & vbcrlf)
	objRs.MoveNext() : Loop
	%>
	</tbody>
	<tfoot>
		<tr class="tfoot">
			<td colspan="14">
				<div>
					<span><label style="display:inline" for="limit">Görüntüle</label></span>
					<select name="limit" id="limit" size="1" onchange="submitform()" style="width:120px">
						<option value=""<%=eSelected(SayfaLimiti = "")%>>İşlem Seçiniz</option>
						<option value="5"<%=eSelected(SayfaLimiti = "5")%>>5</option>
						<option value="10"<%=eSelected(SayfaLimiti = "10")%>>10</option>
						<option value="20"<%=eSelected(SayfaLimiti = "20")%>>20</option>
						<option value="30"<%=eSelected(SayfaLimiti = "30")%>>30</option>
						<option value="50"<%=eSelected(SayfaLimiti = "50")%>>50</option>
						<option value="100"<%=eSelected(SayfaLimiti = "100")%>>100</option>
						<option value="all"<%=eSelected(SayfaLimiti = "all")%>>Tümü</option>
					</select>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<%
'Response.Write( "Sayfala("& ToplamCount &", "& intSayfaSayisi &", "& intSayfaNo &")" )
Response.Write( Sayfala(ToplamCount, intSayfaSayisi, intSayfaNo) )
End If
Set objRs = Nothing 
%>
</div>
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
<input type="hidden" id="views" name="views" value="0" />
<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
</form>




<%ElseIf (task = "new" Or task = "edit") then%>
<!--#include file="category/form.asp"-->
<%
Call TinyMce()
%>
<%Else%>
	<div class="notepad clearfix">
		<div class="warning"><div class="messages"><span>Sayfa bulunamadı!</span></div></div>
	</div>


<%
End If

'End If
%>
