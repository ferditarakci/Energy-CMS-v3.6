<%
If GlobalConfig("request_option") = "Not Found" Then
	GlobalConfig("cpathway") = "<li class=""icon"">"& UCase2(Lang("err_not_found")) & "</li> "
	GlobalConfig("site_ismi") = Lang("err_not_found")
End If


'// Home Page Link Write
strLinks = ""
strLinks = strLinks & "<li class=""home-icon"">"
	strLinks = strLinks & "<a href="""
		strLinks = strLinks & UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", 0, 0, "")
	strLinks = strLinks & """ title=""Web Tasarım"">"& UCase2("Web Tasarım") & "</a>"
strLinks = strLinks & "</li> "



GlobalConfig("cpathway") = strLinks & GlobalConfig("cpathway")
GlobalConfig("cpathway") = "<ul>" & TrimFix(GlobalConfig("cpathway")) & "</ul>"



'clearfix GlobalConfig("request_option")
'// Page Title
Select Case GlobalConfig("request_option")
	Case GlobalConfig("General_Home")
		GlobalConfig("site_ismi") = GlobalConfig("default_site_ismi")

	Case GlobalConfig("General_Tags")
		GlobalConfig("site_ismi") = GlobalConfig("site_ismi") '& " - " & "&#34;webtasarimx.net&#34;"

	Case "Not Found"
		'GlobalConfig("site_ismi") = BasHarfBuyuk(GlobalConfig("site_ismi"))

	Case Else
		If GlobalConfig("site_ismi") <> "" Then
			If GlobalConfig("PageTitleFix") = "" Then
				GlobalConfig("site_ismi") = BasHarfBuyuk(GlobalConfig("site_ismi")) & " - " & GlobalConfig("default_site_ismi")
			Else
				GlobalConfig("site_ismi") = GlobalConfig("PageTitleFix")
			End If
		End If
End Select

If Not GlobalConfig("PageTitleFix") <> "" Then GlobalConfig("site_ismi") = HtmlEncode(GlobalConfig("site_ismi"))

'GlobalConfig("site_ismi") = BasHarfBuyuk( GlobalConfig("site_ismi") )
'GlobalConfig("site_ismi") = ilkHarfBuyuk( GlobalConfig("site_ismi") )
'GlobalConfig("site_ismi") = UCase2( GlobalConfig("site_ismi") )
'GlobalConfig("site_ismi") = LCase2( GlobalConfig("site_ismi") )


'Response.Write  GlobalConfig("cpathway")










Private Sub MundusModules(ByVal Modul_Yeri)
	Dim objRs
	OpenRs objRs, "SELECT kod FROM #___modul WHERE durum = 1 And yer = '"& Modul_Yeri &"' ORDER BY sira ASC;"
	Do While Not objRs.Eof
		Select Case objRs("kod")
			'Case "search" Call MundusSearchBox()

			Case "anamenu" Call MundusMainMenu(0)

			Case "faydali_bilgiler"
				'If Not GlobalConfig("request_option") = GlobalConfig("General_Home") Then Call MundusMakaleMenu(0)
				Call MundusFaydaliMenu(0)
				Call MundusMakaleMenu(0)

			Case "faydali_linkler"
				Call MundusMakaleMenu(0)

			Case "haberler" Call MundusNewsBox()

			Case "duyurular" Call MundusNewsBox()

			Case "facebook_like"
				If Not Site_LOCAL_ADDR = "127.0.0.1s" Then Call MundusFacebook()
				'If GlobalConfig("request_option") = GlobalConfig("General_Page") Then
				'	Call MundusTags(GlobalConfig("General_PagePN"), GlobalConfig("request_sayfaid"), GlobalConfig("site_lang"), False)
				'Else
				'	Call MundusTags("", "", GlobalConfig("site_lang"), False)
				'End If

			Case "anket"

				If Not (_
					GlobalConfig("request_option") = GlobalConfig("General_Search") Or _
					GlobalConfig("request_option") = GlobalConfig("General_Page") ) Then _
				Call MundusAnket()

			Case "e_bulten" Call MundusMailist()

			Case "hava_durumu" Call MundusHavaDurumu()

			Case "doviz_bilgileri" Call MundusTcmbDoviz()

		End Select
	objRs.MoveNext() : Loop
	CloseRs objRs
End Sub










Sub featuredFile(ByVal parent, ByVal parentid, ByVal slang)
	Dim SQL, objRs, strTagTitle, strTagAlt
		SQL = "SELECT IFNULL(title, '') As title, IFNULL(alt, '') As alt, IFNULL(url, '') As url, /* IFNULL(text, '') As text,*/ resim, parent_id FROM #___files" & vbCrLf
		SQL = SQL & "WHERE parent = "& parent &" And parent_id = "& parentid &" And lang = '"& slang &"' And featuredFile = 1 And durum = 1;"

	Set objRs = setExecute( SQL )
	If Not objRs.Eof Then
		Response.Write("<div class=""clearfix"" style=""margin-bottom:20px;"">" & vbCrLf)
			strTagTitle = objRs("title")
			strTagAlt = objRs("alt")
			PicturePath = sFolder(objRs("parent_id"), 0) & "/" & objRs("resim") & ""
			If Not FilesKontrol(PicturePath) Then PicturePath = "/images/blank.gif"

			If objRs("url") <> "" Then _
				Response.Write("<a href="""& objRs("url") &""" title="""& strTagTitle &""">")

				Response.Write("<img class=""img-center"" src="""& PicturePath &""" title="""& strTagTitle &""" alt="""& strTagAlt &""" />")

			If objRs("url") <> "" Then _
				Response.Write("</a>")

			Response.Write(vbCrLf)
		Response.Write("</div>" & vbCrLf)
	End If
	Set objRs = Nothing
End Sub















Sub MundusTags(ByVal parent, ByVal parentid, ByVal slang, ByVal virgul)
	Dim SQL, objRs, strTagTitle

	SQL = ""
	SQL = SQL & "SELECT a.etiket, a.permalink, b.lang FROM #___etiket As a" & vbCrLf
	SQL = SQL & "INNER JOIN #___etiket_id As b ON a.id = b.eid" & vbCrLf
	SQL = SQL & "WHERE" & vbCrLf
	SQL = SQL & "a.status = 1 And b.lang = '"& slang &"'" & vbCrLf
	If parent <> "" Then
		SQL = SQL & "And b.parent = "& parent &" And b.parent_id = "& parentid &"" & vbCrLf
		If GlobalConfig("request_option") = GlobalConfig("General_Tags") Then
			SQL = SQL & "And Not a.id = '"& GlobalConfig("request_sayfaid") &"'" & vbCrLf
		End If
	Else
		SQL = SQL & "ORDER BY Rand() Limit 10" & vbCrLf
	End If
	SQL = SQL & ";"

	Set objRs = setExecute( SQL )
	If Not objRs.Eof Then
		Response.Write("<div class=""etiketler"">" & vbCrLf)
		Response.Write("	<strong>"& Lang("tagsTitles") &" :</strong>" & vbCrLf)
		a = 1
		Do While Not objRs.Eof
			strTagTitle = objRs("etiket")
			If Not a = 1 And virgul Then Response.Write(", " & vbCrLf)
			Response.Write("	<a rel=""tag"" href="""& UrlWrite("", slang, GlobalConfig("General_Tags"), "", objRs("permalink"), "", "", "") &""" title="""& strTagTitle &"""><span>" & strTagTitle & "</span></a>")
			a = a + 1
		objRs.MoveNext() : Loop
		Response.Write(vbCrLf & "</div>" & vbCrLf)
	End If
	Set objRs = Nothing
End Sub











'// Makale Çağır
Sub MundusGetPages(ByVal EnergyType, ByVal EnergyOrder, ByVal EnergyDate, ByVal ModVal1, ByVal ModVal2)

	Dim sSQL, objRs, Count, intTotalRecord, intid, strTitle
	Dim blnTitleStatus, strCDate, strText, strLinks, addClass, blnDivKapat

	sSQL = ""
	sSQL = sSQL & "SELECT" & vbCrLf
	sSQL = sSQL & "    a.id" & vbCrLf
	sSQL = sSQL & "    ,a.titleStatus" & vbCrLf
	sSQL = sSQL & "    ,IFNULL(b.title, '') As title" & vbCrLf
	sSQL = sSQL & "    ,IFNULL(b.text, '') As text" & vbCrLf
	sSQL = sSQL & "    ,IFNULL(b.readmore_text, '') As readmore_text" & vbCrLf
	'sSQL = sSQL & "    ,(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date" & vbCrLf
	'sSQL = sSQL & "    ,(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
	sSQL = sSQL & "FROM #___sayfa As a" & vbCrLf
	sSQL = sSQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	sSQL = sSQL & "INNER JOIN #___content_home_template As c ON a.anasyfAlias = c.alias" & vbCrLf
	sSQL = sSQL & "WHERE (" & vbCrLf
	sSQL = sSQL & "    a.durum = 1" & vbCrLf
	sSQL = sSQL & "    And a.anasyf = 1" & vbCrLf
	sSQL = sSQL & "    And a.anasyfAlias = '"& EnergyType &"'" & vbCrLf
	sSQL = sSQL & "    And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	sSQL = sSQL & "    And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	sSQL = sSQL & "    And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
	sSQL = sSQL & "    And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
	sSQL = sSQL & ")" & vbCrLf
	sSQL = sSQL & "Order By "& EnergyOrder &"" & vbCrLf
	sSQL = sSQL & ";" & vbCrLf
	'sSQL = setQuery(sSQL)
	'Clearfix sSQL

	OpenRs objRs, sSQL
		If Not objRs.Eof Then
			Count = 1 : intTotalRecord = objRs.RecordCount

			With Response
				.Write(vbCrLf & "		<div class=""contents"">" & vbCrLf)

				Do While Not objRs.Eof
					'blnDivKapat = False
					intid = objRs("id")
					strTitle = HtmlEncode(objRs("title"))
					blnTitleStatus = CBool(objRs("titleStatus"))
					'strCDate = objRs("c_date") & ""
					'strMDate = objRs("m_date") & ""
					'If strMDate <> "" Then strCDate = strMDate
					strText = objRs("text") & ""
					strText = PageBreakReplace(strText)
					strText = fnPre(strText, GlobalConfig("sBase"))
					strLinks = UrlWrite(GlobalConfig("sBase"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", intid, "", "")

					addClass = "" : If Count Mod ModVal1 = ModVal2 Then addClass = "sol" Else  addClass = "sag"

					'If (Count Mod ModVal1 = ModVal2) Or ModVal1 = 1 Then _
					'	.Write("			<div class=""sutun"">" & vbCrLf)

					'.Write("				<div class="""& addClass &""">" & vbCrLf)
					'.Write("					<div class=""background"">" & vbCrLf)

					If blnTitleStatus Then
						.Write("<h1 class=""title"" id="""& SefURL(strTitle) &""">")
						If strLinks <> "javascript:;" Then
							.Write("<a class="""& SefURL(strTitle) &""" href="""& strLinks &""" title="""& BasHarfBuyuk(strTitle) &""">"& strTitle &"</a>")
						Else
							.Write( strTitle )
						End If
						.Write("</h1>" & vbCrLf)
					End If

					'addClass = "" : If Not EnergyDate = "OK" Then addClass = " hidden"
					'If blnTitleStatus Then _ 
					'	.Write("						<abbr title="""& DateSqlFormat(strCDate, "yy-mm-dd", 1) &""" class=""dates"& addClass &""">"& TarihFormatla( strCDate ) &"</abbr>" & vbCrLf)

					.Write("						<div class=""clr""></div>" & vbCrLf)

					.Write(							ReadMore("class=""smallbtn2"" rel=""bookmark""", strTitle, ReadMoreText(objRs("readmore_text")), strLinks, strText) & vbCrLf)

					.Write("						<div class=""clr""></div>" & vbCrLf)
					'.Write("					</div>" & vbCrLf)
					'.Write("					<div class=""clr""></div>" & vbCrLf)
					'.Write("				</div>" & vbCrLf)

					'If Count Mod ModVal1 = (ModVal2 = Count) Then _
					'	.Write("			</div>" & vbCrLf): blnDivKapat = True

					'If Not (intTotalRecord = Count) Then .Write(vbCrLf & "<div class=""clr divider""></div>" & vbCrLf)
					If Not (intTotalRecord = Count) Then
						.Write(vbCrLf & "<div class=""clr""></div>" & vbCrLf)
						.Write(vbCrLf & "<div class=""ewy_hr"" style=""margin:20px 0px;""><hr /></div>" & vbCrLf)
						.Write(vbCrLf & "<div class=""clr""></div>" & vbCrLf)
					End If
					Count = Count + 1

				objRs.MoveNext() : Loop

				'If Not blnDivKapat Then .Write("			</div>" & vbCrLf)

				.Write("		</div> <!-- .contents End -->" & vbCrLf)
			End With
		End If
	CloseRs objRs
