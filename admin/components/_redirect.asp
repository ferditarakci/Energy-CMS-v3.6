<%
If Not (task = "tema_preview" Or blnPostMethod) Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
Response.Clear()

Dim modul_yeri, Durum, qsFn, PictureTitlePost, EtiketBilgileri
Dim img_title, img_alt, img_url, img_text, strTbl

Select Case task

'Case "urlkontrol"
'	icerik_dil_id = intYap(Request("dilid"), 1)
'	tabloAdi = intYap(Request.Form("energy"), 1)
'	Select Case tabloAdi
'		Case 1 tabloAdi = "sayfa"
'		Case 2 tabloAdi = "products"
'		Case 3 tabloAdi = "kategori"
'	End Select
'	Response.Write( Newid(tabloAdi, Request.Form("sefurl"), "makale", id) )





Case "tema_preview" ' Tema önizleme
	Set objRs = setExecute("SELECT IFNULL(path, '') As path, IFNULL(styles, '') As styles FROM #___tema WHERE id = "& id &";")
		If Not objRs.Eof Then
			Session("tema_path_" & GlobalConfig("sRoot")) = objRs("path")
			Session("tema_style_" & GlobalConfig("sRoot")) = objRs("styles")
		End If	
	Set objRs = Nothing
	Response.Redirect("../")
	Response.End




Case "template_status" ' Varsayılın temayı değiştir

	If GlobalConfig("admin_yetki") Then
		sqlExecute("UPDATE #___tema Set durum = 0 WHERE Not id = "& id &";")
		sqlExecute("UPDATE #___tema Set durum = 1 WHERE id = "& id &";")
	End If

	Response.Write("checked")
















Case "url_status" ' Url durum değiştirme

	If GlobalConfig("admin_yetki") Then
		sqlExecute("UPDATE #___content_url Set durum = 0 WHERE (parent = "& parent &" And parent_id = "& parent_id &" And Not id = "& id &" And lang = '"& GlobalConfig("site_lang") &"');")
		sqlExecute("UPDATE #___content_url Set durum = 1 WHERE (parent = "& parent &" And parent_id = "& parent_id &" And id = "& id &" And lang = '"& GlobalConfig("site_lang") &"');")
	End If

	Response.Write("checked")




Case "url_save" ' Url kaydet

If GlobalConfig("admin_yetki") Then

	If id = 0 Then
		saveMessage = "Yeni permalink başarıyla eklendi."
	Else
		saveMessage = "Permalink başarıyla düzenlendi."
	End If

		parent = intYap(parent, GlobalConfig("General_PagePN"))
		strTbl = "sayfa"
		If parent = GlobalConfig("General_CategoriesPN") Then strTbl = "kategori"
		If parent = GlobalConfig("General_ProductsPN") Then strTbl = "products"
		If parent = GlobalConfig("General_PollPN") Then strTbl = "anket"

		strLink = Newid(strTbl, SefUrl(Request.Form("url_value")), parent, parent_id, GlobalConfig("site_lang"))

		If id = 0 Then
			sqlExecute("INSERT INTO #___content_url (lang, parent, parent_id, seflink, durum) VALUES('"& GlobalConfig("site_lang") &"', "& parent &", "& parent_id &", '"& strLink &"', 1);")
			id = sqlQuery("SELECT id FROM #___content_url ORDER BY id DESC Limit 1;", 0)
			sqlExecute("UPDATE #___content_url Set durum = 0 WHERE lang = '"& GlobalConfig("site_lang") &"' And Not id = "& id &" And parent = "& parent &" And parent_id = "& parent_id &";")
		Else
			sqlExecute("UPDATE #___content_url Set seflink = '"& strLink &"' WHERE id = "& id &";")
		End If

		strLink = URLDecode(Replace(strLink, "&amp;", "&"))
		'Response.Write(  strLink ) )

	saveClass = "success"
