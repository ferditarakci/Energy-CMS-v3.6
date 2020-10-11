<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo chart">Anket yönetimi<%
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
					<li><a href="?mod=<%=mods%>&amp;task=new<%=sLang & Debug%>" title="Yeni anket ekle"><span class="chart_add"></span>Yeni Anket</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan anketi yayınla"><span class="chart_activate"></span>Yayınla</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan anketi yayından kaldır"><span class="chart_deactivate"></span>Kaldır</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olanları sil"><span class="chart_delete"></span>Sil</a></li>
<%ElseIf task = "new" or task = "edit" Then%>
					<li><a id="form_submit" href="#" title="Anketi kaydet"><span class="save"></span>Kaydet</a></li>
					<li><a href="?mod=<%=mods & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>    
<%End If%>
				</ul>
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
		<td align="left" id="filter-and-length-append">
			<button class="btn reset-button" type="button">Temizle</button>
		</td>
	</tr>
</table>
</div>


<div class="notepad clearfix">
<table id="anket_list" class="table_list">
	<thead>
		<tr>
			<th style="width:3% !important"><div><label style="display:block;" for="toggle">#</label></div></th>
			<th style="width:3% !important"><div><input id="toggle" type="checkbox" /></div></th> 
			<th style="width:43% !important"><div>Anket Sorusu</div></th>
			<th style="width:5% !important"><div><a class="taskListSubmit" data-number="multi-selected" data-status="sort-order" data-apply="" href="#">Sırala</a></div></th>
			<th style="width:8% !important"><div>Tarih</div></th>
			<th style="width:3% !important"><div>Kimlik</div></th>
			<th style="width:3% !important"><div>Seçenek</div></th>
			<th style="width:3% !important"><div>Link</div></th>
			<th style="width:3% !important"><div>Durum</div></th>
			<th style="width:3% !important"><div>Düzenle</div></th>
			<th style="width:3% !important"><div>Sil</div></th>
		</tr>
	</thead>			
	<tbody>
		<tr><td colspan="11">Yükleniyor...</td></tr>
	</tbody>
	<tfoot>
		<tr class="tfoot">
			<td colspan="11"></td>
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
			"bServerSide": true,
			"sServerMethod": "POST",
			"sAjaxSource": "?mod=list_json&task=" + GlobalModValue + GlobalLangValue + GlobalDebug + "",
			"aaSorting": [[ 2, "asc" ]],
			"aoColumns": [
				{"mData": "counter", "bSearchable": false, "bSortable": false},
				{"mData": "checkbox", "sClass": "vTop", "bSearchable": false, "bSortable": false},
				{"mData": "title", "sClass": "left"},
				{"mData": "sira", "sType": "numeric", "bSearchable": false},
				{"mData": "tarih", "sType": "date"},
				{"mData": "kimlik", "sType": "numeric"},
				{"mData": "secenek", "sType": "numeric"},
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

<%ElseIf (task = "new" Or task = "edit") Then%>
<!--#include file="poll/form.asp"-->



<%Else%>
	<div class="notepad clearfix">
		<div class="warning"><div class="messages"><span>Sayfa bulunamadı!</span></div></div>
	</div>


<%End If%>
