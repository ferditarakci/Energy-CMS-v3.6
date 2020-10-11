<%
'Session.Codepage = 65001
'Session.LCID = 1055
With Response
	.Charset = "utf-8"
	.ContentType = "text/html"
	.Codepage = 65001
	.LCID = 1055
End With


Dim inCount, rLang


Function QuickSort(Arr, loBound, hiBound)
	Dim pivot, loSwap, hiSwap, temp
	If hiBound - loBound = 1 then
		If Arr( loBound ) > Arr( hiBound ) then
			temp = Arr( loBound )
			Arr( loBound ) = Arr( hiBound )
			Arr( hiBound ) = temp
		End If
	End If

	pivot = Arr(int((loBound + hiBound) / 2))
	Arr(int((loBound + hiBound) / 2)) = Arr( loBound )
	Arr( loBound ) = pivot
	loSwap = loBound + 1
	hiSwap = hiBound

	Do
	While loSwap < hiSwap And Arr( loSwap ) <= pivot
		loSwap = loSwap + 1
	Wend

	While Arr(hiSwap) > pivot
		hiSwap = hiSwap - 1
	Wend

	If loSwap < hiSwap Then
		temp = Arr( loSwap )
		Arr( loSwap ) = Arr( hiSwap )
		Arr( hiSwap ) = temp
	End If

	Loop while loSwap < hiSwap
		Arr( loBound ) = Arr( hiSwap )
		Arr( hiSwap ) = pivot

		If loBound < (hiSwap - 1) then 
			Call QuickSort(Arr, loBound, hiSwap-1)
		End If

		If hiSwap + 1 < hibound then 
			Call QuickSort(Arr, hiSwap+1, hiBound)
		End If

	QuickSort = Arr

