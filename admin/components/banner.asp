<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo banner">Banner yönetimi<%
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
					<li><a href="?mod=<%=mods%>&amp;task=new<%=sLang & Debug%>" title="Yeni banner ekle"><span class="banner_add"></span>Yeni Banner</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan bannerları yayınla"><span class="banner_activate"></span>Yayınla</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan bannerları yayından kaldır"><span class="banner_deactivate"></span>Kaldır</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan bannerları sil"><span class="banner_delete"></span>Sil</a></li>
<%ElseIf task = "new" Or task = "edit" Then%>
					<li><a id="form_submit" href="#" title="Kaydet"><span class="save"></span>Kaydet</a></li>
					<li><a href="?mod=<%=mods & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>    
<%
End If

If GlobalConfig("admin_username") = GlobalConfig("super_admin") Then
%>
					<li><a id="settings" href="?mod=<%=mods%>_settings<%=Debug%>" title="Ayarlar"><span class="settings"></span>Ayarlar</a></li>
<%
End If
%>				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>


<%
If task = "" Then
%>
<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri")%>" method="post">

<div class="notepad clearfix">
<table>
	<tr>
		<td>
			<span style="float:right;">
				<select name="views" id="views" size="1" style="width:250px" onchange="submitform()">
					<option value="0"<%=eSelected(ViewsiD = 0)%>>  --- Listele ---  </option>
					<option value="1"<%=eSelected(ViewsiD = 1)%>>A&#39;dan Z&#39;ye Sırala</option>
					<option value="2"<%=eSelected(ViewsiD = 2)%>>Z&#39;den A&#39;ya Sırala</option>
					<option value="3"<%=eSelected(ViewsiD = 3)%>>Sadece Aktifler</option>
					<option value="4"<%=eSelected(ViewsiD = 4)%>>Sadece Pasifler</option>
					<option value="5"<%=eSelected(ViewsiD = 5)%>>Tarihe Göre Yeniden Eskiye</option>
					<option value="6"<%=eSelected(ViewsiD = 6)%>>Tarihe Göre Eskiden Yeniye</option>
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
<table id="anket_list" class="table_list">
	<thead>
		<tr>
			<th style="width:3% !important"><label for="toggle">#</label></th>
			<th style="width:3% !important"><input id="toggle" type="checkbox" /></th> 
			<th style="width:55% !important">Başlık</th>
			<th style="width:5% !important"><a class="taskListSubmit" data-number="multi-selected" data-status="sort-order" data-apply="" href="#">Sırala</a></th>
			<th style="width:3% !important">Resim</th>
			<th style="width:8% !important">Tarih</th>
			<th style="width:5% !important">Tıklanma</th>
			<th style="width:6% !important">Yer</th>
			<th style="width:3% !important">Kimlik</th>
			<th style="width:3% !important">Durum</th>
			<th style="width:3% !important">Düzenle</th>
			<th style="width:3% !important">Sil</th>
		</tr>
	</thead>			
	<tbody>
		<tr><td colspan="12">Yükleniyor...</td></tr>
	</tbody>
	<tfoot>
		<tr class="tfoot">
			<td colspan="12"></td>
		</tr>
	</tfoot>
</table>
</div>

<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
</form>




<script type="text/javascript">
/*<![CDATA[*/
jQuery(function( $ ) {
	var dTable = $("#anket_list");

	if(dTable.length > 0) {
		// POST data to server
		var oTable = dTable.dataTable({
			"sDom": "ltfpi\"<\"clear\">\"",
			"bFilter": true,
			"bSort": true,
			"bJQueryUI": false,
			"bAutoWidth": false,
			"aLengthMenu": [[5, 10, 15, 25, 50, 100, 250, 500, -1], [5, 10, 15, 25, 50, 100, 250, 500, "Tümünü Görüntüle"]],
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
			"bServerSide": true,//arrBannerList(counter, title, sira, resim, tarih, hit, yer, kimlik, durum)
			"sServerMethod": "POST",
			"sAjaxSource": "?mod=list_json&task=" + GlobalModValue + GlobalLangValue + GlobalDebug + "",
			"aaSorting": [[ 2, "asc" ]],
			"aoColumns": [
				{"mData": "counter", "bSearchable": false, "bSortable": false},
				{"mData": "checkbox", "sClass": "vTop", "bSearchable": false, "bSortable": false},
				{"mData": "title", "sClass": "left"},
				{"mData": "sira", "sType": "numeric", "bSearchable": false},
				{"mData": "resim", "sType": "html"},
				{"mData": "tarih", "sType": "date"},
				{"mData": "hit", "sType": "numeric"},
				{"mData": "yer"},
				{"mData": "kimlik", "sType": "numeric"},
				{"mData": "durum", "bSearchable": false, "bSortable": false},
				{"mData": "edit", "bSearchable": false, "bSortable": false},
				{"mData": "sil", "bSearchable": false, "bSortable": false}
			]
		});
		$(".reset-button").click(function(e) {
			e.preventDefault();
			$(".dataTables_filter").find("input:text").click().val("");
			oTable.fnFilter("");
			$(window).unbind("beforeunload");
		});

		// DataTable Custom Navigation
		$("tfoot td", dTable).append($(".dataTables_paginate"), $(".dataTables_info"));

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





<script type="text/javascript">
/*<![CDATA[*/
	$(document).ready(function() {
		$(".poll_frames").delegate("a", "click", function(e) {
			e.preventDefault();
			$(this).colorbox({innerWidth: 500, innerHeight:400, iframe:true});
		});
	});
/*]]>*/
</script>

<%ElseIf (task = "new"  or task = "edit") Then%>
<!--#include file="banner/form.asp"-->



<%Else%>
	<div class="notepad clearfix">
		<div class="warning"><div class="messages"><span>Sayfa bulunamadı!</span></div></div>
	</div>


<%End If%>
