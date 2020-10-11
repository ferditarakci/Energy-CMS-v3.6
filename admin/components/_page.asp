<!--#include file="header.asp"-->
		<style type="text/css">
			/*html { overflow:auto !important; }*/
		</style>
	</head>
	<body>
		<%


ViewsiD = intYap(Request.Form("views"), 0)

'Search Code
SearchSQL = ""
inputSearch  = Trim(Temizle(Request.Form("search"), 1))
If inputSearch <> "" Then
	arrSearch = Split(inputSearch, " ")
	SearchSQL = " And ("
	For Each i in arrSearch : SearchSQL = SearchSQL & "t2.title like '%"& i &"%' Or " : Next
	SearchSQL = Left(SearchSQL, Len(SearchSQL) -4) & ")"
End If

'response.write typename(SearchSQL)




'// Tree View List
intCurr = 0
SQL = ""
SQL = SQL & "SELECT t1.id FROM #___sayfa t1 "
SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
SQL = SQL & "WHERE t1.anaid = {0} And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
SQL = SQL & "ORDER BY t1.sira ASC, t1.id DESC;"
Call TreeViewList(SQL, 0, 0)

If Ubound(arrTreeView) >= 0 Then TreeViewShort = Join(arrTreeView, ", ")



		%>
		<form id="EnergyAdminList" action="<%=GlobalConfig("site_uri") & Debug%>" method="post">
		<div class="notepad clearfix">
		<table>
			<tr>
				<td align="left">