Else
	saveMessage = GlobalConfig("admin_yetki_message")
	saveClass = "warning"
End If


Set PictureTitlePost = jsObject()
PictureTitlePost("uid") = id
PictureTitlePost("url") = strLink
'PictureTitlePost("checked") = saveMessage
PictureTitlePost("Msg") = saveMessage
PictureTitlePost("cssClass") = saveClass
PictureTitlePost.Flush
Set PictureTitlePost = Nothing





















Case "yorum" ' Menü silme
Set EtiketBilgileri = jsObject()
	Set objRs = setExecute("SELECT * FROM #___yorum WHERE id = "& id &";")
		If Not objRs.Eof Then
			EtiketBilgileri("idno") = objRs("id")
			EtiketBilgileri("comment_author") = Duzenle(objRs("comment_author"))
			EtiketBilgileri("comment_author_email") = objRs("comment_author_email")
			EtiketBilgileri("comment_author_url") = Duzenle(objRs("comment_author_url"))
			EtiketBilgileri("comment_status") = objRs("comment_status")
			EtiketBilgileri("comment_text") = Duzenle(objRs("comment_text"))
		End If	
	Set objRs = Nothing
EtiketBilgileri.Flush
Set EtiketBilgileri = Nothing









Case GlobalConfig("General_Tags") ' Menü silme
Set EtiketBilgileri = jsObject()
	Set objRs = setExecute("SELECT * FROM #___etiket WHERE id = "& id &";")
		If Not objRs.Eof Then
			EtiketBilgileri("idno") = objRs("id")
			EtiketBilgileri("etiket") = Duzenle(objRs("etiket"))
			EtiketBilgileri("permalink") = objRs("permalink")
			EtiketBilgileri("status") = objRs("status")
			EtiketBilgileri("description") = Duzenle(objRs("description"))
			EtiketBilgileri("keywords") = Duzenle(objRs("keywords"))
			EtiketBilgileri("robots_meta") = objRs("robots_meta")
		End If	
	Set objRs = Nothing
EtiketBilgileri.Flush
Set EtiketBilgileri = Nothing







Case "etiket_autocomplete"' Menü silme
	Set objRs = setExecute("SELECT etiket FROM #___etiket WHERE etiket like '%"& Temizle(Request.Form("q"), 1) &"%';")
		While Not objRs.Eof
			EtiketAutoCompletePost HtmlEnCode(Duzenle(objRs("etiket"))), HtmlEnCode(Duzenle(objRs("etiket")))
		objRs.MoveNext : Wend
	Set objRs = Nothing
	'response.write "[""fer"",""ferd++"",""ferdici#""]"
JsonFlush arrAutoCompleteList


Case "menu_remove" ' Menü silme

If GlobalConfig("admin_yetki") Then
	sqlExeCute("DELETE FROM #___content_menu WHERE id = "& id &";")
	sqlExeCute("DELETE FROM #___content_url WHERE (parent = "& GlobalConfig("General_CustomURLPN") &" And parent_id = "& id &");")
	Call MenuParentDelete(id)

	saveMessage = "Menü başarıyla silindi."
	saveClass = "success"
Else
	saveMessage = GlobalConfig("admin_yetki_message")
	saveClass = "warning"
End If

Set PictureTitlePost = jsObject()
PictureTitlePost("Msg") = saveMessage
PictureTitlePost("cssClass") = saveClass
PictureTitlePost.Flush
Set PictureTitlePost = Nothing





