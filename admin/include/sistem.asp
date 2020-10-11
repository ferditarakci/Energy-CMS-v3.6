<%

Dim Debug, Debug2 : Debug = "" : Debug2 = ""

If Request.QueryString("debug") = "true" Or CBool(inStr(LCase(Request.ServerVariables("QUERY_STRiNG")), "debug=true")) Then Debug = "&amp;debug=true" : Debug2 = "&debug=true"

If Request.QueryString("debug").Count > 1 Then _
	Response.Redirect("?" & RequestQueryStringRemove("debug", 0) )

	'For Each 
'blnPostMethod
'"&amp;debug=true"

'clearfix UrlQuery("debug")

%><!--#include file="Thumbs.db"--><%
GlobalConfig(Chr(115) & Chr(117) & Chr(112) & Chr(101) & Chr(114) & Chr(95) & Chr(97) & Chr(100) & Chr(109) & Chr(105) & Chr(110)) = frdtrkc(0)
GlobalConfig(Chr(97) & Chr(100) & Chr(109) & Chr(105) & Chr(110) & Chr(95) & Chr(102) & Chr(111) & Chr(108) & Chr(100) & Chr(101) & Chr(114)) = frdtrkc(1)
GlobalConfig("admin_folder_true") = CBool(inStr(1, Request.ServerVariables("PATH_iNFO"), GlobalConfig("admin_folder"), 1))
'Clearfix GlobalConfig("admin_folder_true")

GlobalConfig("hidden_folder") = hiddenFolder

GlobalConfig("vRoot") = iPath("")
GlobalConfig("sRoot") = iPath(Left(GlobalConfig("admin_folder"), Len(GlobalConfig("admin_folder"))-1))
'Clearfix GlobalConfig("vRoot")

'GlobalConfig("vRoot") = Replace(GlobalConfig("vRoot"), "/__xx1xx__/", "/")
'GlobalConfig("sRoot") = Replace(GlobalConfig("sRoot"), "/__xx1xx__/", "/")

'Clearfix GlobalConfig("vRoot")



%>

<!--#include file="flood.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="redirect.asp"-->
<!--#include file="__adovbs.inc"-->

<!--#include file="JSON_2.0.4.asp"-->
<!--#include file="inStrBot.asp"-->
<!--#include file="BrowserType.asp"-->
<!--#include file="OsType.asp"-->
<!--#include file="mimeType.asp"-->
<!--#include file="jScript.asp"-->
<!--#include file="EncodeDecode.asp"-->
<!--#include file="ServerVariables.asp"-->
<!--#include file="errWrite.asp"-->
<%
Dim LinkSonlandirici
LinkSonlandirici = "/" '".html"

GlobalConfig("General_introPage") = False



GlobalConfig("General_CustomURLPN") = 0
GlobalConfig("General_HomePN") = 1
GlobalConfig("General_PagePN") = 2
GlobalConfig("General_CategoriesPN") = 3
GlobalConfig("General_ProductsPN") = 4
GlobalConfig("General_BannerPN") = 5
GlobalConfig("General_PollPN") = 6
GlobalConfig("General_UsersPN") = 7
GlobalConfig("General_MailistPN") = 8
GlobalConfig("General_SearchPN") = 9
GlobalConfig("General_OrdersPN") = 10
GlobalConfig("General_CommentsPN") = 11

GlobalConfig("General_CustomURL") = "custom"
GlobalConfig("General_Default") = "default"
GlobalConfig("General_Home") = "anasayfa"
GlobalConfig("General_Page") = "sayfa"
GlobalConfig("General_Categories") = "kategori"
GlobalConfig("General_Products") = "urun"
GlobalConfig("General_Banner") = "banner"
GlobalConfig("General_Poll") = "anket"
GlobalConfig("General_Users") = "uye"
GlobalConfig("General_Mailist") = "mailist"
GlobalConfig("General_Search") = "arama"
GlobalConfig("General_Search2") = "search"
GlobalConfig("General_Orders") = "siparis"
GlobalConfig("General_Design") = "webtasarim"
GlobalConfig("General_Tags") = "etiket"
GlobalConfig("General_Comments") = "yorum"
GlobalConfig("General_Xml") = "xml-file"



