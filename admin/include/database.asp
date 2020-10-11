<%
Dim data, strDb, strKarisikSirala
Dim DateNull, DateTimeNull


Const tablePrefix = "tbl_"

Const vt = 1 '// MySQL = 1 **** MsACCESS = 2 **** MsSQL = 3

'Select Case vt
'	Case 1
		strDb = "MySQL"
		strKarisikSirala = "Rand()"
		DateNull = "0000-00-00"
		DateTimeNull = "0000-00-00 00:00:00"

'	Case 2
'		strDb = "MsACCESS"
'		strKarisikSirala = "Rnd( - (1000 * id) * Time() )"
'		DateNull = "00.00.0000"
'		DateTimeNull = "00.00.0000 00:00:00"

'	Case 3
'		strDb = "MsSQL"
' 		strKarisikSirala = "NEWID()"
'		DateNull = "00.00.0000"
'		DateTimeNull = "00.00.0000 00:00:00"
'End Select





Private Function sqlGuvenlik(ByVal varTxt, ByVal iHTML)
	varTxt = varTxt & ""
	If varTxt = "" Then Exit Function
	Dim strSearch, strReplace, asdf
	If vt = 1 Then
		strSearch = Array("\", "\x1a", "`", "´", "'", """", "--")
		strReplace = Array("\\", "\Z", "\`", "\´", "\'", "\""", "\-\-")
		For asdf = 0 To UBound(strSearch)
			varTxt = Replace(varTxt, strSearch(asdf), strReplace(asdf))
		Next
	Else
		varTxt = Replace(varTxt, "'", "''")
	End If
	sqlGuvenlik = varTxt
End Function



Private Function setQuery(ByVal s)
	s = s & ""
	setQuery = Replace(s, "#___", tablePrefix)
End Function




Sub OpenDatabase(ByRef BN)

	Err.Clear
	On Error Resume Next

	Dim strDbServer, strDbName, strDbUser, strDbPass
	Dim strODBC, strDS, strSetName, strColConnect

	Set BN = Server.CreateObject("Adodb.Connection")
	BN.ConnectionTimeout = 10

	If Left(Site_LOCAL_ADDR, 7) = "192.168" Or Site_LOCAL_ADDR = "127.0.0.1" Or Site_LOCAL_ADDR = "::1" Then
		strDbServer = "localhost"
		strDbName = "webtasarimx"
		strDbUser = "root"
		strDbPass = ""
	Else
		strDbServer = "85.159.67.247"
		strDbName = "webtsrmx"
		strDbUser = "webtsrmx"
		strDbPass = "vDmsMSJbCSBk8y9"
	End If

	'strODBC = "3.51" : strSetName = "latin5" : strColConnect = "latin5_turkish_ci"
	strODBC = "5.1" : strSetName = "utf8" : strColConnect = "utf8_general_ci" ' utf8_turkish_ci
	'strODBC = "5.2 Unicode" : strSetName = "utf8" : strColConnect = "utf8_general_ci" ' utf8_turkish_ci

	'If strODBC = "3.51" Then
	'	strSetName = "latin5" : strColConnect = "latin5_turkish_ci"
	'
	'ElseIf strODBC = "5.1" Then
	'	strSetName = "utf8" : strColConnect = "utf8_general_ci" ' utf8_turkish_ci
	'End If

	strDS = ""
	strDS = strDS & "DRIVER={MySQL ODBC "& strODBC &" Driver}; "
	strDS = strDS & "Server="& strDbServer &"; "
	strDS = strDS & "User="& strDbUser &"; "
	strDS = strDS & "Password="& strDbPass &"; "
	strDS = strDS & "Database="& strDbName &"; "
	strDS = strDS & "Port=3306; "
	strDS = strDS & "Option=16387; "
	strDS = strDS & "SET NAMES '"& strSetName &"';"
	'Clearfix strDS
	BN.ConnectionString = strDS : strDS = "" : strODBC = ""
	BN.Mode = 3
	BN.CursorLocation = 3
	BN.Open

	'If Err Then ErrMsg "Veritabanı bağlantısı başarısız!"

	BN.Execute "SET CHARACTER SET "& strSetName &";"
	BN.Execute "SET COLLATION_CONNECTION = '"& strColConnect &"';"

	strSetName = "" : strColConnect = ""

	If Not (BN.State = 1 Or BN.Errors.Count = 0) Then ErrMsg "Veritabanı bağlantısı başarısız!"
	'Clearfix BN.execute("Select @@max_allowed_packet")(0)
	On Error GoTo 0

End Sub




Sub CloseDatabase(ByRef BN)
	BN.Close
	Set BN = Nothing
End Sub





'Clearfix DateSqlFormat("2012-02-16", "yy/mm/dd", 1)
'Clearfix isDate("2012-02-16 00:")
Private Function DateSqlFormat(ByVal Tarih, ByVal Format, ByVal blnTime)
	If Not isDate(Tarih) Then DateSqlFormat = Null : Exit Function

	Dim Gun, Ay, Yil
	Gun = Day(Tarih) : If Gun < 10 Then Gun = "0" & Gun
	Ay = Month(Tarih) : If Ay < 10 Then Ay = "0" & Ay
	Yil = Year(Tarih)

	Format = Replace(Format, "dd", Gun)
	Format = Replace(Format, "mm", Ay)
	Format = Replace(Format, "yy", Yil)

	If blnTime = 1 Or blnTime = 2 Then
		Dim Saat, Dakika, Saniye
		Saat = Hour(Tarih) : If Saat < 10 Then Saat = "0" & Saat
		Dakika = Minute(Tarih) : If Dakika < 10 Then Dakika = "0" & Dakika
		Saniye = Second(Tarih) : If Saniye < 10 Then Saniye = "0" & Saniye
	End If

	If blnTime = 1 Then Format = Format &" "& Saat & ":" & Dakika & ":" & Saniye
	If blnTime = 2 Then Format = Format & "-" & Saat & Dakika & Saniye

	DateSqlFormat = Format
End Function



'Clearfix PriceFormat(1355.45)
Private Function PriceFormat(ByVal Price)
	Price = Price & ""
	Price = Trim(Price)
	If Not isNumeric(Price) Then PriceFormat = 0 : Exit Function
	If vt = 1 Then
		Price = Cdbl(Price)
		Price = Replace(Price, Chr(44), Chr(46))
	End If
		PriceFormat = Price
End Function
%>