Case "listmenu_save" ' Menü sırala

	If GlobalConfig("admin_yetki") Then
		Dim ListMenuArray
		Set ListMenuArray = Request.Form("menuid[]")
		For i = 1 To ListMenuArray.Count
			intSira = i
			parent = intYap(Request.Form("parent_" & ListMenuArray(i)), 0)
			'If parent = 0 Then intSira 

			If Not GlobalConfig("admin_yetki") Then Exit For
			sqlExecute("UPDATE #___content_menu Set sira = "& intSira &", anaid = "& parent &" WHERE id = "& intYap(ListMenuArray(i), 0) &";")
		Next
		Set ListMenuArray = Nothing

		'If GlobalConfig("admin_yetki") Then
		'	Response.Clear() : saveClass = "success" : saveMessage = "Modül yerleri başarıyla ayarlandı."
		'Else
		'	Response.Clear() : saveClass = "warning" : saveMessage = GlobalConfig("admin_yetki_message")
		'End If
	End If
		Response.Write("ok")
		'Set PictureTitlePost = jsObject()
		'PictureTitlePost("txtMsg") = saveMessage
		'PictureTitlePost("cssClass") = saveClass
		'PictureTitlePost.Flush
		'Set PictureTitlePost = Nothing


















Case "modules_order" ' Modül sırala
	Dim arrModulOrder
	Set arrModulOrder = Request.Form("modul_id[]")
	For i = 1 To arrModulOrder.Count
		If Not GlobalConfig("admin_yetki") Then Exit For
		sqlExecute("UPDATE #___modul Set sira = "& i &", yer = '"& Temizle(Request.Form("data"), 1) &"' WHERE id = "& intYap(arrModulOrder(i), 0) &";")
	Next
	Set arrModulOrder = Nothing

	If GlobalConfig("admin_yetki") Then
		Response.Clear() : saveClass = "success" : saveMessage = "Modül yerleri başarıyla ayarlandı."
	Else
		Response.Clear() : saveClass = "warning" : saveMessage = GlobalConfig("admin_yetki_message")
	End If

	Set PictureTitlePost = jsObject()
	PictureTitlePost("txtMsg") = saveMessage
	PictureTitlePost("cssClass") = saveClass
	PictureTitlePost.Flush
	Set PictureTitlePost = Nothing




Case "modul_status" ' Modül durum değiştir

	Response.Write("unchecked")
	Set objRs = setExecute("SELECT durum FROM #___modul WHERE id = "& id &";")
		If Not objRs.Eof Then
			Durum = 1 : If CBool(objRs("durum")) Then Durum = 0
			If GlobalConfig("admin_yetki") Then sqlExecute("UPDATE #___modul Set durum = "& Durum &" WHERE id = "& id &";")
			If CBool(Durum) Then Response.Clear() : Response.Write("checked")
		End If	
	Set objRs = Nothing

	If GlobalConfig("admin_yetki") Then
		Response.Clear() : saveClass = "success" : saveMessage = "Modül durumu başarıyla değiştirildi."
	Else
		Response.Clear() : saveClass = "warning" : saveMessage = GlobalConfig("admin_yetki_message")
	End If

	Set PictureTitlePost = jsObject()
	PictureTitlePost("txtMsg") = saveMessage
	PictureTitlePost("cssClass") = saveClass
	PictureTitlePost.Flush
	Set PictureTitlePost = Nothing





