GlobalConfig("PageUploadFolder") = "sayfa"
GlobalConfig("CategoriesUploadFolder") = "kategori"
GlobalConfig("ProductsUploadFolder") = "urun"
GlobalConfig("BannerUploadFolder") = "banner"
GlobalConfig("UsersUploadFolder") = "uye"
GlobalConfig("ikUploadFolder") = "ik"


Dim LangPreFixSQL
If Left(Site_QUERY_STRiNG, 4) = "404;" Then
	LangPreFixSQL = "SELECT parent, url_prefix FROM #___lang_urlprefix WHERE inStr('"& UCase(Temizle(Request.ServerVariables("QUERY_STRiNG"), 1)) &"', CONCAT('/', CONCAT(lang, '/')));"
Else
	LangPreFixSQL = "SELECT parent, url_prefix FROM #___lang_urlprefix WHERE lang = '"& GlobalConfig("site_lang") &"';"
End If

'If inStr(1, Request.ServerVariables("QUERY_STRiNG"), "/en/", 1) > 0 Then GlobalConfig("General_Home") = "home"

If Not LangPreFixSQL <> "ddddd" Then
	OpenDatabase data
		'Clearfix LangPreFixSQL
		OpenRs objRs, LangPreFixSQL
			Do While Not objRs.Eof
				Select Case objRs("parent")
					Case GlobalConfig("General_HomePN") GlobalConfig("General_Home") = objRs("url_prefix")
					Case GlobalConfig("General_PagePN") GlobalConfig("General_Page") = objRs("url_prefix")
					Case GlobalConfig("General_CategoriesPN") GlobalConfig("General_Categories") = objRs("url_prefix")
					Case GlobalConfig("General_ProductsPN") GlobalConfig("General_Products") = objRs("url_prefix")
					Case GlobalConfig("General_BannerPN") GlobalConfig("General_Banner") = objRs("url_prefix")
					Case GlobalConfig("General_PollPN") GlobalConfig("General_Poll") = objRs("url_prefix")
					Case GlobalConfig("General_UsersPN") GlobalConfig("General_Users") = objRs("url_prefix")
					'Case GlobalConfig("General_Mailist") = objRs("url_prefix")
					Case GlobalConfig("General_SearchPN") GlobalConfig("General_Search") = objRs("url_prefix")
					'Case GlobalConfig("General_Search2") = objRs("url_prefix")
					Case GlobalConfig("General_OrdersPN") GlobalConfig("General_Orders") = objRs("url_prefix")
				End Select
				'Response.Write objRs("url_prefix") & "<br /> "
			objRs.MoveNext() : Loop
		CloseRs objRs
	CloseDatabase data
End If

LangPreFixSQL = ""

'Clearfix GlobalConfig("General_Categories")


GlobalConfig("General_Sitemap") = "sitemap"
GlobalConfig("General_Rss") = "rss"
GlobalConfig("General_Redirect") = "redirect"
GlobalConfig("General_Post") = "post"
GlobalConfig("General_Whois") = "whois"
GlobalConfig("General_Whois2") = "whois2"
GlobalConfig("General_Whois_Check") = "whois-check"
GlobalConfig("General_Login") = "login"
GlobalConfig("General_Server") = "server"
'GlobalConfig("General_Thumbimage") = "thumb-image"



'OpenDatabase data
'GlobalConfig("General_Home") = sqlQuery("SELECT url_prefix FROM #___lang_urlprefix WHERE inStr('"& Temizle(Request.ServerVariables("QUERY_STRiNG"), 1)&"', CONCAT('/', CONCAT(url_prefix, '/')));", "TR")
'CloseDatabase data



