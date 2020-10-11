<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo menu">Menü yönetimi<%

If menutype <> "" Then
	strTitle = sqlQuery("SELECT title FROM #___content_menu_type WHERE durum = 1 And type = '"& menutype &"';", "")
	Response.Write("<span> &raquo; "& strTitle &"</span>")
End If

%></td>
		<td width="50%">
			<div class="toolbar-list">
				<ul class="clearfix">
					<li><a class="taskListSubmit" data-number="multi-selected" data-status="delete" data-apply="" href="#" title="Seçili olan menüleri sil"><span class="delete"></span>Sil</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>


<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri") & Debug%>" method="post">

<div class="notepad clearfix">
<%
'If task = "" Then

'ViewsiD = intYap(Request.Form("views"), 0)

'Search Code
'SearchSQL = ""
'inputSearch  = Trim(Temizle(Request.Form("search"), 1))
'If inputSearch <> "" Then
'	arrSearch = Split(inputSearch, " ")
'	SearchSQL = " And ("
'	For Each i in arrSearch : SearchSQL = SearchSQL & "t2.title like '%"& i &"%' Or " : Next
'	SearchSQL = Left(SearchSQL, Len(SearchSQL) -4) & ")"
'End If

'response.write typename(SearchSQL)






'// Tree View List
intCurr = 0

SQL = ""
SQL = SQL & "SELECT t1.id, t6.sira AS sira " & vbcrlf
SQL = SQL & "FROM #___sayfa t1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content t2 ON (t1.id = t2.parent_id) " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_template t4 ON (t1.typeAlias = t4.alias And (t4.nerde = '"& GlobalConfig("General_Page") &"' Or t4.nerde = '')) " & vbcrlf
'SQL = SQL & "INNER JOIN #___languages t3 ON (t3.durum = -1) And (t2.lang = t3.lng) " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu_type t5 ON t5.durum = -1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu t6 ON t5.id = t6.menu_id And t1.id = t6.parent_id " & vbcrlf
SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Page") &"' And t5.type = '"& menutype &"' "
SQL = SQL & "And t1.anaid = {0} "
SQL = SQL & ") " & vbcrlf
SQL = SQL & "UNION ALL " & vbcrlf
SQL = SQL & "SELECT t1.id, t6.sira AS sira " & vbcrlf
SQL = SQL & "FROM #___kategori t1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content t2 ON (t1.id = t2.parent_id) " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_template t4 ON (t1.typeAlias = t4.alias And (t4.nerde = '"& GlobalConfig("General_Categories") &"' Or t4.nerde = '')) " & vbcrlf
'SQL = SQL & "INNER JOIN #___languages t3 ON (t3.durum = -1) And (t2.lang = t3.lng) " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu_type t5 ON t5.durum = -1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu t6 ON t5.id = t6.menu_id And t1.id = t6.parent_id " & vbcrlf
SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Categories") &"' And t5.type = '"& menutype &"' "
SQL = SQL & "And t1.anaid = {0} "
SQL = SQL & ") " & vbcrlf
'SQL = SQL & "UNION ALL " & vbcrlf
'SQL = SQL & "SELECT t1.id, t1.sira AS sira " & vbcrlf
'SQL = SQL & "FROM #___products t1 " & vbcrlf
'SQL = SQL & "INNER JOIN #___content t2 ON (t1.id = t2.parent_id) " & vbcrlf
'SQL = SQL & "LEFT JOIN #___content_template t4 ON (t1.typeAlias = t4.alias And (t4.nerde = '"& GlobalConfig("General_Products") &"' Or t4.nerde = '')) " & vbcrlf
'SQL = SQL & "INNER JOIN #___languages t3 ON (t3.durum = -1) And (t2.lang = t3.lng) " & vbcrlf
'SQL = SQL & "INNER JOIN #___content_menu_type t5 ON t5.durum = -1 " & vbcrlf
'SQL = SQL & "INNER JOIN #___content_menu t6 ON t5.id = t6.menu_id And t1.id = t6.parent_id " & vbcrlf
'SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Products") &"' And t5.type = '"& menutype &"' "
'SQL = SQL & "And t1.katid = {0} "
'SQL = SQL & ") " & vbcrlf
SQL = SQL & "ORDER BY sira ASC;"
Call TreeViewList(SQL, 0, 0)

