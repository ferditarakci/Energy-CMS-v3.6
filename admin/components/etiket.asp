
<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo page">Etiketler<%
			'If task = "new" Then
			'	Response.Write("<small> &raquo; Yeni kayıt</small>")
			'ElseIf task = "edit" Then
			'	Response.Write("<small> &raquo; Kayıt düzenle</small>")
			'End If
		%></td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan içeriği yayınla"><span class="page_activate"></span>Aktif Yap</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan içeriği yayından kaldır"><span class="page_deactivate"></span>Pasif Yap</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan içeriği sil"><span class="page_delete"></span>Toplu Sil</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>




<div style="margin-right: -515px;" class="maincolumn">
	<div style="margin-right: 510px;" class="maincolumn-body">

		<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri")%>" method="post">

			<div style="margin-top:0;" class="notepad clearfix">
				<table>
					<tr>
						<td align="left" id="filter-and-length-append">	
							<button class="btn reset-button" type="button">Temizle</button>
						</td>
					</tr>
				</table>
			</div>

			<div style="margin-top:0;" class="notepad clearfix">
				<table id="etiket_list" class="table_list">
					<thead>
						<tr>
							<th style="width:5% !important"><div><label for="toggle">#</label></div></th>
							<th style="width:5% !important"><div><input id="toggle" type="checkbox" /></div></th> 
							<th style="width:58% !important"><div>Etiket</div></th>
							<th style="width:8% !important"><div>Kimlik</div></th>
							<th style="width:8% !important"><div>Durum</div></th>
							<th style="width:8% !important"><div>Düzenle</div></th>
							<th style="width:8% !important"><div>Sil</div></th>
						</tr>
					</thead>
					<tbody>
						<tr><td colspan="7">Yükleniyor...</td></tr>
					</tbody>
					<tfoot>
						<tr class="tfoot">
							<td colspan="7">
								<div>
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

	</div>
</div> <!-- /leftcolumn -->

<div style="width:503px;" class="rightcolumn">

	<div class="m_box">
		<div class="title"><h3 class="box-title">Etiket Ekle / Düzenle</h3></div>
		<div class="head clearfix">
			<div class="form-table clearfix">
				<form id="etiket_save" action="?mod=post&amp;task=<%=mods & sLang & Debug%>" target="_blank" method="post">
					<div class="row clearfix">
						<div class="l"><label for="title_" style="padding-left:5px; font-style:normal;"><span>:</span>Etiket</label></div>
						<div class="r">
							<span class="relative">
								<input style="width:300px;" class="inputbox title" name="title_" id="title_" value="" title="Bu alana etiketinizi girin. Maks. 60 karakter eklenebilir." maxlength="60" type="text" />
								<a style="position: absolute; top: 2px; right:-18px; *top: 10px;" class="tooltip" tabindex="-1" href="#" title="Etiketler SEO açısından önemlidir. <br />Sayfa içeriğiyle ile etiketleri ilişkilendirerek arama sonuçlarında daha çok bulunabilirsiniz. <br />Arama motorlarında başlıklar maksimun 60 karakter ile sınırlıdır, uzun başlıklar girmeniz önerilmez.">&nbsp;</a>
							</span>
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="permalink" style="padding-left:5px; font-style:normal;"><span>:</span>Permalink</label></div>
						<div class="r">
							<span class="relative">
								<input style="width:300px;" class="inputbox seflink" name="permalink" id="permalink" value="" autocomplete="off" maxlength="60" type="text" />
								<a style="position: absolute; top: 2px; right:-18px; *top: 10px;" class="tooltip" tabindex="-1" href="#" title="Permalink etiket sayfasının kalıcı bağlantısıdır. <br />Tümü küçük harflerden, rakam ve tire'den oluşur. Kısa ve okunaklı bağlantı isimleri önerilir. <br />Maksimun 60 karekter girilebilir.">&nbsp;</a>
							</span>
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="durum" style="padding-left:5px; font-style:normal;"><span>:</span>Aktif / Pasif</label></div>
						<div class="r">
							<span class="relative">
								<input style="margin-top:8px;" name="durum" id="durum" value="1" type="checkbox" />
								<a style="position: absolute; top:20px; right:-17px; *top:10px;" class="tooltip" tabindex="-1" href="#" title="Seçimi kaldırıp pasif ettiğiniz taktirde ön sayfada bu etiketin sayfasına ulaşılamayacaktır.">&nbsp;</a>
							</span>
						</div>
					</div>
					<div class="row clearfix">
						<div class="l"><label for="title_status" style="padding-left:5px; font-style:normal;"><span>:</span>Robotlar</label></div>
						<div class="r">
							<span class="relative">
								<select name="robots_meta" id="robots_meta" size="1" style="width:285px;">
									<option value="" selected="selected">Genel Ayarları Kullan</option>
									<option value="index, follow">İndeksle, Takip et &quot;index, follow&quot;</option>
									<option value="noindex, follow">İndeksleme, takip et &quot;noindex, follow&quot;</option>
									<option value="index, nofollow">İndeksle, Takip etme &quot;index, nofollow&quot;</option>
									<option value="noindex, nofollow">İndeksleme, takip etme &quot;noindex, nofollow&quot;</option>
								</select>
								<a style="position: absolute; top:3px; right:-17px; *top:10px;" class="tooltip" tabindex="-1" href="#" title="Arama motorları / Google'ın sayfanızda nasıl davranması gerektiğini belirleyin.">&nbsp;</a>
							</span>
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="description" style="padding-left:5px; font-style:normal;"><span>:</span>Kısa Açıklama (Description)</label></div>
						<div class="r">
							<span class="relative">
								<textarea style="margin-top:3px; width:100%; height:50px;" class="min" name="description" id="description" maxlength="160"></textarea>
								<a style="position: absolute; top: 2px; right:-18px; *top: 10px;" class="tooltip" tabindex="-1" href="#" title="Arama motorları için kısa bir açıklama girin. <br />Maksimun 160 karekter.">&nbsp;</a>
							</span>
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="keywords" style="padding-left:5px; font-style:normal;"><span>:</span>Anahtar Kelime (Keywords)</label></div>
						<div class="r">
							<span class="relative">
								<textarea style="margin-top:3px; width:100%; height:50px;" class="min" name="keywords" id="keywords" maxlength="200"></textarea>
								<a style="position: absolute; top: 2px; right:-18px; *top: 10px;" class="tooltip" tabindex="-1" href="#" title="Arama motorları için anahtar kelimeler girin. <em>(Örnek: hp laptop, casper laptop)</em> <br />Maksimun 200 karekter.">&nbsp;</a>
							</span>
						</div>
					</div>

					<div class="row clearfix" style="position: relative;">
						<img id="save-loading" style="display:none; position:absolute; right:125px; top:11px;" src="<%=GlobalConfig("vRoot")%>images/loading.gif" alt="Lütfen Bekleyin..." />
						<button class="btn" style="float:right; margin-right:17px;" onclick="window.onbeforeunload = null; $('#etiket_save').submit();" type="button">Etiketi Kaydet</button>
						<button class="btn" style="float:left; margin-left:4px;" id="EditEnergyTagFormReset" type="button">Formu Temizle / Yeni Ekle</button>
						<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
					</div>
					<input name="pageid" value="0" type="hidden" />
				</form>
			</div>
		</div>
	</div>

</div> <!-- /rightcolumn -->

<script type="text/javascript">
/*<![CDATA[*/
jQuery(function( $ ) {
	var dTable = $("#etiket_list");

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
				{"mData": "etiket", "sClass": "left"},
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
