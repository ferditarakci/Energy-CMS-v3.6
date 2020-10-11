<%
Response.Write vbcrlf & vbcrlf

If (options = "" or options = "index") Then Response.Write "<div class=""clr"" style=""height:40px !important""></div> " & vbcrlf
'Response.Write "    <div id=""vlightbox"">" & vbcrlf

'Dim order, Sirane
'Dim StrKat, StrKatTotal, StrAnaKatName, StrAnaKatSira
'Dim StrAltKat, StrAltKatTotal, StrAltKatName, StrAltKatSira
'Dim StrProducts, StrProductsTotal, StrPageName, StrPageIcon, UrunGoster
'Dim StrLimit, StrSayfaSayisi
'Dim StrLimitStart, sayfa
'Dim p

orderby    = Request("orderby")
order      = Request("order")

If (order = "") Then
	If (limitstart <= 1) Then
		Sirane = StrKarisikSirala &" " & orderby
	Else
		Sirane = "baslik" &" " &orderby
	End If
ElseIf order = "title" Then
	Sirane = "baslik" &" " &orderby
ElseIf order = "item" Then
	Sirane = "kodu" &" " &orderby
ElseIf order = "price" Then
	Sirane = "fiyat" &" " &orderby
End If

Set StrProducts = Server.CreateObject("ADODB.Recordset")
SQL = Empty
SQL = SQL & "SELECT "&tblPreFix&"products.baslik, "&tblPreFix&"products.id, "&tblPreFix&"kategori.isim, "&tblPreFix&"kategori.id "
SQL = SQL & "FROM "&tblPreFix&"products INNER JOIN "&tblPreFix&"kategori ON "&tblPreFix&"kategori.durum = -1 And "&tblPreFix&"products.katid = "&tblPreFix&"kategori.id "
SQL = SQL & "WHERE ((("&tblPreFix&"kategori.id)=11));"

If (options = "index" or options = "") Then
	StrPageName   = katUrun01
	'******* StrPageIcon   = "Favorite.png"
	UrunGoster = 12
'If (DataBase = "MySQL") Then
'	StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,stokadet,kisatext,katid,yeni,stok,keyword from "&tblPreFix&"products where durum = -1 and vitrin = -1 order by "&Sirane&" Limit 3",data,1,3
'Else
	StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,stokadet,kisatext,katid,yeni,stok,keyword from "&tblPreFix&"products where durum = -1 and vitrin = -1 order by "&Sirane&"",data,1,3
'End If
ElseIf options = "yeni-urunler" Then
	StrPageName   = katUrun02
	'******* StrPageIcon   = "List-manager.png"
	UrunGoster = 12
	StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,stokadet,kisatext,katid,yeni,stok,keyword from "&tblPreFix&"products where durum = -1 and yeni = -1 order by "&Sirane&"",data,1,3

ElseIf options = "stoktaki-urunler" Then
	StrPageName   = katUrun03
	'******* StrPageIcon   = "List-manager.png"
	UrunGoster = 12
	StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,stokadet,kisatext,katid,yeni,stok,keyword from "&tblPreFix&"products where durum = -1 and stok = -1 order by "&Sirane&"",data,1,3

ElseIf options = "kategori" Then
	'StrPageName   = StrAnaKatName
	'******* StrPageIcon   = "folder_green.png"
	UrunGoster = 50
	StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,stokadet,kisatext,katid,yeni,stok,keyword from "&tblPreFix&"products where durum = -1 and katid = "& cid &" order by "&Sirane&"",data,1,3

ElseIf options = "search" Then
	StrPageName   = katUrun04
	StrPageIcon   = "Search.png"
	UrunGoster = 12
	StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,stokadet,kisatext,katid,yeni,stok,keyword from "&tblPreFix&"products where durum = -1 and katid = "&scatid&" and baslik like '%"&q&"%' or kodu like '%"&q&"%' or kisatext like '%"&q&"%' or keyword like '%"&q&"%' order by "&Sirane&"",data,1,3
End If

StrProductsTotal = StrProducts.RecordCount

'******* Sayfada Gösterilecek Ürün Sayısı
If (limit = 0) Then
	StrSayfaSayisi = UrunGoster
ElseIf Request.QueryString("limit") = "all" Then
	StrSayfaSayisi = StrProductsTotal
