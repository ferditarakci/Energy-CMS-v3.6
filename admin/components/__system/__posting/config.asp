<%
Dim site_domain, site_verify, site_analytics, site_seflink, facebook_url, twitter_url, googleplus_url
Dim site_mail_host, site_mail_from, site_mail_username, site_mail_password, site_mail_to, site_mail_type
Dim site_resim_logo_baski, site_resim_yazi_durum, site_status, site_menu_disable, site_urun_yonetimi, site_doviz_kurlari
Dim site_vitrin_urunleri, site_vitrin_kategori, site_vitrin_alt_kategori, site_uye_modul, site_sepet_modul, site_siparis_modul
Dim strSlogan, strLogoAlt, strCopyRight, strResimYazi
Dim MaxPage, MaxCategory, MaxProduct, MaxBanner, MaxPoll

site_domain = Temizle(Request.Form("site_domain"), 1)
site_verify = Temizle(Request.Form("site_verify"), 1)
site_analytics = Temizle(Request.Form("site_analytics"), 1)
site_seflink = intYap(Request.Form("site_seflink"), 0)
facebook_url = Temizle(Request.Form("facebook_url"), 1)
twitter_url = Temizle(Request.Form("twitter_url"), 1)
googleplus_url = Temizle(Request.Form("googleplus_url"), 1)
site_mail_host = Temizle(Request.Form("site_mail_host"), 1)
site_mail_from = Temizle(Request.Form("site_mail_from"), 1)
site_mail_username = Temizle(Request.Form("site_mail_username"), 1)
site_mail_password = Temizle(Request.Form("site_mail_password"), 1)
site_mail_to = Temizle(Request.Form("site_mail_to"), 1)

If GlobalConfig("general_admin") Then
	site_mail_type = Temizle(Request.Form("site_mail_type"), 1)
	MaxPage = intYap(Request.Form("MaxPage"), 10)
	MaxCategory = intYap(Request.Form("MaxCategory"), 10)
	MaxProduct = intYap(Request.Form("MaxProduct"), 10)
	MaxBanner = intYap(Request.Form("MaxBanner"), 10)
	MaxPoll = intYap(Request.Form("MaxPoll"), 10)
Else
	site_mail_type = GlobalConfig("mail_type")
	MaxPage = GlobalConfig("MaxPage")
	MaxCategory = GlobalConfig("MaxCategory")
	MaxProduct = GlobalConfig("MaxProduct")
	MaxBanner = GlobalConfig("MaxBanner")
	MaxPoll = GlobalConfig("MaxPoll")
End If

site_resim_logo_baski = intYap(Request.Form("site_resim_logo_baski"), 0)
site_resim_yazi_durum = intYap(Request.Form("site_resim_yazi_baski"), 0)
site_status = intYap(Request.Form("site_status"), 0)
site_menu_disable = intYap(Request.Form("site_menu_disable"), 0)
site_urun_yonetimi = intYap(Request.Form("site_urun_yonetimi"), 0)
site_doviz_kurlari = intYap(Request.Form("site_doviz_kurlari"), 0)
site_vitrin_urunleri = intYap(Request.Form("site_vitrin_urunleri"), 0)
site_vitrin_kategori = intYap(Request.Form("site_vitrin_kategori"), 0)
site_vitrin_alt_kategori = intYap(Request.Form("site_vitrin_alt_kategori"), 0)
site_uye_modul = intYap(Request.Form("site_uye_modul"), 0)
site_sepet_modul = intYap(Request.Form("site_sepet_modul"), 0)
site_siparis_modul = intYap(Request.Form("site_siparis_modul"), 0)

If Not GlobalConfig("general_admin") Then

	site_resim_logo_baski = GlobalConfig("resim_logo_baski")
	site_resim_yazi_durum = GlobalConfig("resim_yazi_durum")
	site_status = GlobalConfig("site_status")
	site_menu_disable = GlobalConfig("disable_menu")
	site_urun_yonetimi = GlobalConfig("urun_yonetimi")
	site_doviz_kurlari = GlobalConfig("doviz_modul")
	site_vitrin_urunleri = GlobalConfig("vitrin_modul")
	site_vitrin_kategori = GlobalConfig("vitrin_kategori")
	site_vitrin_alt_kategori = GlobalConfig("vitrin_alt_kategori")
	site_uye_modul = GlobalConfig("uye_modul")
	site_sepet_modul = GlobalConfig("sepet_modul")
	site_siparis_modul = GlobalConfig("sip_modul")

