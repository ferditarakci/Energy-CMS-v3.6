<%
If Not blnPostMethod Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
'Response.Clear()
Response.Buffer = True
'Response.ContentType = "text/plain"
On Error Resume Next
Server.ScriptTimeout = 900

If (Request.TotalBytes > 10485761) Then
	Call PictureJson(CookieLang, "", 0, 0, "", "", "", "", "error", "", "", "Tek seferde maksimun yüklenebilecek doysa boyutu 10 MB'tan büyük olamaz!", "")
	arrUpload.Flush
	Response.End
End If

If id = 0 Then id = intYap(pageid, 0)

CookieLang = Request.Cookies("locale_lang")
'Response.Cookies("locale_lang").Expires = Now()-1
'Response.Cookies("locale_lang").Path = "/admin/"

If CookieLang = "" Then CookieLang = GlobalConfig("site_lang")


Dim ttfFontFile : ttfFontFile = Server.MapPath("font/Helvetica.ttf")
'If GlobalConfig("resim_yazi_durum") = 2 Then Dim ttfFontFile : ttfFontFile = Server.MapPath("font/Helvetica.ttf")
'If GlobalConfig("resim_logo_baski") Then Dim pngLogoFile : pngLogoFile = Server.MapPath("font/logo.png")

Select Case task

	Case GlobalConfig("General_Page"), GlobalConfig("General_Page") & "_file_upload"
		parent = GlobalConfig("General_PagePN")

	Case GlobalConfig("General_Categories"), GlobalConfig("General_Categories") & "_file_upload"
		parent = GlobalConfig("General_CategoriesPN")

	Case GlobalConfig("General_Products"), GlobalConfig("General_Products") & "_file_upload"
		parent = GlobalConfig("General_ProductsPN")

	Case GlobalConfig("General_Banner"), GlobalConfig("General_Banner") & "_file_upload"
		parent = GlobalConfig("General_BannerPN")

	Case Else
		parent = 0

End Select




SQL = ""
'SQL = SQL & "SELECT * FROM #___settings As a LEFT JOIN #___settings_lang As b ON " & vbCrLf
SQL = SQL & "SELECT *, IFNULL((SELECT imageText FROM #___settings_lang WHERE parent = "& parent &" And lang = '"& CookieLang &"' Limit 1), '') As imageText FROM #___settings WHERE opt_status = 1 And parent = "& parent &";" & vbCrLf
Set objRs = setExecute( SQL )
	If Not objRs.Eof Then
		GlobalConfig("SmallSizeW") = intYap(objRs("SmallSizeW"), 120)
		GlobalConfig("SmallSizeH") = intYap(objRs("SmallSizeH"), 100)

		GlobalConfig("MediumSizeW") = intYap(objRs("MediumSizeW"), 250)
		GlobalConfig("MediumSizeH") = intYap(objRs("MediumSizeH"), 200)

		GlobalConfig("LargeSizeW") = intYap(objRs("LargeSizeW"), 600)
		GlobalConfig("LargeSizeH") = intYap(objRs("LargeSizeH"), 450)

		GlobalConfig("SmallTextStatus") = intYap(objRs("SmallTextStatus"), 0)
		GlobalConfig("MediumTextStatus") = intYap(objRs("MediumTextStatus"), 0)
		GlobalConfig("LargeTextStatus") = intYap(objRs("LargeTextStatus"), 0)

		GlobalConfig("SmallLogoStatus") = intYap(objRs("SmallLogoStatus"), 0)
		GlobalConfig("MediumLogoStatus") = intYap(objRs("MediumLogoStatus"), 0)
		GlobalConfig("LargeLogoStatus") = intYap(objRs("LargeLogoStatus"), 0)

		GlobalConfig("MaxPicture") = intYap(objRs("MaxPicture"), 0)
		GlobalConfig("MaxPictureSize") = intYap(objRs("MaxPictureSize"), 0)
		GlobalConfig("MaxPictureTotalSize") = intYap(objRs("MaxPictureTotalSize"), 0)

		GlobalConfig("MaxFile") = intYap(objRs("MaxFile"), 0)
		GlobalConfig("MaxFileSize") = intYap(objRs("MaxFileSize"), 0)
		GlobalConfig("MaxFileTotalSize") = intYap(objRs("MaxFileTotalSize"), 0)

		GlobalConfig("imageText") = objRs("imageText") & ""
		GlobalConfig("LogoWrite") = objRs("LogoWrite") & ""
	End If
Set objRs = Nothing





Select Case task

	Case GlobalConfig("General_Page")

	%><!--#include file="sayfa_img_upload.asp"--><%

	Case GlobalConfig("General_Page") & "_file_upload"

	%><!--#include file="sayfa_file_upload.asp"--><%

	Case GlobalConfig("General_Page") & "_settings"

	%><!--#include file="sayfa_logo_upload.asp"--><%




	Case GlobalConfig("General_Categories")

	%><!--#include file="kategori_img_upload.asp"--><%

	Case GlobalConfig("General_Categories") & "_file_upload"

	%><!--#include file="kategori_file_upload.asp"--><%

	Case GlobalConfig("General_Categories") & "_settings"

	%><!--#include file="kategori_logo_upload.asp"--><%



	Case GlobalConfig("General_Products")

	%><!--#include file="urun_img_upload.asp"--><%

	Case GlobalConfig("General_Products") & "_file_upload"

	%><!--#include file="urun_file_upload.asp"--><%

	Case GlobalConfig("General_Products") & "_settings"

	%><!--#include file="urun_logo_upload.asp"--><%



	Case GlobalConfig("General_Banner")

	%><!--#include file="banner_img_upload.asp"--><%

	Case GlobalConfig("General_Banner") & "_settings"

	%><!--#include file="banner_logo_upload.asp"--><%



	Case "ayar"

	%><!--#include file="site_logo_upload.asp"--><%

	Case Else

	Call PictureJson(CookieLang, "", 0, 0, "", "", "", "", "error", "", "", "Dosya yüklenemedi, belirtilen yol doğru değil.", "")

End Select

If Err.Number = 8 Then
	Response.Clear()
	'jAddClass = "error"
	'jMessage = "Üzgünüm :( Bir hata oluştu, Hata Kodu: " & Err.Description
	'errDesc = Err.Description
	'If errDesc = "At least one of the uploaded files exceeds the maximum allowed size." Then errDesc = "Yüklemeye çalıştığınız dosya maksimun dosya boyutunu aşıyor."
	'If errDesc = "The system cannot find the file specified." Then errDesc = "Yazma izinlerinde problemler var."
	Call PictureJson(CookieLang, "", 0, 0, "", "", "", "", "error", "", "", "Yüklemeye çalıştığınız dosya maksimun dosya boyutunu aşıyor.", "")

ElseIf Not Err.Number = 0 And Err.Number <> 8 Then
	Response.Clear()
	'jAddClass = "error"
	'jMessage = "Üzgünüm :( Bir hata oluştu, Hata Kodu: " & Err.Description
	'errDesc = Err.Description
	'If errDesc = "At least one of the uploaded files exceeds the maximum allowed size." Then errDesc = "Yüklemeye çalıştığınız dosya maksimun dosya boyutunu aşıyor."
	'If errDesc = "The system cannot find the file specified." Then errDesc = "Yazma izinlerinde problemler var."
	Call PictureJson(CookieLang, "", 0, 0, "", "", "", "", "error", "", "", "" & Err.Description, "")
End If

On Error GoTo 0

Call JsonFlush(arrUpload)

%>