Else 
	StrSayfaSayisi = StrLimit
End If 

'******* Sayfa Listele

If (limitstart > 0) Then 
	sayfa = cdbl(limitstart) - 1
	StrProducts.move sayfa * StrSayfaSayisi
Else 
	sayfa = 0 
End If 
'If StrProductsTotal/StrSayfaSayisi = int(StrProductsTotal/StrSayfaSayisi) Then sayfaadet = StrProductsTotal/StrSayfaSayisi Else sayfaadet = int(StrProductsTotal/StrSayfaSayisi) +1

'Response.Write "<form action="""&SystemRoot&""" method=""get"" name=""adminForm"">" & vbcrlf

'If StrProducts.Eof Then
	'Response.Write "<span style=""font-size:11px;color:#ff0000;"">"& Lang016 &"</span>"& vbcrlf
'Else
	'Response.Write "<span style=""float:right;margin-top:3px;"">"& Replace(Replace(Lang023,"[ToplamUrun]","<font color=""#a51717"">"&StrProductsTotal&"</font>"),"[ToplamSayfa]","<font color=""#a51717"">"&sayfaadet &"</font>") &"</span>" & vbcrlf

'Response.Write "<span>" & vbcrlf
'*********************************************
'If (options = "") Then
'	Response.Write "      <input type=""hidden"" name=""option"" value=""index"" />" & vbcrlf
'Else
'	Response.Write "      <input type=""hidden"" name=""option"" value="""&options&""" />" & vbcrlf
'End If

'If (options = "kategori") Then
	'Response.Write "      <input type=""hidden"" name=""task"" value="""&task&""" />" & vbcrlf
	'Response.Write "      <input type=""hidden"" name=""cid"" value="""&cid&""" />" & vbcrlf
	'Response.Write "      <input type=""hidden"" name=""ctitle"" value="""&ctitle&""" />" & vbcrlf
'End If

'If StrLimit = "" Then
'StrSelected_all_ = " selected=""selected"""  
'ElseIf StrLimit = "10" Then
'StrSelected_10_ = " selected=""selected"""
'ElseIf StrLimit = "20" Then
'StrSelected_20_ = " selected=""selected"""
'ElseIf StrLimit = "30" Then
'StrSelected_30_ = " selected=""selected"""
'ElseIf StrLimit = "50" Then
'StrSelected_50_ = " selected=""selected"""
'ElseIf StrLimit = "100" Then
'StrSelected_100_ = " selected=""selected"""
'ElseIf StrLimit = "all" Then
'StrSelected_all_ = " selected=""selected"""
'End If 

'Response.Write " Görüntüle:<select style=""width:100px;"" name=""limit"" onchange=""submitform();"">" & vbcrlf
'Response.Write " <option"&StrSelected_10_&" value=""10"">10</option>" & vbcrlf
'Response.Write " <option"&StrSelected_20_&" value=""20"">20</option>" & vbcrlf
'Response.Write " <option"&StrSelected_30_&" value=""30"">30</option>" & vbcrlf
'Response.Write " <option"&StrSelected_50_&" value=""50"">50</option>" & vbcrlf
'Response.Write " <option"&StrSelected_100_&" value=""100"">100</option>" & vbcrlf
'Response.Write " <option"&StrSelected_all_&" value=""all"">Tümü</option>" & vbcrlf
'Response.Write "</select>&nbsp;"

'If order = "" or order = "title" Then
'StrSelected_ = " selected=""selected"""  
'ElseIf order = "item" Then
'StrSelected__ = " selected=""selected"""
'ElseIf order = "price" Then
'StrSelected___ = " selected=""selected"""
'ElseIf order = "rnd" Then
'StrSelected____ = " selected=""selected"""
'End If
'Response.Write Lang017 &":<select style=""width:100px;"" name=""order"" onchange=""submitform();"">" & vbcrlf
'Response.Write " <option"&StrSelected_&" value=""title"">"& Lang018 &"</option>" & vbcrlf
'Response.Write " <option"&StrSelected__&" value=""item"">"& Lang019 &"</option>" & vbcrlf
'Response.Write " <option"&StrSelected___&" value=""price"">"& Lang020 &"</option>" & vbcrlf
'Response.Write "</select>&nbsp;"