End Sub












'// Üst Menü
'Call MundusTopMenu(0)
Sub MundusTopMenu(ByVal intAnaid)

	Dim strCreateHtml
	strCreateHtml = ""
	'strCreateHtml = strCreateHtml & "<div{!linkParentClass}>"
		strCreateHtml = strCreateHtml & "<a {!rel} {!style} class=""{!arrowClass}{!class}"" href=""{!href}"" {!title} {!target}>"
			strCreateHtml = strCreateHtml & "<span class=""nav-tag"">{!tag}</span>"
		strCreateHtml = strCreateHtml & "</a>"
	'strCreateHtml = strCreateHtml & "</div>"

	Response.Write(vbCrLf)
	Response.Write("<ul class=""nav clearfix"" id=""navlist"">" & vbCrLf)
	Call EnergyMenuFonksiyon(strCreateHtml, "ustmenu", intAnaid, 0)
	Response.Write(vbCrLf & "</ul> <!-- #navlist End -->" & vbCrLf)
End Sub











'Call MundusMainMenu(0)
Sub MundusMainMenu(ByVal intAnaid)
	Dim strCreateHtml
	strCreateHtml = ""
	strCreateHtml = ""
	'strCreateHtml = strCreateHtml & "<div{!linkParentClass}>"
		strCreateHtml = strCreateHtml & "<a {!rel} {!style} class=""{!arrowClass}{!class}"" href=""{!href}"" {!title} {!target}><span>{!tag}</span></a>"
	'strCreateHtml = strCreateHtml & "</div>"

	With Response
		.Write("<div class=""module"">" & vbCrLf)
		'.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("anamenu")) &"</span></h6>" & vbCrLf)
		.Write("	<h3 class=""box_title"" title=""Web Tasarım Hizmetlerimiz""><span><i style=""display:none;"">WEB TASARIM</i> HİZMETLERİMİZ</span></h3>" & vbCrLf)
		.Write("	<nav>" & vbCrLf)
		.Write("		<ul class=""useful_nav menu"">" & vbCrLf)
		Call EnergyMenuFonksiyon(strCreateHtml, "anamenu", intAnaid, 0)
		.Write("		</ul>" & vbCrLf)
		.Write("	</nav>" & vbCrLf)
		.Write("</div>" & vbCrLf)
	End With
End Sub





'Call MundusMainMenu(0)
Sub MundusFaydaliMenu(ByVal intAnaid)
	Dim strCreateHtml
	strCreateHtml = ""
	strCreateHtml = ""
	'strCreateHtml = strCreateHtml & "<div{!linkParentClass}>"
		strCreateHtml = strCreateHtml & "<a {!rel} {!style} class=""{!arrowClass}{!class}"" href=""{!href}"" {!title} {!target}><span>{!tag}</span></a>"
	'strCreateHtml = strCreateHtml & "</div>"

	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("faydali")) &"</span></h6>" & vbCrLf)
		.Write("	<nav>" & vbCrLf)
		.Write("		<ul class=""useful_nav menu"">" & vbCrLf)
		Call EnergyMenuFonksiyon(strCreateHtml, "faydali_bilgi", intAnaid, 0)
		.Write("		</ul>" & vbCrLf)
		.Write("	</nav>" & vbCrLf)
		.Write("</div>" & vbCrLf)
	End With
