<%
Private Function OSType()

	Dim strUserAgent	'Holds info on the users browser and os
	Dim strOS		'Holds the users OS

	'Get the users HTTP user agent (web browser)
	strUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
	
	'Get users OS
	'Windows
	'Windows 7 and Windows 2008 R2 (both NT6.1)
	If inStr(1, strUserAgent, "Windows 7", 1) Or inStr(1, strUserAgent, "NT 6.1", 1) Then
		strOS = "Windows 7" 'Only show windows 7 even if Windows 2008 R2
	'Windows Vista and Windows Server 2008 (both NT6.0)
	ElseIf inStr(1, strUserAgent, "Windows Vista", 1) Or inStr(1, strUserAgent, "NT 6.0", 1) Then
		strOS = "Windows Vista"  
	ElseIf inStr(1, strUserAgent, "Windows 2003", 1) Or inStr(1, strUserAgent, "NT 5.2", 1) Then
		strOS = "Windows 2003"
	ElseIf inStr(1, strUserAgent, "Windows XP", 1) Or inStr(1, strUserAgent, "NT 5.1", 1) Then
		strOS = "Windows XP"
	ElseIf inStr(1, strUserAgent, "NT 5.01", 1) Then
		strOS = "Windows 2000 SP1"
	ElseIf inStr(1, strUserAgent, "Windows 2000", 1) Or inStr(1, strUserAgent, "NT 5", 1) Then
		strOS = "Windows 2000"
	ElseIf inStr(1, strUserAgent, "Windows NT", 1) Or inStr(1, strUserAgent, "WinNT", 1) Then
		strOS = "Windows  NT 4"
	ElseIf inStr(1, strUserAgent, "Windows 95", 1) Or inStr(1, strUserAgent, "Win95", 1) Then
		strOS = "Windows 95"
	ElseIf inStr(1, strUserAgent, "Windows ME", 1) Or inStr(1, strUserAgent, "Win 9x 4.90", 1) Then
		strOS = "Windows ME"
	ElseIf inStr(1, strUserAgent, "Windows 98", 1) Or inStr(1, strUserAgent, "Win98", 1) Then
		strOS = "Windows 98"
	ElseIf Instr(1, strUserAgent, "Windows CE", 1) Then
		strOS = "Windows CE"
	ElseIf Instr(1, strUserAgent, "Windows Phone OS 7.0", 1) Then
		strOS = "Windows Phone 7"

	'PalmOS
	ElseIf inStr(1, strUserAgent, "PalmOS", 1) Then
		strOS = "Palm OS"

	'PalmPilot
	ElseIf inStr(1, strUserAgent, "Elaine", 1) Then
		strOS = "PalmPilot"

	'Nokia
	ElseIf inStr(1, strUserAgent, "Nokia", 1) Then
		strOS = "Nokia"

	'Ubuntu
	ElseIf inStr(1, strUserAgent, "Ubuntu", 1) Then
		strOS = "Ubuntu"

	'Amiga
	ElseIf inStr(1, strUserAgent, "Amiga", 1) Then
		strOS = "Amiga"

	'Solaris
	ElseIf inStr(1, strUserAgent, "Solaris", 1) Then
		strOS = "Solaris"

	'SunOS
	ElseIf inStr(1, strUserAgent, "SunOS", 1) Then
		strOS = "Sun OS"

	'BSD
	ElseIf inStr(1, strUserAgent, "BSD", 1) Or inStr(1, strUserAgent, "FreeBSD", 1) Then
		strOS = "Free BSD"

	'Unix
	ElseIf inStr(1, strUserAgent, "Unix", 1) Or inStr(1, strUserAgent, "X11", 1) Then
		strOS = "Unix"

	'AOL webTV
	ElseIf inStr(1, strUserAgent, "AOLTV", 1) Or inStr(1, strUserAgent, "AOL_TV", 1) Then
		strOS = "AOL TV"

	ElseIf inStr(1, strUserAgent, "WebTV", 1) Then
		strOS = "Web TV"

	'iPad
	ElseIf inStr(1, strUserAgent, "iPad", 1) Then
		strOS = "iPad"

	'iPhone
	ElseIf inStr(1, strUserAgent, "iPhone", 1) Then
		strOS = "iPhone"

	'iPod
	ElseIf inStr(1, strUserAgent, "iPod", 1) Then
		strOS = "iPod"

	'Android
	ElseIf inStr(1, strUserAgent, "Android", 1) Then
		strOS = "Android"

	'Linux
	ElseIf inStr(1, strUserAgent, "Linux", 1) Then
		strOS = "Linux"

	'Machintosh
	ElseIf inStr(1, strUserAgent, "Mac OS X", 1) Then
		strOS = "Mac OS X"

	ElseIf inStr(1, strUserAgent, "Mac_PowerPC", 1) Or Instr(1, strUserAgent, "PPC", 1) Then
		strOS = "Mac PowerPC"

	ElseIf inStr(1, strUserAgent, "Mac", 1) Or inStr(1, strUserAgent, "apple", 1) Then
		strOS = "Macintosh"

	'OS/2
	ElseIf inStr(1, strUserAgent, "OS/2", 1) Then
		strOS = "OS/2"

	'Search Robot
	ElseIf _
		inStr(1, strUserAgent, "Googlebot", 1) Or _
		inStr(1, strUserAgent, "Mediapartners-Google", 1) Or _
		inStr(1, strUserAgent, "ZyBorg", 1) Or _
		inStr(1, strUserAgent, "slurp", 1) Or _
		inStr(1, strUserAgent, "Scooter", 1) Or _
		inStr(1, strUserAgent, "Robozilla", 1) Or _
		inStr(1, strUserAgent, "Jeeves", 1) Or _
		inStr(1, strUserAgent, "lycos", 1) Or _
		inStr(1, strUserAgent, "ArchitextSpider", 1) Or _
		inStr(1, strUserAgent, "Gulliver", 1) Or _
		inStr(1, strUserAgent, "crawler@fast", 1) Or _
		inStr(1, strUserAgent, "TurnitinBot", 1) Or _
		inStr(1, strUserAgent, "internetseer", 1) Or _
		inStr(1, strUserAgent, "nameprotect", 1) Or _
		inStr(1, strUserAgent, "PhpDig", 1) Or _
		inStr(1, strUserAgent, "StackRambler", 1) Or _
		inStr(1, strUserAgent, "UbiCrawler", 1) Or _
		inStr(1, strUserAgent, "Ask Jeeves/Teoma", 1) Or _
		inStr(1, strUserAgent, "Spider", 1) Or _
		inStr(1, strUserAgent, "ia_archiver", 1) Or _
		inStr(1, strUserAgent, "msnbot", 1) Or _
		inStr(1, strUserAgent, "bingbot", 1) Or _
		inStr(1, strUserAgent, "arianna.libero.it", 1) Or _
		inStr(1, strUserAgent, "y2bot", 1) Or _
		inStr(1, strUserAgent, "Twiceler", 1) Or _
		inStr(1, strUserAgent, "Baiduspider", 1) Or _
		inStr(1, strUserAgent, "YandexBot", 1) Or _
		inStr(1, strUserAgent, "magpie-crawler", 1) _
	Then
		strOS = "Search Robot"

	Else

		strOS = "Unknown"

	End If
	
	'Return function
	OSType = strOS
End Function
%>