'If orderby = "" or orderby = "asc" Then
'Response.Write "<a href=""javascript:void(0)"" onclick=""javascript:document.adminForm.orderby.value='desc';submitform();return false;""><img src=""images/sort_desc.png"" title="""& Lang024 &""" width=""12"" height=""12"" /></a>" & vbcrlf
'ElseIf orderby = "desc" Then
'Response.Write "<a href=""javascript:void(0)"" onclick=""javascript:document.adminForm.orderby.value='asc';submitform();return false;""><img src=""images/sort_asc.png"" title="""& Lang025 &""" width=""12"" height=""12"" /></a>" & vbcrlf
'End If
'Response.Write "  <input type=""hidden"" name=""orderby"" value=""asc"" />" & vbcrlf

'Response.Write "     </span>" & vbcrlf
'End If
'If Not StrLimitStart = "" Then
'	Response.Write "      <input type=""hidden"" name=""limitstart"" value=""0"" />" & vbcrlf
'End If
'Response.Write "                 </td>" & vbcrlf
'Response.Write "              </tr>" & vbcrlf
'Response.Write "           </table>" & vbcrlf
'Response.Write "</form>" & vbcrlf
%>

<!-- Ürünler Başladı -->
<div id="products" class="clearfix">
	<h2 class="title"><%=StrPageName%></h2>
<%
'Response.Write "<h2 class=""title"">"&StrPageName&"</h2>"
For  i = 1 To StrSayfaSayisi 
If StrProducts.Eof Then Exit For
'If (i mod 3 = 0) Then
'	Kapat = "              </td>" & vbcrlf
'	Kapat = Kapat & "           </tr>" & vbcrlf
'	If Not (StrProductsTotal = i) Then
'		Kapat = Kapat & "           <tr>"
'	End If
'Else
'	Kapat = "              </td>"
'	If (StrProductsTotal = i) Then
'		Kapat = Kapat & "           </tr>"
'	End If
'End If

StrProductID = StrProducts("id")
StrProductBaslik = StrProducts("baslik")
StrProductFiyat = StrProducts("fiyat")
StrProductPara = StrProducts("para")
StrProductFiyatYuzde = StrProducts("yuzde")
StrProductKodu = StrProducts("kodu")
StrProductstokadet = StrProducts("stokadet")
'StrProductkisatext = StrProducts("kisatext")
StrProductKatID = StrProducts("katid")
StrProductYeni = StrProducts("yeni")
StrProductStok = StrProducts("stok")
StrProductKeyWord = StrProducts("keyword")


If (Request.QueryString("option") = "search") Then
	StrProductBaslik       = Replace(""&StrProductBaslik&"", ""&q&"", "<font class=serach_high_light>"&q&"</font>",1,-1,1)
	StrProductKodu         = Replace(""&StrProductKodu&"", ""&q&"", "<font class=serach_high_light>"&q&"</font>",1,-1,1)
	StrProductkisatext = Replace(""&StrProductkisatext&"", ""&q&"", "<font class=serach_high_light>"&q&"</font>",1,-1,1)
End If

'// Kategori
	Set StrObj = data.Execute("SELECT isim FROM "&tblPreFix&"kategori where id = "&StrProductKatID&"")
		If StrObj.Eof Then
			StrProductKat1Adi = ""
		Else
			StrProductKat1Adi = StrObj("isim")
		End If
	StrObj.Close : Set StrObj = Nothing

'// Kur Çevir
'If StrDoviz = True Then
  If StrProductPara = "USD" Then
    StrTLFiyat = FormatNumber(StrProductFiyat*dolar1,0)/10000
    StrKdvDahil = StrTLFiyat+StrTLFiyat*StrProductFiyatYuzde/100
  ElseIf StrProductPara = "EUR" Then
    StrTLFiyat = FormatNumber(StrProductFiyat*euro1,0)/10000
    StrKdvDahil = StrTLFiyat+StrTLFiyat*StrProductFiyatYuzde/100
  ElseIf StrProductPara = "TL" Then
    StrTLFiyat = StrProductFiyat
    StrKdvDahil = StrTLFiyat+StrTLFiyat*StrProductFiyatYuzde/100
  End If
'End If

