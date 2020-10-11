<%

SQL = ""
SQL = SQL & "SELECT Count(a.id) As Toplam" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	a.durum = 1" & vbCrLf
SQL = SQL & "	And a.anaid = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
SQL = SQL & "	And b.parent = '"& GlobalConfig("General_Page") &"'" & vbCrLf
SQL = SQL & "	And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "	And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "ORDER BY a.sira ASC;"

intTotalRecord = Cdbl(sqlQuery(SQL, 0))
intSayfaSayisi = 5
'Clearfix intTotalRecord

intSayfaNo = intYap(GlobalConfig("request_start") -1, 0)
If (intSayfaNo > 0) Then
	intSayfaNos = intYap(int(intTotalRecord/intSayfaSayisi), 0)
	If (intSayfaNo > intSayfaNos) Then intSayfaNo = intSayfaNos
Else
	intSayfaNo = 0
End If

intLimitStart = intYap(int(intSayfaNo * intSayfaSayisi), 0)

intTotalRecord = intYap(intTotalRecord, 0)
intSayfaSayisi = intYap(intSayfaSayisi, 0)
'Response.Write "Limit "& intLimitStart & ", " & intSayfaSayisi

'Response.Write( "DefaultHaber_Sayfala("&intTotalRecord&", "&intSayfaSayisi&", "&intSayfaNo&", "&GlobalConfig("request_sayfaid")&") ")

SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.id, b.title, b.id As Parentid, a.sira, a.durum, a.anasyf, a.c_date, a.ozel, a.pass, b.text, b.hit," & vbCrLf
SQL = SQL & "	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 1 ORDER BY id ASC Limit 1) As c_date" & vbCrLf
SQL = SQL & ",	(SELECT DateTimes FROM #___content_revision_date WHERE parent = b.parent And parent_id = b.parent_id And Revizyon = 2 ORDER BY id DESC Limit 1) As m_date" & vbCrLf
SQL = SQL & "FROM #___sayfa As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	a.durum = 1" & vbCrLf
SQL = SQL & "	And a.anaid = "& GlobalConfig("request_sayfaid") &"" & vbCrLf
SQL = SQL & "	And b.parent = '"& GlobalConfig("General_Page") &"'" & vbCrLf
SQL = SQL & "	And (a.s_date = '"& DateTimeNull &"' OR a.s_date Is Null OR a.s_date <= Now())" & vbCrLf
SQL = SQL & "	And (a.e_date = '"& DateTimeNull &"' OR a.e_date Is Null OR a.e_date >= Now())" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "ORDER BY a.sira ASC" & vbCrLf
SQL = SQL & "Limit "& intLimitStart & ", " & intSayfaSayisi & ";" & vbCrLf
SQL = setQuery( SQL )

'Clearfix(SQL)
Set objRs = Server.CreateObject("ADODB.Recordset")
objRs.Open( SQL ),data,1,3
If objRs.Eof Then
	With Response
		.Write("<div class=""message warning block clearfix""><div class=""content""><span>"&Lang("page_err_mesaj")&"</span></div></div>")
		.Status = "404 Not Found"
	End With
Else
	With Response
	Do While Not objRs.Eof
	'If Not _
	'	Session("Energy_CMS_Page_Hit_"& objRs("Parentid")) Then _
	'	data.ExeCute(setQuery("UPDATE #___content Set hit = (hit + 1) WHERE (id = "&objRs("Parentid")&");"))
	'	Session("Energy_CMS_Page_Hit_"& objRs("Parentid")) = True

		'Response.Write Boolean(Len(objRs("text")))
	intid = objRs("id")
	strTitle = UCase2( objRs("title") )
	'intPageHit = objRs("hit")
	strCDate = TarihFormatla(objRs("c_date"))
	'strMDate = TarihFormatla(objRs("m_date"))
	'strCDate = DateSqlFormat(objRs("c_date"), "dd.mm.yy", 3)
	strText = objRs("text")
	strTitle2 = strTitle
	'strTitle2 = BolunmusSayfaBaslik(strTitle2, strText)

	strText = fnPre(strText, GlobalConfig("sRoot"))
	'strText = BSayfaLink(intid, strTitle, strText)	&	RegExpSayfaBol( strText )

	strText = Replace(strText, "<hr class=""system-pagebreak""", "<hr class=""system-pagebreak"" style=""display:none""")
	strLinks = UrlWrite("", GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", intid, 0, "")

	strText = ReadMore("devami", strTitle, Lang("page_devami"), strLinks, strText)

'	strSharedUrl = Server.UrlEncode(GlobalConfig("site_uri"))
'	strSharedUrl = Replace(strSharedUrl, "%2E", ".", 1, -1, 1)

	.Write("	<div class=""contents"">" & vbCrLf)
	.Write("		<div class=""sutun"">" & vbCrLf)
	.Write("			<div class=""orta"">" & vbCrLf)
	.Write("				<div class=""background"">" & vbCrLf)

'	.Write("					<div class=""share-button clearfix"">" & vbCrLf)
'	.Write("						<div class=""tweet_share""><a href=""#"" onclick=""window.open('http://twitter.com/?status="& Server.UrlEncode(BasHarfBuyuk(strTitle)) &" - "& strSharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Twitter&apos;da Paylaş"" target=""_blank"">Twitter&apos;da Paylaş</a></div>" & vbCrLf)
'	.Write("						<div class=""face_share""><a href=""#"" onclick=""window.open('http://www.facebook.com/sharer.php?u="& strSharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Facebook&apos;da Paylaş"" target=""_blank"">Facebook&apos;da Paylaş</a></div>" & vbCrLf)
'	'If Site_REMOTE_ADDR = "z127.0.0.1" Then _
'	'.Write("						<div class=""face_like""><iframe style=""border:none; overflow:hidden; width:110px; height:21px"" src=""http://www.facebook.com/plugins/like.php?href="& strSharedUrl &"&amp;layout=button_count&amp;show_faces=true&amp;width=110&amp;action=like&amp;colorscheme=light&amp;height=21"" frameborder=""0"" scrolling=""no""></iframe></div>" & vbCrLf)
'	.Write("					</div>" & vbCrLf)

	.Write("					<h2 class=""title"" title="""& strTitle &"""><a href="""& strLinks &""" title="""& strTitle &""">"& strTitle2 &"</a></h2>" & vbCrLf) 
	.Write("					<span class=""tarih hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strCDate) &"</span>" & vbCrLf)
	.Write("					<div class=""clr""></div>" & vbCrLf)

	.Write( strText & vbCrLf)

	.Write("					<div class=""clr""></div>" & vbCrLf)
	.Write("				</div>" & vbCrLf)
	.Write("			</div>" & vbCrLf)
	.Write("		</div>" & vbCrLf)
	.Write("	</div>" & vbCrLf)

	objRs.MoveNext : Loop
	End With

	Response.Write("<div class=""clr""></div>" & vbCrLf)
	Response.Write( PixSayfala(intTotalRecord, intSayfaSayisi, intSayfaNo, GlobalConfig("request_sayfaid")) )

End If
objRs.Close : Set objRs = Nothing
%>