End Function










	'Dim emailList(4), uploadList(8), otherList(2), wLCID(124), inCount, rLang
	'emailList(0) = Array( "CDO NTS","CDONTS.NewMail","N","Email" )
	'emailList(1) = Array( "CDOSYS","CDO.Message","N","Email" )
	'emailList(2) = Array( "Dimac JMail","JMail.Message","N","Email" )
	'emailList(3) = Array( "ASP Mail","SMTPsvg.Mailer","N","Email" )
	'emailList(4) = Array( "Persits ASP Email","Persits.MailSender","N","Email" )



	'uploadList(0) = Array( "ASP Simple Upload","ASPSimpleUpload.Upload","N","Upload" )
	'uploadList(1) = Array( "ASP Smart Upload","aspSmartUpload.SmartUpload","N","Upload" )
	'uploadList(2) = Array( "Persits Jpeg","Persits.Jpeg","V","Jpeg" )
	'uploadList(3) = Array( "Persits File Upload","Persits.Upload","N","Upload" )
	'uploadList(4) = Array( "Dundas Upload","Dundas.Upload.2","N","Upload" )
	'uploadList(5) = Array( "Soft Artisans File Upload","SoftArtisans.FileUp","N","Upload" )
	'uploadList(6) = Array( "GSWhois","GSWhois.Whois","N","Whois" )
	'uploadList(7) = Array( "C2G Whois","c2g.whois","N","Whois" )
	'uploadList(8) = Array( "Dynu.Whois","Dynu.Whois","N","Whois" )


	Dim EnergyList(45)
	EnergyList(0) = Array( "AB Mailer","ABMailer.Mailman", "N", "Mailer" )
	EnergyList(1) = Array( "ABC Upload","ABCUpload4.XForm", "N", "Upload" )
	EnergyList(2) = Array( "ActiveFile","ActiveFile.Post", "N", "File" )
	EnergyList(3) = Array( "ActiveX Data Object","ADODB.Connection", "Y", "Required for Database Operations" )
	EnergyList(4) = Array( "Adiscon SimpleMail","ADISCON.SimpleMail.1", "N", "Mail" )
	EnergyList(5) = Array( "ASP HTTP","AspHTTP.Conn", "N", "HTTP" )
	EnergyList(6) = Array( "ASP Image","AspImage.Image", "N", "Image" )
	EnergyList(7) = Array( "ASP Mail","SMTPsvg.Mailer", "N", "Mail" )
	EnergyList(8) = Array( "ASP Simple Upload","ASPSimpleUpload.Upload", "N", "Upload" )
	EnergyList(9) = Array( "ASP Smart Cache","aspSmartCache.SmartCache", "N", "Cache" )
	EnergyList(10) = Array( "ASP Smart Mail","aspSmartMail.SmartMail", "N", "Mail" )
	EnergyList(11) = Array( "ASP Smart Upload","aspSmartUpload.SmartUpload", "N", "Upload" )
	EnergyList(12) = Array( "ASP Tear","SOFTWING.ASPtear", "N", "Tear" )
	EnergyList(13) = Array( "ASP Thumbnailer","ASPThumbnailer.Thumbnail", "N", "Thumbnailer" )
	EnergyList(14) = Array( "ASP Whois","WhoIs2.Whois", "N", "Whois" )
	EnergyList(15) = Array( "ASPSoft NT Object","ASPSoft.NT", "N", "NT Object" )
	EnergyList(16) = Array( "ASPSoft Upload","ASPSoft.Upload", "N", "Upload" )
	EnergyList(17) = Array( "CDO NTS","CDONTS.NewMail", "N", "Mailer" )
	EnergyList(18) = Array( "Chestysoft Image","csImageFile.Manage", "N", "Image" )
	EnergyList(19) = Array( "Chestysoft Upload","csASPUpload.Process", "N", "Upload" )
	EnergyList(20) = Array( "Dimac JMail","JMail.Message", "N", "JMail" )
	EnergyList(21) = Array( "Distinct SMTP","DistinctServerSmtp.SmtpCtrl", "N", "SMTP" )
	EnergyList(22) = Array( "Dundas Mailer","Dundas.Mailer", "N", "Mailer" )
	EnergyList(23) = Array( "Dundas Upload","Dundas.Upload.2", "N", "Upload" )
	EnergyList(24) = Array( "Dynu Encrypt","Dynu.Encrypt", "N", "Encrypt" )
	EnergyList(25) = Array( "Dynu HTTP","Dynu.HTTP", "N", "HTTP" )
	EnergyList(25) = Array( "Dynu Ftp","Dynu.Ftp", "N", "Ftp" )
	EnergyList(26) = Array( "Dynu Mail","Dynu.Email", "N", "Mail" )
	EnergyList(27) = Array( "Dynu Upload","Dynu.Upload", "N", "Upload" )
	EnergyList(28) = Array( "Dynu Whois","Dynu.Whois", "N", "Whois" )
	EnergyList(29) = Array( "GSWhois","GSWhois.Whois","N","Whois", "N", "Whois" )
	EnergyList(30) = Array( "C2G Whois","c2g.whois","N","Whois", "N", "Whois" )
	EnergyList(31) = Array( "Easy Mail","EasyMail.SMTP.5", "N", "Mail" )
	EnergyList(32) = Array( "File System Object","Scripting.FileSystemObject", "Y", "Required for Upload Operations" )
	EnergyList(33) = Array( "Ticluse Teknologi HTTP","InteliSource.Online", "N", "HTTP" )
	EnergyList(34) = Array( "Last Mod","LastMod.FileObj", "N", "Last Mod" )
	EnergyList(35) = Array( "Microsoft XML Engine","Microsoft.XMLDOM", "N", "Required for XML Operations" )
	EnergyList(36) = Array( "Persits AspUpload","Persits.Upload", "N", "Upload" )
	EnergyList(37) = Array( "Persits AspJpeg","Persits.Jpeg", "V", "JPEG" )
	EnergyList(38) = Array( "Persits AspEmail","Persits.MailSender", "N", "Email" )
	EnergyList(39) = Array( "Persits AspEncrypt","Persits.CryptoManager", "N", "ASPEncrypt" )
	EnergyList(40) = Array( "Persits AspPDF","Persits.Pdf", "N", "Mailer" )
	EnergyList(41) = Array( "Persits AspGrid","Persits.Grid", "N", "Mailer" )
	EnergyList(42) = Array( "SMTP Mailer","SmtpMail.SmtpMail.1", "N", "Mailer" )
	EnergyList(43) = Array( "Soft Artisans File Upload","SoftArtisans.FileUp", "N", "Upload" )
	EnergyList(44) = Array( "Chilkat Ftp File Upload","Chilkat.Ftp2", "N", "Upload" )
	EnergyList(45) = Array( "XStandard.Zip","XStandard.Zip", "N", "Zip" )
	'EnergyList(46) = Array( "ActiveX Data Object","ADODB.Connection","Y" ,"Required for Database Operations")