'// Ürün Resim
	Set StrObj = data.Execute("SELECT resim FROM "&tblPreFix&"images WHERE anaresim = -1 and anaid = "&StrProductID&"")
		If StrObj.Eof Then
			StrDefaultImage = ""
		Else
			StrDefaultImage = StrObj("resim")
		End If
	StrObj.Close : Set StrObj = Nothing

	
'Response.Write "	<div class=""urun_baslik"">" & vbcrlf
'Response.Write "		<a href="""&UrlYaz("detay", StrProductID, StrProductBaslik)&""" title="""&StrProductBaslik&""">"
'Response.Write "<span>"&KacKarekter(StrProductBaslik, 25)&"</span>"
'Response.Write "<img src="""&SystemRoot&Klasor2&"/"&StrDefaultImage&""" alt="""&StrProductBaslik&""" />"
'Response.Write "</a>" & vbcrlf
'Response.Write "<span class=""product-lightbox""><a class=""vlightbox"" href="""& SystemRoot&Klasor &"/" &StrProductsDefaultIMG &""" title="""& StrProductBaslikFull &""">Zoom</a></span>"

'Response.Write " </div>" & vbcrlf

'If StrProductYeni = True Then
	'Response.Write "<span><img src=""images/yeni.gif"" title=""yeni ürün"" /></span>" & vbcrlf
'End If
	
'If StrProductKodu <> "" Then
'	Response.Write " <div class=""item"">" & vbcrlf
'	Response.Write "<a href=""http://"&StrProductKodu&""" target=""_blank""><span>"&KacKarekter(StrProductKodu, 25)&"</span></a>"
'	Response.Write " </div>" & vbcrlf
'End If
	
'// ************************************************************* //'
Response.Write "	<div class=""product"">" & vbCrLf
Response.Write "		<div>" & vbCrLf
Response.Write "			<div>" & vbCrLf
Response.Write "				<div>" & vbCrLf
Response.Write "					<div>" & vbCrLf

Response.Write "						<a class=""name"" href="""&UrlReWrite("", "detay", "", StrProductID, "")&""" title="""&StrProductBaslik&"""><span>"&KacKarekter(StrProductBaslik, 25)&"</span></a>" & vbCrLf
Response.Write "						<a class=""photo"" href="""&UrlReWrite("", "detay", "", StrProductID, "")&""" title="""&StrProductBaslik&""">"
Response.Write "<img class=""reflect"" src="""&SystemRoot&Klasor2&"/"&StrDefaultImage&""" alt="""&StrProductBaslik&""" /></a>" & vbCrLf
'Response.Write "<span class=""product-lightbox""><a class=""vlightbox"" href="""& SystemRoot&Klasor &"/" &StrDefaultImage &""" title="""& StrProductBaslik &""">Zoom</a></span>"

If StrProductKodu <> "" Then
	Response.Write "	<div class=""item"">" & vbcrlf
	Response.Write "		<a href=""http://"&StrProductKodu&""" title="""&StrProductBaslik&""" target=""_blank""><span>"&StrProductKodu&"</span></a>"
	Response.Write "	</div>" & vbcrlf
End If

Response.Write "					</div>" & vbCrLf
Response.Write "				</div>" & vbCrLf
Response.Write "			</div>" & vbCrLf
Response.Write "		</div>" & vbCrLf
Response.Write "	</div>" & vbCrLf


' style=""background: no-repeat; width:28px; background-image: url('http://www.pagerank.fr/pagerank-actuel.gif?uri="&StrProductKodu&"')""

'If Not FormatNumber(StrProductFiyat,2) = "0,00" Then
'Response.Write " <div class=""urun_fiyat"">" & vbcrlf
'Response.Write " "& FormatNumber(StrProductFiyat,2) &"&nbsp;"& StrProductPara &"" & vbcrlf
'If Not StrProductPara = "TL" Then
'Response.Write " - <span class=""tl"">"& FormatNumber(StrTLFiyat,2) &"&nbsp;TL</span>" & vbcrlf
'End If
'Response.Write "<span class=""kdv"">"& Lang022 &"&nbsp;"& FormatNumber(StrKdvDahil,2) &"&nbsp;TL</span>" & vbcrlf
'Response.Write " </div>" & vbcrlf
'End If