'Vitrin resmi yap
Case GlobalConfig("General_Page") & "_defaultFile", _
     GlobalConfig("General_Categories") & "_defaultFile", _
	 GlobalConfig("General_Products") & "_defaultFile"

	'parent = GlobalConfig("General_PagePN")

	'If task = GlobalConfig("General_Categories") & "_defaultFile" Then _
	'	parent = GlobalConfig("General_CategoriesPN")

	'If task = GlobalConfig("General_Products") & "_defaultFile" Then _
	'	parent = GlobalConfig("General_ProductsPN")

	Set objRs = setExecute("SELECT parent, parent_id, anaresim, featuredFile FROM #___files WHERE lang = '"& GlobalConfig("site_lang") &"' And id = "& id &";")
		If Not objRs.Eof Then

			Durum = 0
			If (Request.Form("featured") = 0) Then
				'If objRs("anaresim") <> 1 Then Durum = 1
				If objRs("anaresim") = 0 Then Durum = 1

			ElseIf (Request.Form("featured") = 1) Then
				'If objRs("anaresim") < 2 Then Durum = 2
				If objRs("featuredFile") = 0 Then Durum = 1

			End If

			If GlobalConfig("admin_yetki") Then
				If (Request.Form("featured") = 0) Then
					sqlExecute("UPDATE #___files Set anaresim = 0 WHERE parent = "& objRs("parent") &" And parent_id = "& objRs("parent_id") &" And Not id = "& id &" And lang = '"& GlobalConfig("site_lang") &"';")
					sqlExecute("UPDATE #___files Set anaresim = "& Durum &" WHERE parent = "& objRs("parent") &" And id = "& id &" And lang = '"& GlobalConfig("site_lang") &"';")

				ElseIf (Request.Form("featured") = 1) Then
					sqlExecute("UPDATE #___files Set featuredFile = "& Durum &" WHERE parent = "& objRs("parent") &" And id = "& id &" And lang = '"& GlobalConfig("site_lang") &"';")
				End If
			End If
			Response.Write(Durum)
		End If
	Set objRs = Nothing









'Vitrin durum değiştirme
Case GlobalConfig("General_Page") & "_status", _
     GlobalConfig("General_Categories") & "_status", _
     GlobalConfig("General_Products") & "_status"

	'parent = GlobalConfig("General_PagePN")
	'If task = GlobalConfig("General_Categories") & "_status" Then _
	'	parent = GlobalConfig("General_CategoriesPN")

	'If task = GlobalConfig("General_Products") & "_status" Then _
	'	parent = GlobalConfig("General_ProductsPN")

	Set objRs = setExecute("SELECT durum, parent FROM #___files WHERE lang = '"& GlobalConfig("site_lang") &"' And id = "& id &";")
		If Not objRs.Eof Then
			Durum = 1 : If objRs("durum") = 1 Then Durum = 0
			If GlobalConfig("admin_yetki") Then
				sqlExecute("UPDATE #___files Set durum = "& Durum &" WHERE parent = "& objRs("parent") &" And id = "& id &" And lang = '"& GlobalConfig("site_lang") &"';")
				'Durum = Cdbl(sqlQuery("SELECT durum FROM #___files WHERE parent = "& objRs("parent") &" And id = "& id &" And lang = '"& GlobalConfig("site_lang") &"';", 0))
				'If CBool(Durum) Then Durum = 1 Else Durum = 0
			End If
			Response.Write(Durum)
		End If
	Set objRs = Nothing









Case GlobalConfig("General_Page") & "_settings_fileDelete", _
	GlobalConfig("General_Categories") & "_settings_fileDelete", _
	GlobalConfig("General_Products") & "_settings_fileDelete", _
	GlobalConfig("General_Banner") & "_settings_fileDelete"

		If task = GlobalConfig("General_Page") & "_settings_fileDelete" Then
			parent = GlobalConfig("General_PagePN")

		ElseIf task = GlobalConfig("General_Categories") & "_settings_fileDelete" Then
			parent = GlobalConfig("General_CategoriesPN")

		ElseIf task = GlobalConfig("General_Products") & "_settings_fileDelete" Then
			parent = GlobalConfig("General_ProductsPN")

		ElseIf task = GlobalConfig("General_Banner") & "_settings_fileDelete" Then
			parent = GlobalConfig("General_BannerPN")
		End If


