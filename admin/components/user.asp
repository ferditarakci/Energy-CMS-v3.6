<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo user">Kullanıcı yönetimi<%
	If task = "new" Then
		Response.Write("<small> &raquo; Yeni kayıt</small>")
	ElseIf task = "edit" Then
		Response.Write("<small> &raquo; Kayıt düzenle</small>")
	End If
%></td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
<%If GlobalConfig("admin_username") = GlobalConfig("super_admin") And task <> "hatali" Then%><li><a href="?mod=<%=mods%>&amp;task=hatali<%=sLang & Debug%>" title="Giriş Hataları"><span class="user_warning"></span>Giriş Hataları</a></li><%End If%>
<%If task = "" Then%>
					<li><a href="?mod=<%=mods%>&amp;task=new<%=sLang & Debug%>" title="Yeni kullanıcı ekle"><span class="user_add"></span>Yeni Kullanıcı</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan kullanıcıları aktif et"><span class="user_activate"></span>Aktif Et</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan kullanıcıları iptal et"><span class="user_deactivate"></span>Pasif Et</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan kullanıcıları sil"><span class="user_delete"></span>Kullanıcı Sil</a></li>
<%ElseIf (task = "new" Or task = "edit" Or task = "hatali") Then%>
					<%If Not task = "hatali" Then%><li><a id="form_submit" href="#" title="Kaydet"><span class="save"></span>Kaydet</a></li><%End If%>
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
	<table id="uye_list" class="table_list">
		<thead>
			<tr>
				<th style="width:3% !important"><div><label style="display:block;" for="toggle">#</label></div></th>
				<th style="width:3% !important"><div><input id="toggle" type="checkbox" /></div></th> 
				<th style="width:20% !important"><div>Adı&nbsp;Soyadı</div></th>
				<th style="width:8% !important"><div>Kullanıcı&nbsp;Adı</div></th>
				<th style="width:20% !important"><div>Mail&nbsp;Adresi</div></th>
				<th style="width:8% !important"><div>Kayıt&nbsp;Tarihi</div></th>
				<th style="width:8% !important"><div>Son&nbsp;Ziyaret</div></th>
				<th style="width:10% !important"><div>Üye&nbsp;Türü</div></th>
				<th style="width:10% !important"><div>Yetki</div></th>
				<th style="width:3% !important"><div>Hit</div></th>
				<th style="width:3% !important"><div>Kimlik</div></th>
				<th style="width:3% !important"><div>Durum</div></th>
				<th style="width:3% !important"><div>Düzenle</div></th>
				<th style="width:3% !important"><div>Sil</div></th>
			</tr>
		</thead>
		<tbody>
			<tr><td colspan="14">Yükleniyor...</td></tr>
		</tbody>
		<tfoot>
			<tr class="tfoot">
				<td colspan="14"></td>
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
	var dTable = $("#uye_list");

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
				{"mData": "isim", "sClass": "left"},
				{"mData": "kulad", "sClass": "left"},
				{"mData": "mail", "sClass": "left"},
				{"mData": "tarih", "sType": "date"},
				{"mData": "songiris", "sType": "date"},
				{"mData": "uyetipi"},
				{"mData": "yetki"},
				{"mData": "hit"},
				{"mData": "kimlik"},
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















<%ElseIf (task = "new" or task = "edit") Then%>
<!--#include file="user/form.asp"-->




<%ElseIf (task = "hatali") Then%>

<div class="notepad clearfix">
<%
SQL = "SELECT * FROM #___login_error ORDER BY id DESC;"
SQL = setQuery( SQL )
Set objRs = data.Execute( SQL )
If objRs.Eof Then

	Response.Write("<div class=""warning""><div class=""messages""><span>Kayıt bulunamadı</span></div></div>")

Else
%>
<table class="table_list">
	<thead>
		<tr>
			<th style="width:5% !important"><div>#</div></th>
			<th style="width:15% !important"><div>Kullanıcı Adı</div></th>
			<th style="width:15% !important"><div>Şifre</div></th>
			<th style="width:15% !important"><div>Tarih</div></th>
			<th style="width:5% !important"><div>Kimlik</div></th>
			<th style="width:45% !important"><div><span style="visibility:hidden">&nbsp;</span></div></th>
		</tr>
	</thead>
	<tbody>
<%
intCounter = 1
Do While Not objRs.Eof
%>
	<tr class="<%=TabloModClass(intCounter)%>">
		<td><%=intCounter%></td>
		<td class="left"><%=objRs("kulad")%></td>
		<td class="left"><%=objRs("pass")%></td>
		<td class="left"><%=TarihFormatla(objRs("tarih"))%></td>
		<td><%=objRs("id")%></td>
		<td><span style="visibility:hidden;">&nbsp;</span></td>
	</tr>
<%
intCounter = intCounter + 1
objRs.MoveNext() : Loop
%></tbody></table><%
End If
Set objRs = Nothing
%>
</div>



<%Else%>

	<div class="notepad clearfix">
		<div class="warning"><div class="messages"><span>Sayfa bulunamadı!</span></div></div>
	</div>


<%End If%>