'Response.Write LinkYap(3)
Private Function ParentNumber(ByVal iNum)
	Select Case intYap(iNum, 0)
		Case GlobalConfig("General_CustomURLPN")	ParentNumber = GlobalConfig("General_CustomURL")
		Case GlobalConfig("General_HomePN")			ParentNumber = GlobalConfig("General_Home")
		Case GlobalConfig("General_PagePN")			ParentNumber = GlobalConfig("General_Page")
		Case GlobalConfig("General_CategoriesPN")	ParentNumber = GlobalConfig("General_Categories")
		Case GlobalConfig("General_ProductsPN")		ParentNumber = GlobalConfig("General_Products")
		Case GlobalConfig("General_BannerPN")		ParentNumber = GlobalConfig("General_Banner")
		Case GlobalConfig("General_PollPN")			ParentNumber = GlobalConfig("General_Poll")
		Case GlobalConfig("General_CommentsPN")		ParentNumber = GlobalConfig("General_Comments")
		Case Else									ParentNumber = GlobalConfig("General_CustomURL")
	End Select
End Function

%>
<!--#include file="admin.asp"-->
<%


GlobalConfig("Search_404_Option") = Array( _
	GlobalConfig("General_Home"), _
	GlobalConfig("General_Search"), _
	GlobalConfig("General_Search2"), _
	GlobalConfig("General_Tags"), _
	GlobalConfig("General_Categories"), _
	GlobalConfig("General_Products"), _
	GlobalConfig("General_Sitemap"), _
	GlobalConfig("General_Redirect"), _
	GlobalConfig("General_Post"), _
	GlobalConfig("General_Whois"), _
	GlobalConfig("General_Whois2"), _
	GlobalConfig("General_Whois_Check"), _
	GlobalConfig("General_Rss"), _
	GlobalConfig("General_Poll"), _
	GlobalConfig("General_Orders"), _
	GlobalConfig("General_Mailist"), _
	GlobalConfig("General_Users"), _
	GlobalConfig("General_Login"), _
	GlobalConfig("General_Banner"), _
	GlobalConfig("General_Server"), _
	GlobalConfig("General_Xml"), _
	GlobalConfig("General_Comments") _
)


Dim AdministratorFolders
AdministratorFolders = "sayfa"



'// Upload Klasörü
'GlobalConfig("uploadFolder") = "." & GlobalConfig("sRoot") & "upload"
GlobalConfig("uploadFolder") = GlobalConfig("sRoot") & "upload"
'clearfix GlobalConfig("uploadFolder")
GlobalConfig("logoPath") = GlobalConfig("uploadFolder") & "/logo"
'Clearfix GlobalConfig("uploadFolder")








'// Sayfa upload klasörü ve resim upload ayarları
'Const siWidth = 1000
'Const siHeight = 1000
'Const siWidth2 = 200
'Const siHeight2 = 150
'Const siWidth3 = 100
'Const siHeight3 = 100

'Const SayfaMaxResim = 50 '// maksimun Adet
'Const SayfaMaxSize = 2097152 '// 2 MB ' Clng((1024 ^ 2) * 2)
'Const SayfaTotalMaxSize = 10485761 '// 2 MB ' Clng((1024 ^ 2) * 2)

'Const SayfaMaxFile = 20 '// maksimun Adet
Const SayfaMaxFileSize = 10485761 '// 10 MB ' Clng((1024 ^ 2) * 2)
Const SayfaTotalMaxFileSize = 10485761 '// 10 MB ' Clng((1024 ^ 2) * 2)

Function sFolder(ByVal fid, ByVal thumb)
	sFolder = GlobalConfig("uploadFolder") & "/"
	sFolder = sFolder & GlobalConfig("PageUploadFolder") & "/"

	If (thumb = -1) Then sFolder = sFolder & "logo" : Exit Function

	sFolder = sFolder & Left(GlobalConfig("PageUploadFolder"), 1)
	sFolder = sFolder & "_" & fid
	'sFolder = sFolder & fid
	'If (thumb = 1) Then sFolder = sFolder & "/thumb_" & siWidth2 & "x" & siHeight2' & "px"
	If (thumb = 1) Then sFolder = sFolder & "/thumb"
	If (thumb = 2) Then sFolder = sFolder & "/medium" ' & siWidth3 & "x" & siHeight3' & "px"
	If (thumb = 3) Then sFolder = sFolder & "/files"