If GlobalConfig("admin_yetki") Then
	OpenRs objRs, "SELECT LogoWrite FROM #___settings WHERE parent = "& parent &";"
	If Not objRs.Eof Then
		If task = GlobalConfig("General_Page") & "_settings_fileDelete" Then
			Call DeleteFile(sFolder("", -1) & "/" & objRs("LogoWrite"))

		ElseIf task = GlobalConfig("General_Categories") & "_settings_fileDelete" Then
			Call DeleteFile(kFolder("", -1) & "/" & objRs("LogoWrite"))

		ElseIf task = GlobalConfig("General_Products") & "_settings_fileDelete" Then
			Call DeleteFile(pFolder("", -1) & "/" & objRs("LogoWrite"))				

		ElseIf task = GlobalConfig("General_Banner") & "_settings_fileDelete" Then
			Call DeleteFile(bFolder & "/" & objRs("LogoWrite"))				
		End If
		objRs("LogoWrite") = ""
		objRs.Update
	End If
	CloseRs objRs

	saveMessage = "Dosya başarıyla sunucudan silindi."
	saveClass = "success"

Else

	saveMessage = GlobalConfig("admin_yetki_message")
	saveClass = "warning"

End If

Set PictureTitlePost = jsObject()
PictureTitlePost("Msg") = saveMessage
PictureTitlePost("cssClass") = saveClass
PictureTitlePost.Flush
Set PictureTitlePost = Nothing





Case GlobalConfig("General_Page") & "_fileDelete", _
	GlobalConfig("General_Categories") & "_fileDelete", _
	GlobalConfig("General_Products") & "_fileDelete"

If GlobalConfig("admin_yetki") Then
	OpenRs objRs, "SELECT parent, parent_id, file_type, resim FROM #___files WHERE id = "& id &";"
	If Not objRs.Eof Then
		If objRs("file_type") = 1 Then
			If objRs("parent") = GlobalConfig("General_PagePN") Then
				Call DeleteFile(sFolder(objRs("parent_id"), 0) & "/" & objRs("resim"))
				Call DeleteFile(sFolder(objRs("parent_id"), 1) & "/" & objRs("resim"))
				Call DeleteFile(sFolder(objRs("parent_id"), 2) & "/" & objRs("resim"))

			ElseIf objRs("parent") = GlobalConfig("General_CategoriesPN") Then
				Call DeleteFile(kFolder(objRs("parent_id"), 0) & "/" & objRs("resim"))
				Call DeleteFile(kFolder(objRs("parent_id"), 1) & "/" & objRs("resim"))
				Call DeleteFile(kFolder(objRs("parent_id"), 2) & "/" & objRs("resim"))

			ElseIf objRs("parent") = GlobalConfig("General_ProductsPN") Then
				Call DeleteFile(pFolder(objRs("parent_id"), 0) & "/" & objRs("resim"))
				Call DeleteFile(pFolder(objRs("parent_id"), 1) & "/" & objRs("resim"))
				Call DeleteFile(pFolder(objRs("parent_id"), 2) & "/" & objRs("resim"))					
			End If

		ElseIf objRs("file_type") = 2 Then
			If objRs("parent") = GlobalConfig("General_PagePN") Then
				Call DeleteFile(sFolder(objRs("parent_id"), 3) & "/" & objRs("resim"))

			ElseIf objRs("parent") = GlobalConfig("General_CategoriesPN") Then
				Call DeleteFile(kFolder(objRs("parent_id"), 3) & "/" & objRs("resim"))

			ElseIf objRs("parent") = GlobalConfig("General_ProductsPN") Then
				Call DeleteFile(pFolder(objRs("parent_id"), 3) & "/" & objRs("resim"))
			
			End If
		End If
		objRs.Delete
	End If
	CloseRs objRs

	saveMessage = "Dosya başarıyla sunucudan silindi."
	saveClass = "success"

Else

	saveMessage = GlobalConfig("admin_yetki_message")
	saveClass = "warning"

End If

Set PictureTitlePost = jsObject()
PictureTitlePost("Msg") = saveMessage
PictureTitlePost("cssClass") = saveClass
PictureTitlePost.Flush
Set PictureTitlePost = Nothing






