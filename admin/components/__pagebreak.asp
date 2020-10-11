<!--#include file="header.asp"-->
<style type="text/css"><!--
/*html{overflow:hidden !important;}*/
--></style>
</head>
<body>
	<script type="text/javascript">
	//<![CDATA[
		function SayfaSonuEkle() {
			var title = document.getElementById("title");
			if (title.value == '') {
				title.focus();
				alert('Sayfa sonu ekleyebilmeniz için başlık giriniz.');
				return false;
			}
			else {
				var tag = "<hr class=\"system-pagebreak\" title=\"" + title.value + "\" \/><br />";
				window.parent.jInsertEditorText(tag, "<%=Request.QueryString("e_name")%>");
				window.parent.$.colorbox.close();
				return false;
			}
		}
	//]]>
	</script>
	<form onsubmit="return SayfaSonuEkle();">
		<table align="center" style="margin:15px auto 0;">
			<tr>
				<td align="right">
					<label style="font-weight:bold;" for="title">Başlık <span class="red">Maks. (30)</span> :</label>
				</td>
				<td style="padding-left:2px;">
					<input style="width:200px;" class="inputbox" id="title" name="title" maxlength="30" type="text" />
				</td>
				<td style="padding-left:2px;">
					<button class="btn" type="submit">Ekle</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