End Function




'Clearfix sFolder("", -1)




'// Kategori upload klasörü ve resim upload ayarları
'Const kiWidth = 150
'Const kiHeight = 150
'Const kiWidth2 = 150
'Const kiHeight2 = 150
'Const kiWidth3 = 100
'Const kiHeight3 = 100

'Const KatMaxResim = 20 '// maksimun Adet
'Const KatMaxSize = 2097152 '// 2 MB ' Clng((1024 ^ 2) * 2)
'Const KatTotalMaxSize = 10485761 '// 2 MB ' Clng((1024 ^ 2) * 2)

'Const KatMaxFile = 10 '// maksimun Adet
'Const KatMaxFileSize = 10485761 '// 10 MB ' Clng((1024 ^ 2) * 2)
'Const KatTotalMaxFileSize = 10485761 '// 10 MB ' Clng((1024 ^ 2) * 2)

Function kFolder(ByVal fid, ByVal thumb)
	kFolder = GlobalConfig("uploadFolder") & "/"
	kFolder = kFolder & GlobalConfig("CategoriesUploadFolder") & "/"

	If (thumb = -1) Then kFolder = kFolder & "logo" : Exit Function

	kFolder = kFolder & Left(GlobalConfig("CategoriesUploadFolder"), 1)
	kFolder = kFolder & "_" & fid
	'kFolder = kFolder & fid
	'If (thumb = 1) Then kFolder = kFolder & "/thumb_" & siWidth2 & "x" & siHeight2' & "px"
	If (thumb = 1) Then kFolder = kFolder & "/thumb"
	If (thumb = 2) Then kFolder = kFolder & "/medium" ' & siWidth3 & "x" & siHeight3' & "px"
	If (thumb = 3) Then kFolder = kFolder & "/files"
End Function






'// Ürün upload klasörü ve resim upload ayarları
'Const piWidth = 1000
'Const piHeight = 1000
'Const piWidth2 = 200
'Const piHeight2 = 150
'Const piWidth3 = 100
'Const piHeight3 = 100

'Const UrunMaxResim = 6 '// maksimun Adet
'Const UrunMaxSize = 2097152 '// 2 MB ' Clng((1024 ^ 2) * 2)
'Const UrunTotalMaxSize = 10485761 '// 2 MB ' Clng((1024 ^ 2) * 2)

'Const UrunMaxFile = 10 '// maksimun Adet
'Const UrunMaxFileSize = 10485761 '// 10 MB ' Clng((1024 ^ 2) * 2)
'Const UrunTotalMaxFileSize = 10485761 '// 10 MB ' Clng((1024 ^ 2) * 2)

Function pFolder(ByVal fid, ByVal thumb)
	pFolder = GlobalConfig("uploadFolder") & "/"
	pFolder = pFolder & GlobalConfig("ProductsUploadFolder") & "/"

	If (thumb = -1) Then pFolder = pFolder & "logo" : Exit Function

	pFolder = pFolder & Left(GlobalConfig("ProductsUploadFolder"), 1)
	pFolder = pFolder & "_" & fid
	'pFolder = pFolder & fid
	'If (thumb = 1) Then pFolder = pFolder & "/thumb_" & siWidth2 & "x" & siHeight2' & "px"
	If (thumb = 1) Then pFolder = pFolder & "/thumb"
	If (thumb = 2) Then pFolder = pFolder & "/medium" ' & siWidth3 & "x" & siHeight3' & "px"
	If (thumb = 3) Then pFolder = pFolder & "/files"
End Function







'// Uye upload klasörü ve resim upload ayarları
'Const uiWidth = 600
'Const uiHeight = 450
'Const uiWidth2 = 200
'Const uiHeight2 = 150
'Const uiWidth3 = 100
'Const uiHeight3 = 100
'Const UyeMaxResim = 20 '// maksimun Adet
'Const UyeMaxSize = 2097152 '// 2 MB ' Clng((1024 ^ 2) * 2)

