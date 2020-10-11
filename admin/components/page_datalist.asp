<%
If Request.QueryString("fileRemoved") = "true" Then FileRemoved()
%>
<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo page">İçerik yönetimi<%
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
					<li><a href="?mod=<%=mods%>&amp;task=new<%=sLang & Debug%>" title="Yeni içerik ekle"><span class="page_add"></span>Yeni İçerik</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan içeriği yayınla"><span class="page_activate"></span>Yayınla</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan içeriği yayından kaldır"><span class="page_deactivate"></span>Kaldır</a></li>
					<!--<li><a onclick="listItemTask('all', 'anasayfa', 'true')" href="#" title="Seçili olan içeriği anasayfada yayınla"><span class="icon-32-frontpage"></span>Ön Sayfa</a></li>
					<li><a onclick="listItemTask('all', 'anasayfa', 'false')" href="#" title="Seçili olan içeriği anasayfadan kaldır"><span class="icon-32-frontpage pasif"></span>Ön Sayfa</a></li>-->
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan içeriği sil"><span class="page_delete"></span>Sil</a></li>
<%ElseIf task = "new" Or task = "edit" Then%>
					<li><a class="iframe2" href="?mod=preview<%=sLang & Debug%>" title="Önizleme"><span class="preview"></span>Önizleme</a></li>
					<li><a id="form_submit" href="#" title="İçeriği kaydet"><span class="save"></span>Kaydet</a></li>
					<li><a href="?mod=<%=mods & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>    
<%End If%>
					<li><a href="?mod=<%=GlobalConfig("General_Comments")%>&amp;parent=<%=GlobalConfig("General_PagePN") & sLang & Debug%>" title="Yorumlar"><span class="comments"></span>Yorumlar</a></li>
					<li><a id="settings" href="?mod=<%=mods%>_settings<%=Debug%>" title="Ayarlar"><span class="settings"></span>Ayarlar</a></li>
<%If GlobalConfig("admin_username") = GlobalConfig("super_admin") Then%><li><a href="?mod=<%=mods & sLang & Debug%>&amp;fileRemoved=true" title="Giriş Hataları"><span class="delete"></span>Dosyaları Temizle</a></li><%End If%>
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
SQL = SQL & "SELECT t1.id FROM #___sayfa t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t1.anaid = {0} And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
SQL = SQL & "ORDER BY t1.sira ASC, t1.id DESC;"
Call TreeViewList(SQL, 0, 0)

If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")

%>

<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri")%>" method="post">

<div class="notepad clearfix">
<table>
	<tr>
		<td align="left" id="filter-and-length-append"><%

'intDurumTumu = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 INNER JOIN #___content t2 ON t1.id = t2.parent_id WHERE t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
'intDurumAktif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 INNER JOIN #___content t2 ON t1.id = t2.parent_id WHERE t1.durum = 1 And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
'intDurumPasif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 INNER JOIN #___content t2 ON t1.id = t2.parent_id WHERE t1.durum = 0 And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)
	'intDurumCop = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 INNER JOIN #___content t2 ON t1.id = t2.parent_id WHERE t1.remove = 1 And t2.lang = '"& GlobalConfig("site_lang") &"';", 0)	

%>
			<!--
			<span style="float:right; margin-top:7px;">
				<a <%If ViewsiD = 0 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(0); submitform(); return false;" href="#">Tümü (<%=intDurumTumu%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 1 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(1); submitform(); return false;" href="#">Sadece Aktifler (<%=intDurumAktif%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
				<a <%If ViewsiD = 2 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(2); submitform(); return false;" href="#">Sadece Pasifler (<%=intDurumPasif%>)</a>
			</span>
			-->

			<!--
			<input class="inputbox" name="search" id="search" value="<%=inputSearch%>" type="text" size="30" />
			<button class="btn search-button" type="button">Ara</button>
			-->
			<button class="btn reset-button" type="button">Temizle</button>
		</td>
	</tr>
</table>
</div>

