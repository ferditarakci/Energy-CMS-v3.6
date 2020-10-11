<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo design">Tema yönetimi</td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
					<li><a href="?mod=<%=GlobalConfig("General_Page") & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>
<style type="text/css">
	/*html { overflow:auto !important; }*/
	ol.text {margin:0 0 0 10px; padding:4px 0 4px 20px;}
	ol.text li {margin:0; padding:0px 0 0px 0px; font-size:12px; font-weight:700;}
</style>

<div class="notepad hidden">
	<table>
		<tr>
			<td width="100%" class="pageinfo design">Temalar&nbsp;<small></small></td>
			<td width="50%">
				<div class="toolbar-list">
					<ul class="clearfix">
						<li><a href="?mod=<%=GlobalConfig("General_Page") & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>
					</ul>
					<div class="clr"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
<%
'Set objRs = setExecute("SELECT id, title, durum, path, thumb FROM #___tema ORDER BY id ASC;")
OpenRs objRs, "SELECT id, title, durum, path, thumb, theme_text FROM #___tema ORDER BY sira, title ASC;"

If objRs.Eof Then

	Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Üye bilgileri bulunamadı.</span></div></div></div>")

Else
%>
<form id="Energy_Form_<%=SifreUret( 10 )%>" action="<%=GlobalConfig("site_uri")%>" method="post">

<div class="maincolumn" style="margin-right:0px;">
	<div class="maincolumn-body" style="margin-right:0px;">

		<div class="m_box">
			<div class="head clearfix">
				<div class="form-table clearfix">

<div id="ewy_themes" class="clearfix">
<%

While Not objRs.Eof
	imgPath = Replace(GlobalConfig("Tema_Dizin") & objRs("path") & "/" & objRs("thumb"), GlobalConfig("sDomain"), "")
	strActive = "" : If objRs("durum") Then strActive = " activeTheme"
	'If FilesKontrol(imgPath) Then
		imgPath = "<a class=""screenshot"" href="""& imgPath &""" target=""_blank""><img src="""& imgPath &""" alt="""" /></a>" & vbcrlf
	'Else
	'	imgPath = ""
	'End If
%>
	<div class="ewy_theme">
		<%=imgPath%>
		<h3><%=objRs("title")%></h3>
		<span class="action-links">
			<a href="?mod=redirect&amp;task=template_status&amp;id=<%=objRs("id")%>" id="template_<%=objRs("id")%>" class="activatelink<%=strActive%>" onclick="return false;" title="Bu Temayı Etkinleştirin.">Etkinleştir</a> |
			<a href="?mod=redirect&amp;task=tema_preview&amp;id=<%=objRs("id")%>" title="Bu Temanın Nasıl Göründüğününe Bakın." target="_blank">Önizleme</a> |
			<a class="theme_detay" href="#" title="Bu Temanın Açıklamalarını Görün." onclick="return false;">Detaylar</a>
		</span>
		<p class="theme_desc hidden"><%=objRs("theme_text")%></p>
	</div>
<%
objRs.MoveNext() : Wend
%>
</div>


				</div>
			</div>
		</div>
	</div>
</div>
</form>
<%
End If
CloseRs objRs
%>
<div class="maincolumn" style="margin-right:0px;">
	<div class="maincolumn-body" style="margin-right:0px;">
		<div class="m_box">
			<div class="head clearfix">
				<div class="form-table clearfix">
					<ol class="text">
						<li>Tema seçiminizi sayfalarınızı oluşturmadan önce yapmanızı öneririz, zira bazı temalarda slider ve sayfalar farklı görünümlere sebep olabilir.</li>
						<li>Tema önizlemelerini tema görüntüsü altında bulunan Önizleme bağlantısına tıklarak görebilirsiniz.</li>
						<li>Temaların üzerindeki Etkinleştir bağlantısına tıklayarak varsayılan tema seçimi yapailirsiniz.</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
/*<![CDATA[*/
$(document).ready(function(){
	$("#ewy_themes").disableSelection();
	$("#ewy_themes a.activatelink:not(.activeTheme)").live("click", function(e){
		//alert(/template_(\d+)/.exec($(this).attr("id"))[1]); return false;
		e.preventDefault();
		var $this = $(this);
		$.ajax({
			cache: false,
			type: "POST",
			url: $this.attr("href"),
			data: {},
			beforeSend: function() {
				Messages("loading", "Yeni tema ayarlanıyor, lütfen bekleyin.");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
			},
			success: function(veri) {
				setTimeout(function() {
					Messages("success", "<em class=\"red\">" + $this.parents(".ewy_theme").find("h3").text() + "</em> isimli tema varsayılan olarak ayarlandı.");
					$("#ewy_themes a.activatelink").removeClass("activeTheme");
					$this.addClass("activeTheme");
					
				}, 500); 
			}
		});
		
	});

	$("#ewy_themes a.theme_detay").click(function(e){
		e.preventDefault();
		var themeDesc = $(this).parent().parent().find(".theme_desc");
		if(themeDesc.text() != "") {themeDesc.toggle("blind");}
	});

	var $scShot = $("a.screenshot");
	if($scShot.length > 0) {
		$scShot.colorbox({rel:"screenshot", slideshow:true});
	}

});
/*]]>*/
</script>
