<!--#include file="header.asp"-->
		<style type="text/css">
			/*html { overflow:auto !important; }*/
			ol.text {margin:0 0 0 10px; padding:4px 0 4px 20px;}
			ol.text li {margin:0; padding:0px 0 0px 0px; font-size:12px; font-weight:700;}
		</style>
	</head>
	<body>
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
		OpenRs objRs, "SELECT id, title, durum, path, thumb FROM #___tema ORDER BY id ASC;"

		If objRs.Eof Then

			Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Üye bilgileri bulunamadı.</span></div></div></div>")

		Else
		%>
		<form id="Energy_Form_<%=SifreUret( 10 )%>" action="<%=GlobalConfig("site_uri")%>" method="post">

		<div class="maincolumn" style="margin-right:0px">
			<div class="maincolumn-body" style="margin-right:0px">

				<div class="m_box">
					<div class="title"><span class="refresh"><a href="#" onclick="window.location.reload(); return false;" title="Yenile">Yenile</a></span> <h3 class="box-title">Temaları önizleme yapmak için küçük resimlere tıklayın...</h3></div>
					<div class="head clearfix">
						<div class="form-table clearfix">

		<ul class="templates clearfix">
		<%

		While Not objRs.Eof
			strPicture = Replace(GlobalConfig("Tema_Dizin") & objRs("path") & "/" & objRs("thumb"), GlobalConfig("sDomain"), "")
			'Response.Write strPicture
			If FilesKontrol(strPicture) Then
				strPicture = "<a class=""tooltip_images"" href=""?mod=redirect&amp;task=tema_preview&amp;id="& objRs("id") &""" target=""_blank"" title="""& Server.HtmlEncode("Bu temayı görüntülemek için küçük resimlere tıklayın...<br /><img src="""& strPicture &""" />") &"""><img src="""& strPicture &""" style=""max-width:150px; max-height:150px;"" /></a>" & vbcrlf
			Else
				strPicture = ""
			End If

			strChecked = "" : If objRs("durum") Then strChecked = " checked"

			Response.Write("	<li id=""template_"& objRs("id") &""">" & vbcrlf)
			Response.Write("			<div class=""contents"">" & vbcrlf)
			Response.Write(strPicture)
			Response.Write("		<a href=""#"" class=""template_status"& strChecked &""" title=""Temayı kullan"">Temayı kullan</a>" & vbcrlf)

			'Response.Write("		<div class=""name"" style=""z-index:1;"">" & vbcrlf)
			'Response.Write("			<span>"& objRs("title") &"</span>" & vbcrlf)
			'Response.Write("			<br />" & vbcrlf)
			'Response.Write("			<select id=""modul-yer_"& objRs("id") &""" class=""modul-yeri"" size=""1"">" & vbcrlf)
			'Response.Write("				<option value=""sag"">Sağ'da Göster</option>" & vbcrlf)
			'Response.Write("				<option selected=""selected"" value=""sol"">Sol'da Göster</option>" & vbcrlf)
			'Response.Write("			</select>" & vbcrlf)
			'Response.Write("		</div>" & vbcrlf)
			Response.Write("		</div>" & vbcrlf)
						Response.Write("			<div class=""titles"">"& objRs("title") &"</div>" & vbcrlf)

			Response.Write("	</li>" & vbcrlf)

		objRs.MoveNext() : Wend
		%></ul>

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
		<div class="maincolumn" style="margin-right:0px">
			<div class="maincolumn-body" style="margin-right:0px">
				<div class="m_box">
					<div class="head clearfix">
						<div class="form-table clearfix">
							<ol class="text">
								<li>Tema seçiminizi sayfalarınızı oluşturmadan önce yapmanızı öneririz, zira bazı temalar slider ve sayfalarda farklı görünümlere sebep olabilir.</li>
								<li>Tema önizlemelerini küçük resimlere tıklayarak yapabilirsiniz.</li>
								<li>Temaların üzerinde ki Aktif/Pasif ikonlarına tıklayarak varsayılan tema seçimi yapailirsiniz.</li>
							</ol>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		/*<![CDATA[*/
		$(document).ready(function(){
			$(".template_status:not(.checked)").live("click", function(e){
				e.preventDefault();
				var $this = $(this);
				var $id = /template_(\d+)/.exec($this.parents("li").attr("id"))[1]; //alert($id)
				$.ajax({
					cache: false,
					type: "POST",
					url: "?mod=redirect&task=template_status&id=" + $id,
					data: {},
					beforeSend: function() {
						window.parent.Messages("loading", "Yeni tema ayarlanıyor, lütfen bekleyin.");
					},
					error: function(xhr, ajaxOptions, thrownError) {
						window.parent.ErrorMessages("Hay aksi! işlem yapılırken bir hata oluştu.", xhr.responseText);
					},
					success: function(veri) {
						setTimeout(function() {
							window.parent.Messages("success", "<em class=\"red\">" + $this.parents("li").find(".titles").text() + "</em> isimli tema varsayılan olarak ayarlandı.");
							$(".template_status.checked").removeClass("checked");
							$this.toggleClass("checked")/*.parents("ul").prepend($this.parents("li").remove().clone())*/;
							
						}, 800); 
					}
				});
			});
		});
		/*]]>*/
		</script>
	</body>
</html>