If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")













'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT t1.id, t4.id As menuid, t4.sira AS sira, t1.durum, t2.title, t5.title As TypeTitle, t3.title As MenuTitle, t2.parent, t6.DateTimes As c_date, t1.s_date, t1.e_date " & vbcrlf
SQL = SQL & "FROM #___sayfa t1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_menu_type t3 ON (t3.durum = -1 Or t3.durum = 1) " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu t4 ON t3.id = t4.menu_id And t1.id = t4.parent_id " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_template t5 ON t1.typeAlias = t5.alias And (t5.nerde = '"& GlobalConfig("General_Page") &"' Or t5.nerde = '') " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_revision_date t6 ON t1.id = t6.parent_id And t6.parent = '"& GlobalConfig("General_Page") &"' And t6.Revizyon = 1 " & vbCrLf
SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Page") &"' And t3.type = '"& menutype &"') " & vbcrlf

SQL = SQL & "UNION ALL " & vbcrlf

SQL = SQL & "SELECT t1.id, t4.id As menuid, t4.sira AS sira, t1.durum, t2.title, t5.title As TypeTitle, t3.title As MenuTitle, t2.parent, t6.DateTimes As c_date, 0 As s_date, 0 As e_date " & vbcrlf
SQL = SQL & "FROM #___kategori t1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_menu_type t3 ON (t3.durum = -1 Or t3.durum = 1) " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu t4 ON t3.id = t4.menu_id And t1.id = t4.parent_id " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_template t5 ON t1.typeAlias = t5.alias And (t5.nerde = '"& GlobalConfig("General_Categories") &"' Or t5.nerde = '') " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_revision_date t6 ON t1.id = t6.parent_id And t6.parent = '"& GlobalConfig("General_Categories") &"' And t6.Revizyon = 1 " & vbCrLf
SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Categories") &"' And t3.type = '"& menutype &"') " & vbcrlf


'SQL = SQL & "UNION ALL " & vbcrlf

'SQL = SQL & "SELECT t1.id, t4.id As menuid, t4.sira AS sira, t1.durum, t2.title, t5.title As TypeTitle, t3.title As MenuTitle, t2.parent, t6.DateTimes As c_date, t1.s_date, t1.e_date " & vbcrlf
'SQL = SQL & "FROM #___products t1 " & vbcrlf
'SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id " & vbcrlf
'SQL = SQL & "LEFT JOIN #___content_menu_type t3 ON (t3.durum = -1 Or t3.durum = 1) " & vbcrlf
'SQL = SQL & "INNER JOIN #___content_menu t4 ON t3.id = t4.menu_id And t1.id = t4.parent_id " & vbcrlf
'SQL = SQL & "LEFT JOIN #___content_template t5 ON t1.typeAlias = t5.alias And (t5.nerde = '"& GlobalConfig("General_Products") &"' Or t5.nerde = '') " & vbcrlf
'SQL = SQL & "LEFT JOIN #___content_revision_date t6 ON t1.id = t6.parent_id And t6.parent = '"& GlobalConfig("General_Products") &"' And t6.Revizyon = 1 " & vbCrLf
'SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Products") &"' And t3.type = '"& menutype &"') " & vbcrlf

If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(id, "& TreeViewShort &");"



'SQL = setQuery( SQL )
'Clearfix SQL