End Sub












'Call MundusMakaleMenu(0)
Sub MundusMakaleMenu(ByVal intAnaid)
	Dim strCreateHtml
	strCreateHtml = ""
	strCreateHtml = ""
	'strCreateHtml = strCreateHtml & "<div{!linkParentClass}>"
		strCreateHtml = strCreateHtml & "<a {!rel} {!style} class=""{!arrowClass}{!class}"" href=""{!href}"" {!title} {!target}><span>{!tag}</span></a>"
	'strCreateHtml = strCreateHtml & "</div>"

	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("makaleler")) &"</span></h6>" & vbCrLf)
		.Write("	<nav>" & vbCrLf)
		.Write("		<ul class=""useful_nav menu"">" & vbCrLf)
		Call EnergyMenuFonksiyon(strCreateHtml, "makaleler", intAnaid, 0)
		.Write("		</ul>" & vbCrLf)
		.Write("	</nav>" & vbCrLf)
		.Write("</div>" & vbCrLf)
	End With
End Sub











'Call MundusHizmetlerMenu(0)
Sub MundusHizmetlerMenu(ByVal intAnaid)
	Dim strCreateHtml
	strCreateHtml = ""
	strCreateHtml = ""
	'strCreateHtml = strCreateHtml & "<div{!linkParentClass}>"
		strCreateHtml = strCreateHtml & "<a {!rel} {!style} class=""{!arrowClass}{!class}"" href=""{!href}"" {!title} {!target}><span>{!tag}</span></a>"
	'strCreateHtml = strCreateHtml & "</div>"

	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>HİZMETLERİMİZ</span></h6>" & vbCrLf)
		.Write("	<nav>" & vbCrLf)
		.Write("		<ul class=""useful_nav menu"">" & vbCrLf)
		Call EnergyMenuFonksiyon(strCreateHtml, "hizmetler", intAnaid, 0)
		.Write("		</ul>" & vbCrLf)
		.Write("	</nav>" & vbCrLf)
		.Write("</div>" & vbCrLf)
	End With
End Sub











'Call MundusProgramMenu(0)
Sub MundusProgramMenu(ByVal intAnaid)
	Dim strCreateHtml
	strCreateHtml = ""
	strCreateHtml = ""
	'strCreateHtml = strCreateHtml & "<div{!linkParentClass}>"
		strCreateHtml = strCreateHtml & "<a {!rel} {!style} class=""{!arrowClass}{!class}"" href=""{!href}"" {!title} {!target}><span>{!tag}</span></a>"
	'strCreateHtml = strCreateHtml & "</div>"

	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>WEB PROGRAMLAMA</span></h6>" & vbCrLf)
		.Write("	<nav>" & vbCrLf)
		.Write("		<ul class=""useful_nav menu"">" & vbCrLf)
		Call EnergyMenuFonksiyon(strCreateHtml, "programlama", intAnaid, 0)
		.Write("		</ul>" & vbCrLf)
		.Write("	</nav>" & vbCrLf)
		.Write("</div>" & vbCrLf)
	End With
End Sub








'// Alt Menü
'Call MundusFooterEtiketMenu(0)
Sub MundusFooterEtiketMenu(ByVal intAnaid)
	Response.Write("<div class=""fr clearfix"">" & vbCrLf)
	Response.Write("	<nav class=""footer-nav clearfix"">" & vbCrLf)
	Response.Write("		<ul id=""seo-title"" class=""clearfix"">" & vbCrLf)
	Call EnergyMenuFonksiyon("<a href=""{!href}"" {!style} {!target} {!rel}>{!tag}</a>", "etiketler", intAnaid, 0)
	Response.Write(vbCrLf)
	Response.Write("		</ul>" & vbCrLf)
	Response.Write("	</nav>" & vbCrLf)
	Response.Write("</div>" & vbCrLf)
End Sub




'// Alt Menü
'Call MundusFooterMenu(0)
Sub MundusFooterMenu(ByVal intAnaid)
	Response.Write("<div class=""fr clearfix"">" & vbCrLf)
	Response.Write("	<nav class=""footer-nav clearfix"">" & vbCrLf)
	Response.Write("		<ul class=""clearfix"">" & vbCrLf)
	Call EnergyMenuFonksiyon("<a href=""{!href}"" {!title} {!style} {!target} {!rel}>{!tag}</a>", "altmenu", intAnaid, 0)
	Response.Write(vbCrLf)
	Response.Write("		</ul>" & vbCrLf)
	Response.Write("	</nav>" & vbCrLf)
	Response.Write("</div>" & vbCrLf)
End Sub












Sub MundusHavaDurumu()
	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("havadurumu_title")) &"</span></h6>" & vbCrLf)
		.Write("	<div class=""pdng clearfix"">" & vbCrLf)
		.Write("		<ul class=""clearfix"" style=""list-style:none; margin:0; padding:0; width:100%; text-align:center; font-size:11px;"">" & vbCrLf)
		.Write("			<li style=""float:left; width:33.3%; *width:33%;""><a href=""http://www.mgm.gov.tr/tahmin/il-ve-ilceler.aspx?m=ISTANBUL"" title=""İstanbul&apos;da Önümüzdeki 5 Gün Hava Tahmini İçin Tıklayın"" target=""_blank"">İstanbul<br /><img src=""http://www.mgm.gov.tr/sunum/tahmingor-a1.aspx?g=1&amp;m=ISTANBUL"" width=""50"" height=""50"" alt=""İSTANBUL"" /></a><br /></li>" & vbCrLf)
		.Write("			<li style=""float:left; width:33.3%; *width:33%;""><a href=""http://www.mgm.gov.tr/tahmin/il-ve-ilceler.aspx?m==ANKARA"" title=""Ankara&apos;da Önümüzdeki 5 Gün Hava Tahmini İçin Tıklayın"" target=""_blank"">Ankara<br /><img src=""http://www.mgm.gov.tr/sunum/tahmingor-a1.aspx?g=1&amp;m=ANKARA"" width=""50"" height=""50"" alt=""ANKARA"" /></a><br /></li>" & vbCrLf)
		.Write("			<li style=""float:left; width:33.3%; *width:33%;""><a href=""http://www.mgm.gov.tr/tahmin/il-ve-ilceler.aspx?m=IZMIR"" title=""İzmir&apos;de Önümüzdeki 5 Gün Hava Tahmini İçin Tıklayın"" target=""_blank"">İzmir<br /><img src=""http://www.mgm.gov.tr/sunum/tahmingor-a1.aspx?g=1&amp;m=IZMIR"" width=""50"" height=""50"" alt=""İZMİR"" /></a><br /></li>" & vbCrLf)
		.Write("			<li style=""float:left; width:33.3%; *width:33%;""><a href=""http://www.mgm.gov.tr/tahmin/il-ve-ilceler.aspx?m=SAMSUN"" title=""Samsun&apos;da Önümüzdeki 5 Gün Hava Tahmini İçin Tıklayın"" target=""_blank"">Samsun<br /><img src=""http://www.mgm.gov.tr/sunum/tahmingor-a1.aspx?g=1&amp;m=SAMSUN"" width=""50"" height=""50"" alt=""SAMSUN"" /></a></li>" & vbCrLf)
		.Write("			<li style=""float:left; width:33.3%; *width:33%;""><a href=""http://www.mgm.gov.tr/tahmin/il-ve-ilceler.aspx?m=ADANA"" title=""Adana&apos;da Önümüzdeki 5 Gün Hava Tahmini İçin Tıklayın"" target=""_blank"">Adana<br /><img src=""http://www.mgm.gov.tr/sunum/tahmingor-a1.aspx?g=1&amp;m=ADANA"" width=""50"" height=""50"" alt=""ADANA"" /></a></li>" & vbCrLf)
		.Write("			<li style=""float:left; width:33.3%; *width:33%;""><a href=""http://www.mgm.gov.tr/tahmin/il-ve-ilceler.aspx?m=DIYARBAKIR"" title=""Diyarbakır&apos;da Önümüzdeki 5 Gün Hava Tahmini İçin Tıklayın"" target=""_blank"">Diyarbakır<br /><img src=""http://www.mgm.gov.tr/sunum/tahmingor-a1.aspx?g=1&amp;m=DIYARBAKIR"" width=""50"" height=""50"" alt=""DİYARBAKIR"" /></a></li>" & vbCrLf)
		.Write("		</ul>" & vbCrLf)
		.Write("	</div>" & vbCrLf)
		.Write("</div>")
	End With
