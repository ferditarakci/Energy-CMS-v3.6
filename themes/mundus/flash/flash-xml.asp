<%
'// Energy Sitemap Scripti
With Response
	.Clear()
	.CacheControl = "no-cache"
	.CacheControl = "no-store"
	.AddHeader "pragma", "no-cache"
	.ContentType = "text/xml"
End With


'Clearfix GlobalConfig("request_task")

If GlobalConfig("request_task") = "flash-slider" Then

%>
<?xml version="1.0" encoding="utf-8" ?>
<Banner
bannerBackgroundColor = ""
bannerLoopCount = ""
bannerCornerRadius = "0"
buttonsVerticalMargin = "10"
buttonsHorizontalMargin = "10"
textEmbed(Smooth) = "yes"
textBoldAll = "yes"
textSize = "14"
textColor = ""
textAreaWidth = ""
textLineSpacing = "0"
textLetterSpacing = "-0.5"
textMarginLeft = "12"
textMarginBottom = "5"
textBackgroundColor = "0"
textBackgroundBlur = "true"
textBackgroundTransparency = "0"
transitionType = "10"
transitionVertical = "no"
transitionDirection = "1"
transitionRandomEffects = "yes"
transitionDelayTimeFixed = "2"
transitionDelayTimePerWord = "0.5"
transitionSpeed = "8"
transitionBlur = "yes"
showTimerClock = "yes"
showNextButton = "yes"
showBackButton = "yes"
showNumberButtons = "yes"
showNumberButtonsAlways = "no"
showNumberButtonsHorizontal = "no"
showNumberButtonsAscending = "yes"
showPlayPauseOnTimer = "yes"
alignButtonsLeft = "no"
alignTextTop = "no"
autoPlay = "yes"
imageResizeToFit = "yes"
imageRandomizeOrder = "no"
>
<%
'1450 Efe@302030
'u 1 19/10 21.40
xmlWrite = ""

'// Ana Sayfa Banner
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "    t1.title, t1.alt, t1.img, t1.url, t1.text" & vbCrLf
SQL = SQL & "FROM #___banner t1" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	t1.durum = 1" & vbCrLf
SQL = SQL & "    And t1.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & ") " & vbCrLf
SQL = SQL & "ORDER BY t1.sira ASC;" & vbCrLf
Set objRs = setExecute(SQL)
	Do While Not objRs.Eof

		xmlWrite = xmlWrite & "<item" & vbCrLf
		'xmlWrite = xmlWrite & "    buttonLabel=""" & objRs("title") &"""" & vbCrLf
		xmlWrite = xmlWrite & "    image="""& bFolder & "/" & objRs("img") &"""" & vbCrLf
		xmlWrite = xmlWrite & "    link=""" & objRs("url") &"""" & vbCrLf
		xmlWrite = xmlWrite & "    target=""_blank""" & vbCrLf
		xmlWrite = xmlWrite & "    delay=""500""" & vbCrLf
		xmlWrite = xmlWrite & "    textBlend=""no"">" & vbCrLf
		xmlWrite = xmlWrite & "<![CDATA[" & vbCrLf
		xmlWrite = xmlWrite & objRs("text") & "" & vbCrLf
		xmlWrite = xmlWrite & "]]>" & vbCrLf
		xmlWrite = xmlWrite & "</item>" & vbCrLf

		'xmlWrite = xmlWrite & "		<image:image>" & vbCrLf
		'xmlWrite = xmlWrite & "			<image:loc>"& SitemapDomain & bFolder & "/" & objRs("img") &"</image:loc>" & vbCrLf
		'xmlWrite = xmlWrite & "			<image:title><![CDATA[" & HtmlEncode(objRs("title")) & "]]></image:title>" & vbCrLf
		'If objRs("alt") <> "" Or objRs("text") <> "" Then
			'xmlWrite = xmlWrite & "			<image:caption><![CDATA["

			'If objRs("alt") <> "" Then _
			'	xmlWrite = xmlWrite & HtmlEncode(objRs("alt"))

			'If objRs("text") <> "" Then _
			'	xmlWrite = xmlWrite & vbCrLf & objRs("text")

			'xmlWrite = xmlWrite & "]]></image:caption>" & vbCrLf
		'End If
		'xmlWrite = xmlWrite & "		</image:image>" & vbCrLf
	objRs.MoveNext() : Loop
Set objRs = Nothing

Response.Write xmlWrite
Response.Write "</Banner>"

End If
%>