'Clearfix lbound(EnergyList)

	'otherList(0) = Array( "ActiveX Data Object","ADODB.Connection","Y" ,"Required for Database Operations")
	'otherList(1) = Array( "File System Object","Scripting.FileSystemObject","Y", "Required for Upload Operations" )
	'otherList(2) = Array( "Microsoft XML Engine","Microsoft.XMLDOM","N","Required for XML Operations" )

	Dim wLCID(124)
    wLCID(0) = Array( 1078,"Afrikaans","af" )
    wLCID(1) = Array( 1052,"Albanian","sq" )
    wLCID(2) = Array( 1025,"Arabic(Saudi Arabia)","ar-sa" )
    wLCID(3) = Array( 2049,"Arabic(Iraq)","ar-iq" )
    wLCID(4) = Array( 3073,"Arabic(Egypt)","ar-eg" )
    wLCID(5) = Array( 4097,"Arabic(Libya)","ar-ly" ) 
    wLCID(6) = Array( 5121,"Arabic(Algeria)","ar-dz" )
    wLCID(7) = Array( 6145,"Arabic(Morocco)","ar-ma" ) 
    wLCID(8) = Array( 7169,"Arabic(Tunisia)","ar-tn" )
    wLCID(9) = Array( 8193,"Arabic(Oman)","ar-om" ) 
    wLCID(10) = Array( 9217,"Arabic(Yemen)","ar-ye" )
    wLCID(11) = Array( 10241,"Arabic(Syria)","ar-sy" ) 
    wLCID(12) = Array( 11265,"Arabic(Jordan)","ar-jo" ) 
    wLCID(13) = Array( 12289,"Arabic(Lebanon)","ar-lb" ) 
    wLCID(14) = Array( 13313,"Arabic(Kuwait)","ar-kw" ) 
    wLCID(15) = Array( 14337,"Arabic(U.A.E.)","ar-ae" ) 
    wLCID(16) = Array( 15361,"Arabic(Bahrain)","ar-bh" ) 
    wLCID(17) = Array( 16385,"Arabic(Qatar)","ar-qa" ) 
    wLCID(18) = Array( 1069,"Basque","eu" ) 
    wLCID(19) = Array( 1026,"Bulgarian","bg" ) 
    wLCID(20) = Array( 1059,"Belarusian","be" ) 
    wLCID(21) = Array( 1027,"Catalan","ca" ) 
    wLCID(22) = Array( 1028,"Chinese(Taiwan)","zh-tw" ) 
    wLCID(23) = Array( 2052,"Chinese(PRC)","zh-cn" ) 
    wLCID(24) = Array( 3076,"Chinese(Hong Kong)","zh-hk" ) 
    wLCID(25) = Array( 4100,"Chinese(Singapore)","zh-sg" ) 
    wLCID(26) = Array( 1050,"Croatian","hr" )
    wLCID(27) = Array( 1029,"Czech","cs" ) 
    wLCID(28) = Array( 1030,"Danish","da" ) 
    wLCID(29) = Array( 1043,"Dutch(Standard)","n" ) 
    wLCID(30) = Array( 2067, "Dutch(Belgian)","nl-be" ) 
    wLCID(31) = Array( 9,"English","en" ) 
    wLCID(32) = Array( 1033,"English(United States)","en-us" ) 
    wLCID(33) = Array( 2057,"English(British)","en-gb" ) 
    wLCID(34) = Array( 3081,"English(Australian)","en-au" ) 
    wLCID(35) = Array( 4105,"English(Canadian)","en-ca" ) 
    wLCID(36) = Array( 5129,"English(New Zealand)","en-nz" ) 
    wLCID(37) = Array( 6153,"English(Ireland)","en-ie" ) 
    wLCID(38) = Array( 7177,"English(South Africa)","en-za" ) 
    wLCID(39) = Array( 8201,"English(Jamaica)","en-jm" ) 
    wLCID(40) = Array( 9225,"English(Caribbean)","en" ) 
    wLCID(41) = Array( 10249,"English(Belize)","en-bz" ) 
    wLCID(42) = Array( 11273,"English(Trinidad)","en-tt" ) 
    wLCID(43) = Array( 1061,"Estonian","et" ) 
    wLCID(44) = Array( 1080,"Faeroese","fo" ) 
    wLCID(45) = Array( 1065,"Farsi","fa" ) 
    wLCID(46) = Array( 1035,"Finnish","fi" ) 
    wLCID(47) = Array( 1036,"French(Standard)","fr" ) 
    wLCID(48) = Array( 2060,"French(Belgian)","fr-be" ) 
    wLCID(49) = Array( 3084,"French(Canadian)","fr-ca" ) 
    wLCID(50) = Array( 4108,"French(Swiss)","fr-ch" ) 
    wLCID(51) = Array( 5132,"French(Luxembourg)","fr-lu" ) 
    wLCID(52) = Array( 1071,"FYRO Macedonian","mk" ) 
    wLCID(53) = Array( 1084,"Gaelic(Scots)","gd" ) 
    wLCID(54) = Array( 2108,"Gaelic(Irish)","gd-ie" ) 
    wLCID(55) = Array( 1031,"German(Standard)","de" ) 
    wLCID(56) = Array( 2055,"German(Swiss)","de-ch" ) 
    wLCID(57) = Array( 3079,"German(Austrian)","de-at" ) 
    wLCID(58) = Array( 4103,"German(Luxembourg)","de-lu" ) 
    wLCID(59) = Array( 5127,"German(Liechtenstein)","de-li" ) 
    wLCID(60) = Array( 1032,"Greek ","e" )
    wLCID(61) = Array( 1037,"Hebrew","he" ) 
    wLCID(62) = Array( 1081,"Hindi","hi" ) 
    wLCID(63) = Array( 1038,"Hungarian","hu" ) 
    wLCID(64) = Array( 1039,"Icelandic","is" ) 
    wLCID(65) = Array( 1057,"Indonesian","in" ) 
    wLCID(66) = Array( 1040,"Italian(Standard)","it" ) 
    wLCID(67) = Array( 2064,"Italian(Swiss)","it-ch" ) 
    wLCID(68) = Array( 1041,"Japanese","ja" ) 
    wLCID(69) = Array( 1042,"Korean","ko" ) 
    wLCID(70) = Array( 2066,"Korean(Johab)","ko" ) 
    wLCID(71) = Array( 1062,"Latvian","lv" ) 
    wLCID(72) = Array( 1063,"Lithuanian","lt" ) 
    wLCID(73) = Array( 1086,"Malaysian","ms" ) 
    wLCID(74) = Array( 1082,"Maltese","mt" ) 
    wLCID(75) = Array( 1044,"Norwegian(Bokmal)","no" ) 
    wLCID(76) = Array( 2068,"Norwegian(Nynorsk)","no" ) 
    wLCID(77) = Array( 1045,"Polish","p" ) 
    wLCID(78) = Array( 1046,"Portuguese(Brazil)","pt-br" ) 
    wLCID(79) = Array( 2070,"Portuguese(Portugal)","pt" ) 
    wLCID(80) = Array( 1047,"Rhaeto-Romanic","rm" ) 
    wLCID(81) = Array( 1048,"Romanian","ro" ) 
    wLCID(82) = Array( 2072,"Romanian(Moldavia)","ro-mo" ) 
    wLCID(83) = Array( 1049,"Russian","ru" ) 
    wLCID(84) = Array( 2073,"Russian(Moldavia)","ru-mo" ) 
    wLCID(85) = Array( 1083,"Sami(Lappish)","sz" ) 
    wLCID(86) = Array( 3098,"Serbian(Cyrillic)","sr" ) 
    wLCID(87) = Array( 2074,"Serbian(Latin)","sr" ) 
    wLCID(88) = Array( 1051,"Slovak","sk" ) 
    wLCID(89) = Array( 1060,"Slovenian","s" ) 
    wLCID(90) = Array( 1070,"Sorbian","sb" ) 
    wLCID(91) = Array( 1034,"Spanish(Spain - Traditional Sort)","es" ) 
    wLCID(92) = Array( 2058,"Spanish(Mexican)","es-mx" ) 
    wLCID(93) = Array( 3082,"Spanish(Spain - Modern Sort)","es" ) 
    wLCID(94) = Array( 4106,"Spanish(Guatemala)","es-gt" ) 
    wLCID(95) = Array( 5130,"Spanish(Costa Rica)","es-cr" ) 
    wLCID(96) = Array( 6154,"Spanish(Panama)","es-pa" )
    wLCID(97) = Array( 7178,"Spanish(Dominican Republic)","es-do" ) 
    wLCID(98) = Array( 8202,"Spanish(Venezuela)","es-ve" )
    wLCID(99) = Array( 9226,"Spanish(Colombia)","es-co" )
    wLCID(100) = Array( 10250,"Spanish(Peru)","es-pe" )
    wLCID(101) = Array( 11274,"Spanish(Argentina)","es-ar" ) 
    wLCID(102) = Array( 12298,"Spanish(Ecuador)","es-ec" )
    wLCID(103) = Array( 13322,"Spanish(Chile)","es-c" )
    wLCID(104) = Array( 14346,"Spanish(Uruguay)","es-uy" )
    wLCID(105) = Array( 15370,"Spanish(Paraguay)","es-py" )
    wLCID(106) = Array( 16394,"Spanish(Bolivia)","es-bo" )
    wLCID(107) = Array( 17418,"Spanish(El Salvador)","es-sv" ) 
    wLCID(108) = Array( 18442,"Spanish(Honduras)","es-hn" )
    wLCID(109) = Array( 19466,"Spanish(Nicaragua)","es-ni" )
    wLCID(110) = Array( 20490,"Spanish(Puerto Rico)","es-pr" )
    wLCID(111) = Array( 1072,"Sutu","sx" )
    wLCID(112) = Array( 1053,"Swedish","sv" )
    wLCID(113) = Array( 2077,"Swedish(Finland)","sv-fi" )
    wLCID(114) = Array( 1054,"Thai","th" )
    wLCID(115) = Array( 1073,"Tsonga","ts" )
    wLCID(116) = Array( 1074,"Tswana","tn" )
    wLCID(117) = Array( 1055,"Turkish","tr" )
    wLCID(118) = Array( 1058,"Ukrainian","uk" )
    wLCID(119) = Array( 1056,"Urdu","ur" )
    wLCID(120) = Array( 1075,"Venda","ve" )
    wLCID(121) = Array( 1066,"Vietnamese","vi" )
    wLCID(122) = Array( 1076,"Xhosa","xh" )
    wLCID(123) = Array( 1085,"Yiddish","ji" )
    wLCID(124) = Array( 1077,"Zulu","zu" )
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" xml:lang="tr" lang="tr">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="robots" content="noindex, nofollow" />
<meta name="robots" content="noarchive" />
<meta name="author" content="Energy Design and Programming Ferdi Tarakcı, http://www.webtasarimx.net" />
<meta name="reply-to" content="bilgi@webtasarimx.net" />
<meta name="Owner" content="bilgi@webtasarimx.net" />
<meta name="Publisher" content="Energy Web Tasarım" />
<meta name="generator" content="Energy İçerik Yönetim Sistemi CMS v 3.5" />
<meta name="abstract" content="Energy, kişisel ve kurumsal kimliğinize uygun, prestijli web siteleri tasarlar" />
<meta name="copyright" content="&copy; 2008 - 2011 Energy İçerik Yönetim Sistemi" />
<title>Server Info - Energy Energy Web Yazılım - &copy; 2008 - <%=Year(Date())%></title>
<link href="http://webdizayni.org/favicon.ico" rel="shortcut icon" type="image/x-icon" title="Energy Energy Web Yazılım - &copy; 2008 - <%=Year(Date())%>" />
<link href="http://webdizayni.org/css/reset.css" type="text/css" rel="stylesheet" media="screen" />
<style type="text/css">
<!--
	body#ewy {
		margin: 1em auto;
		padding: 1em 2em;
		color:#fff;
		font:85%;
		font-family: tahoma;
		background-color:#f5f5f5;
	}
	div#ewy-content {
		width: 960px;
		margin: 0em auto;
		padding: 25px 10px;
		font-family: tahoma;
		text-align: center;
		border: 1px solid #dfdfdf;
		background-color: #fff;
		border-radius: 8px;
		-moz-border-radius: 8px;
		-khtml-border-radius: 8px;
		-webkit-border-radius: 8px;
	}
	div#ewy-content h1 {
		margin:0;
		padding:0 0 8px 0;
		line-height:19px;
		font-size: 18px;
		color:#444;
	}
	div#ewy-content p {
		margin:0;
		margin-bottom:5px;
		padding:0;
		line-height:15px;
		font-size: 14px;
		color:#444;
	}
	div#ewy-content span {
		color:#f00;
	}
	div#ewy-error-content .table {
		margin:0 auto;
		padding:1px;
		margin-top:20px;
		background-color:#aaa;
		border-radius: 5px;
		-moz-border-radius: 5px;
		-khtml-border-radius: 5px;
		-webkit-border-radius: 5px;
	}
	div#ewy-content table {
		width:100%;
		margin:0 auto;
		padding:5px;
		line-height:13px;
		font-size: 12px;
		color:#444;
		background-color:#aaa;
		border:0;
	}
	div#ewy-content th {
		height:32px;
		padding:2px 5px;
		background-color:#333333;
		color:#fff;
		text-align:left;
		vertical-align:middle;
		border:none;
		border-right:1px solid #fefbd8;
		border-bottom:1px solid #fefbd8
	}
	div#ewy-content th.red {
		font-family: georgia;
		font-size: 18px;
		font-weight: 700;
		font-style: italic;
		color:#f00;
	}
	div#ewy-content td {
		background-color:#eee;
		color:#000;
		height:32px;
		padding:2px 5px;
		text-align:left;
		vertical-align:middle;
		border:none;
		border-right:1px solid #fefbd8;
		border-bottom:1px solid #fefbd8
	}
	div#ewy-content td.red {
		color:#f00;
	}
	div#ewy-content td.green {
		color:#4a9501;
	}
	div#ewy-content td .blue {
		color:#1e33ff;
	}