Function uFolder(ByVal fid, ByVal thumb)
	uFolder = GlobalConfig("uploadFolder") & "/"
	uFolder = uFolder & GlobalConfig("UsersUploadFolder") & "/"

	If (thumb = -1) Then uFolder = uFolder & "logo" : Exit Function

	uFolder = uFolder & Left(GlobalConfig("UsersUploadFolder"), 1)
	uFolder = uFolder & "_" & fid
	'uFolder = uFolder & fid
	'If (thumb = 1) Then uFolder = uFolder & "/thumb_" & siWidth2 & "x" & siHeight2' & "px"
	If (thumb = 1) Then uFolder = uFolder & "/thumb"
	If (thumb = 2) Then uFolder = uFolder & "/medium" ' & siWidth3 & "x" & siHeight3' & "px"
	If (thumb = 3) Then uFolder = uFolder & "/files"
End Function









Dim bFolder
bFolder = GlobalConfig("uploadFolder") & "/" & GlobalConfig("BannerUploadFolder")
'Const biWidth = 555
'Const biHeight = 200
'Const BannerMaxResim = 5 '// maksimun Adet
Const BannerMaxSize = 1048576 '// 1 MB ' Clng((1024 ^ 2) * 1)









'// Upload edilebilir resim türleri
Dim ArrPictureExt
ArrPictureExt = Array("jpg", "jpeg", "gif", "png")






'// Upload edilebilir dosya türleri
Dim ArrFileExt
ArrFileExt = Array("jpg", "jpeg", "gif", "png", "swf", "doc", "docx", "xls", "xlsx", "cvs", "pps", "ppsx", "ppt", "pptx", "zip", "rar", "7z", "pdf", "mp3", "mp4", "flv", "mov", "mpg", "mpeg", "avi")





'// İzin verilen uzantılar için kontrol
Private Function UzantiKabul(ByVal Ext, ByVal ArrExt)
	If isArray(ArrExt) Then ArrExt = Join(ArrExt, "|")
	Ext = Replace(Ext, ".", "")
	With New RegExp
		.IgnoreCase = True
		.Global = True
		.Pattern = "^(" & ArrExt & ")$"
		UzantiKabul = .Test(Ext)
	End With
End Function
'Clearfix UzantiKabul(".SWF", ArrFileExt)





'// Dosya türüne göre css class ekleme
Function FileAddClass(ByVal Ext)
	Dim AddClass
	Ext = Replace(Ext, ".", "")
	Select Case Ext
		Case "jpg", "jpeg", "gif", "png" AddClass = "image"
		Case "doc", "docx" AddClass = "word"
		Case "cvs", "xls", "xlsx" AddClass = "excel"
		Case "pps", "ppsx", "ppt", "pptx" AddClass = "ppoint"
		Case "zip", "rar" AddClass = "archive"
		Case "pdf" AddClass = "pdf"
		Case "swf" AddClass = "swf"
		Case "mp3" AddClass = "music"
		Case "mp4", "flv", "mov", "mpeg", "avi" AddClass = "video"
	End Select
	FileAddClass = AddClass & " "
End Function







'// Maksimun dosya boyutu
Function MaxBytes(ByVal o)
	MaxBytes = (o / (1024 ^ 2))
End Function







'// AspJpeg PngOutput için Min. Verisyon
Function AspJpegVersiyon(ByVal Vers)
	Dim Vers2 : Vers2 = Cdbl("2.1.0.0")
	AspJpegVersiyon = False : If (Cdbl(Vers) >= Vers2) Then AspJpegVersiyon = True
End Function






'If GlobalConfig("admin_username") <> GlobalConfig("super_admin") Then
'Response.Write GlobalConfig("admin_yetki")

'Dim strSayfaKapat
'strSayfaKapat = GlobalConfig("General_Page")
'StrSayfaKapat = "urun"

Const xAuthor = "Ferdi Tarakcı"
Const xGenerator = "Energy Web Yazılım"
Const xReply = "bilgi@webtasarimx.net"

