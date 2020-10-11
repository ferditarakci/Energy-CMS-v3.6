<%

Select Case GlobalConfig("request_task")
	'Case "lang"
	'	Response.Cookies("energy")("lang") = Temizle(Request.QueryString("lang"), 0)
	'	Response.Cookies("energy").Expires = Now() + 365
	'	Response.Redirect(Site_HTTP_REFERER)


	Case "banhit"
		strBanUrl = ""
		Set objRs = setExecute("SELECT url FROM #___banner WHERE id = "& GlobalConfig("request_globalid") &";")
			If Not objRs.Eof Then
				sqlExecute("UPDATE #___banner Set hit = hit + 1 WHERE id = "& GlobalConfig("request_globalid") &";")
				strBanUrl = objRs("url")
			End If
		Set objRs = Nothing
			strBanUrl = strBanUrl & ""
			If strBanUrl = "" Then
				ErrMsg "Yönlendirilecek adres bulunamadı!"
				'Response.Status = "404 Not Found"
				'Response.AddHeader "status", "404 Not Found"
			Else
				Response.Redirect( strBanUrl )
			End If




'	Case "site"
'		strBanUrl = ""
'		Set objRs = setExecute("SELECT kodu FROM #___products WHERE id = "& GlobalConfig("request_globalid") &";")
'			If Not objRs.Eof Then
'				sqlExecute("UPDATE #___products Set hit = hit + 1 WHERE id = "& GlobalConfig("request_globalid") &";")
'				strBanUrl = objRs("kodu")
'			End If
'		Set objRs = Nothing
'			strBanUrl = strBanUrl & ""
'			If strBanUrl = "" Then
'				ErrMsg "Yönlendirilecek adres bulunamadı!"
'				'Response.Status = "404 Not Found"
'				'Response.AddHeader "status", "404 Not Found"
'			Else
'				'Response.Redirect( strBanUrl )
'				Response.AddHeader "Refresh", "0; URL=http://" & strBanUrl
'			End If



'	Case Else

		'Response.Redirect(UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Home"), "", "", "", "", ""))
		'ErrMsg Lang("post_err")

End Select

#@~^9QAAAA==@#@&qW,`Dl/0P{~JmNhk	J~C	NP"n;!+/DcEwm/kJbPx~r XFyE#,K4n	@#@&jnk/rW	 :khr!YP,P,~P,'~,Z@#@&j//bGxvJb9hrxdWTkUJb~{PPD!n@#@&?ndkkWUcrSGobU:khJ*PP{PrE[,1Ghv#@#@&U+/krW	`Jz[hk	b9kE#~~,'~Jm[:bxE@#@&I+d2Kxd+c]NrM+1Y`rl9hk	zrx9+a m/wrb@#@&2x9~(0@#@&QUMAAA==^#~@
%>