-->
</style>
</head>
<body id="ewy">
	<div id="ewy-content">
		<h1>Energy Web Yazılım Hizmetleri</h1>
		<p><span><strong>Server Info</strong></span></p>
		<div class="table">
<%
	Function checkObject( comIdentity )
		On Error Resume Next
		Dim xTestObj
		checkObject = False
		Err = 0
		Set xTestObj = Server.CreateObject( comIdentity )
		If Err = 0 Then checkObject = True
		Set xTestObj = Nothing
		Err = 0
	End Function

	Public Sub CheckCOM(byVal comLists, byRef inCount)
		Dim strTxt, item, Provider, arr, xx
		strTxt = ""
		inCount = 0
		For item = LBound( comLists ) To UBound( comLists )
			Provider = item
			strTxt = strTxt & String(4, vbTab) & "<tr>" & VbCrlf
			strTxt = strTxt & String(5, vbTab) & "<th>" & comLists(item)(0) & "</th>" & VbCrlf
			If checkObject( comLists(item)(1) ) Then
				strTxt = strTxt & String(5, vbTab) & "<td class=""green"">Bileşen yüklü ( <span class=""blue"">" & comLists(item)(1) & "</span> )" & VbCrlf
				If inStr(comLists(item)(1), "Persits.") > 0 Then strTxt = strTxt & "( <span class=""blue""> v. " & Server.CreateObject(comLists(item)(1)).Version & "</span> )" & VbCrlf
				strTxt = strTxt & "</td>" & VbCrlf

				inCount = inCount + 1
			Else
				strTxt = strTxt & String(5, vbTab) & "<td class=""red"">Bileşen yüklü değil ( <span class=""blue""> " & comLists(item)(1) & "</span> )</td>" & VbCrlf
			End If
			strTxt = strTxt & String(4, vbTab) & "</tr>" & VbCrlf
			strTxt = strTxt & "#energy_web_yazilim#"
		Next
		'CheckCOM = strTxt
		arr = Split(strTxt, "#energy_web_yazilim#")
		arr = QuickSort(arr, 0, UBound( arr ))
		Response.Write( Join(arr) )
	End Sub

	Sub ShowServerVars()
	Dim arr, strList, Key, KeyValue
		On Error Resume Next
		Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
		Response.Write( String(5, vbTab) & "<th class=""red"" colspan=""2"">Server Variables</th>" & VbCrlf )
		Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )
		strList = ""
		strList = strList & String(4, vbTab) & "<tr>" & VbCrlf
		strList = strList & String(5, vbTab) & "<th>REQUEST_URI</th>" & VbCrlf
		strList = strList & String(5, vbTab) & "<td>" & Request.ServerVariables("REQUEST_URI") & "</td>" & VbCrlf
		strList = strList & String(4, vbTab) & "</tr>" & VbCrlf & "#energy_web_yazilim#"
		For Each Key In Request.ServerVariables
			If Request.ServerVariables(Key) <> "" Then
				If Ucase(Key) = "AUTH_PASSWORD" Then 
					KeyValue = String(Len(Request.ServerVariables( Key )), "*") 
				Else 
					KeyValue = Request.ServerVariables(Key) 
					If inStr(1 , Key, "ALL_", 1) <> 1 And inStr(1 , Key, "HTTP_AUTHORIZATION", 1) = 0 Then 
						strList = strList & String(4, vbTab) & "<tr>" & VbCrlf
						strList = strList & String(5, vbTab) & "<th>" & Key & "</th>" & VbCrlf
						strList = strList & String(5, vbTab) & "<td>" & KeyValue & "</td>" & VbCrlf
						strList = strList & String(4, vbTab) & "</tr>" & VbCrlf & "#energy_web_yazilim#"
						'strList = strList & "<tr><td valign=top class=smtext>" & Key & "</td>" & VbCrlf
						'strList = strList & "<td valign=top class=smbtext>" & KeyValue & "</td></tr>#@#" & VbCrlf
					End If
				End If
			End If
		Next
		arr = Split(strList, "#energy_web_yazilim#")
		arr = QuickSort(arr, 0, UBound( arr ))
		Response.Write( Join(arr) )
	End Sub


	Sub CheckMDAC()
		Dim objConn, strStr
		'On Error Resume Next
		strStr = String(4, vbTab) & "<tr>" & VbCrlf
		Set objConn = Server.CreateObject("ADODB.Connection")
		strStr = strStr  & String(5, vbTab) & "<th>MDAC (require 2.7)</th>" & VbCrlf
		If objConn.version < "2.7" Then 
			strStr = strStr & String(5, vbTab) & "<td>Your Version " & objConn.version & "&nbsp;(Needs updating!)</td>" & VbCrlf
		Else 
			strStr = strStr & String(5, vbTab) & "<td>Your Version " & objConn.version & "&nbsp;(OK)</td>" & VbCrlf
		End if
		Set objConn = Nothing
		strStr = strStr & String(4, vbTab) & "</tr>" & VbCrlf
			
		Response.Write( strStr )
	End Sub

	Function SetLCiD(byRef rLang)
		Dim wLang, wPos, rCount
		wlang = Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")
		wPos = InStr(1 , wLang, ",")
		If wPos > 0 Then
			wLang = Left(wLang, wPos -1)
		End If
		For rCount = 0 To UBound(wLCiD)
			If LCase(wLang) = wLCID( rCount )(2) Then
				SetLCiD = wLCID( rCount )(0)
				rLang = wLCID( rCount )(1)
				Exit Function
			End If
		Next
	End Function

	Response.Write( String(3, vbTab) & "<table>" & VbCrlf )
	Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	Response.Write( String(5, vbTab) &  "<th class=""red"" colspan=""2"">Bileşenler</th>" & VbCrlf )
	Response.Write( String(4, vbTab) & "</tr>" & VbCrlf	 )

	'Response.Write( CheckCOM(emailList, inCount) ) 
	'If inCount = 0 Then
	'	Response.Write( "<tr>" & VbCrlf )
	'	Response.Write( "<td colspan=2 class=smrText><b>At Least one Component is Required for Emailing</b></td>" & VbCrlf )
	'	Response.Write( "</tr>" & VbCrlf )
	'End If

	'Response.Write( CheckCOM(uploadList, inCount) )
	Call CheckCOM(EnergyList, inCount)
	'If inCount = 0 Then
	'	Response.Write( vbTab & "<tr>" & VbCrlf )
	'	Response.Write( String(5, vbTab) & "<th colspan=""2""><b>At Least one Component is Required for Uploading</b></th>" & VbCrlf )
	'	Response.Write( vbTab & "</tr>" & VbCrlf )
	'End If

	'Response.Write( CheckCOM(otherList, inCount) )
	
	'Response.Write( vbTab & "<tr>" & VbCrlf )
	Call CheckMDAC()
	'Response.Write( vbTab & "</tr>" & VbCrlf )

	Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<th>" & ScriptEngine & " ( require 5.6 )</th>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<td>" & "Your Server Version " & ScriptEngineMajorVersion & "." & ScriptEngineMinorVersion & "." & ScriptEngineBuildVersion  )
	If ScriptEngineMajorVersion & "." & ScriptEngineMinorVersion < "5.6" Then
		Response.Write( " ( Needs Updating )" )
	Else
		Response.Write( " ( OK )" )
	End If
	Response.Write( "</td>" & VbCrlf )
	Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )

	'Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	'Response.Write( String(5, vbTab) & "<th>Browser LCID:</th>" & VbCrlf )
	'Response.Write( String(5, vbTab) & "<td>" & SetLCiD( rLang ) & "</td>" & VbCrlf )
	'Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )

	Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<th>Session LCID:</th>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<td>" & Session.LCID & "</td>" & VbCrlf )
	Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )

	Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<th>Session Codepage:</th>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<td>" & Session.Codepage & "</td>" & VbCrlf )
	Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )

	Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<th>Response LCID:</th>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<td>" & Response.LCID & "</td>" & VbCrlf )
	Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )

	Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<th>Response Codepage:</th>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<td>" & Response.Codepage & "</td>" & VbCrlf )
	Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )

	Call ShowServerVars()

	Response.Write( String(4, vbTab) & "<tr>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<th>Fiziksel Yol: </th>" & VbCrlf )
	Response.Write( String(5, vbTab) & "<td>" & Server.MapPath("/") & "\</td>" & VbCrlf )
	Response.Write( String(4, vbTab) & "</tr>" & VbCrlf )

	Response.Write( String(3, vbTab) & "</table>" )


'On Error GoTo 0
%>
		</div>
	</div>
</body>
</html>