'keyword = ""
'If Not StrProductKeyWord = "" Then
'StrProductKeyWord2 = Split(StrProductKeyWord,",")
'For tt = 0 to Ubound(StrProductKeyWord2)
'keyword = keyword & "<a href=""?option=search&amp;q="&Trim(StrProductKeyWord2(tt))&""">"&StrProductKeyWord2(tt)&"</a>, "
'Next
'Response.Write Left(keyword,Len(keyword)-7)
'End If

'Response.Write "              <div class=""product_zoom""> <a class=""vlightbox"" href="""& Klasor &"/" &StrDefaultImage &""" title="""& StrProductBaslikFull &""">Zoom</a></div>" & vbcrlf
'If StrProductStok = True Then
'Response.Write "             <img src=""images/stok.png"" align=""right"">" & vbcrlf
'End If
%>

<%
'Response.Write ( Kapat )
StrProducts.MoveNext : Next
%>
	<div class="clr"></div>
</div>
<!-- Ürünler Bitti -->


<%
'Response.Write "<table class=""sayfala"" style=""float:right;"" cellspacing=""1"">" & vbcrlf
'If StrProductsTotal/StrSayfaSayisi = int(StrProductsTotal/StrSayfaSayisi) Then sayfaadet = StrProductsTotal/StrSayfaSayisi Else sayfaadet = int(StrProductsTotal/StrSayfaSayisi) +1
'If Not StrProductsTotal = 0 Then
'Response.Write " <tr>" & vbcrlf
'Response.Write "   <td align=""right"" valign=""top"">" & vbcrlf
'Response.Write " "& Replace(Replace(Lang023,"[ToplamUrun]","<font color=""#a51717"">"&StrProductsTotal&"</font>"),"[ToplamSayfa]","<font color=""#a51717"">"& sayfaadet &"</font>") &" </td>" & vbcrlf
'Response.Write " </tr>" & vbcrlf
'End If
If (options = "index" or options = "") Then
	Response.Write "		<div style=""line-height:30px; float:right; text-align:right;"">" & vbcrlf
	Response.Write "			<a href="""&UrlReWrite("", "kategori", "", 11, "")&""" title=""Yaptığımız İşler"">Tümünü Göster</a>" & vbcrlf
	Response.Write "			<div class=""clr""></div>" & vbcrlf
	Response.Write "		</div>" & vbcrlf
End If
'If StrProductsTotal > StrSayfaSayisi Then
'Response.Write " <tr>" & vbcrlf
'Response.Write "   <td style=""float:right;text-align:right;"" valign=""top"">" & vbcrlf
For p = 0 To sayfaadet-1 
If sayfa = p Then
ActivePageButton = " id=""ActivePageButton"""
Else
ActivePageButton = ""
End If
'Response.Write "   <a"&ActivePageButton&" class=""PageButton"" href=""?start="&p+1&""">"& p+1 &"</a>" & vbcrlf
'Response.Write "   <a class=""PageButton"""&ActivePageButton&" href=""?limitstart="&p+1&""">"& UrunGoster * p+1  & " - " & UrunGoster + UrunGoster * p  &"</a>" & vbcrlf
'Response.Write UrunGoster * p+1  & " > " & UrunGoster + UrunGoster * p & vbcrlf
Next
'Response.Write "   </td>" & vbcrlf
'Response.Write " </tr>" & vbcrlf
'End If
'Response.Write "</table>" & vbcrlf

'If Not StrProducts.Eof Then
'Response.Write "           <table width=""100%"">" & vbcrlf
'Response.Write "              <tr>" & vbcrlf
'Response.Write "                 <td width=""100%"">" & vbcrlf
'Response.Write "   <span class=""article_separator"">&nbsp;</span>  " & vbcrlf
'Response.Write "                 </td>" & vbcrlf
'Response.Write "              </tr>" & vbcrlf
'Response.Write "              </table>" & vbcrlf
'End If

'Response.Write "     <script src="""&SystemRoot&"javascript/VisualLightBox/js/visuallightbox.js"" type=""text/javascript""></script> " & vbcrlf
'Response.Write "    </div>" & vbcrlf
'Response.Write "    </div>" & vbcrlf

StrProducts.Close : Set StrProducts = Nothing
%>