<div class="notepad clearfix">
<table id="page_table_list" class="table_list">
	<thead>
		<tr>
			<th class="nosort" style="width:3% !important"><label style="display:block;" for="toggle">#</label></th>
			<th style="width:3% !important"><input id="toggle" type="checkbox" /></th> 
			<th style="width:47% !important"><div>Başlık</div></th>
			<th style="width:5% !important"><div><a class="taskListSubmit" data-number="multi-selected" data-status="sort-order" data-apply="" href="#">Sırala</a></div></th>
			<th style="width:14% !important"><div>İçerik Şablonu</div></th>
			<th style="width:8% !important"><div>Ouşturma&nbsp;Tarihi</div></th>
			<th style="width:3% !important"><div>Kimlik</div></th>
			<th style="width:3% !important"><div>Hit</div></th>
			<th style="width:3% !important"><div>Yorum</div></th>
			<th style="width:3% !important">Link</th>
			<th style="width:3% !important">Durum</th>
			<th style="width:3% !important">Düzenle</th>
			<th style="width:5% !important">Sil</th>
		</tr>
	</thead>
	<tbody>
		<tr><td colspan="13">Yükleniyor...</td></tr>
	</tbody>
	<tfoot>
		<tr class="tfoot">
			<td colspan="13">
				<div>
					<!--
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
					-->
				</div>
			</td>
		</tr>
	</tfoot>
</table>
</div>
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:absolute !important; left:-9999px !important;" />
<input type="hidden" id="views" name="views" value="0" />
<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
</form>



<script type="text/javascript">
/*<![CDATA[*/
jQuery(function( $ ) {
	var dTable = $("#page_table_list");

	if(dTable.length > 0) {
		var oTable = dTable.dataTable({
			"sDom": "ltfpi\"<\"clear\">\"",
			"bFilter": true,
			"bSort": false,
			"bJQueryUI": false,
			"bAutoWidth": false,
			"aLengthMenu": [ [5, 10, 15, 25, 50, 100, 250, 500, -1], [5, 10, 15, 25, 50, 100, 250, 500, "Tümünü Görüntüle"] ],
			"iDisplayLength": 5,
			"oLanguage": {
				"sLengthMenu": "Görüntüle : _MENU_",
				"sZeroRecords": "Üzgünüz, hiç sonuç bulamadık.",
				"sInfo": "Toplam _TOTAL_ kayıttan _START_ arası _END_ görüntüleniyor.",
				"sInfoEmpty": "Hiç kayıt bulunamadı.",
				"sInfoFiltered": "(filtered from _MAX_ total records)",
				"sProcessing": "Lütfen Bekleyin...",
				"sInfoPostFix": "",
				"sSearch": "Süzgeç : ",
				"sUrl": "",
				"oPaginate": { "sFirst": "İlk", "sPrevious": "Önceki", "sNext": "Sonraki", "sLast": "Son" }
			},
			"sPaginationType": "full_numbers",
			"bStateSave": true,
			"bServerSide": true,
			"sServerMethod": "POST",
			"sAjaxSource": "?mod=list_json&task=" + GlobalModValue + GlobalLangValue + GlobalDebug,
			"aoColumns": [
				{"mData": "counter", "bSearchable": false, "bSortable": false},
				{"mData": "checkbox", "sClass": "vTop", "bSearchable": false, "bSortable": false},
				{"mData": "baslik", "sClass": "left"},
				{"mData": "sira", "sType": "numeric", "bSearchable": false},
				{"mData": "tema", "sClass": "left"},
				{"mData": "tarih", "sType": "date"},
				{"mData": "kimlik", "sType": "numeric"},
				{"mData": "hit", "sType": "numeric", "bSearchable": false},
				{"mData": "yorum", "sType": "numeric", "bSearchable": false},
				{"mData": "link", "bSearchable": false, "bSortable": false},
				{"mData": "durum", "bSearchable": false, "bSortable": false},
				{"mData": "edit", "bSearchable": false, "bSortable": false},
				{"mData": "sil", "bSearchable": false, "bSortable": false}
			]
		});

		$(".reset-button").click(function(e) {
			e.preventDefault();
			$(".dataTables_filter").find("input:text").click().val("");
			oTable.fnFilter("");
			//window.onbeforeunload = null;
			$(window).unbind("beforeunload");
		});

		// DataTable Custom Navigation
		$("#page_table_list tfoot td").append($(".dataTables_paginate"), $(".dataTables_info"));

		// DataTable Custom Search
		$("#filter-and-length-append").append(
			$(".dataTables_length"),
			$(".dataTables_filter"),
			$(".dataTables_filter").append(
				$("#filter-and-length-append button")
			)
		).find("input:text").addClass("inputbox");

		$(".dataTables_length select").selectBox();
	}
});
/*]]>*/
</script>









<%ElseIf (task = "new" Or task = "edit") Then%>
<!--#include file="page/form.asp"-->


<%Else%>
	<div class="notepad clearfix">
		<div class="warning"><div class="messages"><span>Sayfa bulunamadı!</span></div></div>
	</div>


<%End If%>
