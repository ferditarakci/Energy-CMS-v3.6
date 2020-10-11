<%
Response.Write "<form action="""& FormURL &""" method=""post"" name=""adminForm"">" & vbcrlf
Response.Write "    <div id=""products"">" & vbcrlf

Sirala = Request.Form("sort_order")

If Sirala = "0" or Sirala = "" Then
Sirane = StrKarisikSirala
'******* Sirane = "NEWID()"

ElseIf Sirala = "1" Then
Sirane = "baslik asc"

ElseIf Sirala = "2" Then
Sirane = "baslik desc"

ElseIf Sirala = "3" Then
Sirane = "kodu asc"

ElseIf Sirala = "4" Then
Sirane = "kodu desc"

ElseIf Sirala = "5" Then
Sirane = "fiyat asc"

ElseIf Sirala = "6" Then
Sirane = "fiyat desc"

Else
Sirane = "baslik asc"
End If


Set StrProducts = Server.CreateObject("ADODB.RecordSet")
If Request.QueryString("option") = "home" or Request.QueryString("option") = "" Then
StrPageName   = Lang041
'******* StrPageIcon   = "Favorite.png"
UrunGosret = 8

StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,koli,kisaaciklama,bolumid,kat1,kat2,yeni,stok from "&tblPreFix&"products where durum = -1 and vitrin = -1 order by "&Sirane&"",data,1,3

ElseIf Request.QueryString("option") = "newproducts" Then
StrPageName   = Lang065
'******* StrPageIcon   = "List-manager.png"
UrunGosret = 12

StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,koli,kisaaciklama,bolumid,kat1,kat2,yeni,stok from "&tblPreFix&"products where durum = -1 and yeni = -1 order by "&Sirane&"",data,1,3

ElseIf Request.QueryString("option") = "stok" Then
StrPageName   = Lang069
'******* StrPageIcon   = "List-manager.png"
UrunGosret = 12

StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,koli,kisaaciklama,bolumid,kat1,kat2,yeni,stok from "&tblPreFix&"products where durum = -1 and stok = -1 order by "&Sirane&"",data,1,3

ElseIf Request.QueryString("option") = "categories" Then

set StrKat = Server.CreateObject("ADODB.RecordSet")
StrKat.open "Select * from kategori where durum = -1 and id = "& catid &" ",data,1,3
StrKatTotal = StrKat.recordcount
StrAnaKatName = StrKat("isim")
StrAnaKatSira = StrKat("sira")

If Request.QueryString("task") = "cat" or Request.QueryString("task") = "" Then
StrPageName   = StrAnaKatName
'******* StrPageIcon   = "folder_green.png"
UrunGosret = 12
StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,koli,kisaaciklama,bolumid,kat1,kat2,yeni,stok from "&tblPreFix&"products where durum = -1 and kat1 = "& catid &"  and kat2 = 0 order by "&Sirane&"",data,1,3
ElseIf Request.QueryString("task") = "sub" Then
set StrAltKat = Server.CreateObject("ADODB.RecordSet")
StrAltKat.open "Select * from kategori2 where durum = -1 and id = "& subid &"",data,1,3
StrAltKatTotal = StrAltKat.recordcount
StrAltKatName  = StrAltKat("isim")
StrAltKatSira  = StrAltKat("sira")

StrPageName   = StrAnaKatName &"&nbsp;&raquo;&nbsp;" & StrAltKatName
'******* StrPageIcon   = "folder_green.png"
UrunGosret = 12

StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,koli,kisaaciklama,bolumid,kat1,kat2,yeni,stok from "&tblPreFix&"products where durum = -1 and kat1 = "& catid &" and kat2 = "& subid &" order by "&Sirane&"",data,1,3

End If

ElseIf Request.QueryString("option") = "search" Then
StrPageName   = Lang070
StrPageIcon   = "Search.png"
UrunGosret = 12

StrProducts.open "Select id,baslik,kodu,fiyat,para,yuzde,koli,kisaaciklama,bolumid,kat1,kat2,yeni,stok from "&tblPreFix&"products where durum = -1 and kat1 like '%"&scatid&"%' and baslik like '%"&q&"%' or kodu like '%"&q&"%' or kisaaciklama like '%"&q&"%' order by "&Sirane&"",data,1,3
End If

StrProductsTotal = StrProducts.RecordCount

'*******   If Instr(1,SagBlok,"search.asp",1) or _
'*******   Instr(1,SagBlok,"default.asp",1) Then
'*******   Session("katadi")   = ""
'*******   Session("altkatadi")   = ""
'*******   StrMod = 4
'*******   UrunGosret = 10
'*******   Else
'*******   StrMod = 2
'*******   UrunGosret = 6
'*******   End If

'******* Sayfada Gösterilecek Ürün Sayısı
If Request.Form("Limit") = "0" or Request.Form("Limit") = "" Then
sayfasayisi = UrunGosret
ElseIf Request.Form("Limit") = "all" Then
sayfasayisi = StrProductsTotal
Else 
sayfasayisi = Request.Form("Limit")
End If 

'******* Sayfa Listele
If Request.Form("limitstart") <> "" Then 
sayfa = cdbl(Request.Form("limitstart"))
StrProducts.move sayfa*sayfasayisi
Else 
sayfa = 0 
End If 

Response.Write "           <table width=""100%"" class=""contentpaneopen"">" & vbcrlf
Response.Write "              <tr>" & vbcrlf
Response.Write "                 <td class=""contentheading"" width=""100%"" style=""font-size:18px;"">" & vbcrlf
'******* Response.Write "<img src=""images/images/"& StrPageIcon &""" width=""32"" height=""32"" align=""absmiddle"" />"
Response.Write " "& StrPageName &" "
Response.Write "     </td>" & vbcrlf
Response.Write "              </tr>" & vbcrlf
Response.Write "              <tr>" & vbcrlf
Response.Write "                 <td valign=""top"" class=""createdate"">" & vbcrlf
If StrProducts.Eof Then
Response.Write "<span style=""font-size:11px;color:#ff0000;"">"& Lang064 &"</span>"& vbcrlf
Else
Response.Write "Sırala &raquo;&nbsp;"& vbcrlf
Response.Write "<a href=""#"" onclick=""javascript: document.adminForm.sort_order.value="
If Sirala = "1" Then
Response.Write "2"
Else
Response.Write "1"
End If
Response.Write "; submitform();return false;"">"& Lang050 &"</a>"
Response.Write "&nbsp;"
Response.Write "<img src="""
If Sirala = "1" Then
Response.Write "images/ok_asagi.gif"
ElseIf Sirala = "2" Then
Response.Write "images/ok_yukari.gif"
Else
Response.Write "images/spacer.gif"
End If
Response.Write """ width=""9"" height=""5"" align=""absmiddle"">"& vbcrlf

Response.Write "<a href=""#"" onclick=""javascript: document.adminForm.sort_order.value="
If Sirala = "3" Then
Response.Write "4"
Else
Response.Write "3"
End If
Response.Write "; submitform();return false;"">"& Lang051 &"</a>"
Response.Write "&nbsp;"
Response.Write "<img src="""
If Sirala = "3" Then
Response.Write "images/ok_asagi.gif"
ElseIf Sirala = "4" Then
Response.Write "images/ok_yukari.gif"
Else
Response.Write "images/spacer.gif"
End If
Response.Write """ width=""9"" height=""5"" align=""absmiddle"">"& vbcrlf

Response.Write "<a href=""#"" onclick=""javascript: document.adminForm.sort_order.value="
If Sirala = "5" Then
Response.Write "6"
Else
Response.Write "5"
End If
Response.Write "; submitform();return false;"">"& Lang052 &"</a>"
Response.Write "&nbsp;"
Response.Write "<img src="""
If Sirala = "5" Then
Response.Write "images/ok_asagi.gif"
ElseIf Sirala = "6" Then
Response.Write "images/ok_yukari.gif"
Else
Response.Write "images/spacer.gif"
End If
Response.Write """ width=""9"" height=""5"" align=""absmiddle"">"& vbcrlf
End If
Response.Write "                 </td>" & vbcrlf
Response.Write "              </tr>" & vbcrlf
Response.Write "           </table>" & vbcrlf

For  i = 1 To StrProductsTotal 
If StrProducts.Eof Then Exit For
'*******   If i mod StrMod = 0 Then
'*******   Kapat = "              </td>" & vbcrlf
'*******   Kapat = Kapat & "           </tr>" & vbcrlf
'*******      If Not StrProductsTotal = i Then
'*******      Kapat = Kapat & "           <tr>"
'*******      End If
'*******   Else
'*******   Kapat = "              </td>"
'*******      If StrProductsTotal = i Then
'*******      Kapat = Kapat & "           </tr>"
'*******      End If
'*******   End If

StrProductID                = StrProducts("id")
If Len(HtmlEncodeYazi(StrProducts("baslik"))) > 50 Then 
 StrProductBaslik           = Left(HtmlEncodeYazi(StrProducts("baslik")),50) &" ..."
Else
 StrProductBaslik           = HtmlEncodeYazi(StrProducts("baslik")) 
End If
StrProductBaslikFull        = StrProducts("baslik")
StrProductFiyat             = StrProducts("fiyat")
StrProductPara              = StrProducts("para")
StrProductFiyatYuzde        = StrProducts("yuzde")
StrProductKodu              = StrProducts("kodu")
StrProductKoli              = StrProducts("koli")
StrProductKisaAciklama      = StrProducts("kisaaciklama")
StrProductBolumID           = StrProducts("bolumid")
StrProductKat1              = StrProducts("kat1")
StrProductKat2              = StrProducts("kat2")
StrProductYeni              = StrProducts("yeni")

If Request.QueryString("option") = "search" Then
StrProductBaslik            = Replace(StrProductBaslik, (q), "<span class=serach_high_light>"&q&"</span>",1,-1,1)
StrProductKodu              = Replace(StrProductKodu, (q), "<span class=serach_high_light>"&q&"</span>",1,-1,1)
StrProductKisaAciklama      = Replace(StrProductKisaAciklama, (q), "<span class=serach_high_light>"&q&"</span>",1,-1,1)
End If

'*******  Bölüm
'   sql="SELECT * FROM bolumler where id = "& StrProductBolumID &" " : Set StrDetayBolum=data.Execute(sql)
'     If Not StrDetayBolum.Eof Then
'        StrProductBolumAdi         = StrDetayBolum("isim")
'     End If

'*******  Kategori
   sql="SELECT * FROM kategori where id = "& StrProductKat1 &" " : Set StrDetayKategori=data.Execute(sql)
     If Not StrDetayKategori.Eof Then
        StrProductKat1Adi          = StrDetayKategori("isim")
     End If

'*******  Alt Kategori
If Not StrProductKat2 = 0 Then
   sql="SELECT * FROM kategori2 where id = "& StrProductKat2 &" " : Set StrDetayKategori2=data.Execute(sql)
     If Not StrDetayKategori2.Eof Then
        StrProductKat2Adi          = StrDetayKategori2("isim")
     End If
End If

'*******  Kur Çevir
If StrDoviz = True Then
  If StrProductPara     = "USD" Then
    StrTLFiyat       = formatnumber(StrProductFiyat*dolar1,0)/10000
    StrKdvDahil      = StrTLFiyat+StrTLFiyat*StrProductFiyatYuzde/100
  ElseIf StrProductPara = "EUR" Then
    StrTLFiyat       = formatnumber(StrProductFiyat*euro1,0)/10000
    StrKdvDahil      = StrTLFiyat+StrTLFiyat*StrProductFiyatYuzde/100
  ElseIf StrProductPara = "TL" Then
    StrTLFiyat       = StrProductFiyat
    StrKdvDahil      = StrTLFiyat+StrTLFiyat*StrProductFiyatYuzde/100
  Else
    StrTLFiyat       = StrProductFiyat
   StrKdvDahil       = ""
  End If
End If




'*******   Ürün Resim
sql="SELECT * FROM "&tblPreFix&"images WHERE anaresim = -1 and anaid = "& StrProductID &"" : Set StrProductsIMG = img.Execute(sql)
If Not StrProductsIMG.Eof Then
StrProductsDefaultIMG  = StrProductsIMG("resim")
End If
StrProductsIMG.Close


Response.Write "           <div class=""product"">" & vbcrlf
Response.Write "              <div class=""product_title"">" & vbcrlf
Response.Write "		  	   <a href=""?option=productinfo&id="& StrProductID &"&title="& StrCevirSeoLink((HtmlEncodeYazi((StrProductBaslikFull &" " &StrProductKodu)))) &""" title="""& StrProductBaslikFull &""">"& StrProductBaslik &"</a>" & vbcrlf
Response.Write "               </div>" & vbcrlf
Response.Write "              <div class=""product_detail"">" & vbcrlf
Response.Write "                 <div class=""product_item"" style=""color:#cf6633;"">" & vbcrlf
If Not StrProductKodu = "" Then
Response.Write "                     <span class=""left""># "& StrProductKodu &"</span>" & vbcrlf
End If
If Not StrProductKoli = "" Then
Response.Write "                     <span class=""right"">"& Lang110 &" "& StrProductKoli &"</span>" & vbcrlf
End If
Response.Write "                 </div>" & vbcrlf
If StrProductYeni = True Then
Response.Write "              <div class=""product_new_icon""><img src=""images/spacer.gif"" height=""1"" width=""1""></div>" & vbcrlf
End If
Response.Write "              <div class=""product_"">"& StrProductKisaAciklama &"</div>" & vbcrlf
Response.Write "              <div class=""product_link"">" & vbcrlf
Response.Write "                 <ul>" & vbcrlf
Response.Write "                    <li>" & vbcrlf
Response.Write "                       <a href=""?option=teklif&title="& Server.UrlEncode(Trim(StrProductBaslikFull)) &"&item="& Server.UrlEncode(Trim(StrProductKodu)) &"&img="& StrProductsDefaultIMG &""" title="""& Lang049 &""">"& Lang049 &"</a>" & vbcrlf
Response.Write "                    </li>" & vbcrlf
Response.Write "                 </ul>" & vbcrlf
Response.Write "              </div>" & vbcrlf
Response.Write "              <div class=""product_img"">" & vbcrlf
Response.Write "                 <a href=""?option=productinfo&id="& StrProductID &"&title="& StrCevirSeoLink((HtmlEncodeYazi((StrProductBaslikFull &" " &StrProductKodu)))) &""" title="""& StrProductBaslikFull &""">"
Response.Write "<img class=""reflect"" onerror=""src='upload/yok.png'"" src="""& Klasor2 &"/" &StrProductsDefaultIMG &""" width=""100"" height=""75"" border=""0"" alt="""& HtmlEncodeYazi((StrProductBaslikFull)) &""" title="""& HtmlEncodeYazi((StrProductBaslikFull)) &""" />"
Response.Write "</a>" & vbcrlf
Response.Write "              </div>" & vbcrlf

If Not StrProductFiyat = "" Then
If Not StrProductFiyat = 0 Then
Response.Write "              <div class=""product_price"">" & vbcrlf
Response.Write "               "& Replace(StrProductFiyat,",","<span class=""para"">,") &"&nbsp;"& StrProductPara &"</span>" & vbcrlf
If Not StrProductPara = "TL" Then
Response.Write "                 <span class=""TLfiyat"">"& Replace(formatnumber(StrTLFiyat,2),",","<span class=""para2"">,") &"&nbsp;TL</span></span>" & vbcrlf
End If
Response.Write "                 <span class=""Kdvfiyat"">"& Lang053 &"&nbsp;"& Replace(formatnumber(StrKdvDahil,2),",","<span class=""para2"">,") &"&nbsp;TL</span></span>" & vbcrlf
Response.Write "              </div>" & vbcrlf
End If
End If
Response.Write "           </div>" & vbcrlf
Response.Write "              <div class=""product_footer""><img src=""images/spacer.gif"" height=""1"" width=""1""></div>" & vbcrlf
Response.Write "           </div>" & vbcrlf
'**** Response.Write ( Kapat )
StrProducts.MoveNext : Next
%>
<!--#include file="Sayfala.asp"-->
<%
If Not StrProducts.Eof Then
Response.Write "           <table width=""100%"">" & vbcrlf
Response.Write "              <tr>" & vbcrlf
Response.Write "                 <td width=""100%"">" & vbcrlf
Response.Write "   <span class=""article_separator"">&nbsp;</span>  " & vbcrlf
Response.Write "                 </td>" & vbcrlf
Response.Write "              </tr>" & vbcrlf
Response.Write "              </table>" & vbcrlf
End If
Response.Write "    </div>" & vbcrlf
Response.Write "  <input type=""hidden"" name=""sort_order"" value=""0"" />" & vbcrlf
Response.Write "</form>" & vbcrlf
StrProducts.Close : Set StrProducts = Nothing
%>