<div id="module-menu" style="float:right; height:15px; margin-top:-6px;"><%
'Clearfix sTotalLang()
If sTotalLang() > 1 Then
	Dim strHeaderLang
	OpenRs objRs, "SELECT title, lng, default_lng FROM #___languages WHERE durum = 1 ORDER BY default_lng DESC, sira ASC;"
		If Not objRs.Eof Then
			Response.Write( vbCrLf & "<ul class=""lang-menu clearfix"" id=""ewy_langs"">")
			While Not objRs.Eof
				strHeaderLang = ""
				strHeaderLang = strHeaderLang & "?mod=" & mods
				If menutype <> "" Then strHeaderLang = strHeaderLang & "&amp;menutype=" & menutype
				If task <> "" Then strHeaderLang = strHeaderLang & "&amp;task=" & task
				If Request("e_name") <> "" Then strHeaderLang = strHeaderLang & "&amp;e_name=" & Request("e_name")
				If id > 0 Then strHeaderLang = strHeaderLang & "&amp;id=" & id
				If Not CBool(objRs("default_lng")) Then strHeaderLang = strHeaderLang & "&amp;"& ewy_queryLang &"=" & LCase(objRs("lng"))
				Response.Write( vbCrLf & "				<li class="""& LCase(objRs("lng")) &"""><a href="""& strHeaderLang & Debug &""" title="""& objRs("title") &"""><span>"& objRs("title") &"</span></a></li>")
			objRs.MoveNext() : Wend
			Response.Write( vbCrLf & "					</ul>")
			strHeaderLang = ""
		End If
	CloseRs objRs
End If
%></div><%
					intDurumTumu = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 LEFT JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
					intDurumAktif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 LEFT JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE (t1.durum = -1 Or t1.durum = 1) And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)	
					intDurumPasif = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 LEFT JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE t1.durum = 0 And t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "& SearchSQL &";", 0)
					'intDurumCop = sqlQuery("SELECT Count( t1.id ) As toplam FROM #___sayfa t1 LEFT JOIN #___content t2 ON (t1.id = t2.parent_id) WHERE (t1.remove = -1 Or t1.remove = 1) And t2.lang = '"& GlobalConfig("site_lang") &"';", 0)	
		%>
					<span style="float:right; margin-top:7px;">
						<a <%If ViewsiD = 0 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(0); submitform(); return false;" href="#">Tümü (<%=intDurumTumu%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
						<a <%If ViewsiD = 1 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(1); submitform(); return false;" href="#">Sadece Aktifler (<%=intDurumAktif%>)</a> &nbsp;&nbsp; | &nbsp;&nbsp;
						<a <%If ViewsiD = 2 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(2); submitform(); return false;" href="#">Sadece Pasifler (<%=intDurumPasif%>)</a><!-- &nbsp;&nbsp; | &nbsp;&nbsp;
						<a <%If ViewsiD = 3 Then Response.Write("class=""active"" ")%> style="font-weight:bold;" onclick="$('#views').val(3); submitform(); return false;" href="#">Çöptekiler (<%=intDurumCop%>)</a> -->
					</span>
					Süzgeç :
					<input class="inputbox" name="search" id="search" value="<%=inputSearch%>" type="text" style="width:100px;" />
					<button class="btn" onclick="window.onbeforeunload = null; this.form.submit();" type="button">Ara</button>
					<button class="btn" onclick="$('#search').val(''); window.onbeforeunload = null; this.form.submit();" type="button">Temizle</button>
				</td>
			</tr>
		</table>
		</div>

		<div class="notepad clearfix">
		<%

		'// Toplam Kayıt Sayısını Alalım
		SQL = ""
		SQL = SQL & "SELECT Count( t1.id ) As Toplam FROM #___sayfa t1 "
		SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id "
		SQL = SQL & "WHERE t2.parent = "& GlobalConfig("General_PagePN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "

		Select Case ViewsiD
			Case 1 SQL = SQL & "And t1.durum = 1" & vbCrLf
			Case 2 SQL = SQL & "And t1.durum = 0" & vbCrLf
			Case 3 SQL = SQL & "And t1.remove = 1" & vbCrLf
		End Select

		SQL = SQL & ""& SearchSQL &" "
		SQL = SQL & ";"
		ToplamCount = Cdbl(sqlQuery(SQL, 0))



		'// Bilgisayara Cookie Bırakalım
		Call getAdminCookie(mods)



		'// Sorgumuzu oluşturup kayıtları çekelim
		SQL = ""
		SQL = SQL & "SELECT " & vbCrLf
		SQL = SQL & "t1.id, t1.sira, t1.ozel, t1.durum, t1.anasyf, /*date_format(t1.c_date, '%d.%m.%Y') As*/ t4.DateTimes As c_date, t1.s_date, t1.e_date, " & vbCrLf
		SQL = SQL & "t2.title, t2.hit, t3.title As typetitle " & vbCrLf
		SQL = SQL & "FROM #___sayfa t1 " & vbCrLf
		SQL = SQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id " & vbCrLf
		SQL = SQL & "LEFT JOIN #___content_template t3 ON t1.typeAlias = t3.alias And (t3.parent = "& GlobalConfig("General_PagePN") &" Or t3.parent = 0) " & vbCrLf
		SQL = SQL & "LEFT JOIN #___content_revision_date t4 ON t1.id = t4.parent_id And t4.parent = "& GlobalConfig("General_PagePN") &" And t4.Revizyon = 1 " & vbCrLf
		'SQL = SQL & "INNER JOIN #___languages t5 ON (t5.durum = -1 Or t5.durum = 1) And t2.lang = t5.lng " & vbCrLf

		SQL = SQL & "WHERE " & vbCrLf
		SQL = SQL & "/*t5.lng = '"& GlobalConfig("site_lang") &"' And*/ t2.lang = '"& GlobalConfig("site_lang") &"' And t2.parent = "& GlobalConfig("General_PagePN") &" "& SearchSQL &" " & vbCrLf

		Select Case ViewsiD
			Case 1 SQL = SQL & "And t1.durum = 1" & vbCrLf
			Case 2 SQL = SQL & "And t1.durum = 0" & vbCrLf
			Case 3 SQL = SQL & "And t1.remove = 1" & vbCrLf
		End Select

		If TreeViewShort <> "" Then SQL = SQL & "ORDER BY Field(t1.id, "& TreeViewShort &") " & vbCrLf

		SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi

		SQL = SQL & ";"

		'SQL = setQuery( SQL )
		'Clearfix SQL
		Set objRs = setExecute( SQL )

			If objRs.Eof Then

				Response.Write("<div class=""warning""><div class=""messages""><span>Kayıt bulunamadı</span></div></div>")

			Else

				Response.Write("<table class=""table_list"">" & vbcrlf) 
				Response.Write("	<thead>" & vbcrlf) 
				Response.Write("		<tr>" & vbcrlf) 
				Response.Write("			<th style=""width:3% !important"">#</th>" & vbcrlf) 
				Response.Write("			<th style=""width:50% !important"">Başlık</th>" & vbcrlf) 
				Response.Write("			<th style=""width:40% !important"">Permalink</th>" & vbcrlf) 
				'Response.Write("			<th style=""width:15% !important"">Şablon</th>" & vbcrlf) 
				'Response.Write("			<th style=""width:6% !important"">Görünürlük</th>" & vbcrlf) 
				Response.Write("			<th style=""width:7% !important"">Tarih</th>" & vbcrlf) 
				'Response.Write("			<th style=""width:3% !important"">Kimlik</th>" & vbcrlf) 
				Response.Write("		</tr>" & vbcrlf) 
				Response.Write("	</thead>" & vbcrlf) 
				Response.Write("	<tbody>") 

				intCounter = intLimitStart
				Do While Not objRs.Eof

					intCounter = intCounter + 1 : intLevel = 0

					For i = 0 To Ubound(arrTreeView) : If Clng(arrTreeView(i)) = Clng(objRs("id")) Then intLevel = arrSubLevel(i) End If : Next

					spaces = 1 * intLevel : tempSpaces = ""

					For y = 1 To spaces : tempSpaces = tempSpaces & "&ndash;&ndash;" : Next : If intLevel > 0 Then tempSpaces = tempSpaces & "&nbsp;"

					'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
					strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""

					strTitle = Cstr(objRs("title")) ': If strTitle = "" Then strTitle = "( Başlık yok )"

					strLink = URLDecode(UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", ""))

					If CBool(objRs("durum")) Then
						strTitle = "<a"& strDirection &" href=""#"" onclick=""window.parent.jSelectArticle('"& Temizle(strTitle, 1) &"', '"& Temizle(strLink, 1) &"', '"& Temizle(Request.QueryString("e_name"), 1) &"');"" title="""& strTitle &""">"& strTitle &"</a>"
						'strTitle = "<a "& strDirection &"href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Cdbl(objRs("id")), "", "") &""" title="""& strTitle &""" target=""_blank"">"& strTitle &"</a>"
					Else
						strTitle = "<span class=""status-false"" title="""& strTitle &""">"& strTitle &"</span>"
					End If


					If strLink = "javascript:;" Then strLink = "#"
					strLink = "<input onclick=""iSelected(this);"" id=""inputurl["& intCounter &"]"" class=""inputbox"" style=""width:90%"" value="""& strLink &""" title="""& strLink &""" type=""text"" readonly=""readonly"""& eDisabled(Not CBool(objRs("durum")) Or strLink = "#") &" />"

					CreateDate = objRs("c_date")
					StartDate = objRs("s_date")
					EndDate = objRs("e_date")

					If isDate(CreateDate) Then CreateDate = FormatDateTime(objRs("c_date"), 2)
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

					Response.Write("<tr id=""trid_"& objRs("id") &""" class="""& TabloModClass(intCounter) &""">" & vbcrlf) 
					Response.Write("		<td><label style=""display:block"" for=""cb"& intCounter-1 &""">"& intCounter &"</label></td>" & vbcrlf) 
					Response.Write("		<td class=""left"">"& tempSpaces &" <div"& strDirection &" style=""display:inline;"" id=""u"& objRs("id") &""">"& strTitle &"</div>"& ZamanAsimi &"</td>" & vbcrlf) 
					Response.Write("		<td>"& strLink &"</td>" & vbcrlf) 
					'Response.Write("		<td class=""left nowrap"">"& objRs("typetitle") &"</td>" & vbcrlf) 
					'Response.Write("		<td class=""nowrap"">"& Gorunurluk(objRs("ozel")) &"</td>" & vbcrlf) 
					Response.Write("		<td class=""nowrap""><span class=""tooltip-text"" title="""& TarihFormatla(objRs("c_date")) &""">"& CreateDate &"</span></td>" & vbcrlf) 
					'Response.Write("		<td>"& objRs("id") &"</td>" & vbcrlf) 
					Response.Write("	</tr>" & vbcrlf)

				objRs.MoveNext() : Loop
			%>
			</tbody>
			<tfoot>
				<tr class="tfoot">
					<td colspan="4">
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
		Response.Write( Sayfala(ToplamCount, intSayfaSayisi, intSayfaNo) )
		End If
		Set objRs = Nothing 
		%>
		</div>
		<input type="submit" value="Kaydet" style="width:0 !important; height:0 !important; position:absolute !important; left:-9999px !important;" />
		<input type="hidden" id="views" name="views" value="0" />
		<input type="hidden" id="boxchecked" name="boxchecked" value="0" />
		<input type="hidden" id="total_records" name="total_records" value="<%=intCounter-1%>" />
		<input type="hidden" id="limitstart" name="limitstart" value="<%=SayfaLimitStart%>" />
		</form>
	</body>
</html>