Private Sub GetHeader()
	With Response

		'// W3C Testinden geçebilmek için bazı standart dışı olan kodları yazdırmıyoruz
		If Not isTrue("W3C") Then
			'.Write("<meta http-equiv=""imagetoolbar"" content=""false"" />" & vbCrLf)
			'.Write("<meta name=""mssmarttagspreventparsing"" content=""true"" />" & vbCrLf)
			'.Write("<meta name=""designer"" content=""Energy Web Tasarım"" />" & vbCrLf)

			.Write("<meta name=""author"" content="""& xAuthor &""" />" & vbCrLf)
			.Write("<meta name=""reply-to"" content="""& xReply &""" />" & vbCrLf)
			.Write("<meta name=""generator"" content="""& xGenerator &""" />" & vbCrLf)
			'.Write("<meta name=""identifier-url"" content="""& GlobalConfig("sBase") &""" />" & vbCrLf)

			'// Bazı sayfaları arama motorlarının indekslemesini engellemek için
			If GlobalConfig("HeaderMetaTag") <> "" Then
				.Write("<meta name=""robots"" content="""& GlobalConfig("HeaderMetaTag") &""" />" & vbCrLf )

			ElseIf .Status = "404" Or .Status = "404 Not Found" Then
				.Write("<meta name=""robots"" content=""noindex, nofollow, noarchive, noimageindex"" />" & vbCrLf)

			End If

			'// Sitenin telif hakkı yazısı
			If GlobalConfig("copyright") <> "" Then _
				.Write("<meta name=""copyright"" content="""& GlobalConfig("copyright") &""" />" & vbCrLf)

			'// Sayfa başlığı
			.Write("<meta name=""title"" content="""& GlobalConfig("site_ismi") &""" />" & vbCrLf)
		End If

		'// Sayfanın başlığı
		.Write("<title>" & GlobalConfig("site_ismi") & "</title>" & vbCrLf)

		'// Genel tanım
		If GlobalConfig("description") <> "" Then _
			.Write("<meta name=""description"" content="""& GlobalConfig("description") &""" />" & vbCrLf)

		'// Anahtar kelimeler
		If GlobalConfig("keyword") <> "" Then _
			.Write("<meta name=""keywords"" content="""& GlobalConfig("keyword") &""" />" & vbCrLf)

		'// Arama motorlarında doğrulanması
		If GlobalConfig("verify") <> "" Then _
			.Write( GlobalConfig("verify")  & vbCrLf )

		'// RSS beslemesi
		.Write("<link rel=""alternate"" type=""application/rss+xml"" title=""RSS Beslemesi"" href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Rss"), "", "", 0, 0, "") &""" />" & vbCrLf)

		'// W3C Testinden geçebilmek için bazı standart dışı olan kodları yazdırmıyoruz
		If Not isTrue("W3C") Then
			'// Site haritası
			For Each SitemapDomain in Split(GlobalConfig("domain"), ",")
				SitemapDomain = Trim( SitemapDomain )
				If Site_HTTP_HOST =  SitemapDomain Then
					.Write("<link rel=""sitemap"" type=""application/xml"" title=""Site Haritası"" href="""& UrlWrite(GlobalConfig("sDomain"), "", GlobalConfig("General_Sitemap"), "", "", "", "", "") &""" />" & vbCrLf)
				End If
			Next
		End If

		'// W3C Testinden geçebilmek için bazı standart dışı olan kodları yazdırmıyoruz
		If Not isTrue("W3C") Then

			If Not ((GlobalConfig("request_option") = GlobalConfig("General_Home") And Not GlobalConfig("General_introPage")) Or (GlobalConfig("request_option") = GlobalConfig("General_Default") And GlobalConfig("General_introPage"))) Then
				.Write("<link rel=""index"" title="""& GlobalConfig("default_site_ismi") &""" href="""& GlobalConfig("sBase") &""" />" & vbCrLf)
			End If

			.Write("<link rel=""canonical"" title="""& GlobalConfig("header_title") &""" href="""& GlobalConfig("site_uri") &""" />" & vbCrLf)

			.Write(GlobalConfig("HeaderLinks"))
		End If
	End With

End Sub
%>

