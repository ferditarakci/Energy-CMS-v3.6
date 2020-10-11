<%
'// Energy Web Tasarım
'// Ferdi TARAKCI
'// 0546 831 20 73
'// bilgi@webtasarimx.net
'// www.webdizzayni.org


'// Ajax Türkçe Yazi Düzenleme Fonksiyonu
Private Function AjaxTurkish(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
		varText = Replace(varText, "Ã§", Chr(231), 1, -1, 0)  ' ç
		varText = Replace(varText, "Ã‡", Chr(199), 1, -1, 0)  ' Ç
		varText = Replace(varText, Chr(240), ChrW(287), 1, -1, 0) ' ğ
		varText = Replace(varText, Chr(208), ChrW(287), 1, -1, 0) ' Ğ
		varText = Replace(varText, "ÄŸ", ChrW(287), 1, -1, 0) ' ğ
		varText = Replace(varText, "Ä?", ChrW(286), 1, -1, 0) ' Ğ
		varText = Replace(varText, "Äž", ChrW(286), 1, -1, 0) ' Ğ
		varText = Replace(varText, "Ä±", ChrW(305), 1, -1, 0) ' ı
		varText = Replace(varText, "ý", ChrW(305), 1, -1, 0) ' ı
		varText = Replace(varText, "Ý", ChrW(304), 1, -1, 0) ' İ
		varText = Replace(varText, "Ä°", ChrW(304), 1, -1, 0) ' İ
		varText = Replace(varText, "Ã¶", Chr(246), 1, -1, 0)  ' ö
		varText = Replace(varText, "Ã–", Chr(214), 1, -1, 0)  ' Ö
		varText = Replace(varText, Chr(254), ChrW(351), 1, -1, 0) ' ş
		varText = Replace(varText, Chr(222), ChrW(350), 1, -1, 0) ' Ş
		varText = Replace(varText, "ÅŸ", ChrW(351), 1, -1, 0) ' ş
		varText = Replace(varText, "Å?", ChrW(350), 1, -1, 0) ' Ş
		varText = Replace(varText, "Åž", ChrW(350), 1, -1, 0) ' Ş
		varText = Replace(varText, "Ã¼", Chr(252), 1, -1, 0)  ' ü
		varText = Replace(varText, "Ãœ", Chr(220), 1, -1, 0)  ' Ü
	AjaxTurkish = varText
End Function
'Clearfix AjaxTurkish("Ã§ Ã‡ ÄŸ Ä? Ä± Ä° Ã¶ Ã– ÅŸ Å? Ã¼  Ãœ")








Private Function ReplaceEditorTag(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	varText = Replace(varText, "&lt;", "&amp;lt;", 1, -1, 1)
	varText = Replace(varText, "&gt;", "&amp;gt;", 1, -1, 1)
	varText = Replace(varText, "<", "&lt;", 1, -1, 1)
	varText = Replace(varText, ">", "&gt;", 1, -1, 1)
	ReplaceEditorTag = varText
End Function
'Clearfix RemoveTag("& < > ' "" \ --")






Private Function RemoveTag(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	varText = Replace(varText, "<", "&lt;", 1, -1, 1)
	varText = Replace(varText, ">", "&gt;", 1, -1, 1)
	RemoveTag = varText
End Function
'Clearfix RemoveTag("& < > ' "" \ --")









Private Function Temizle(ByVal varText, ByVal iHTML)
	varText = varText & ""
	If varText = "" Then Exit Function

	If iHTML <> 0 Then
		varText = Duzenle(varText)
	End If

	varText = TrimFix(varText)
	varText = Replace(varText, "&#34;", """", 1, -1, 1)
	varText = Replace(varText, "&#39;", "'", 1, -1, 1)
	varText = Replace(varText, "&amp;", "&", 1, -1, 1)

	If Not iHTML = -1 Then
		varText = sqlGuvenlik(varText, "")
	End If

	If iHTML = 1 Or iHTML = -1 Then
		varText = RemoveTag( varText )
	End If

	varText = Replace(varText, "&", "&amp;", 1, -1, 1)
	varText = Replace(varText, "&amp;amp%3b", "&amp;", 1, -1, 1)

	If Not GlobalConfig("admin_username") = GlobalConfig("super_admin") Then
		varText = Replace(varText, "<script", "&lt;script", 1, -1, 1)
		varText = Replace(varText, "</script>", "&lt;/script&gt;", 1, -1, 1)
		varText = Replace(varText, "<html", "&lt;html", 1, -1, 1)
		varText = Replace(varText, "<meta", "&lt;meta", 1, -1, 1)
	End If

	If iHTML = 1 Or iHTML = -1 Then varText = HtmlEncode( varText )

'	varText = Replace(varText, "‘", "&lsquo;", 1, -1, 0)
'	varText = Replace(varText, "’", "&rsquo;", 1, -1, 0)
'	varText = Replace(varText, "“", "&ldquo;", 1, -1, 0)
'	varText = Replace(varText, "”", "&rdquo;", 1, -1, 0)
'	varText = Replace(varText, "′", "&prime;", 1, -1, 0)
'	varText = Replace(varText, "″", "&Prime;", 1, -1, 0)
'	varText = Replace(varText, "´", "&acute;", 1, -1, 0)

'	varText = Replace(varText, "©", "&copy;", 1, -1, 0)
'	varText = Replace(varText, "®", "&reg;", 1, -1, 0)
'	varText = Replace(varText, "½", "&#189;", 1, -1, 0)
'	varText = Replace(varText, "™", "&trade;", 1, -1, 0)
'	varText = Replace(varText, "‰", "&permil;", 1, -1, 0)
'	varText = Replace(varText, "•", "&bull;", 1, -1, 0)
'	varText = Replace(varText, "·", "&middot;", 1, -1, 0)
'	varText = Replace(varText, "…", "&hellip;", 1, -1, 0)
'	varText = Replace(varText, "«", "&laquo;", 1, -1, 0)
'	varText = Replace(varText, "»", "&raquo;", 1, -1, 0)
'	varText = Replace(varText, "(", "&#40;", 1, -1, 0)
'	varText = Replace(varText, ")", "&#41;", 1, -1, 0)

'	varText = Replace(varText, "[", "&#91;", 1, -1, 0)
'	varText = Replace(varText, "]", "&#93;", 1, -1, 0)
'	varText = Replace(varText, "%", "&#37;", 1, -1, 0)

'	varText = Replace(varText, "ß", "&szlig;", 1, -1, 0)
'	varText = Replace(varText, "¶", "&para;", 1, -1, 0)
'	varText = Replace(varText, "µ", "&micro;", 1, -1, 0)
'	varText = Replace(varText, "¥", "&yen;", 1, -1, 0)
'	varText = Replace(varText, "£", "&pound;", 1, -1, 0)
'	varText = Replace(varText, "€", "&euro;", 1, -1, 0)
'	varText = Replace(varText, "¢", "&cent;", 1, -1, 0)

'	varText = Replace(varText, "♦", "&diams;", 1, -1, 0)
'	varText = Replace(varText, "♥", "&hearts;", 1, -1, 0)
'	varText = Replace(varText, "♣", "&clubs;", 1, -1, 0)
'	varText = Replace(varText, "◊", "&loz;", 1, -1, 0)
'	varText = Replace(varText, "↔", "&harr;", 1, -1, 0)
'	varText = Replace(varText, "↓", "&darr;", 1, -1, 0)
'	varText = Replace(varText, "→", "&rarr;", 1, -1, 0)
'	varText = Replace(varText, "↑", "&uarr;", 1, -1, 0)
'	varText = Replace(varText, "←", "&larr;", 1, -1, 0)
'	varText = Replace(varText, "ω", "&omega;", 1, -1, 0)
'	varText = Replace(varText, "≈", "&asymp;", 1, -1, 0)
'	varText = Replace(varText, "√", "&radic;", 1, -1, 0)

'	varText = Replace(varText, "SELECT", "SELEC&#84;", 1, -1, 0)
'	varText = Replace(varText, "Select", "Selec&#116;", 1, -1, 0)
'	varText = Replace(varText, "select", "selec&#116;", 1, -1, 1)

'	varText = Replace(varText, "JOIN", "JOI&#78;", 1, -1, 0)
'	varText = Replace(varText, "Join", "Joi&#110;", 1, -1, 0)
'	varText = Replace(varText, "join", "joi&#110;", 1, -1, 1)

'	varText = Replace(varText, "UNION", "UNIO&#78;", 1, -1, 0)
'	varText = Replace(varText, "Union", "Unio&#110;", 1, -1, 0)
'	varText = Replace(varText, "union", "unio&#110;", 1, -1, 1)

'	varText = Replace(varText, "WHERE", "WHER&#69;", 1, -1, 0)
'	varText = Replace(varText, "Where", "Wher&#101;", 1, -1, 0)
'	varText = Replace(varText, "where", "wher&#101;", 1, -1, 1)

'	varText = Replace(varText, "INSERT", "INSER&#84;", 1, -1, 0)
'	varText = Replace(varText, "Insert", "Inser&#116;", 1, -1, 0)
'	varText = Replace(varText, "insert", "inser&#116;", 1, -1, 1)

'	varText = Replace(varText, "DELETE", "DELET&#69;", 1, -1, 0)
'	varText = Replace(varText, "Delete", "Delet&#101;", 1, -1, 0)
'	varText = Replace(varText, "delete", "delet&#101;", 1, -1, 1)

'	varText = Replace(varText, "UPDATE", "UPDAT&#69;", 1, -1, 0)
'	varText = Replace(varText, "Update", "Updat&#101;", 1, -1, 0)
'	varText = Replace(varText, "update", "updat&#101;", 1, -1, 1)

'	varText = Replace(varText, "LIKE", "LIK&#69;", 1, -1, 0)
'	varText = Replace(varText, "Like", "Lik&#101;", 1, -1, 0)
'	varText = Replace(varText, "like", "lik&#101;", 1, -1, 0)

'	varText = Replace(varText, "DROP", "DRO&#80;", 1, -1, 0)
'	varText = Replace(varText, "Drop", "Dro&#112;", 1, -1, 0)
'	varText = Replace(varText, "drop", "dro&#112;", 1, -1, 1)

'	varText = Replace(varText, "CREATE", "CREAT&#69;", 1, -1, 0)
'	varText = Replace(varText, "Create", "Creat&#101;", 1, -1, 0)
'	varText = Replace(varText, "create", "creat&#101;", 1, -1, 1)

'	varText = Replace(varText, "MODIFY", "MODIF&#89;", 1, -1, 0)
'	varText = Replace(varText, "Modify", "Modif&#121;", 1, -1, 0)
'	varText = Replace(varText, "modify", "modif&#121;", 1, -1, 1)

'	varText = Replace(varText, "RENAME", "RENAM&#69;", 1, -1, 0)
'	varText = Replace(varText, "Rename", "Renam&#101;", 1, -1, 0)
'	varText = Replace(varText, "rename", "renam&#101;", 1, -1, 1)

'	varText = Replace(varText, "ALTER", "ALTE&#82;", 1, -1, 0)
'	varText = Replace(varText, "Alter", "Alte&#114;", 1, -1, 0)
'	varText = Replace(varText, "alter", "alte&#114;", 1, -1, 1)

'	varText = Replace(varText, "CAST", "CAS&#84;", 1, -1, 0)
'	varText = Replace(varText, "Cast", "Cas&#116;", 1, -1, 0)
'	varText = Replace(varText, "cast", "cas&#116;", 1, -1, 1)

'	varText = Replace(varText, "ON", "O&#78;", 1, -1, 0)
'	varText = Replace(varText, "On", "O&#110;", 1, -1, 0)
'	varText = Replace(varText, "on", "o&#110;", 1, -1, 1)

	varText = HtmlUnicodeEdit( varText )
	varText = Trim(TrimFix( varText ))
	Temizle = varText
End Function
'Clearfix Temizle("' "" < > & % \n &amp;#39; &amp;amp; &amp;quot; <ul style=""font-size: 15px; font-weight: bold; font-style: oblique; line-height: 1.8em;"">", 0)
'Clearfix Temizle("' "" < > & % \n &amp;#39; &amp;amp; &amp;quot;", 1)







Private Function HtmlEncode(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	varText = HtmlUnicodeEdit(Trim(varText))
	varText = Replace(varText, "&", "&amp;")
	varText = Replace(varText, """", "&#34;")
	varText = Replace(varText, "'", "&#39;")
	varText = Replace(varText, "<", "&lt;")
	varText = Replace(varText, ">", "&gt;")
	varText = HtmlUnicodeEdit( varText )
	HtmlEncode = varText
End Function
'Clearfix HtmlEncode(" "" ' < > & &amp;#39; &amp;amp; &amp;quot;")







Private Function HtmlUnicodeEdit(ByVal varText)
	varText = varText & ""
	If varText = "" Then Exit Function
	With New RegExp
		.IgnoreCase = True
		.MultiLine = True
		.Global = True
		'.Pattern = "&amp;([a-z\d]{2,6});"
		.Pattern = "&amp;(#x?[\d]{2,8}|[a-z]{2,8});"
		varText = .Replace(varText, "&$1;")
		'varText = .test(varText)
	End With
	HtmlUnicodeEdit = varText
End Function
'Clearfix HtmlUnicodeEdit("&amp;#39; &amp;amp; &amp;quot;")








'// Türkçe Harflerin HTML Asci Kodlarına Çevirme Fonksiyonu
'Private Function TurkishAsci(ByVal varText)
'	varText = varText & ""
'	If varText = "" Then Exit Function
'	varText = Replace(varText, Chr(231), "&#231;", 1, -1, 0)  ' ç
'	varText = Replace(varText, Chr(199), "&#199;", 1, -1, 0)  ' Ç
'	varText = Replace(varText, ChrW(287), "&#287;", 1, -1, 0) ' ğ
'	varText = Replace(varText, ChrW(286), "&#286;", 1, -1, 0) ' Ğ
'	varText = Replace(varText, ChrW(305), "&#305;", 1, -1, 0) ' ı
'	varText = Replace(varText, ChrW(304), "&#304;", 1, -1, 0) ' İ
'	varText = Replace(varText, Chr(246), "&#246;", 1, -1, 0)  ' ö
'	varText = Replace(varText, Chr(214), "&#214;", 1, -1, 0)  ' Ö
'	varText = Replace(varText, ChrW(351), "&#351;", 1, -1, 0) ' ş
'	varText = Replace(varText, ChrW(350), "&#350;", 1, -1, 0) ' Ş
'	varText = Replace(varText, Chr(252), "&#252;", 1, -1, 0)  ' ü
'	varText = Replace(varText, Chr(220), "&#220;", 1, -1, 0)  ' Ü
'	TurkishAsci = varText
'End Function
'Clearfix TurkishAsci("ç Ç ğ Ğ ı İ ö Ö ş Ş ü Ü")








'// Ajax Türkçe Yazi Düzenleme Fonksiyonu
'Private Function AjaxTurkish2(ByVal varText)
'	varText = varText & ""
'	If varText = "" Then Exit Function
'	varText = Replace(varText, "ÃŸ", Chr(223), 1, -1, 0)  ' ß
'	varText = Replace(varText, "â‚¬", ChrW(8364), 1, -1, 0)  ' €
'	varText = Replace(varText, "Â´", Chr(180), 1, -1, 0)  ' ´
'	varText = Replace(varText, "Â¨", Chr(168), 1, -1, 0)  ' ¨
'	varText = Replace(varText, "Ã©", Chr(233), 1, -1, 0)  ' é
'	varText = Replace(varText, "Ãª", Chr(234), 1, -1, 0)  ' ê
'	varText = Replace(varText, "ÃŠ", Chr(202), 1, -1, 0)  ' Ê
'	varText = Replace(varText, "Ã¢", Chr(226), 1, -1, 0)  ' â
'	varText = Replace(varText, "Ã‚", Chr(194), 1, -1, 0)  ' Â
'	varText = Replace(varText, "ÃƒÂ¶", Chr(246), 1, -1, 0)  ' ö
'	varText = Replace(varText, "ÃƒÆ’Ã†â€™ÂÂÂ¶", Chr(246), 1, -1, 0)  ' ö
'	varText = Replace(varText, "Ãƒæ’ã†â€™âââ¶", Chr(246), 1, -1, 0)  ' ö
'	varText = Replace(varText, "ÃƒÆ’Ã†â€™Ã‚Ã‚Â¶", Chr(246), 1, -1, 0)  ' ö
'	varText = Replace(varText, "ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€šÃ‚Â ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¾Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¶", Chr(246), 1, -1, 0)  ' ö
'	varText = Replace(varText, "yÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€Â¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€šÃ‚Â ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¾Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Â¦Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¶", Chr(246), 1, -1, 0)  ' ö
'	varText = Replace(varText, "%C3%83%C6%92%C3%86%E2%80%99%C3%83%E2%80%A0%C3%A2%E2%82%AC%E2%84%A2%C3%83%C6%92%C3%A2%E2%82%AC%C2%A0%C3%83%C2%A2%C3%A2%E2%80%9A%C2%AC%C3%A2%E2%80%9E%C2%A2%C3%83%C6%92%C3%86%E2%80%99%C3%83%C2%A2%C3%A2%E2%80%9A%C2%AC%C3%82%C2%A0%C3%83%C6%92%C3%82%C2%A2%C3%83%C2%A2%C3%A2%E2%82%AC%C5%A1%C3%82%C2%AC%C3%83%C2%A2%C3%A2%E2%82%AC%C5%BE%C3%82%C2%A2%C3%83%C6%92%C3%86%E2%80%99%C3%83%E2%80%A0%C3%A2%E2%82%AC%E2%84%A2%C3%83%C6%92%C3%82%C2%A2%C3%83%C2%A2%C3%A2%E2%82%AC%C5%A1%C3%82%C2%AC%C3%83%E2%80%9A%C3%82%C2%A0%C3%83%C6%92%C3%86%E2%80%99%C3%83%E2%80%9A%C3%82%C2%A2%C3%83%C6%92%C3%82%C2%A2%C3%83%C2%A2%C3%A2%E2%80%9A%C2%AC%C3%85%C2%A1%C3%83%E2%80%9A%C3%82%C2%AC%C3%83%C6%92%C3%82%C2%A2%C3%83%C2%A2%C3%A2%E2%80%9A%C2%AC%C3%85%C2%BE%C3%83%E2%80%9A%C3%82%C2%A2%C3%83%C6%92%C3%86%E2%80%99%C3%83%E2%80%A0%C3%A2%E2%82%AC%E2%84%A2%C3%83%C6%92%C3%A2%E2%82%AC%C2%A0%C3%83%C2%A2%C3%A2%E2%80%9A%C2%AC%C3%A2%E2%80%9E%C2%A2%C3%83%C6%92%C3%86%E2%80%99%C3%83%E2%80%9A%C3%82%C2%A2%C3%83%C6%92%C3%82%C2%A2%C3%83%C2%A2%C3%A2%E2%80%9A%C2%AC%C3%85%C2%A1%C3%83%E2%80%9A%C3%82%C2%AC%C3%83%C6%92%C3%A2%E2%82%AC%C2%A6%C3%83%E2%80%9A%C3%82%C2%A1%C3%83%C6%92%C3%86%E2%80%99%C3%83%E2%80%A0%C3%A2%E2%82%AC%E2%84%A2%C3%83%C6%92%C3%82%C2%A2%C3%83%C2%A2%C3%A2%E2%82%AC%C5%A1%C3%82%C2%AC%C3%83%E2%80%A6%C3%82%C2%A1%C3%83%C6%92%C3%86%E2%80%99%C3%83%C2%A2%C3%A2%E2%80%9A%C2%AC%C3%85%C2%A1%C3%83%C6%92%C3%A2%E2%82%AC%C5%A1%C3%83%E2%80%9A%C3%82%C2%B6", Chr(246), 1, -1, 0)  ' ö
'	AjaxTurkish2 = varText
'End Function
'Clearfix AjaxTurkish("Ã§ Ã‡ ÄŸ Ä? Ä± Ä° Ã¶ Ã– ÅŸ Å? Ã¼  Ãœ")









'// URL Çeviri Fonksiyonu
'Function URLDecodes(ByVal strString)
'	strString = strString & ""
'	If strString = "" Then Exit Function
'		strString = Replace(strString, "%2F", "/")
'		strString = Replace(strString, "%7C", "|")
'		strString = Replace(strString, "%3F", "?")
'		strString = Replace(strString, "%21", "!")
'		strString = Replace(strString, "%40", "@")
'		strString = Replace(strString, "%5C", "\")
'		strString = Replace(strString, "%23", "#")
'		strString = Replace(strString, "%24", "$")
'		strString = Replace(strString, "%5E", "^")
'		strString = Replace(strString, "%26", "&")
'		strString = Replace(strString, "%25", "%")
'		strString = Replace(strString, "%2A", "*")
'		strString = Replace(strString, "%28", "(")
'		strString = Replace(strString, "%29", ")")
'		strString = Replace(strString, "%7D", "}")
'		strString = Replace(strString, "%3A", ":")
'		strString = Replace(strString, "%2C", ",")
'		strString = Replace(strString, "%7B", "{")
'		strString = Replace(strString, "%2B", "+")
'		strString = Replace(strString, "%2E", ".")
'		strString = Replace(strString, "%2D", "-")
'		strString = Replace(strString, "%7E", "~")
'		strString = Replace(strString, "%5B", "[")
'		strString = Replace(strString, "%5F", "_")
'		strString = Replace(strString, "%5D", "]")
'		strString = Replace(strString, "%60", "`")
'		strString = Replace(strString, "%3D", "=")
'		strString = Replace(strString, "%27", "'")
'		strString = Replace(strString, "+", " ")
'		strString = Replace(strString, "%22", Chr(34))
'	URLDecodes = strString
'End Function











'Private Function UrlTurkishEncode(varText)
'	varText = varText & ""
'	If varText = "" Then Exit Function
'	varText = Replace(varText, "%FD", ChrW(305), 1, -1, 0)    ' ı
'	varText = Replace(varText, Chr(231), "%C3%A7", 1, -1, 0)  ' ç
'	varText = Replace(varText, Chr(199), "%C3%87", 1, -1, 0)  ' Ç
'	varText = Replace(varText, ChrW(287), "%C4%9F", 1, -1, 0) ' ğ
'	varText = Replace(varText, ChrW(286), "%C4%9E", 1, -1, 0) ' Ğ
'	varText = Replace(varText, ChrW(305), "%C4%B1", 1, -1, 0) ' ı
'	varText = Replace(varText, ChrW(304), "%C4%B0", 1, -1, 0) ' İ
'	varText = Replace(varText, Chr(246), "%C3%B6", 1, -1, 0)  ' ö
'	varText = Replace(varText, Chr(214), "%C3%96", 1, -1, 0)  ' Ö
'	varText = Replace(varText, ChrW(351), "%C5%9F", 1, -1, 0) ' ş
'	varText = Replace(varText, ChrW(350), "%C5%9E", 1, -1, 0) ' Ş
'	varText = Replace(varText, Chr(252), "%C3%BC", 1, -1, 0)  ' ü
'	varText = Replace(varText, Chr(220), "%C3%9C", 1, -1, 0)  ' Ü
'	varText = Replace(varText, Chr(226), "%C3%A2", 1, -1, 0)  ' â
'	varText = Replace(varText, Chr(194), "%C3%82", 1, -1, 0)  ' Â
'	varText = Replace(varText, Chr(202), "%C3%8A", 1, -1, 0)  ' Ê
'	varText = Replace(varText, Chr(234), "%C3%AA", 1, -1, 0)  ' ê
'	UrlTurkishEncode = varText
'End Function
'Clearfix Urldecode("%C3%B6")









'Private Function UrlTurkishDecode(varText)
'	varText = varText & ""
'	If varText = "" Then Exit Function
'	varText = Replace(varText, "%FD", ChrW(305), 1, -1, 0)    ' ı
'	varText = Replace(varText, "%C3%A7", Chr(231), 1, -1, 0)  ' ç
'	varText = Replace(varText, "%C3%87", Chr(199), 1, -1, 0)  ' Ç
'	varText = Replace(varText, "%C4%9F", ChrW(287), 1, -1, 0) ' ğ
'	varText = Replace(varText, "%C4%9E", ChrW(286), 1, -1, 0) ' Ğ
'	varText = Replace(varText, "%C4%B1", ChrW(305), 1, -1, 0) ' ı
'	varText = Replace(varText, "%C4%B0", ChrW(304), 1, -1, 0) ' İ
'	varText = Replace(varText, "%C3%B6", Chr(246), 1, -1, 0)  ' ö
'	varText = Replace(varText, "%C3%96", Chr(214), 1, -1, 0)  ' Ö
'	varText = Replace(varText, "%C5%9F", ChrW(351), 1, -1, 0) ' ş
'	varText = Replace(varText, "%C5%9E", ChrW(350), 1, -1, 0) ' Ş
'	varText = Replace(varText, "%C3%BC", Chr(252), 1, -1, 0)  ' ü
'	varText = Replace(varText, "%C3%9C", Chr(220), 1, -1, 0)  ' Ü
'	varText = Replace(varText, "%C3%A2", Chr(226), 1, -1, 0)  ' â
'	varText = Replace(varText, "%C3%82", Chr(194), 1, -1, 0)  ' Â
'	varText = Replace(varText, "%C3%8A", Chr(202), 1, -1, 0)  ' Ê
'	varText = Replace(varText, "%C3%AA", Chr(234), 1, -1, 0)  ' ê
'	UrlTurkishDecode = varText
'End Function
'Clearfix UrlEncode("%FD ç Ç ğ Ğ ı İ ö Ö ş Ş ü Ü")










'Private Function Duzenle(ByVal varText)
'	varText = varText & ""
'	If varText = "" Then Exit Function
'	varText = Replace(varText, "&#231;", Chr(231), 1, -1, 0) ' ç
'	varText = Replace(varText, "&#199;", Chr(199), 1, -1, 0) ' Ç
'	varText = Replace(varText, "&#287;", ChrW(287), 1, -1, 0) ' ğ
'	varText = Replace(varText, "&#286;", ChrW(286), 1, -1, 0) ' Ğ
'	varText = Replace(varText, "&#305;", ChrW(305), 1, -1, 0) ' ı
'	varText = Replace(varText, "&#304;", ChrW(304), 1, -1, 0) ' İ
'	varText = Replace(varText, "&#246;", Chr(246), 1, -1, 0) ' ö
'	varText = Replace(varText, "&#214;", Chr(214), 1, -1, 0) ' Ö
'	varText = Replace(varText, "&#351;", ChrW(351), 1, -1, 0) ' ş
'	varText = Replace(varText, "&#350;", ChrW(350), 1, -1, 0) ' Ş
'	varText = Replace(varText, "&#252;", Chr(252), 1, -1, 0) ' ü
'	varText = Replace(varText, "&#220;", Chr(220), 1, -1, 0) ' Ü
'
'	varText = Replace(varText, "&amp;", Chr(38))
'	varText = Replace(varText, "&#38;", Chr(38))
'
'	varText = Replace(varText, "&lt;", Chr(60))
'	varText = Replace(varText, "&#60;", Chr(60))
'
'	varText = Replace(varText, "&gt;", Chr(62))
'	varText = Replace(varText, "&#62;", Chr(62)) 
'
'	varText = Replace(varText, "&quot;", Chr(34))
'	varText = Replace(varText, "&#34;", Chr(34))
'
'	varText = Replace(varText, "&apos;", Chr(39))
'	varText = Replace(varText, "&#39;", Chr(39))
'
'	varText = Replace(varText, "&copy;", Chr(169))
'
'	varText = Replace(varText, "&reg;", Chr(174))
'
'	varText = Replace(varText, "&trade;", ChrW(8482))
'	varText = Replace(varText, "&#8482;", ChrW(8482))
'
'	varText = Replace(varText, "&#45;&#45;", Chr(45) & Chr(45))
'	varText = Replace(varText, "&#94;", Chr(94))
'	varText = Replace(varText, "&#96;", Chr(96))
'	varText = Replace(varText, "&#126;", Chr(126))
'
'	varText = Replace(varText, "&#37;", "%", 1, -1, 0)
'
'	varText = Replace(varText, "&#61;", "=", 1, -1, 0)
'	varText = Replace(varText, "&#91;", "[", 1, -1, 0)
'	varText = Replace(varText, "&#92;", "\", 1, -1, 0)
'	varText = Replace(varText, "&#93;", "]", 1, -1, 0)
'
'	varText = Replace(varText, "&lsquo;", "‘", 1, -1, 0)
'	varText = Replace(varText, "&rsquo;", "’", 1, -1, 0)
'	varText = Replace(varText, "&ldquo;", "“", 1, -1, 0)
'	varText = Replace(varText, "&rdquo;", "”", 1, -1, 0)
'	varText = Replace(varText, "&prime;", "′", 1, -1, 0)
'	varText = Replace(varText, "&Prime;", "″", 1, -1, 0)
'	varText = Replace(varText, "&acute;", "´", 1, -1, 0)
'
'	varText = Replace(varText, "&permil;", "‰", 1, -1, 0)
'	varText = Replace(varText, "&bull;", "•", 1, -1, 1)
'	varText = Replace(varText, "&middot;", "·", 1, -1, 0)
'	varText = Replace(varText, "&hellip;", "…", 1, -1, 0)
'
'	varText = Replace(varText, "&szlig;", "ß", 1, -1, 0)
'	varText = Replace(varText, "&para;", "¶", 1, -1, 0)
'	varText = Replace(varText, "&micro;", "µ", 1, -1, 0)
'	varText = Replace(varText, "&yen;", "¥", 1, -1, 0)
'	varText = Replace(varText, "&pound;", "£", 1, -1, 0)
'	varText = Replace(varText, "&euro;", "€", 1, -1, 0)
'	varText = Replace(varText, "&cent;", "¢", 1, -1, 0)
'	varText = Replace(varText, "&euro;", "€", 1, -1, 0)
'	varText = Replace(varText, "&laquo;", "«", 1, -1, 0)
'	varText = Replace(varText, "&raquo;", "»", 1, -1, 0)
'	varText = Replace(varText, "&diams;", "♦", 1, -1, 0)
'	varText = Replace(varText, "&hearts;", "♥", 1, -1, 0)
'	varText = Replace(varText, "&clubs;", "♣", 1, -1, 0)
'	varText = Replace(varText, "&loz;", "◊", 1, -1, 0)
'	varText = Replace(varText, "&harr;", "↔", 1, -1, 0)
'	varText = Replace(varText, "&darr;", "↓", 1, -1, 0)
'	varText = Replace(varText, "&rarr;", "→", 1, -1, 0)
'	varText = Replace(varText, "&uarr;", "↑", 1, -1, 0)
'	varText = Replace(varText, "&larr;", "←", 1, -1, 0)
'	varText = Replace(varText, "&omega;", "ω", 1, -1, 0)
'	varText = Replace(varText, "&asymp;", "≈", 1, -1, 0)
'	varText = Replace(varText, "&radic;", "√", 1, -1, 0)
'
'	varText = Replace(varText, "&#286;", ChrW(286), 1, -1, 0) ' Ğ
'	varText = Replace(varText, "&#287;", ChrW(287), 1, -1, 0) ' ğ
'	varText = Replace(varText, "&#304;", ChrW(304), 1, -1, 0) ' İ
'	varText = Replace(varText, "&#305;", ChrW(305), 1, -1, 0) ' ı
'	varText = Replace(varText, "&#350;", ChrW(350), 1, -1, 0) ' Ş
'	varText = Replace(varText, "&#351;", ChrW(351), 1, -1, 0) ' ş
'
'	Dim c
'	For c = 130 To 255 Step 1
'		varText = Replace(varText, "&#"& c &";", Chr(c), 1, -1, 0)
'	Next
'
'	Duzenle = HtmlUnicodeEdit(varText)
'End Function











'Private Function AsciCode(ByVal varText)
'	varText = varText & ""
'	If varText = "" Then Exit Function

'	varText = Replace(varText, Chr(231), "&#231;", 1, -1, 0) ' ç
'	varText = Replace(varText, Chr(199), "&#199;", 1, -1, 0) ' Ç
'	varText = Replace(varText, ChrW(287), "&#287;", 1, -1, 0) ' ğ
'	varText = Replace(varText, ChrW(286), "&#286;", 1, -1, 0) ' Ğ
'	varText = Replace(varText, ChrW(305), "&#305;", 1, -1, 0) ' ı
'	varText = Replace(varText, ChrW(304), "&#304;", 1, -1, 0) ' İ
'	varText = Replace(varText, Chr(246), "&#246;", 1, -1, 0) ' ö
'	varText = Replace(varText, Chr(214), "&#214;", 1, -1, 0) ' Ö
'	varText = Replace(varText, ChrW(351), "&#351;", 1, -1, 0) ' ş
'	varText = Replace(varText, ChrW(350), "&#350;", 1, -1, 0) ' Ş
'	varText = Replace(varText, Chr(252), "&#252;", 1, -1, 0) ' ü
'	varText = Replace(varText, Chr(220), "&#220;", 1, -1, 0) ' Ü

'	varText = Replace(varText, Chr(34), "&quot;")
'	varText = Replace(varText, Chr(38), "&amp;")
'	varText = Replace(varText, Chr(39), "&apos;")
'	varText = Replace(varText, Chr(169), "&copy;")
'	varText = Replace(varText, Chr(174), "&reg;")
'	varText = Replace(varText, ChrW(8482), "&trade;")
'
'	varText = Replace(varText, Chr(45) & Chr(45), "&#45;&#45;")
'	varText = Replace(varText, Chr(94), "&#94;")
'	varText = Replace(varText, Chr(96), "&#96;")
'	varText = Replace(varText, Chr(126), "&#126;")
'
'	varText = Replace(varText, "‘", "&lsquo;", 1, -1, 0)
'	varText = Replace(varText, "’", "&rsquo;", 1, -1, 0)
'	varText = Replace(varText, "“", "&ldquo;", 1, -1, 0)
'	varText = Replace(varText, "”", "&rdquo;", 1, -1, 0)
'	varText = Replace(varText, "′", "&prime;", 1, -1, 0)
'	varText = Replace(varText, "″", "&Prime;", 1, -1, 0)
'	varText = Replace(varText, "´", "&acute;", 1, -1, 0)
'
'	varText = Replace(varText, "©", "&copy;", 1, -1, 0)
'	varText = Replace(varText, "®", "&reg;", 1, -1, 0)
'	varText = Replace(varText, "™", "&trade;", 1, -1, 0)
'	varText = Replace(varText, "‰", "&permil;", 1, -1, 0)
'	varText = Replace(varText, "•", "&bull;", 1, -1, 0)
'	varText = Replace(varText, "·", "&middot;", 1, -1, 0)
'	varText = Replace(varText, "…", "&hellip;", 1, -1, 0)
'	varText = Replace(varText, "«", "&laquo;", 1, -1, 0)
'	varText = Replace(varText, "»", "&raquo;", 1, -1, 0)
'
'	varText = Replace(varText, "[", "&#91;", 1, -1, 0)
'	varText = Replace(varText, "]", "&#93;", 1, -1, 0)
'	varText = Replace(varText, "%", "&#37;", 1, -1, 0)
'
'	varText = Replace(varText, ChrW(286), "&#286;", 1, -1, 0) ' Ğ
'	varText = Replace(varText, ChrW(287), "&#287;", 1, -1, 0) ' ğ
'	varText = Replace(varText, ChrW(304), "&#304;", 1, -1, 0) ' İ
'	varText = Replace(varText, ChrW(305), "&#305;", 1, -1, 0) ' ı
'	varText = Replace(varText, ChrW(350), "&#350;", 1, -1, 0) ' Ş
'	varText = Replace(varText, ChrW(351), "&#351;", 1, -1, 0) ' ş
'	'varText = TurkishAsci(varText)
'
'	Dim cn
'	For cn = 130 To 255 Step 1
'		varText = Replace(varText, Chr(cn), "&#"& cn &";", 1, -1, 0)
'	Next
'
'	AsciCode = HtmlUnicodeEdit(varText)
'End Function
'Clearfix AsciCode("ç Ç ğ Ü ş İ ı < -- ' " & ChrW(8482))







'// Unicode Türkçe (UTF-8) Hex Kodu
'Private Function Utf8Unicode(ByVal varText)
'	varText = varText & ""
'	If varText = "" Then Exit Function
'	varText = Replace(varText, Chr(231), "&#xE7;", 1, -1, 0)   ' ç
'	varText = Replace(varText, Chr(199), "&#xC7;", 1, -1, 0)   ' Ç
'	varText = Replace(varText, ChrW(287), "&#x11F;", 1, -1, 0) ' ğ
'	varText = Replace(varText, ChrW(286), "&#x11E;", 1, -1, 0) ' Ğ
'	varText = Replace(varText, ChrW(305), "&#x131;", 1, -1, 0) ' ı
'	varText = Replace(varText, ChrW(304), "&#x130;", 1, -1, 0) ' İ
'	varText = Replace(varText, Chr(246), "&#xF6;", 1, -1, 0)   ' ö
'	varText = Replace(varText, Chr(214), "&#xD6;", 1, -1, 0)   ' Ö
'	varText = Replace(varText, ChrW(351), "&#x15F;", 1, -1, 0) ' ş
'	varText = Replace(varText, ChrW(350), "&#x15E;", 1, -1, 0) ' Ş
'	varText = Replace(varText, Chr(252), "&#xFC;", 1, -1, 0)   ' ü
'	varText = Replace(varText, Chr(220), "&#xDC;", 1, -1, 0)   ' Ü
'	Utf8Unicode = varText
'End Function
'Clearfix Utf8Unicode("ç Ç ğ Ğ ı İ ö Ö ş Ş ü Ü")
%>