Case "otherFileOrder" ' Dosya sırala

	If GlobalConfig("admin_yetki") Then
		Dim arrFilesOrder
		Set arrFilesOrder = Request.Form("other_file_id[]")
		For i = 1 To arrFilesOrder.Count
			If Not GlobalConfig("admin_yetki") Then Exit For
			sqlExecute("UPDATE #___files Set sira = "& i &", lang = '"& Temizle(Request.Form("lang"), 1) &"' WHERE id = "& intYap(arrFilesOrder(i), 0) &";")
		Next
		Set arrFilesOrder = Nothing
		saveMessage = "Dosyalar başarıyla sıralandı."
		saveClass = "success"
	Else
		saveMessage = GlobalConfig("admin_yetki_message")
		saveClass = "warning"
	End If
	Set PictureTitlePost = jsObject()
	PictureTitlePost("Msg") = saveMessage
	PictureTitlePost("cssClass") = saveClass
	PictureTitlePost.Flush
	Set PictureTitlePost = Nothing







Case "imgFileOrder" ' Resim sırala

	If GlobalConfig("admin_yetki") Then
		Dim arrPictureOrder
		Set arrPictureOrder = Request.Form("image-id[]")
		For i = 1 To arrPictureOrder.Count
			If Not GlobalConfig("admin_yetki") Then Exit For
			sqlExecute("UPDATE #___files Set sira = "& i &", lang = '"& Temizle(Request.Form("lang"), 1) &"' WHERE id = "& intYap(arrPictureOrder(i), 0) &";")
		Next
		Set arrPictureOrder = Nothing
		saveMessage = "Resimler başarıyla sıralandı."
		saveClass = "success"
	Else
		saveMessage = GlobalConfig("admin_yetki_message")
		saveClass = "warning"
	End If
	Set PictureTitlePost = jsObject()
	PictureTitlePost("Msg") = saveMessage
	PictureTitlePost("cssClass") = saveClass
	PictureTitlePost.Flush
	Set PictureTitlePost = Nothing








Case "fileUpdate"
	Dim fileTitle, fileAlt, fileText, fileUrl
	fileTitle = Request.Form("fileTitle")
	fileAlt = Request.Form("fileAlt")
	fileText = Request.Form("fileText")
	fileUrl = TrimFix(Temizle(UrlEncode(Request.Form("fileUrl")), 1))

	SQL = ""
	If GlobalConfig("admin_yetki") Then
		If Cbool(sqlQuery("SELECT id FROM #___files WHERE id = "& id &";", 0)) Then
			SQL = SQL & "UPDATE #___files Set "
			SQL = SQL & "title = '"& TrimFix(Temizle(fileTitle, 1)) &"', "
			SQL = SQL & "alt = '"& TrimFix(Temizle(fileAlt, 1)) &"', "
			SQL = SQL & "url = '"& UrlDecode(fileUrl) &"', "
			SQL = SQL & "text = '"& TrimFix(Temizle(fileText, 0)) &"'"
			If GlobalConfig("general_admin") Then _
			SQL = SQL & ", tarih = '"& DateSqlFormat(Request.Form("fileDateTime"), "yy-mm-dd", 1) &"' "
			SQL = SQL & "WHERE id = "& id &";"
			SQL = SQL & ""
			sqlExecute(SQL)
			Response.Clear()
		End If
		saveClass = "success"
		saveMessage = "Bilgiler başarıyla güncellendi."
	Else
		saveClass = "warning"
		saveMessage = GlobalConfig("admin_yetki_message")
	End If

	Set PictureTitlePost = jsObject()
	PictureTitlePost("fileTitle") = fileTitle
	PictureTitlePost("fileAlt") = fileAlt
	PictureTitlePost("fileUrl") = UrlDecode(fileUrl)
	PictureTitlePost("fileText") = fileText
	PictureTitlePost("fileMessage") = saveMessage
	PictureTitlePost("fileCssClass") = saveClass
	PictureTitlePost.Flush
	Set PictureTitlePost = Nothing