End Sub







Sub MundusTcmbDoviz()
	On Error Resume Next
	Dim TcmbDovizCek, GetTur, TcmbDoviz1, TcmbDoviz2, TcmbDoviz3, TcmbDoviz4, TcmbDoviz5, TcmbDoviz6, s, SonDate

	'Application.Contents.Remove("TcmbDovizTime")

	'Clearfix (Application("TcmbDovizTime")) & " " & _
	'(DateDiff("s", Application("TcmbDovizTime"), "21.03.2012 07:14:40"))
	's = 0
	
	If (Application("TcmbDovizTime") = "" Or DateDiff("s", Application("TcmbDovizTime"), Now()) >= 1) Then
		'If Hour(Now()) > 8 And Hour(Now()) < 18 Then
			TcmbDovizCek = GETHTTP("http://www.tcmb.gov.tr/kurlar/today.html")
			's = 1
			GetTur = inStr(1, TcmbDovizCek, "USD", 1)
			TcmbDoviz1 = Mid(TcmbDovizCek, GetTur + 42, 6)
			TcmbDoviz2 = Mid(TcmbDovizCek, GetTur + 55, 6)
			If Err <> 0 Then TcmbDoviz1 = 0 : TcmbDoviz2 = 0

			GetTur = inStr(1, TcmbDovizCek, "EUR", 1)
			TcmbDoviz3 = Mid(TcmbDovizCek, GetTur + 42, 6)
			TcmbDoviz4 = Mid(TcmbDovizCek, GetTur + 55, 6)
			If Err <> 0 Then TcmbDoviz3 = 0 : TcmbDoviz4 = 0

			GetTur = inStr(1, TcmbDovizCek, "GBP", 1)
			TcmbDoviz5 = Mid(TcmbDovizCek, GetTur + 37, 6)
			TcmbDoviz6 = Mid(TcmbDovizCek, GetTur + 50, 6)
			If Err <> 0 Then TcmbDoviz5 = 0 : TcmbDoviz6 = 0

			SonDate = Application("TcmbDovizTime") & vbTab
			Application.Lock
			Application("TcmbDovizTime") = DateAdd("h", 1, Now())
			Application("TcmbDoviz") = Array(TcmbDoviz1, TcmbDoviz2, TcmbDoviz3, TcmbDoviz4, TcmbDoviz5, TcmbDoviz6)
			Application.UnLock
		'End If
	End If

	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("tcmb_title")) &"</span></h6>" & vbCrLf)
		.Write("	<div class=""pdng clearfix"">" & vbCrLf)
		.Write("		<ul class=""modul-liste clearfix"">" & vbCrLf)
		'// Dolar
		.Write("			<li><span><em>:</em> "& Lang("tcmb_dolar_alis") &"</span> "& Application("TcmbDoviz")(0) &" TL</li>" & vbCrLf)
		.Write("			<li><span><em>:</em> "& Lang("tcmb_dolar_satis") &"</span> "& Application("TcmbDoviz")(1) &" TL</li>" & vbCrLf)
		'// Euro
		.Write("			<li><span><em>:</em> "& Lang("tcmb_euro_alis") &"</span> "& Application("TcmbDoviz")(2) &" TL</li>" & vbCrLf)
		.Write("			<li><span><em>:</em> "& Lang("tcmb_euro_satis") &"</span> "& Application("TcmbDoviz")(3) &" TL</li>" & vbCrLf)
		'// Sterlin
		.Write("			<li><span><em>:</em> "& Lang("tcmb_sterlin_alis") &"</span> "& Application("TcmbDoviz")(4) &" TL</li>" & vbCrLf)
		.Write("			<li class=""last""><span><em>:</em> "& Lang("tcmb_sterlin_satis") &"</span> "& Application("TcmbDoviz")(5) &" TL</li>" & vbCrLf)
		.Write("		</ul>" & vbCrLf)
		.Write("		<div class=""clearfix"">" & SonDate & Application("TcmbDovizTime") & "</div>" & vbCrLf)
		.Write("	</div>" & vbCrLf)
		.Write("</div>") 
	End With
	On Error Goto 0
End Sub
























