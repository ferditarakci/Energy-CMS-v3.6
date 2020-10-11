
<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo comment">Yorumlar<%
		

If parent_id > 0 Then
	SQL = ""
	SQL = SQL & "SELECT title FROM #___content" & vbCrLf
	SQL = SQL & "WHERE parent_id = "& parent_id &"" & vbCrLf
	SQL = SQL & "And parent = "& intYap(parent, 0) &" And lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "Limit 1;"

	strTitle = sqlQuery(SQL, "")
	If strTitle <> "" Then
		strTitle = "<a href="""& UrlWrite("", GlobalConfig("site_lang"), ParentNumber(parent), "", "", parent_id, "", "") &""" title="""& strTitle &""">"& strTitle &"</a> "
		strTitle = strTitle & "<a style=""font-size:10px; color:#969696;"" href=""?mod="& ParentNumber(parent) &"&amp;task=edit&amp;id="& parent_id & sLang & Debug &""" title=""Düzenle"">(Düzenle)</a>"
		Response.Write ("<small style=""font-weight:normal; font-style:normal;""> &raquo; " & strTitle & "</small>")
	End If
End If

		%></td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="true" href="#" title="Seçili olan yorumları onayla"><span class="page_activate"></span>Onayla</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="status" data-apply="false" href="#" title="Seçili olan yorumları askıya al"><span class="page_deactivate"></span>Askıya Al</a></li>
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan yorumları sil"><span class="page_delete"></span>Yorumları Sil</a></li>
					<li><a href="?mod=<%=mods & sLang & Debug%>" title="Kapat"><span class="cancel"></span>Kapat</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>


<%
ViewsiD = intYap(Request.Form("views"), 0)

'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(Request.Form("search"), 1))
If inputSearch <> "" Then
	arrSearch = Split(inputSearch, " ")
	SearchSQL = " And ("
	For Each i in arrSearch : SearchSQL = SearchSQL & "comment_author like '%"& i &"%' Or comment_author_email like '%"& i &"%' Or comment_author_url like '%"& i &"%' Or " : Next
	SearchSQL = Left(SearchSQL, Len(SearchSQL) -4) & ")"
End If

'response.write typename(SearchSQL)





'// Tree View List
intCurr = 0
SQL = ""
SQL = SQL & "SELECT id FROM #___yorum" & vbCrLf
SQL = SQL & "WHERE comment_parent_id = {0}" & vbCrLf
If parent_id > 0 Then SQL = SQL & "And parent_id = "& parent_id &"" & vbCrLf
SQL = SQL & "And parent = "& intYap(parent, 0) &" And lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "ORDER BY id DESC;"
Call TreeViewList(SQL, 0, 0)
'Clearfix Ubound(arrTreeView)
If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")

%>

<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri")%>" method="post">


<div style="margin-right: -465px;" class="maincolumn">
	<div style="margin-right: 460px;" class="maincolumn-body">
	
	
<div style="margin-top:0;" class="notepad clearfix">
<table>
	<tr>
		<td align="left"><%

intDurumTumu = sqlQuery("SELECT Count(id) As toplam FROM #___yorum WHERE comment_status <> 10 "& SearchSQL &";", 0)	
intDurumAktif = sqlQuery("SELECT Count(id) As toplam FROM #___yorum WHERE comment_status = 1 "& SearchSQL &";", 0)	
intDurumPasif = sqlQuery("SELECT Count(id) As toplam FROM #___yorum WHERE comment_status = 0 "& SearchSQL &";", 0)
'intDurumCop = sqlQuery("SELECT Count(id) As toplam FROM #___etiket t1 INNER JOIN #___content t2 ON t1.id = t2.parent_id WHERE t1.remove = 1 And t2.lang = '"& GlobalConfig("site_lang") &"';", 0)	

%>
			<span style="float:right; margin-top:10px;">
				<a <%If ViewsiD = 0 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(0); submitform(); return false;" href="#">Tümü (<%=intDurumTumu%>)</a>&nbsp;&nbsp;|&nbsp;
				<a <%If ViewsiD = 1 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(1); submitform(); return false;" href="#">Sadece Aktifler (<%=intDurumAktif%>)</a>&nbsp;&nbsp;|&nbsp;
				<a <%If ViewsiD = 2 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(2); submitform(); return false;" href="#">Sadece Pasifler (<%=intDurumPasif%>)</a><!--&nbsp;|&nbsp;
				<a <%If ViewsiD = 3 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(3); submitform(); return false;" href="#">Çöptekiler (<%=intDurumCop%>)</a> -->
			</span>
			<span style="float:left;">
				Süzgeç :
				<input style="width:150px;" class="inputbox" name="search" id="search" value="<%=inputSearch%>" type="text" size="30" />
				<button class="btn" onclick="window.onbeforeunload = null; this.form.submit();" type="button">Ara</button>
				<button class="btn" onclick="$('#search').val(''); window.onbeforeunload = null; this.form.submit();" type="button">Temizle</button>
			</span>
		</td>
	</tr>