Case GlobalConfig("General_Banner") & "_fileDelete" ' Banner resim silme
If GlobalConfig("admin_yetki") Then
	OpenRs objRs, "SELECT img FROM #___banner WHERE id = "& id &";"
		If Not objRs.Eof Then
			ResimAdi = objRs("img")
			Call DeleteFile(bFolder & "/" & ResimAdi)
			objRs("img") = ""
			objRs.Update
		End If
	CloseRs objRs
	saveClass = "success"
	saveMessage = "Banner görseli başarıyla silindi."
Else
	saveClass = "warning"
	saveMessage = GlobalConfig("admin_yetki_message")
End If
	Set PictureTitlePost = jsObject()
	PictureTitlePost("Msg") = saveMessage
	PictureTitlePost("cssClass") = saveClass
	PictureTitlePost.Flush
	Set PictureTitlePost = Nothing




Case "ayar_fileDelete" ' Banner resim silme
If GlobalConfig("admin_yetki") Then
	OpenRs objRs, "SELECT logo FROM #___ayarlar WHERE id = 1;"
		If Not objRs.Eof Then
			ResimAdi = objRs("logo")
			Call DeleteFile(GlobalConfig("logoPath") & "/" & ResimAdi)
			objRs("logo") = ""
			objRs.Update
		End If
	CloseRs objRs
	saveClass = "success"
	saveMessage = "Site logosu başarıyla silindi."
Else
	saveClass = "warning"
	saveMessage = GlobalConfig("admin_yetki_message")
End If
	Set PictureTitlePost = jsObject()
	PictureTitlePost("Msg") = saveMessage
	PictureTitlePost("cssClass") = saveClass
	PictureTitlePost.Flush
	Set PictureTitlePost = Nothing



Case "il"
	Call ilceler(id, 0)




Case "ilce"
	Call semtler(id, 0)











'Case "username_kontrol"
'	qsFn = Trim(Temizle(Request.QueryString("fn"), 1))
'	Set objRs = setExecute("SELECT id FROM #___uyeler WHERE kulad = '"& qsFn &"';")
'		If objRs.Eof Then
'			Response.Write("<span class=""text green"">Müsait</span>")
'		Else
'			Response.Write("<span class=""text red"">Kullanımda</span>")
'		End If
'	Set objRs = Nothing



'Case "usermail_kontrol"
'	qsFn = Trim(Temizle(Request.QueryString("fn"), 1))
'	Set objRs = setExecute("SELECT id FROM #___uyeler WHERE mail = '"& qsFn &"';")
'		If objRs.Eof Then
'			Response.Write("<span class=""text green"">Müsait</span>")
'		Else
'			Response.Write("<span class=""text red"">Kullanımda</span>")
'		End If
'	Set objRs = Nothing





Case "secenek_sil" ' Anket seçenek silme
	If GlobalConfig("admin_yetki") Then sqlExecute("DELETE FROM #___anket_secenek WHERE secenekid = "& id &";")
	Response.Write("ok")



'// Hit sıfırlama
Case "anket_secenek_oy_sifirla"
	'Call HitDelete("anket_secenek", id)
	If GlobalConfig("admin_yetki") Then
		sqlExecute("UPDATE #___anket_secenek Set oy = 0 WHERE secenekid = "& id &";")
		Response.Write(0)
	Else
		Response.Write("İşlem yetkiniz yok!")
	End If


Case "bannerhit"
	Call HitDelete("banner", id)

Case "hit_reset"
	Call HitDelete("content", id)


Case "uyehit"
	Call HitDelete("uyeler", id)



End Select











Sub HitDelete(ByVal strTable, ByVal intID)
	If GlobalConfig("admin_yetki") Then
		sqlExecute("UPDATE #___"& strTable &" Set hit = 0 WHERE id = "& intID &";")
		Response.Write(0)
	Else
		Response.Write("İşlem yetkiniz yok!")
	End If
End Sub
%>
