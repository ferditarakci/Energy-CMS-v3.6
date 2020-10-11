<%
Sub VisualCategoryList(ByVal Catid, ByVal CatModulStatus, ByVal CatLangTitle)
	If Not CatModulStatus Then Exit Sub
	Dim sSQL, objSubRs, intiD, strCatTitle, strCatFullTitle, strCatShortTitle, strCatPicture, strCatPictureTitle, strCatPictureAlt, intPageNo
	sSQL = Empty
	sSQL = sSQL & "SELECT t1.id, t2.title, t2.short_title, t3.resim, t3.title As img_title, t3.alt As img_alt " & vbCrLf
'	sSQL = sSQL & ", (SELECT t3.resim, t3.title As img_title, t3.alt As img_alt FROM #___images WHERE anaresim = -1 And anaid = t1.id And nerde = '"& GlobalConfig("General_Categories") &"' Limit 1) " & vbCrLf
	sSQL = sSQL & "FROM #___kategori t1 " & vbCrLf
	sSQL = sSQL & "INNER JOIN #___content t2 ON t1.id = t2.parent_id " & vbCrLf
	sSQL = sSQL & "LEFT JOIN (SELECT id, resim, title, alt, anaid FROM #___images WHERE (durum = -1 Or durum = 1) And (anaresim = -1 Or anaresim = 1) And file_type = 1 And nerde = '"& GlobalConfig("General_Categories") &"') t3 ON t3.anaid = t1.id " & vbCrLf
'	sSQL = sSQL & "INNER JOIN #___languages t6 ON t2.lang = t6.lng " & vbCrLf
	sSQL = sSQL & "WHERE (" & vbCrLf
	sSQL = sSQL & "(t1.durum = -1 Or t1.durum = 1) " & vbCrLf
	'sSQL = sSQL & "And t3.anaresim = -1 " & vbCrLf
	sSQL = sSQL & "And t2.parent = '"& GlobalConfig("General_Categories") &"' " & vbCrLf
'	sSQL = sSQL & "And t3.nerde = '"& GlobalConfig("General_Categories") &"' " & vbCrLf
	sSQL = sSQL & "And t2.lang = '"& GlobalConfig("site_lang") &"' " & vbCrLf
	sSQL = sSQL & "And t1.anaid = "& Catid &" " & vbCrLf
	sSQL = sSQL & ") "
	sSQL = sSQL & "ORDER BY t1.sira ASC;"
	sSQL = setQuery( sSQL )
'	Clearfix sSql
	Set objSubRs = data.ExeCute( sSQL )
	If Not objSubRs.Eof Then
		With Response
'			.Write("<table style=""width:100%;"" cellpadding=""0"" cellspacing=""0"">" & vbCrLf)
'			.Write("              <tr>" & vbCrLf)
'			.Write("                 <td class=""contentheading"" width=""100%"" style=""padding-bottom:10px;"">" & vbCrLf)
'			.Write( klang )
'			.Write("                 </td>" & vbCrLf)
'			.Write("              </tr>" & vbCrLf)
'			.Write("   <tr>" & vbCrLf)
'			.Write(" 	    <td valign=""top"">" & vbCrLf)
'			.Write("        <div>" & vbCrLf)
'			.Write("           <table width=""100%"" class=""contentpaneopen"">" & vbCrLf)
'			.Write("              <tr>" & vbCrLf)
'			.Write("                 <td valign=""top"">" & vbCrLf)

			.Write("<div id=""sub_category"">" & vbCrLf)
			.Write("	<ol>" & vbCrLf)

			Do While Not objSubRs.Eof
				intiD = objSubRs("id")
				strCatTitle = objSubRs("title")
				strCatFullTitle = strCatTitle
				strCatShortTitle = objSubRs("short_title")
				If strCatShortTitle <> "" Then strCatTitle = strCatShortTitle
				strCatPicture = objSubRs("resim")
				strCatPictureTitle = objSubRs("img_title")
				strCatPictureAlt = objSubRs("img_alt")

				'If objSubRs("resim") <> "" Then  strCatPicture = GlobalConfig("sBase") & kFolder( &"/"& objSubRs("resim"), 1)
				If isNull(strCatPicture) Or strCatPicture = "" Then
					strCatPicture = GlobalConfig("sBase") & "upload/folder.png"
				Else
					strCatPicture = GlobalConfig("sBase") & kFolder(intiD, 0) & "/" & strCatPicture
				End If

				intPageNo = GlobalConfig("request_start")
				If intPageNo > 1 And Not Cstr(GlobalConfig("request_showall")) = "true" Then intPageNo = "true"

'				.Write("	<div style=""float:left;"">" & vbCrLf)
				.Write("		<li>" & vbCrLf)
				.Write("			<a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Categories"), "", "", intiD, intPageNo, "") &""" title="""& strCatFullTitle &""">")
				.Write("<img src="""& strCatPicture &""" title="""& strCatPictureTitle &""" alt="""& strCatPictureAlt &""" />")
				.Write("<span>"& UCase2( strCatTitle ) &"</span>")
				.Write("</a>" & vbCrLf)
				.Write("		</li>" & vbCrLf)
'				.Write("	</div>" & vbCrLf)

			objSubRs.MoveNext : Loop

			.Write("	</ol>" & vbCrLf)
			.Write("	<div class=""clr""></div>" & vbCrLf)
			.Write("</div>" & vbCrLf)

'			.Write(" 	    </td>" & vbCrLf)
'			.Write("   </tr>" & vbCrLf)
'			.Write("           </table>" & vbCrLf)
'			.Write("   <span class=""article_separator"">&nbsp;</span> " & vbCrLf)
'			.Write("        </div>" & vbCrLf)
'			.Write(" 	    </td>" & vbCrLf)
'			.Write("   </tr>" & vbCrLf)
'			.Write("</table>" & vbCrLf)
			End With
		End If
	Set objSubRs = Nothing
End Sub
%>