</table>
</div>
	
	
<div style="margin-top:0;" class="notepad clearfix">

<%

'// Toplam Kayıt Sayısını Alalım
SQL = ""
SQL = SQL & "SELECT Count(id) As Toplam FROM #___yorum "
SQL = SQL & "WHERE user_id > -1 "

Select Case ViewsiD
	Case 1 SQL = SQL & "And comment_status = 1 " & vbCrLf
	Case 2 SQL = SQL & "And comment_status = 0 " & vbCrLf
End Select

SQL = SQL & ""& SearchSQL &" "
SQL = SQL & ";"
ToplamCount = Cdbl(sqlQuery(SQL, 0))



'// Bilgisayara Cookie Bırakalım
Call getAdminCookie(mods)



'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "id, comment_author, comment_author_email, comment_author_url, comment_status, c_date" & vbCrLf
SQL = SQL & "FROM #___yorum" & vbCrLf
SQL = SQL & "WHERE user_id > -1 "& SearchSQL &"" & vbCrLf

Select Case ViewsiD
	Case 1 SQL = SQL & "And comment_status = 1 " & vbCrLf
	Case 2 SQL = SQL & "And comment_status = 0 " & vbCrLf
End Select

If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(id, "& TreeViewShort &")" & vbCrLf

SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi

SQL = SQL & ";"


'Clearfix setQuery( SQL )