Sub MundusFacebook()
	GlobalConfig("facebook_url") = GlobalConfig("facebook_url") & ""
	If GlobalConfig("facebook_url") = "" Then Exit Sub

	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("face_title")) &"</span></h6>" & vbCrLf)
		.Write("	<div id=""facelike"" class=""clearfix"">" & vbCrLf)
		.Write("		<div id=""fb-root""></div><script type=""text/javascript"" src=""http://connect.facebook.net/tr_TR/all.js#xfbml=1""></script>" & vbCrLf)
		.Write("	</div>" & vbCrLf)
		.Write("</div>" & vbCrLf)
		.Write("<script type=""text/javascript"">" & vbCrLf)
		.Write("/*<![CDATA[*/" & vbCrLf)
		.Write("$(document).ready(function() {" & vbCrLf)
		.Write("	$('#fb-root').append('<fb:like-box href="""& GlobalConfig("facebook_url") &""" colorscheme=""light"" width=""295"" height=""190"" show_faces=""true"" stream=""false"" header=""false""></fb:like-box>');" & vbCrLf)
		.Write("});" & vbCrLf)
		.Write("/*]]>*/" & vbCrLf)
		.Write("</script>")
	End With
End Sub













Sub MundusAnket()
	Dim ToplamAnket, intOy, TotalOy, nobg, SecenekTitle, SecenekOy
	SQL = ""
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	id, title" & vbCrLf
	SQL = SQL & "FROM #___anket" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	durum = 1" & vbCrLf
	SQL = SQL & "	And lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "	And (s_date = '"& DateTimeNull &"' OR s_date Is Null OR s_date <= Now())" & vbCrLf
	SQL = SQL & "	And (e_date = '"& DateTimeNull &"' OR e_date Is Null OR e_date >= Now())" & vbCrLf
	SQL = SQL & ")"
	SQL = SQL & "ORDER BY sira ASC, title ASC;"
	SQL = setQuery( SQL )
	Set objRs = Server.CreateObjecT("ADODB.Recordset")
	objRs.Open SQL, data, 1, 3 
	If Not objRs.Eof Then
	ToplamAnket = objRs.RecordCount
		With Response
			.Write("<script type=""text/javascript"">" & vbCrLf)
			.Write("/*<![CDATA[*/" & vbCrLf)
			.Write("var ewyError = '"& Duzenle(Lang("ewyError")) &"'," & vbCrLf)
			.Write("    ewyLoading = '"& Duzenle(Lang("ewyLoading")) &"';" & vbCrLf)
			.Write("	$(function() {" & vbCrLf)
			.Write("		$("".anket .buttonSet"").buttonset();" & vbCrLf)
			.Write("	});" & vbCrLf)
			.Write("/*]]>*/" & vbCrLf)
			.Write("</script>")
			.Write("<div class=""module"">" & vbCrLf)
			.Write("				<h6 class=""box_title""><span>"& UCase2(Lang("anket_title")) &"</span></h6>" & vbCrLf)
			.Write("				<div class=""pdng"">" & vbCrLf)
			For a = 1 To ToplamAnket
				If objRs.Eof Then Exit For
				addClass = "" : If (ToplamAnket = a) Then addClass = " nobg"

					.Write("					<form id=""energy_anket"& a &""" name=""energy_anket"& a &""" action="""& UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Post"), "anket", "", "", "", "") &""" method=""post"" onsubmit=""return EnergyFormSubmit(this.id);"">" & vbCrLf)
					.Write("						<div class=""anket"& addClass &" clearfix"">" & vbCrLf)
					.Write("							<h5 class=""a_title"">"& BasHarfBuyuk( objRs("title") ) &"</h5>" & vbCrLf)

					TotalOy = Cdbl(sqlQuery("SELECT Sum( oy ) toplam FROM #___anket_secenek WHERE anketid = "& objRs("id") &";", 1))
					If TotalOy = 0 Then TotalOy = 1

					Set objRs2 = setExecute("SELECT secenekid, secenek, oy FROM #___anket_secenek WHERE anketid = "& objRs("id") &";")
					If objRs2.Eof Then
						.Write("	<div style=""text-align:center; color:red"">"& BasHarfBuyuk( Lang("anket_secenek_err") ) &"</div>")
					Else
						.Write("							<ul class=""buttonSet"">" & vbCrLf)
						i = 1
						Do While Not objRs2.Eof
							intOy = intYap(objRs2("oy"), 1) : If intOy = 0 Then intOy = 1
							SecenekTitle = BasHarfBuyuk(objRs2("secenek"))
							SecenekOy = ((intOy / TotalOy) * 100)
							SecenekOyTitle = Lang("anket_mesaj")
							SecenekOyTitle = Replace(SecenekOyTitle, "[Title]", objRs2("secenek"))
							SecenekOyTitle = Replace(SecenekOyTitle, "[Count]", intOy)
							SecenekOyTitle = Replace(SecenekOyTitle, "[Yuzde]", FormatNumber(SecenekOy, 1))
							.Write("								<li>" & vbCrLf)
							.Write("									<div class=""radio""><input name=""aid"" id=""anket_"& a & "_" & i &""" value="""& objRs2("secenekid") &""" type=""radio"" /></div>" & vbCrLf)
							.Write("									<div class=""text""><label for=""anket_"& a & "_" & i &""" title="""& SecenekOyTitle &""">"& SecenekTitle &"</label></div>" & vbCrLf)
							.Write("									<div class=""clr""></div>" & vbCrLf)
							.Write("								</li>" & vbCrLf)
							i = i + 1
						objRs2.MoveNext() : Loop
						.Write("							</ul>" & vbCrLf)
						.Write("							<div class=""button"">" & vbCrLf)
						.Write("								<span class=""ie""><input class=""button"" value="""& Lang("anket_buton_01") &""" title="""& Lang("anket_buton_01") &""" name=""e-submit"" type=""submit"" /></span> " & vbCrLf)
						.Write("								<span class=""ie""><input class=""button"" value="""& Lang("anket_buton_02") &""" title="""& Lang("anket_buton_02") &""" type=""button"" onclick=""window.open('"& UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Poll"), "", "", objRs("id"), "", "") &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=500'); return false;"" /></span>" & vbCrLf)
						.Write("							</div>" & vbCrLf)
					End If
				Set objRs2 = Nothing
			.Write("							<div id=""energy_anket"& a &"Msj"" class=""hidden""></div>" & vbCrLf)
			.Write("						</div>" & vbCrLf)
			.Write("						<div class=""hidden""><input type=""hidden"" name=""energy"" value=""OK"" /></div>" & vbCrLf)
			.Write("					</form>" & vbCrLf)
			objRs.MoveNext() : Next
			'.Write("<div class=""ewy_sys_msg success""><div class=""ewy_messages""><span>Oylama yapabilmek için bir seçenek seçmelisiniz.</span></div></div>" & vbCrLf)
			'.Write("<div class=""ewy_sys_msg warning""><div class=""ewy_messages""><span>Oylama yapabilmek için bir seçenek seçmelisiniz.</span></div></div>" & vbCrLf)
			'.Write("<div class=""ewy_sys_msg error""><div class=""ewy_messages""><span>Oylama yapabilmek için bir seçenek seçmelisiniz.</span></div></div>" & vbCrLf)
			'.Write("<div class=""ewy_sys_msg info""><div class=""ewy_messages""><span>Oylama yapabilmek için bir seçenek seçmelisiniz.</span></div></div>" & vbCrLf)
			'.Write("<div class=""ewy_sys_msg loading""><div class=""ewy_messages""><span>Oylama yapabilmek için bir seçenek seçmelisiniz.</span></div></div>" & vbCrLf)
		.Write("				</div>" & vbCrLf)
		.Write("</div>" & vbCrLf)
		End With
	End If
	objRs.Close : Set objRs = Nothing
End Sub


















Sub MundusMailist()
	With Response
		.Write("<div class=""module"">" & vbCrLf)
		.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("mailist_title")) &"</span></h6>" & vbCrLf)
		.Write("	<div class=""pdng clearfix"">" & vbCrLf)
		.Write("	<form id=""energy_mailist_form"" name=""energy_mailist_form"" action="""& UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Post"), "mail-ekle", "", 0, 0, "") &""" method=""post"" onsubmit=""return EnergyFormSubmit(this.id);"">" & vbCrLf)
		.Write("		<ul class=""mailist clearfix"">" & vbCrLf)
		.Write("			<li class=""text"">"& Lang("mailist_text") &"</li>" & vbCrLf)
		.Write("			<li><input style=""width:100%; *width:95%;"" class=""inputbox"" type=""text"" name=""mailist_isim"" id=""mailist_isim"" maxlength=""50"" title="""& Lang("mailist_isim_gir") &""" value="""& Lang("mailist_isim_gir") &""" onblur=""if(this.value=='') this.value='"& Lang("mailist_isim_gir") &"';"" onfocus=""if(this.value=='"& Lang("mailist_isim_gir") &"') this.value='';"" /></li>" & vbCrLf)
		.Write("			<li><input style=""width:100%; *width:95%;"" class=""inputbox"" type=""text"" name=""mailist_email"" id=""mailist_email"" maxlength=""50"" title="""& Lang("mailist_mail_adresi_gir") &""" value="""& Lang("mailist_mail_adresi_gir") &""" onblur=""if(this.value=='') this.value='"& Lang("mailist_mail_adresi_gir") &"';"" onfocus=""if(this.value=='"& Lang("mailist_mail_adresi_gir") &"') this.value='';"" /></li>" & vbCrLf)
		.Write("			<li class=""center""><span class=""ie""><input class=""button"" title="""& Lang("mailist_kaydol") &""" value="""& Lang("mailist_kaydol") &""" name=""e-submit"" type=""submit"" /></span></li>" & vbCrLf)
		.Write("		</ul>" & vbCrLf)
		.Write("		<div class=""hidden""><input type=""hidden"" name=""energy"" value=""OK"" /></div>" & vbCrLf)
		.Write("	</form>" & vbCrLf)
		.Write("	<div id=""energy_mailist_formMsj"" class=""hidden""></div>" & vbCrLf)
		.Write("	</div>" & vbCrLf)
		.Write("</div>")
	End With
End Sub

















Sub MundusSearchBox()
	Dim sText, sUrl' : GlobalConfig("seo_url") = False
	If GlobalConfig("request_q") <> "" Then sText = GlobalConfig("request_q") Else sText = Lang("ara_arama")
	sUrl = Replace(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Search"), "{search}", "", "", "", ""), "&amp;", "&")
	With Response
		.Write("<div class=""module"">" & vbCrLf)
		'.Write("				<div class=""box_title hidden""><span>"& UCase2(Lang("ara_title")) &"</span></div>" & vbCrLf)
		.Write("				<form id="""& ewy_querySearch &"_form"" name="""& ewy_querySearch &"_form"" action="""& GlobalConfig("sBase") &""" method=""get"" onsubmit=""return ewy_search();"">" & vbCrLf)
		If Not GlobalConfig("default_lang") = GlobalConfig("site_lang") Then _
		.Write("					<div class=""hidden""><input name="""& ewy_queryLang &""" value="""& LCase(GlobalConfig("site_lang")) &""" type=""hidden"" /></div>" & vbCrLf)
		.Write("					<div class=""hidden""><input name="""& ewy_queryOption &""" value="""& GlobalConfig("General_Search") &""" type=""hidden"" /></div>" & vbCrLf)
		.Write("					<div class=""search"">" & vbCrLf)
		.Write("						<div class=""sinput""><input class=""inputbox"" type=""text"" name="""& ewy_querySearch &""" id="""& ewy_querySearch &""" title="""& Lang("ara_arama") &""" value="""& sText &""" onblur=""if($(this).val() == '') $(this).val('"& Lang("ara_arama") &"').css('color', '#a8a8a8');"" onfocus=""if($(this).val() == '"& Lang("ara_arama") &"') $(this).val('').css('color', '#fff');"" /></div>" & vbCrLf)
		.Write("						<div class=""sbutton""><input type=""submit"" title="""& Lang("ara_02") &""" value="""& Lang("ara_02") &""" /></div>" & vbCrLf)
		.Write("					</div>" & vbCrLf)
		.Write("				</form>" & vbCrLf)
		.Write("</div>" & vbCrLf)
		.Write("<!--googleoff: index-->" & vbCrLf)
		.Write("<script type=""text/javascript"">" & vbCrLf)
		.Write("/*<![CDATA[*/" & vbCrLf)
		.Write("	function ewy_search() {" & vbCrLf)
		.Write("		var sQuery = $(""#"& ewy_querySearch &""");" & vbCrLf)
		.Write("		var sVal = sQuery.val();" & vbCrLf)
		.Write("		if (sVal == """" || sVal == """& Lang("ara_arama") &""") {" & vbCrLf)
		.Write("			alert("""& Lang("ara_01") &""");" & vbCrLf)
		.Write("			sQuery.focus();" & vbCrLf)
		.Write("		} else {" & vbCrLf)
		'If GlobalConfig("seo_url") Then
		'	.Write("			var url = """& sUrl &""";" & vbCrLf)
		'	.Write("			url = url.replace(/{search}/gi, sVal).replace(/([ ]|[+]{2,})/g, ""+"");" & vbCrLf)
		'	.Write("			window.document.location.href = url;" & vbCrLf)
		'Else
			.Write("			$(""#"& ewy_querySearch &"_form"").submit();" & vbCrLf)
		'End If
		.Write("		}" & vbCrLf)
		.Write("		return false;" & vbCrLf)
		.Write("	}" & vbCrLf)
		.Write("/*]]>*/" & vbCrLf)
		.Write("</script>" & vbCrLf)
		.Write("<!--googleon: index-->")
	End With
End Sub


















Sub MundusNewsBox()
	Dim sSQL, objSubRs, strTitleStatus, strTitle, strText

	sSQL = ""
	sSQL = sSQL & "SELECT" & vbCrLf
	sSQL = sSQL & "    a.id, a.titleStatus, b.title, b.text" & vbCrLf
	sSQL = sSQL & "FROM #___sayfa As a" & vbCrLf
	sSQL = sSQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	sSQL = sSQL & "WHERE (" & vbCrLf
	sSQL = sSQL & "    a.durum = 1" & vbCrLf
	sSQL = sSQL & "    And a.anasyfAlias = 'slider'" & vbCrLf
	sSQL = sSQL & "    And b.parent = "& GlobalConfig("General_PagePN") &"" & vbCrLf
	sSQL = sSQL & "    And b.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	sSQL = sSQL & "    And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
	sSQL = sSQL & "    And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
	sSQL = sSQL & ")" & vbCrLf
	sSQL = sSQL & "ORDER BY a.sira ASC;"
	'sSQL = setQuery( sSQL )
	'Clearfix ssql
	Set objSubRs = setExecute( sSQL )
	If Not objSubRs.Eof Then
		With Response
			.Write("<div class=""module"">" & vbCrLf)
			.Write("	<h6 class=""box_title""><span>"& UCase2(Lang("haberler")(0)) &"</span></h6>" & vbCrLf)
			.Write("	<div id=""haberler"">" & vbCrLf)
			.Write("		<div id=""jcarousellite"">" & vbCrLf)
			.Write("			<ul class=""news"">" & vbCrLf)
			Do While Not objSubRs.Eof
				strTitleStatus = CBool(objSubRs("titleStatus"))
				strTitle = objSubRs("title")
				strText = objSubRs("text")

				strText = Replace(strText, "<hr class=""system-pagebreak""", "<hr class=""system-pagebreak"" style=""display:none""")
				strText = fnPre(strText, GlobalConfig("sBase"))
				strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", objSubRs("id"), 0, "")
				strText = Replace(Replace(ReadMore("devami", strTitle, Lang("haber_devami"), strLinks, strText), "class=""clearfix devami""", "style=""float: right;"""), "class=""devami""", "style=""float: right;""")

				.Write("				<li class=""items"">" & vbCrLf)
				If strTitleStatus Then _
				.Write("	<h3 class=""title blue"">"& strTitle &"</h3>" & vbCrLf)
				.Write( strText & vbCrLf)
				.Write("</li>" & vbCrLf)

			objSubRs.MoveNext() : Loop

			.Write("			</ul>" & vbCrLf)
			.Write("		</div>" & vbCrLf)
			.Write("		<div class=""button""><div><a href=""#"" class=""up"" title="""& Lang("haberler")(1) &""">"& Lang("haberler")(1) &"</a><a href=""#"" class=""down"" title="""& Lang("haberler")(2) &""">"& Lang("haberler")(2) &"</a></div></div>" & vbCrLf)
			.Write("		<div class=""clr""></div>" & vbCrLf)
			.Write("	</div>" & vbCrLf)
			.Write("</div>" & vbCrLf)
			.Write("<script type=""text/javascript"">" & vbCrLf)
			.Write("//<![CDATA[" & vbCrLf)
			.Write("$(document).ready(function() {" & vbCrLf)
			.Write("	$(""#jcarousellite"").jCarouselLite({" & vbCrLf)
			.Write("		vertical: true," & vbCrLf)
			.Write("		hoverPause:true," & vbCrLf)
			.Write("		visible: 1," & vbCrLf)
			.Write("		auto:4000," & vbCrLf)
			.Write("		speed:800," & vbCrLf)
			.Write("		btnNext: ""#haberler .button a.down""," & vbCrLf)
			.Write("		btnPrev: ""#haberler .button a.up"" " & vbCrLf)
			.Write("	});" & vbCrLf)
			.Write("});" & vbCrLf)
			.Write("//]]>" & vbCrLf)
			.Write("</script>" & vbCrLf)
		End With
	End If
	Set objSubRs = Nothing

End Sub




















'// Sayfalama Fonksiyonu
Function MundusSayfala(ByVal intToplam, ByVal intSayfaAdet, ByVal intiD, ByVal strTitle, ByVal Query, ByVal intPageiD)
	'on error resume next
	Dim SayfaWrite, intToplamAdet, sayfano, TmpCounter, xxUrlTitle, strTitle2
	intiD = Clng(intiD) + 1
	strTitle = BasHarfBuyuk(strTitle)
	strTitle2 = strTitle
	'intSayfaAdet = intYap(intSayfaAdet, 1)
	If (intToplam/intSayfaAdet = int(intToplam/intSayfaAdet)) Then intToplamAdet = int(intToplam/intSayfaAdet) Else intToplamAdet = int(intToplam/intSayfaAdet) + 1
	SayfaWrite = "<div class=""sayfala clearfix"">"
	SayfaWrite = SayfaWrite & vbCrLf & "	<ul>"
	xxUrlTitle = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("request_option"), Query, "", intPageiD, 1, "")
	If intiD <> 1 Then SayfaWrite = SayfaWrite & vbCrLf & "		<li><a href="""& xxUrlTitle &""" title="""& strTitle2 &""">"& Lang("page_buttons")(0) &"</a></li>" Else  SayfaWrite = SayfaWrite & vbCrLf & "		<li class=""active""><span>"& Lang("page_buttons")(0) &"</span></li>"
	xxUrlTitle = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("request_option"), Query, "", intPageiD, intiD-1, "")
	If intiD > 1 Then SayfaWrite = SayfaWrite & vbCrLf & "		<li><a href="""& xxUrlTitle &""" title="""& strTitle2 &""">"& Lang("page_buttons")(1) &"</a></li>" Else  SayfaWrite = SayfaWrite & vbCrLf & "		<li class=""active""><span>"& Lang("page_buttons")(1) &"</span></li>"
	For sayfano = 1 To intToplamAdet
		'strTitle = strTitle
		If Not sayfano = 1 Then strTitle = strTitle2 & " " & sayfano & "/" & intToplamAdet
		xxUrlTitle = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("request_option"), Query, "", intPageiD, sayfano, "")
		If (sayfano = intiD) Then
			TmpCounter = 0
			SayfaWrite = SayfaWrite & vbCrLf & "		<li class=""active""><span>"& sayfano &"</span></li>"
		ElseIf sayfano = 1 Or sayfano > intToplamAdet - 3 Then
			SayfaWrite = SayfaWrite & vbCrLf & "		<li><a href="""& xxUrlTitle &""" title="""& strTitle &""">"& sayfano &"</a></li>"

		ElseIf sayfano > intiD - 2 And sayfano < intiD + 2 Then
			SayfaWrite = SayfaWrite & vbCrLf & "		<li><a href="""& xxUrlTitle &""" title="""& strTitle &""">"& sayfano &"</a></li>"

		ElseIf TmpCounter < 1 Or TmpCounter > 1 Then
			'If intToplamAdet > 10 Then SayfaWrite = SayfaWrite & vbCrLf & "		<li class=""gap""><span>...</span></li>" Else SayfaWrite = SayfaWrite & vbCrLf & "		<li><a href=""javascript:sayfa_id("&sayfano&")"">"&sayfano&"</a></li>"
			SayfaWrite = SayfaWrite & vbCrLf & "		<li class=""gap""><span>...</span></li>"
			TmpCounter = TmpCounter + 1
		End If
	Next
	xxUrlTitle = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("request_option"), Query, "", intPageiD, intiD +1, "")
	If intiD < sayfano-1 Then SayfaWrite = SayfaWrite & vbCrLf & "		<li><a href="""& xxUrlTitle &""" title="""& strTitle2 &" "& intiD +1 & "/" & intToplamAdet &""">"& Lang("page_buttons")(2) &"</a></li>" Else  SayfaWrite = SayfaWrite & vbCrLf & "		<li class=""active""><span>"& Lang("page_buttons")(2) &"</span></li>"
	xxUrlTitle = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("request_option"), Query, "", intPageiD, sayfano -1, "")
	If intiD <> sayfano-1 Then SayfaWrite = SayfaWrite & vbCrLf & "		<li><a href="""& xxUrlTitle &""" title="""& strTitle2 &" "& sayfano -1 & "/" & intToplamAdet &""">"& Lang("page_buttons")(3) &"</a></li>" Else  SayfaWrite = SayfaWrite & vbCrLf & "		<li class=""active""><span>"& Lang("page_buttons")(3) &"</span></li>"
	SayfaWrite = SayfaWrite & vbCrLf & "	</ul>"
	SayfaWrite = SayfaWrite & vbCrLf & "</div>"
	'SayfaWrite = SayfaWrite & vbCrLf & "<input id=""plimitstart"" name=""plimitstart"" value="""& PageLimitStart &""" type=""hidden"" />"
	MundusSayfala = SayfaWrite
End Function















'// Sayfalama Fonksiyonu
Sub MundusComment(ByVal intPageid, ByVal intParent, ByVal intCommentAdet, ByVal intCommentTrue)
	If (intCommentTrue = 0) Then Exit Sub

	Dim strName, strMail, strWeb

		Call MundusCommentContent(intPageid, intParent, 0, intCommentAdet, 0)

With Request
	strName = .Cookies("comment")("name")
	strMail = .Cookies("comment")("mail")
	strWeb = .Cookies("comment")("web")
End With

%>
<div id="comment-form" class="clearfix">
<script type="text/javascript">
/*<![CDATA[*/
var ewyError = '<%=Duzenle(Lang("ewyError"))%>',
    ewyLoading = '<%=Duzenle(Lang("ewyLoading"))%>';
/*]]>*/
</script>
	<div id="respond" class="clearfix">
		<div class="cancel-comment-reply" style="float:right;">
			<small><a rel="nofollow" id="cancel-comment-reply-link" href="#respond" style="color:#f00; display:none;"><%=Lang("cancel_comment_reply_link")%></a></small>
		</div>
		<h3 id="yorumYap" class="title"><%=Lang("comment_form_title")%></h3>
		<form id="commentform" action="<%=UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Post"), "comment-post", "", "", "", "")%>" method="post">
		<fieldset>
			<legend><%=Lang("comment_form_title")%></legend>
			<div class="comment-form-fields">
				<div class="comment-form-field">
					<label for="author"<%If strName <> "" Then Response.Write(" style=""display:none;""")%>>
						<%=Lang("comment_form_label_text")(0)%>
					</label>
					<div class="comment-form-input"><input id="author" name="author" value="<%=strName%>" type="text" /></div>
				</div>
				<div class="comment-form-field">
					<label for="email"<%If strMail <> "" Then Response.Write(" style=""display:none;""")%>>
						<%=Lang("comment_form_label_text")(1)%>
					</label>
					<div class="comment-form-input"><input id="email" name="email" value="<%=strMail%>" type="text" /></div>
				</div>
				<div class="comment-form-field">
					<label for="url"<%If strWeb <> "" Then Response.Write(" style=""display:none;""")%>>
						<%=Lang("comment_form_label_text")(2)%>
					</label>
					<div class="comment-form-input"><input id="url" name="url" value="<%=strWeb%>" type="text" /></div>
				</div>
				<div class="comment-form-field" style="width:auto;">
					<label for="comment">
						<%=Lang("comment_form_label_text")(3)%>
					</label>
					<div class="comment-form-textarea"><textarea id="comment" name="comment" rows="1" cols="1"></textarea></div>
				</div>
			</div>

			<!--<p><small><strong>XHTML:</strong> You can use these tags: <code>&lt;a href=&quot;&quot; title=&quot;&quot;&gt; &lt;abbr title=&quot;&quot;&gt; &lt;acronym title=&quot;&quot;&gt; &lt;b&gt; &lt;blockquote cite=&quot;&quot;&gt; &lt;cite&gt; &lt;code&gt; &lt;del datetime=&quot;&quot;&gt; &lt;em&gt; &lt;i&gt; &lt;q cite=&quot;&quot;&gt; &lt;strike&gt; &lt;strong&gt; </code></small></p>-->

			<div class="row buttons clearfix" style="margin-bottom:5px;">
				<div>
					<span class="ie b1" style="margin-left:0px;"><input class="button submit" id="submit" value="<%=Lang("comment_form_button")(0)%>" title="<%=Lang("comment_form_button")(0)%>" name="e-submit" type="submit" /></span>
					<span class="ie b2" style="margin-left:5px;"><input class="button reset" id="reset" value="<%=Lang("comment_form_button")(1)%>" title="<%=Lang("comment_form_button")(1)%>" type="reset" /></span>
				</div>
			</div>
			<input type="hidden" name="comment_page" id="comment_page" value="<%=intParent%>" />
			<input type="hidden" name="comment_page_id" id="comment_page_id" value="<%=intPageid%>" />
			<input type="hidden" name="comment_parentid" id="comment_parentid" value="0" />
		</fieldset>
		</form>
		<div id="commentformMsj" class="hidden"></div>
	</div>
</div>
<%
'Session.Abandon
%>
<%
End Sub

'response.write 3 * 3 * 3 * 3 * 3 * 3 * 3

'For Each item in Session.Contents

'	Response.write ( "Session.Contents(" & item & ")" ) & "<br>"

'Next

'Sub MundusCommentContent(ByVal intPageiD, ByVal intCommentAdet, ByVal intParentid, ByVal intLevel)
Sub MundusCommentContent(ByVal intPageiD, ByVal intParent, ByVal intParentid, ByVal intCommentAdet, ByVal intLevel)
	'If (intPageid = 0) Then Exit Sub
	'Response.write intPageid
If intLevel = 0 Then


End If
	Dim sSQL, objRs, Count, intTotalRecord, intid, strTitle
	Dim blnTitleStatus, strCDate, strText, strLinks, addClass, blnDivKapat





	sSQL = ""
	sSQL = sSQL & "SELECT" & vbCrLf
	sSQL = sSQL & "    Count(a.id)" & vbCrLf
	sSQL = sSQL & "FROM #___yorum As a" & vbCrLf
	sSQL = sSQL & "WHERE (" & vbCrLf
	sSQL = sSQL & "    a.comment_status = 1" & vbCrLf
	sSQL = sSQL & "    And a.parent_id = "& intPageiD &"" & vbCrLf
	sSQL = sSQL & "    And a.parent = "& intParent &"" & vbCrLf
	sSQL = sSQL & "    And a.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	sSQL = sSQL & ");" & vbCrLf

	intTotalRecord = Cdbl(sqlQuery(sSQL, 0))
	intSayfaSayisi = 5



	sSQL = ""
	sSQL = sSQL & "SELECT" & vbCrLf
	sSQL = sSQL & "    a.id" & vbCrLf
	sSQL = sSQL & "    ,IFNULL(a.comment_author, '') As author" & vbCrLf
	sSQL = sSQL & "    ,IFNULL(a.comment_author_url, '') As author_url" & vbCrLf
	sSQL = sSQL & "    ,IFNULL(a.comment_text, '') As comment_text" & vbCrLf
	sSQL = sSQL & "    ,a.c_date" & vbCrLf
	sSQL = sSQL & "    ,a.m_date" & vbCrLf
	sSQL = sSQL & "FROM #___yorum As a" & vbCrLf
	sSQL = sSQL & "WHERE (" & vbCrLf
	sSQL = sSQL & "    a.comment_status = 1" & vbCrLf
	sSQL = sSQL & "    And a.comment_parent_id = "& intParentid &"" & vbCrLf
	sSQL = sSQL & "    And a.parent_id = "& intPageiD &"" & vbCrLf
	sSQL = sSQL & "    And a.parent = "& intParent &"" & vbCrLf
	sSQL = sSQL & "    And a.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	sSQL = sSQL & ")" & vbCrLf
	sSQL = sSQL & "ORDER BY a.id ASC" & vbCrLf
	sSQL = sSQL & ";" & vbCrLf
	'Clearfix setQuery(sSQL)

	OpenRs objRs, sSQL
		'If Not objRs.Eof Then
			Count = 1 ': intTotalRecord = objRs.RecordCount

			With Response
				If intLevel = 0 Then  .Write(vbCrLf & "		<div id=""comment-list"">" & vbCrLf)
				If intLevel = 0 Then  .Write(vbCrLf & "		<h3 class=""title"">"& Replace(Replace(Lang("comment_list_title"), "[title]", BasHarfBuyuk(GlobalConfig("PageTitle"))), "[count]", intTotalRecord) &"</h3>" & vbCrLf)
				.Write(vbCrLf & "		<ol>" & vbCrLf)

				Do While Not objRs.Eof
					'blnDivKapat = False
					intid = objRs("id")
					strTitle = HtmlEncode(objRs("author"))
					'blnTitleStatus = CBool(objRs("titleStatus"))
					strCDate = objRs("c_date") & ""
					'strMDate = objRs("m_date") & ""
					'If strMDate <> "" Then strCDate = strMDate
					strText = TextBR(objRs("comment_text") & "")
					strLinks = objRs("author_url") & ""
					'strText = PageBreakReplace(strText)
					'strText = fnPre(strText, GlobalConfig("sBase"))
					'strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", intid, "", "")



					'If (Count Mod ModVal1 = ModVal2) Or ModVal1 = 1 Then _
					'	.Write("			<div class=""sutun"">" & vbCrLf)

					'.Write("				<div class="""& addClass &""">" & vbCrLf)
					'.Write("					<div class=""background"">" & vbCrLf)
					'.Write("<li>" & vbCrLf)

					'	.Write("<div class=""avatar""><img src="""" alt="""" /></div>")
					'	.Write("<div class=""yazar"">")
					'		If strLinks <> "" Then
					'			.Write("<a href="""& strLinks &""">"& strTitle &"</a>")
					'		Else
					'			.Write( strTitle )
					'		End If
					'	.Write("</div>" & vbCrLf)
					'End If

%>

<li class="depth depth-<%=intLevel%>" id="comment-<%=intid%>">
	<div class="comment clearfix" id="div-comment-<%=intid%>">
		<div class="avatar-holder">
			<img src="<%=GlobalConfig("General_ThemePath")%>images/avatar_48.png" class="avatar avatar-48 grav-hashed grav-hijack" alt="Avatar" />
		</div>
		<div class="comment-author-and-date">
			<div class="comment-author"><%
				'Lang("comment_list_author") = "[url]<strong>[author]</strong>[/url] dedi ki:"
				strTitle = Replace(Lang("comment_list_author"), "[author]", strTitle)
				If strLinks <> "" Then
					strTitle = Replace(strTitle, "[url]", "<a href="""& strLinks &""">")
					strTitle = Replace(strTitle, "[/url]", "</a>")
					If Not CBool(inStr(1, strTitle, Site_HTTP_HOST, 1)) Then strTitle = Replace(strTitle, "<a href=", "<a rel=""nofollow external"" href=")
				Else
					strTitle = Replace(strTitle, "[url]", "")
					strTitle = Replace(strTitle, "[/url]", "")
				End If

				.Write( strTitle )
				%>
			</div>
			<div class="commentDate">
				<abbr title="<%=strCDate%>"><%=TarihFormatla(strCDate)%></abbr>
			</div>
		</div>
		<div class="commentText">
			<p><%=strText%></p>
			<!--<p class="edit-comment"></p>-->
			<p class="reply-link"><a id="comment-reply-link-<%=intid%>" class="comment-reply-link" href="#comment-reply-link"><%=Lang("comment_reply_link")%></a></p>
		</div>
	</div>
	<div class="clr"></div>
	<div class="comment-form-container" id="comment-form-<%=intid%>"></div>
	<%
		Call MundusCommentContent(intPageiD, intParent, intid, intCommentAdet, intLevel + 1)
	%>
</li>
<%
					Count = Count + 1
				objRs.MoveNext() : Loop

				.Write("		</ol>" & vbCrLf)
				If intLevel = 0 Then  .Write("		</div> <!-- .comments End -->" & vbCrLf)
			End With
		'End If
	CloseRs objRs
End Sub




'// Karşılama Mesajı
'Sub WelcomeMessages()
'	Select Case Hour(Now())
'		Case 6, 7, 8, 9, 10, 11
'			Response.Write(Lang("gunaydin"))
'		Case 12, 13, 14, 15, 16
'			Response.Write(Lang("tunaydin"))
'		Case 17, 18, 19, 20, 21
'			Response.Write(Lang("iyi_aksamlar"))
'		Case 22, 23, 0, 1, 2, 3, 4, 5
'			Response.Write(Lang("iyi_geceler"))
'	End Select
'		Response.Write("...&nbsp;" & Lang("hos_geldiniz"))
'		Response.Write("<br />" & Replace(Lang("zaman"), "[Now]", TarihFormatla( Now() )))
'End Sub















'Sub MilliBayram(ByVal strPicture)
'	Dim Ay, Gun
'	Ay = Month(Date())
'	Gun = Day(Date())
'	If ( _
'		(Ay = 4 And Gun = 23) xOr _
'		(Ay = 5 And Gun = 19) xOr _
'		(Ay = 8 And Gun = 30) xOr _
'		(Ay = 10 And Gun = 29) xOr _
'		(Ay = 11 And Gun = 10) _
'	) Then
'		Response.Write("<div class=""milli-bayram"">")
'		Response.Write( strPicture )
'		Response.Write("</div>")
'	End If
'End Sub
%>