Set objRs = setExecute( SQL )

	If objRs.Eof Then

		Response.Write("<div class=""warning""><div class=""messages""><span>Kayıt bulunamadı</span></div></div>")

	Else

		Response.Write("<table class=""table_list hidden"">" & vbcrlf) 
		Response.Write("	<thead>" & vbcrlf) 
		Response.Write("		<tr>" & vbcrlf) 
		Response.Write("			<th style=""width:3% !important""><label style=""display:block;"" for=""toggle"">#</label></th>" & vbcrlf) 
		Response.Write("			<th style=""width:3% !important""><input id=""toggle"" type=""checkbox"" /></th> " & vbcrlf) 
		Response.Write("			<th style=""width:35% !important"">Başlık</th>" & vbcrlf) 
		Response.Write("			<th style=""width:5% !important""><a class=""taskListSubmit"" data-number=""multi-selected"" data-status=""sort-order"" data-apply="""" href=""#"">Sırala</a></th>" & vbcrlf) 
		Response.Write("			<th style=""width:20% !important"">Menü / Tür</th>" & vbcrlf) 
		Response.Write("			<th style=""width:20% !important"">Şablon</th>" & vbcrlf) 
		Response.Write("			<th style=""width:3% !important"">Kimlik</th>" & vbcrlf) 
		Response.Write("			<th style=""width:3% !important"">Link</th>" & vbcrlf) 
		Response.Write("			<th style=""width:3% !important"">Düzenle</th>" & vbcrlf) 
		Response.Write("			<th style=""width:3% !important"">Sil</th>" & vbcrlf) 
		Response.Write("		</tr>" & vbcrlf) 
		Response.Write("	</thead>" & vbcrlf) 
		Response.Write("	<tbody>") 


		Dim strSayfaTurus
		intCounter = intLimitStart
		Do While Not objRs.Eof

			intCounter = intCounter + 1 : intLevel = 0

			For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

			spaces = 1 * intLevel : tempSpaces = ""

			For y = 1 To spaces : tempSpaces = tempSpaces & "&ndash;&ndash;" : Next : If intLevel > 0 Then tempSpaces = tempSpaces & "&nbsp;"


			'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
			strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""


			strTitle = Cstr(objRs("title")) ': If strTitle = "" Then strTitle = "( Başlık yok )"

			If CBool(objRs("durum")) Then
				strTitle = "<a"& strDirection &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), objRs("parent"), "", "", Cdbl(objRs("id")), "", "") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"
			Else
				strTitle = "<span"& strDirection &" class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
			End If


			CreateDate = objRs("c_date")
			StartDate = objRs("s_date")
			EndDate = objRs("e_date")

			If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
			If Not isDate(StartDate) Then StartDate = Null
			If Not isDate(EndDate) Then EndDate = Null


			ZamanAsimi = ""
			If DateDiff("s", StartDate, Now()) <= 1 Then
				ZamanAsimi = "<span class=""red tooltip"" title=""Başlama Tarihi : "& StartDate &"""> ( Tarihi Bekliyor )</span>"
			ElseIf DateDiff("s", EndDate, Now()) >= 1 Then
				ZamanAsimi = "<span class=""red tooltip"" title=""Bitiş Tarihi : "& EndDate &"""> ( Zaman Aşımına Uğradı )</span>"
			'ElseIf isDate(objRs("s_date")) = False Then
			'    ZamanAsimi = "Başlangıç Belirtilmedi"
			'ElseIf isDate(objRs("e_date")) = False Then
			'    ZamanAsimi = "Bitiş Belirtilmedi"
			'ElseIf isDate(objRs("s_date")) = False And isDate(objRs("e_date")) = False Then
			'	ZamanAsimi = "Tarih Belirtilmedi"
			'Else
			'	ZamanAsimi = "Yayında"
			End If

			'If DateDiff("s", datem, Now()) <= 1 Then
			'	ZamanAsimi = "zamanı bekliyor"
			'ElseIf DateDiff("s", datem2, Now()) <= 1 Then
			'    ZamanAsimi = "zamanı bitti"
			'Else
			'    ZamanAsimi = "eski"
			'End If


			Select Case objRs("parent")
				Case GlobalConfig("General_Categories") strSayfaTurus = "Kategori"
				Case GlobalConfig("General_Products") strSayfaTurus = "Ürün"
				Case GlobalConfig("General_Page") strSayfaTurus = "Sayfa"
				Case Else strSayfaTurus = "Diğer"
			End Select


			Response.Write("<tr id=""trid_"& objRs("menuid") &""" class="""& TabloModClass(intCounter) &""">" & vbcrlf) 
			Response.Write("		<td><label style=""display:block;"" for=""cb"& intCounter-1 &""">"& intCounter &"</label></td>" & vbcrlf) 
			Response.Write("		<td><input id=""cb"& intCounter-1 &""" onclick=""isChecked("& intCounter-1 &")"" name=""postid[]"" value="""& objRs("menuid") &""" type=""checkbox"" /></td>" & vbcrlf) 
			Response.Write("		<td class=""left"">"& tempSpaces &" <div "& parent_dir &"style=""display:inline;"" id=""u"& objRs("id") &""">"& strTitle &"</div>"& ZamanAsimi &"</td>" & vbcrlf) 
			Response.Write("		<td><input class=""inputbox list-order"" id=""order_"& objRs("menuid") &""" name=""order[]"" value="""& objRs("sira") &""" maxlength=""3"" type=""text"" /></td>" & vbcrlf) 
			Response.Write("		<td class=""left"">"& objRs("MenuTitle") & " &raquo; " & strSayfaTurus &"</td>" & vbcrlf) 
			Response.Write("		<td class=""left nowrap"">"& objRs("TypeTitle") &"</td>" & vbcrlf) 
			Response.Write("		<td>"& objRs("id") &"</td>" & vbcrlf)
			Response.Write("		<td><a class=""url_list"" href=""?mod=url_list&amp;parent="& objRs("parent") &"&amp;parent_id="& objRs("id") & sLang &""" data-title="""& objRs("title") &""" title=""URL Liste"">URL Liste</a></td>" & vbcrlf) 
			Response.Write("		<td><a class=""list-edit-icon"" href=""?mod="& objRs("parent") &"&amp;task=edit&amp;id="& objRs("id") & sLang &""" title=""Düzenle"">Düzenle</a></td>" & vbcrlf) 
			Response.Write("		<td><a class=""list-delete-icon taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""delete"" data-apply="""" title=""Menü Bağlantısını Kaldır"">Menü Bağlantısını Kaldır</a></td>" & vbcrlf) 
			Response.Write("	</tr>" & vbcrlf)

		objRs.MoveNext() : Loop
	%>
	</tbody>
</table>
<%
End If
Set objRs = Nothing 
%>
</div>
<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:relative !important; left:-9999px !important;" />
<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
</form>











<style type="text/css">

 	.sortables {
		position:relative;
	}
	
	.sortables, .sortables li {
		margin:0;
		padding:0;
		list-style:none;
	}
	
	.sortables li {
		width:200px;
		margin:1px;
		padding:5px;
		border:solid 1px #AAA;
		background-color:#EEE;
		
		position:relative;
	}
	
	.sortables li ul {
		position:absolute;
		top:-1px;
		left:212px;
		padding-left:1px;
	}
	
	.ph {
		background-color:#ff0000;
	}








</style>
<script type="text/javascript">
	$(function() {
		$("ul.menus").addClass("ui-corner-all")
			.sortable({
				forcePlaceholderSize: true,
				connectWith: "ul",
				items: 'li',
				tolerance: 'pointer',
				//placeholder: 'ph',
				options:{menuItemDepthPerLevel:30, globalMaxDepth:11},
				menuList: undefined,
				targetList: undefined,
				revert: true,
				cursor: "move",
				opacity: 0.5,
				update: function() {
					var order = $(this).sortable("serialize");// + "&data=" + $(this).attr("data"); //alert(order)
					alert(order)//$.post("?mod=redirect&task=modules_order", order, function(s){});
				}
			})
			.find("li").addClass("ui-corner-all")
			.click(function() {
				$(this).toggleClass("selected")
			})
			.disableSelection()
		;

/*

		$(".menus").addClass("ui-corner-all").sortable({
			forcePlaceholderSize: true,
			tolerance: 'pointer',
			placeholder: 'ph',
			connectWith: 'ul',
			opacity: 0.8,
			items: 'li',
			update: function() {
				var order = $(this).sortable("serialize") + "&data="; alert(order)
				//$.post("?mod=redirect&task=modules_order", order, function(s){});
			}
		});
		$(".menus").disableSelection();
*/
	});
	</script>












<%
Response.Write("<ul class=""menus"">" & vbCrLf)

Call EnergyMenuFonksiyon(0, 0)

Response.Write(vbCrLf & "</ul>" & vbCrLf)










Private Sub EnergyMenuFonksiyon(ByVal intAnaid, ByVal intLevel)

	Dim SQL, objRs, intid, intMenuid, strTitle, intNerden, varStyle

'// Sorgumuzu oluşturup kayıtları çekelim
SQL = ""
SQL = SQL & "SELECT t1.id As id, t6.id As menuid, t6.sira AS sira, t1.durum As durum, t2.title As title, t4.title As typetitle, t5.title As Menutitle, t2.parent As parent " & vbcrlf
SQL = SQL & "FROM #___sayfa t1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content t2 ON (t1.id = t2.parent_id) " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_template t4 ON (t1.typeAlias = t4.alias And (t4.nerde = '"& GlobalConfig("General_Page") &"' Or t4.nerde = '')) " & vbcrlf
'SQL = SQL & "INNER JOIN #___languages t3 ON (t3.durum = -1) And (t2.lang = t3.lng) " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu_type t5 ON t5.durum = -1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu t6 ON t5.id = t6.menu_id And t1.id = t6.parent_id " & vbcrlf
SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Page") &"' And t5.type = '"& menutype &"' "
SQL = SQL & "And t1.anaid = "& intAnaid &" "
SQL = SQL & ") " & vbcrlf
SQL = SQL & "UNION ALL " & vbcrlf
SQL = SQL & "SELECT t1.id As id, t6.id As menuid, t6.sira AS sira, t1.durum As durum, t2.title As title, t4.title As typetitle, t5.title As Menutitle, t2.parent As parent " & vbcrlf
SQL = SQL & "FROM #___kategori t1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content t2 ON (t1.id = t2.parent_id) " & vbcrlf
SQL = SQL & "LEFT JOIN #___content_template t4 ON (t1.typeAlias = t4.alias And (t4.nerde = '"& GlobalConfig("General_Categories") &"' Or t4.nerde = '')) " & vbcrlf
'SQL = SQL & "INNER JOIN #___languages t3 ON (t3.durum = -1) And (t2.lang = t3.lng) " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu_type t5 ON t5.durum = -1 " & vbcrlf
SQL = SQL & "INNER JOIN #___content_menu t6 ON t5.id = t6.menu_id And t1.id = t6.parent_id " & vbcrlf
SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Categories") &"' And t5.type = '"& menutype &"' "
SQL = SQL & "And t1.anaid = "& intAnaid &" "
SQL = SQL & ") " & vbcrlf
'SQL = SQL & "UNION ALL " & vbcrlf
'SQL = SQL & "SELECT t1.id As id, t6.id As menuid, t1.sira AS sira, t1.durum As durum, t2.title As title, t4.title As typetitle, t5.title As Menutitle, t2.parent As parent " & vbcrlf
'SQL = SQL & "FROM #___products t1 " & vbcrlf
'SQL = SQL & "INNER JOIN #___content t2 ON (t1.id = t2.parent_id) " & vbcrlf
'SQL = SQL & "LEFT JOIN #___content_template t4 ON (t1.typeAlias = t4.alias And (t4.nerde = '"& GlobalConfig("General_Products") &"' Or t4.nerde = '')) " & vbcrlf
'SQL = SQL & "INNER JOIN #___languages t3 ON (t3.durum = -1) And (t2.lang = t3.lng) " & vbcrlf
'SQL = SQL & "INNER JOIN #___content_menu_type t5 ON t5.durum = -1 " & vbcrlf
'SQL = SQL & "INNER JOIN #___content_menu t6 ON t5.id = t6.menu_id And t1.id = t6.parent_id " & vbcrlf
'SQL = SQL & "WHERE (t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = '"& GlobalConfig("General_Products") &"' And t5.type = '"& menutype &"' "
'SQL = SQL & "And t1.katid = "& intAnaid &" "
'SQL = SQL & ") " & vbcrlf
SQL = SQL & "ORDER BY sira ASC;"

SQL = setQuery( SQL )

'Clearfix SQL
'If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(id, "& TreeViewShort &");"

	
	Set objRs = data.ExeCute( SQL )

	With Response

		'If Not objRs.Eof Then

			'// vbTab Yaz
			If (intLevel > 0) Then .Write(vbCrLf & String(intLevel * 2, vbTab))

			'// Alt Menü UL Tag Aç
			If (intLevel > 0) Then .Write("<ul class=""sub-menu"">" & vbCrLf)
			'.Write("<ul class=""sub-menu"">" & vbCrLf)

			Do While Not objRs.Eof

				'// Menü idsi
				intid = Cdbl(objRs("id"))

				'// Menü idsi
				intMenuid = Cdbl(objRs("menuid"))

				'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
				strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""


				strTitle = Cstr(objRs("title")) ': If strTitle = "" Then strTitle = "( Başlık yok )"

				If CBool(objRs("durum")) Then
					strTitle = "<a"& strDirection &" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), objRs("parent"), "", "", Cdbl(objRs("id")), "", "") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"
				Else
					strTitle = "<span"& strDirection &" class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
				End If


				'CreateDate = objRs("c_date")
				'StartDate = objRs("s_date")
				'EndDate = objRs("e_date")

				'If isDate(CreateDate) Then CreateDate = FormatDateTime(CreateDate, 2)
				'If Not isDate(StartDate) Then StartDate = Null
				'If Not isDate(EndDate) Then EndDate = Null


				ZamanAsimi = ""
				If DateDiff("s", StartDate, Now()) <= 1 Then
					ZamanAsimi = "<span class=""red tooltip"" title=""Başlama Tarihi : "& StartDate &"""> ( Tarihi Bekliyor )</span>"
				ElseIf DateDiff("s", EndDate, Now()) >= 1 Then
					ZamanAsimi = "<span class=""red tooltip"" title=""Bitiş Tarihi : "& EndDate &"""> ( Zaman Aşımına Uğradı )</span>"
				'ElseIf isDate(objRs("s_date")) = False Then
				'    ZamanAsimi = "Başlangıç Belirtilmedi"
				'ElseIf isDate(objRs("e_date")) = False Then
				'    ZamanAsimi = "Bitiş Belirtilmedi"
				'ElseIf isDate(objRs("s_date")) = False And isDate(objRs("e_date")) = False Then
				'	ZamanAsimi = "Tarih Belirtilmedi"
				'Else
				'	ZamanAsimi = "Yayında"
				End If

				'If DateDiff("s", datem, Now()) <= 1 Then
				'	ZamanAsimi = "zamanı bekliyor"
				'ElseIf DateDiff("s", datem2, Now()) <= 1 Then
				'    ZamanAsimi = "zamanı bitti"
				'Else
				'    ZamanAsimi = "eski"
				'End If


				Select Case objRs("parent")
					Case GlobalConfig("General_Categories") strSayfaTurus = "Kategori"
					Case GlobalConfig("General_Products") strSayfaTurus = "Ürün"
					Case GlobalConfig("General_Page") strSayfaTurus = "Sayfa"
					Case Else strSayfaTurus = "Diğer"
				End Select





				'// Menü türü
				'intNerden = objRs("Tur")
				'If intNerden = 1 Then varURL = "?git=kategori&amp;id=" & intMenuid Else varURL = "?git=urun&amp;id=" & intMenuid

				'varStyle = "" : If intNerden = 2 Then varStyle = " color:red"

				'// Menü ismi
				'strTitle = objRs("title") & " --- <b style=""font-size:14px;"& varStyle &""">( " & objRs("Nerden") & " )</b> "

				'// vbTab Yaz
				If (intLevel > 0) Then .Write(String(intLevel * 2, vbTab))
				.Write(String(1, vbTab))

				'// Menu LI Tag Aç
				.Write("<li id=""postid_"& objRs("menuid") &""" class=""menu-item"">")

				'.Write("<a href="""& varURL &""" title="""">" & strTitle & "</a>")
				.Write( strTitle & objRs("menuid"))

					'// Alt Menü Çağır
					Call EnergyMenuFonksiyon(intid, intLevel + 1)

				'// Menu LI Tag Kapat
				.Write("</li>")

				'// Alt Satırdan Devam Et
				'If Not (MenuSay = Count) Then .Write( vbCrLf )

				'// vbTab Yaz
				If (intLevel > 0) Then .Write(String(intLevel * 2, vbTab))

				objRs.MoveNext() : Loop

				'// Sub Menu UL Tag Kapat
				'.Write("</ul>" & vbCrLf)
				If (intLevel > 0) Then .Write("</ul>" & vbCrLf)

				'// vbTab Yaz
				If (intLevel > 0) Then .Write(String((intLevel *2) -1, vbTab))

		'End If
	Set objRs = Nothing
	End With
End Sub

%>