Set objRs = setExecute( SQL )

	Response.Write("<table id=""comment_list"" class=""table_list"">" & vbCrLf)
	Response.Write("	<thead>" & vbCrLf)
	Response.Write("		<tr>" & vbCrLf)
	Response.Write("			<th style=""width:5% !important""><label style=""display:block;"" for=""toggle"">#</label></th>" & vbCrLf)
	Response.Write("			<th style=""width:5% !important""><input id=""toggle"" type=""checkbox"" /></th> " & vbCrLf)
	Response.Write("			<th style=""width:50% !important"">Yazar</th>" & vbCrLf)
	'Response.Write("			<th style=""width:35% !important"">Permalink</th>" & vbCrLf)
	'Response.Write("			<th style=""width:5% !important"">Hit</th>" & vbCrLf) 
	Response.Write("			<th style=""width:16% !important"">Tarih</th>" & vbCrLf) 
	Response.Write("			<th style=""width:8% !important"">Durum</th>" & vbCrLf)
	Response.Write("			<th style=""width:8% !important"">Düzenle</th>" & vbCrLf)
	Response.Write("			<th style=""width:8% !important"">Sil</th>" & vbCrLf)
	Response.Write("		</tr>" & vbCrLf) 
	Response.Write("	</thead>" & vbCrLf) 
	Response.Write("	<tbody>") 

	intCounter = intLimitStart
	Do While Not objRs.Eof
		intCounter = intCounter + 1 : intLevel = 0

		For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

		'spaces = 1 * intLevel : tempSpaces = ""

		'For y = 1 To spaces : tempSpaces = tempSpaces & "&ndash;&ndash;" : Next : If intLevel > 0 Then tempSpaces = tempSpaces & "&nbsp;"

		tempSpaces = ""
		For y = 1 To intLevel * 3
			tempSpaces = tempSpaces & "&nbsp;"
		Next
		If intLevel > 0 Then tempSpaces = tempSpaces & "&#8211;"

		strTitle = Cstr(objRs("comment_author"))

		If CBool(objRs("comment_status")) Then
			'strTitle = "<a style=""padding-right:13px !important; background:url(images/icons/link-icon_external.gif) no-repeat 100% 0;"" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Tags"), "", objRs("permalink"), "", "", "") &""" title="""& strTitle2 &""" target=""_blank"">"& strTitle &"</a>"
			strTitle = "<a"& strDirection &" rel=""nofollow"" href="""& objRs("comment_author_url") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"
		Else
			strTitle = "<span"& strDirection &" class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
		End If

		Response.Write("<tr id=""trid_"& objRs("id") &""" class="""& TabloModClass(intCounter) &""">" & vbCrLf)
		Response.Write("		<td><label style=""display:block;"" for=""cb"& intCounter-1 &""">"& intCounter &"</label></td>" & vbCrLf)
		Response.Write("		<td><input id=""cb"& intCounter-1 &""" onclick=""isChecked("& intCounter-1 &")"" name=""postid[]"" value="""& objRs("id") &""" type=""checkbox"" /></td>" & vbCrLf) 
		Response.Write("		<td class=""left"">"& tempSpaces &" <div style=""display:inline;"" id=""u"& objRs("id") &""">"& strTitle &"</div></td>" & vbCrLf) 
		'Response.Write("		<td class=""left nowrap"">"& objRs("permalink") &"</td>" & vbCrLf)
		'Response.Write("		<td>"& objRs("hit") &"</td>" & vbCrLf)
		Response.Write("		<td>"& TarihFormatla(objRs("c_date")) &"</td>" & vbCrLf)
		Response.Write("		<td><a id=""d"& objRs("id") &""" class="""& StatusStyle(objRs("comment_status"), "list-passive-icon", "list-active-icon") &" taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""status"" data-apply="""" title=""Aktif/Pasif Yap"">Aktif/Pasif Yap</a></td>" & vbCrLf)
		Response.Write("		<td><a class=""list-edit-icon EditEnergyComment"" href=""#"" title=""Düzenle"">Düzenle</a></td>" & vbcrlf) 
		Response.Write("		<td><a class=""list-delete-icon taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""delete"" data-apply="""" title=""Kalıcı Olarak Sil"">Kalıcı Olarak Sil</a></td>" & vbCrLf)
		Response.Write("	</tr>" & vbCrLf)
	objRs.MoveNext() : Loop
%>
	</tbody>
	<tfoot>
		<tr class="tfoot">
			<td colspan="13">
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
'Response.Write( "Sayfala("& ToplamCount &", "& intSayfaSayisi &", "& intSayfaNo &")" )
If Not objRs.Eof Then Response.Write( Sayfala(ToplamCount, intSayfaSayisi, intSayfaNo) )
Set objRs = Nothing 
%>
</div>
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
<input type="hidden" id="views" name="views" value="0" />
<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
</form>


	</div>
</div> <!-- /leftcolumn -->


<div style="width:453px;" class="rightcolumn">

	<div class="m_box">
		<div class="title"><h3 class="box-title">Yorum Düzenle</h3></div>
		<div class="head clearfix">
			<div class="form-table clearfix">
				<form id="comment_save" action="?mod=post&amp;task=<%=mods & sLang & Debug%>" method="post">
					<div class="row clearfix">
						<div class="l"><label for="comment_author" style="padding-left:5px; font-style:normal;"><span>:</span>Yazar Adı</label></div>
						<div class="r">
							<input style="width:270px;" class="inputbox" name="comment_author" id="comment_author" value="" title="100 karakter eklenebilir." maxlength="60" type="text" />
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="comment_author_email" style="padding-left:5px; font-style:normal;"><span>:</span>E-Posta</label></div>
						<div class="r">
							<input style="width:270px;" class="inputbox" name="comment_author_email" id="comment_author_email" value="" autocomplete="off" maxlength="100" type="text" />
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="comment_author_url" style="padding-left:5px; font-style:normal;"><span>:</span>Web Sitesi</label></div>
						<div class="r">
							<input style="width:270px;" class="inputbox" name="comment_author_url" id="comment_author_url" value="" autocomplete="off" type="text" />
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="comment_status" style="padding-left:5px; font-style:normal;"><span>:</span>Durum</label></div>
						<div class="r">
							<select name="comment_status" id="comment_status" size="1" style="width:255px;">
								<option value="" selected="selected">Durum Seçimi</option>
								<option value="1">Onaylandı</option>
								<option value="0">Askıda</option>
								<option value="2">Spam</option>
							</select>
						</div>
					</div>

					<div class="row clearfix">
						<div class="l"><label for="comment_text" style="padding-left:5px; font-style:normal;"><span>:</span>Yorum</label></div>
						<div class="r">
							<textarea style="margin-top:3px; width:100%; height:150px;" class="min" name="comment_text" id="comment_text" maxlength="200"></textarea>
						</div>
					</div>

					<div class="row clearfix" style="position: relative;">
						<img id="save-loading" style="display:none; position:absolute; right:125px; top:11px;" src="<%=GlobalConfig("vRoot")%>images/loading.gif" alt="Lütfen Bekleyin..." />
						<button class="btn" style="float:right; margin-right:17px;" onclick="window.onbeforeunload = null; $('#comment_save').submit();" type="button">Yorumu Kaydet</button>
						<button class="btn" style="float:left; margin-left:4px;" id="EditEnergyCommentFormReset" type="button">Formu Temizle</button>
						<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
					</div>
					<input name="pageid" value="0" type="hidden" />
				</form>
			</div>
		</div>
	</div>

</div> <!-- /rightcolumn -->