End If

If Not Len(site_domain) > 3 Then
	saveClass = "warning"
	saveMessage = "Lütfen bir alan adı (domain name) girin."

Else

	SQL = ""
	SQL = SQL & "UPDATE #___ayarlar Set "
	SQL = SQL & "domain = '"& site_domain &"', "
	SQL = SQL & "verify = '"& site_verify &"', "
	SQL = SQL & "analytics = '"& site_analytics &"', "
	SQL = SQL & "seo_url = "& site_seflink &", "
	SQL = SQL & "facebook_url = '"& facebook_url &"', "
	SQL = SQL & "twitter_url = '"& twitter_url &"', "
	SQL = SQL & "googleplus_url = '"& googleplus_url &"', "
	SQL = SQL & "mail_host = '"& site_mail_host &"', "
	SQL = SQL & "mail_from = '"& site_mail_from &"', "
	SQL = SQL & "mail_user_name = '"& site_mail_username &"', "
	SQL = SQL & "mail_pwrd = '"& site_mail_password &"', "
	SQL = SQL & "mail_to = '"& site_mail_to &"', "
	SQL = SQL & "mail_type = '"& site_mail_type &"', "
	'SQL = SQL & "resim_logo_baski = "& site_resim_logo_baski &", "
	'SQL = SQL & "resim_yazi_durum = "& site_resim_yazi_durum &", "

	SQL = SQL & "MaxPage = "& MaxPage &", "
	SQL = SQL & "MaxCategory = "& MaxCategory &", "
	SQL = SQL & "MaxProduct = "& MaxProduct &", "
	SQL = SQL & "MaxBanner = "& MaxBanner &", "
	SQL = SQL & "MaxPoll = "& MaxPoll &", "

	SQL = SQL & "site_status = "& site_status &", "
	'SQL = SQL & "disable_menu = "& site_menu_disable &", "
	SQL = SQL & "urun_yonetimi = "& site_urun_yonetimi &", "
	SQL = SQL & "doviz_modul = "& site_doviz_kurlari &", "
	SQL = SQL & "vitrin_modul = "& site_vitrin_urunleri &", "
	SQL = SQL & "vitrin_kategori = "& site_vitrin_kategori &", "
	SQL = SQL & "vitrin_alt_kategori = "& site_vitrin_alt_kategori &", "
	SQL = SQL & "uye_modul = "& site_uye_modul &", "
	SQL = SQL & "sepet_modul = "& site_sepet_modul &", "
	SQL = SQL & "sip_modul = "& site_siparis_modul &" "
	SQL = SQL & "WHERE id = 1;"
	sqlExeCute( SQL ) : SQL = ""
	saveid = 1

	'// *********************************************************** //'

	Count = 0
	For Each strLng in Request.Form("languages")
		Count = Count + 1

		strPostTitle = Temizle(Request.Form("site_title_" & strLng), 1)
		strSlogan = Temizle(Request.Form("site_slogan_" & strLng), 1)
		strLogoAlt = Temizle(Request.Form("site_logo_alt_" & strLng), 1)
		strCopyRight = Temizle(Request.Form("site_copyright_" & strLng), 1)
		strDesc = Temizle(Request.Form("site_description_" & strLng), 1)
		strKeyword = Temizle(Replace(Request.Form("site_keyword_" & strLng), vbCrLf, " "), 1)

		'If GlobalConfig("general_admin") Then
		'	strResimYazi = Temizle(Request.Form("site_resim_yazi_" & strLng), 1)
		'Else
		'	strResimYazi = ""
		'End If

		strLangTitle = Temizle(Request.Form("lang_title_" & strLng), 1)

		If Len(strPostTitle) = 0 And Count = 1 Then
			saveClass = "warning"
			saveMessage = "Lütfen "& strLangTitle &" bir başlık girin."
			Exit For

		ElseIf Len(strPostTitle) > 100 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Site ismi çok uzun, lütfen kısaltın."
			Exit For

		ElseIf Len(strSlogan) > 150 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Slogan çok uzun, lütfen kısaltın."
			Exit For

		ElseIf Len(strLogoAlt) > 150 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Logo alternatif text çok uzun, lütfen kısaltın."
			Exit For

		ElseIf Len(strCopyRight) > 150 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Copyright çok uzun, lütfen kısaltın."
			Exit For

		ElseIf Len(strDesc) > 160 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Description çok uzun, lütfen kısaltın."
			Exit For

		ElseIf Len(strKeyword) > 200 Then
			saveClass = "warning"
			saveMessage = strLangTitle & " Keyword çok uzun, lütfen kısaltın."
			Exit For

		'ElseIf site_resim_yazi_durum > 0 And Len(strResimYazi) = 0 Then
		'	saveClass = "warning"
		'	saveMessage = "Lütfen resim baskısı için "& strLangTitle &" bir yazı girin."
		'	Exit For

		'ElseIf Len(strResimYazi) > 200 Then
		'	saveClass = "warning"
		'	saveMessage = strLangTitle & " Resim yazısı çok uzun, lütfen kısaltın."
		'	Exit For

		Else

		'If site_resim_yazi_durum = 0 Then strResimYazi = ""

		intGetContentRow = sqlQuery("SELECT id FROM #___ayar_langs WHERE lang = '"& strLng &"';", 0)
		If strPostTitle = "" Then
			If intGetContentRow > 0 Then sqlExeCute("DELETE FROM #___ayar_langs WHERE id = "& intGetContentRow &";")
		Else
			If intGetContentRow = 0 Then
				SQL = ""
				SQL = SQL & "INSERT INTO #___ayar_langs (" & vbCrLf
				SQL = SQL & "lang, site_ismi, slogan, logo_alt_text, copyright, description, keyword"
				SQL = SQL & ") VALUES (" & vbCrLf
				SQL = SQL & "'"& strLng &"', '"& strPostTitle &"', '"& strSlogan &"', '"& strLogoAlt &"', '"& strCopyRight &"', '"& strDesc &"', '"& strKeyword &"'"
				SQL = SQL & ");"
				sqlExeCute( SQL )
			Else
				SQL = ""
				SQL = SQL & "UPDATE #___ayar_langs Set lang = '"& strLng &"', site_ismi = '"& strPostTitle &"', slogan = '"& strSlogan &"', "
				SQL = SQL & "logo_alt_text = '"& strLogoAlt &"', copyright = '"& strCopyRight &"', description = '"& strDesc &"', "
				SQL = SQL & "keyword = '"& strKeyword &"' "
				SQL = SQL & "WHERE id = "& intGetContentRow &";"
				sqlExeCute( SQL )
			End If
		End If

			'objRs.Open(setQuery("SELECT /*parent_id, */lang, site_ismi, slogan, logo_alt_text, copyright, description, keyword, resim_yazi/*, default_page*/ FROM #___ayar_langs WHERE (/*parent_id = "& saveid &" And */lang = '"& strLng &"');")),data,1,3
			'If strPostTitle = "" Then
			'	If Not objRs.Eof Then objRs.Delete
			'Else
			'If objRs.Eof Then
			'	objRs.AddNew()
			'	'objRs("parent_id") = saveid
			'End If
			'	objRs("lang") = strLng
			'	objRs("site_ismi") = strPostTitle
			'	objRs("slogan") = strSlogan
			'	objRs("logo_alt_text") = strLogoAlt
			'	objRs("copyright") = strCopyRight
			'	objRs("description") = strDesc
			'	objRs("keyword") = strKeyword
			'	objRs("resim_yazi") = strResimYazi
			'	'objRs("default_page") = ""
			'	objRs.Update
			'End If
			'objRs.Close
		End If
	Next

	'Set objRs = Nothing

If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "Ayarlar başarıyla güncellendi."

End If
%>
