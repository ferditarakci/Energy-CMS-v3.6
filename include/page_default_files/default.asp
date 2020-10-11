<%

'// Energy Web Tasarım
'// Ferdi TARAKCI
'// 0546 831 20 73
'// bilgi@webtasarimx.net
'// www.webdizzayni.org

'Clearfix GlobalConfig("request_showall")
Private Function BolunmusSayfaBaslik(ByVal oTitle, ByVal oText)
	oTitle = oTitle & "" : oText = oText & ""
	If oText = "" Then Exit Function
	If (inStr(1, oText, "class=""system-pagebreak""", 1) = 0) Then BolunmusSayfaBaslik = oTitle : Exit Function
		Dim Count, oMatch
		With New RegExp
			.Global = True
			.IgnoreCase = True
			.MultiLine = True
			.Pattern = "<hr class=""system-pagebreak"" title=""(.*?)"" />"
			Count = 1
			For Each oMatch in .Execute(oText)

				If GlobalConfig("request_start") = 1 Or GlobalConfig("request_showall") = "true" Then
					BolunmusSayfaBaslik = oTitle

				ElseIf GlobalConfig("request_start") > 1 And Not GlobalConfig("request_showall") = "true" Then
					'If Not Cstr(GlobalConfig("request_showall")) = "true" Then
						RegExBaslik = .Replace(oMatch.Value, "$1")
						BolunmusSayfaBaslik = oTitle &" <span id=""sub-title""> &ldquo; "& RegExBaslik &" &rdquo; </span>"
					'End If
				End If

				Count = Count + 1
				If GlobalConfig("request_start") = Count Then Exit For
			Next
		End With
	'Else
	'	BolunmusSayfaBaslik = oTitle
	'End If
End Function 



Private Function BSayfaLink(ByVal oiD, ByVal oTitle, ByVal oText)
	oTitle = oTitle & "" : oText = oText & ""
	If oText = "" Then Exit Function
	Dim blnPageBreak, strWrite, oMatch, addClass, intSayfaNo, strTitleReplace

	blnPageBreak = CBool(inStr(1, oText, "class=""system-pagebreak""", 1))
	If blnPageBreak Then

		With New RegExp
			.Global = True
			.IgnoreCase = True
			.MultiLine = True
			.Pattern = "<hr class=""system-pagebreak"" title=""(.*?)"" />"

			addClass = ""
			If GlobalConfig("request_start") = 1 And Not GlobalConfig("request_showall") = "true" Then addClass = " class=""active"""
			strWrite = vbCrLf
			strWrite = strWrite & "	<div id=""toc"">" & vbCrLf
			strWrite = strWrite & "		<h3>"& Lang("pagebreak_title") &"</h3>" & vbCrLf
			strWrite = strWrite & "		<ul>" & vbCrLf
			strWrite = strWrite & "			<li"& addClass &"><a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", oiD, 0, "") &""" title="""& oTitle &""">"& KacKarekter(oTitle, 30) &"</a></li>" & vbCrLf

			intSayfaNo = 2
			For Each oMatch in .Execute(oText)
				addClass = ""
				If GlobalConfig("request_start") = intSayfaNo And Not GlobalConfig("request_showall") = "true" Then addClass = " class=""active"""
				'// Değerin uzunluğu: " & oMatch.Length
				'// Başlangıç sırası: " & oMatch.FirstIndex
				strTitleReplace = .Replace(oMatch.Value, "$1")
				strWrite = strWrite & .Replace(oMatch.Value, "			<li"& addClass &"><a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", oiD, intSayfaNo, "") &""" title="""& strTitleReplace &""">"& KacKarekter(strTitleReplace, 30) &"</a></li>") & vbCrLf
				intSayfaNo = intSayfaNo + 1
			Next

			addClass = ""
			If GlobalConfig("request_showall") = "true" Then addClass = " class=""active"""
			strWrite = strWrite & "			<li"& addClass &"><a href="""& UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", oiD, "true", "") &""" title="""& Lang("pagebreak_tumu") &""">"& Lang("pagebreak_tumu") &"</a></li>" & vbCrLf
			strWrite = strWrite & "		</ul>" & vbCrLf
			strWrite = strWrite & "	</div>" & vbCrLf
		End With
	End If
	BSayfaLink = strWrite
End Function



Private Function RegExpSayfaBol(ByVal oText)
	oText = oText & ""
	If oText = "" Then Exit Function
	'If (Cstr(GlobalConfig("request_showall")) = "true") Then  RegExpSayfaBol = oText : Exit Function
	'If (inStr(1, oText, "class=""system-pagebreak""", 1) = 0) Then Exit Function
	oText = oText & "<hr class=""system-pagebreak"" title=""End Content"" />"

	Dim objBulunan, intStartNo, oMatch, SubCount, strWrite
	With New RegExp
		.Global = True
		.IgnoreCase = True
		.MultiLine = True
		.Pattern = "([\s\S]*?)<hr class=""system-pagebreak"" title=""[\s\S]*?"" />"
		Set objBulunan = .Execute(oText)
	End With

	If objBulunan.Count > 0 Then
		intStartNo = 1
		For Each oMatch in objBulunan
			For SubCount = 0 To oMatch.SubMatches.Count -1
			
				If GlobalConfig("request_start") = intStartNo And Not objBulunan.Count = 1 And Not GlobalConfig("request_showall") = "true" Then
					'If Not Cstr(GlobalConfig("request_showall")) = "true" Then
						strWrite = "<div class=""sayfa-sayisi"">" & Replace(Replace(Lang("pagebreak_syf_no"), "[Start]", intStartNo), "[Count]", objBulunan.Count) & "</div>" & vbCrLf
					'End If
				End If
				'Response.Write Cdbl(GlobalConfig("request_start")) = Cdbl(intStartNo)
				If GlobalConfig("request_start") = intStartNo Then
					RegExpSayfaBol = strWrite & oMatch.SubMatches( SubCount ) & vbCrLf

				ElseIf GlobalConfig("request_showall") = "true" Then
					RegExpSayfaBol = RegExpSayfaBol & oMatch.SubMatches( SubCount ) & vbCrLf
				End If

			Next
			intStartNo = intStartNo + 1
		Next
	'Else
		'Response.Write "Eşleşme Bulunamadı!"
	End If
End Function
%>
