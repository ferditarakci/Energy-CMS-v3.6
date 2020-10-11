<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo">Whois sorgulamaları</td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan alan adlarını sil"><span class="delete"></span>Sil</a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Page") & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>
<%

If task = "" Then


'// Toplam Kayıt Sayısını Alalım
ToplamCount = Cdbl(sqlQuery("SELECT Count( id ) As Toplam FROM #___whois;", 0))




'// Bilgisayara Cookie Bırakalım
Call getAdminCookie(mods)




'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT * FROM #___whois ORDER BY Starih DESC "
SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi
SQL = SQL & ";"

'SQL = setQuery( SQL )

Set objRs = setExecute( SQL )

%>
<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri")%>" method="post">
<div class="notepad clearfix">
<%
If objRs.Eof Then

	Response.Write("<div class=""warning""><div class=""messages""><span>Kayıt bulunamadı</span></div></div>")

Else
%>
<table class="table_list">
	<thead>
		<tr>
			<th style="width:3% !important"><label style="display:block;" for="toggle">#</label></th>
			<th style="width:3% !important"><input id="toggle" type="checkbox" /></th> 
			<th style="width:40% !important">Domain Adı</th>
			<th style="width:32% !important">Durumu</th>
			<th style="width:16% !important">Sorgulama Tarihi</th>
			<th style="width:3% !important">Kimlik</th>
			<th style="width:3% !important">Sil</th>
		</tr>
	</thead>
	<tbody>
<%
	Dim DomainStatus
	intCounter = intLimitStart
	Do While Not objRs.Eof

		intCounter = intCounter + 1


	Select Case objRs("Sdurum")
		Case 0 DomainStatus = "<span style=""color:#67ab06"">Alan Adı Müsait</span>"
		Case 1 DomainStatus = "<span style=""color:#ff1701"">Alan Adı Müsait Değil</span>"
		Case Else DomainStatus = "<span style=""color:#ff9c02"">Bir Hata Oluştu</span>"
	End Select



%>	<tr id="trid_<%=objRs("id")%>" class="<%=TabloModClass(intCounter)%>">
		<td><label style="display:block;" for="cb<%=intCounter-1%>"><%=intCounter%></label></td>
		<td><input id="cb<%=intCounter-1%>" onclick="isChecked(<%=intCounter-1%>)" name="postid[]" value="<%=objRs("id")%>" type="checkbox" /></td>
		<td class="left nowrap"><a href="http://<%=objRs("Sdomain")%>" target="_blank"><%=objRs("Sdomain")%></a></td>
		<td class="left nowrap"><%=DomainStatus%></td>
		<td class="left nowrap"><%=TarihFormatla(objRs("Starih"))%></td>
		<td><%=objRs("id")%></td>
		<td><a class="list-delete-icon taskListSubmit" data-number="<%=intCounter-1%>" data-status="delete" data-apply="" title="Kalıcı Olarak Sil">Kalıcı Olarak Sil</a></td>
	</tr>
<%
objRs.MoveNext() : Loop
%>	</tbody>
	<tfoot>
		<tr class="tfoot">
			<td colspan="7">
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
Response.Write(Sayfala(ToplamCount, intSayfaSayisi, intSayfaNo))
End If
Set objRs = Nothing 
%>
</div>
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
</form>

<%Else%>
	<div class="notepad clearfix">
		<div class="warning"><div class="messages"><span>Sayfa bulunamadı!</span></div></div>
	</div>


<%End If%>

