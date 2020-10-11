<%If Not (mods = "login") Then%>
	<div class="menu-wrap clearfix">
<%
'Clearfix sTotalLang()
If sTotalLang() > 1 Then
	OpenRs objRs, "SELECT title, orj_title, Lower(lng) As lang, default_lng FROM #___languages WHERE durum = 1 ORDER BY default_lng DESC, sira ASC;"
		If Not objRs.Eof Then
			Response.Write("<div class=""langs clearfix"">" & vbCrLf)
			Response.Write("<ul class=""ewy-langs clearfix"">" & vbCrLf)
			Do While Not objRs.Eof
				strTitle = objRs("title")
				If objRs("orj_title") <> "" Then strTitle = strTitle & " / " & objRs("orj_title") & ""
				strLink = ""
				strLink = strLink & "?mod=" & mods
				If menutype <> "" Then strLink = strLink & "&amp;menutype=" & menutype
				If task <> "" Then strLink = strLink & "&amp;task=" & task
				If id > 0 Then strLink = strLink & "&amp;id=" & id
				If Not CBool(objRs("default_lng")) Then strLink = strLink & "&amp;"& ewy_queryLang &"=" & objRs("lang")
				strLink = strLink & Debug
				Response.Write("<li class=""flg-"& objRs("lang") &"""><a href="""& strLink &""" title="""& strTitle &"""><span>"& strTitle &"</span></a></li>" & vbCrLf)
			objRs.MoveNext() : Loop
			Response.Write("</ul>" & vbCrLf)
			Response.Write("</div>" & vbCrLf)
			strLink = ""
		End If
	CloseRs objRs
End If
%>
		<ul class="top-menu clearfix" id="topmenu">
			<li class="first-item"><a href="javascript:;"><span>Menü&nbsp;Yönetimi</span></a><%
OpenRs objRs, "SELECT type, title FROM #___content_menu_type WHERE durum = 1 ORDER BY sira ASC;"
If Not objRs.Eof Then
	Response.Write( vbCrLf & "				<ul>")
	While Not objRs.Eof
		Response.Write( vbCrLf & "					<li><a href=""?mod=menu&amp;menutype="& objRs("type") & sLang & Debug &""" title="""& objRs("title") &"""><span>"& objRs("title") &"&nbsp;Yönetimi</span></a></li>")
	objRs.MoveNext() : Wend
	Response.Write( vbCrLf & "				</ul>")
End If
CloseRs objRs

%>			</li><%If GlobalConfig("urun_yonetimi") Then%>
			<li><a href="javascript:;"><span>Ürün&nbsp;Yönetimi</span></a>
				<ul>
					<li><a href="?mod=<%=GlobalConfig("General_Categories") & sLang & Debug%>"><span>Kategori&nbsp;Yönetimi</span></a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Products") & sLang & Debug%>"><span>Ürün&nbsp;Yönetimi</span></a></li>
					<%If GlobalConfig("general_admin") And GlobalConfig("admin_name") <> "demo" Then%><li><a href="?mod=<%=GlobalConfig("General_Orders") & sLang & Debug%>"><span>Siparişler</span></a></li><%
				End If
				%>
				</ul>
			</li><%
				End If
				%>
			<li><a href="javascript:;"><span>İçerik&nbsp;Yönetimi</span></a>
				<ul>
					<li><a href="?mod=<%=GlobalConfig("General_Page") & sLang & Debug%>"><span>Genel İçerik Yönetimi</span></a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Tags") & sLang & Debug%>"><span>Etiket Yönetimi</span></a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Comments") & sLang & Debug%>"><span>Yorumlar Yönetimi</span></a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Poll") & sLang & Debug%>"><span>Anket Yönetimi</span></a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Banner") & sLang & Debug%>"><span>Banner Yönetimi</span></a></li>
					<li><a href="?mod=<%=GlobalConfig("General_Mailist") & sLang & Debug%>"><span>Mailist Yönetimi</span></a></li>
					<%If GlobalConfig("general_admin") And GlobalConfig("admin_name") <> "demo" Then%><li><a href="?mod=<%=GlobalConfig("General_Whois") & sLang & Debug%>"><span>Whois Yönetimi</span></a></li><%
				End If
				%>
				</ul>
			</li>
			<li><a href="?mod=<%=GlobalConfig("General_Users") & sLang & Debug%>"><span>Kullanıcılar</span></a></li>
			<li><a class="modules_window_open" href="?mod=modul<%=sLang & Debug%>"><span>Modül&nbsp;Ayarları</span></a></li>
			<li><a href="?mod=tema<%=sLang & Debug%>"><span>Temalar</span></a></li>
			<li><a href="?mod=ayar<%=sLang & Debug%>"><span>Site&nbsp;Ayarları</span></a></li>
			<li class="last-item"><%

				Dim splitDomain, sDmn
				splitDomain = GlobalConfig("domain")
				If (Left(Site_LOCAL_ADDR, 7) = "192.168" Or Site_LOCAL_ADDR = "127.0.0.1") And Not inStr(1, splitDomain, Site_HTTP_HOST, 1) > 0 Then splitDomain = Site_HTTP_HOST & ", " & splitDomain
				splitDomain = Split(splitDomain, ",")
				If Ubound(splitDomain) = 0 Then
					Response.Write("<a href="""& UrlWrite(GlobalConfig("sDomain"), "", GlobalConfig("General_Sitemap"), "", "", "", "", "") &""" title=""Site Haritası"" target=""_blank""><span>Site Haritası</span></a>" & vbCrLf)
				Else
					Response.Write("<a href=""javascript:;""><span>Site Haritası</span></a>" & vbCrLf)
					Response.Write("	<ul>" & vbCrLf)
					For Each sDmn In splitDomain
						sDmn = Trim(sDmn)
						Response.Write("		<li><a href="""& UrlWrite("http://" + sDmn, "", GlobalConfig("General_Sitemap"), "", "", "", "", "") &""" target=""_blank""><span>"&sDmn&"</span></a></li>" & vbCrLf)
					Next
					Response.Write("	</ul>" & vbCrLf)
				End If
				'Dim splitDomain, sDmn
				'splitDomain = Split(GlobalConfig("domain"), ",")
				'If Ubound(splitDomain) = 0 Then
				'	Response.Write("<a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Sitemap"), md5(splitDomain(0)), "", "", "", "") &""" title=""Site Haritası"" target=""_blank""><span>Site Haritası</span></a>" & vbCrLf)
				'Else
				'	Response.Write("<a href=""javascript:;"" title=""Site Haritası""><span>Site Haritası</span></a>" & vbCrLf)
				'	Response.Write("	<ul>" & vbCrLf)
				'	For Each sDmn In Split(GlobalConfig("domain"), ",")
				'		sDmn = Trim(sDmn) 'GlobalConfig("General_Sitemap")
				'		Response.Write("		<li><a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Sitemap"), md5(sDmn), "", "", "", "") &""" target=""_blank""><span>"&sDmn&"</span></a></li>" & vbCrLf)
				'	Next
				'	Response.Write("	</ul>" & vbCrLf)
				'End If
%>
			</li>
		</ul>
		<div class="clr"></div>
	</div>
<%
End If
%>

