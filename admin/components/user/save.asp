<%
If Not GlobalConfig("admin_yetki") Then _
	Call ActionPost(saveid, "warning", "Üzgünüz, Kullanıcı hesapları üzerinde işlem yapma yetkiniz bulunmuyor.") : Response.End

Dim strUserName, strMailAdres, strPassword, strPassword2, strDogumTarihi, SonZiyaret

strUserName = Temizle(Request.Form("kuladi"), 1)

strMailAdres = Temizle(Request.Form("mail"), 1)

strPassword = Request.Form("pass")
strPassword2 = Request.Form("pass2")

'clearfix Len(strPassword)
strDogumTarihi = _
	DateSqlFormat( _
		Request.Form("tarihgun") & "/" & _
		Request.Form("tarihay") & "/" & _
		Request.Form("tarihyil"), _
	"yy-mm-dd", 0)

If isDate(strDogumTarihi) Then strDogumTarihi = "'" & strDogumTarihi & "'" Else strDogumTarihi = "Null"

CreateDate = DateSqlFormat(Request.Form("tarih"), "yy-mm-dd", 1)
If isDate(CreateDate) Then CreateDate = "'"& CreateDate &"'" Else CreateDate = "Null"

'SonZiyaret = DateSqlFormat(Request.Form("sonziyaret"), "yy-mm-dd", 1)
'If Not isDate(SonZiyaret) Then SonZiyaret = Null

If Not isValidEMail(strMailAdres) Then
	saveClass = "warning"
	saveMessage = "Geçerli bir mail adresi girin. Örn: <em style=""color:red"">isminiz@domain.com</em>"

ElseIf Len(strMailAdres) > 80 Then
	saveClass = "warning"
	saveMessage = "Mail adresi çok uzun, <em style=""color:red"">maks. 80 karekter</em> girilebilir."

ElseIf Not isValidUserName(strUserName) Then
	saveClass = "warning"
	saveMessage = "Geçerli bir kullanıcı adı girin. (İzin verilen karekterler <em style=""color:red"">a-z A-Z 0-9 . _ - Min. 4, maks. 16 karekter</em>)"

ElseIf Len(strUserName) > 16 Then
	saveClass = "warning"
	saveMessage = "Kullanıcı adı çok uzun, <em style=""color:red"">min. 4, maks. 16 karekter</em> girmelisiniz."

ElseIf (Len(strPassword) = 0 Or Len(strPassword2) = 0) And pageid = 0 Then
	saveClass = "warning"
	saveMessage = "Şifrenizi girin ve şifre tekrarı ile doğrulayın."

ElseIf (strPassword <> "" Or strPassword2 <> "") And (Len(strPassword) < 4 Or Len(strPassword2) < 4) And pageid = 0 Then
	saveClass = "warning"
	saveMessage = "Şifreniz en az 4 karekterden oluşmalıdır."

ElseIf (strPassword <> "" Or strPassword2 <> "") And (Len(strPassword) < 4 Or Len(strPassword2) < 4) And pageid > 0 Then
	saveClass = "warning"
	saveMessage = "Şifreniz en az 4 karekterden oluşmalıdır."

ElseIf strPassword <> strPassword2 Then
	saveClass = "warning"
	saveMessage = "Şifrenizi girin ve şifre tekrarı ile doğrulayın."

ElseIf Not isDate(Replace(CreateDate, "'", "")) Then
	saveClass = "warning"
	saveMessage = "Lütfen kayıt tarihi girin."

Else

	If strPassword <> "" Then strPassword = MD5(Temizle(strPassword, 1))
	If strPassword2 <> "" Then strPassword2 = MD5(Temizle(strPassword2, 1))

	If pageid = 0 Then
		SQL = "SELECT * FROM #___uyeler WHERE (kulad = '"& strUserName &"' OR mail = '"& strMailAdres &"');"

	ElseIf pageid > 0 Then
		SQL = "SELECT * FROM #___uyeler WHERE id ="& pageid &";"

	End If

	OpenRs objRs, SQL

	If pageid = 0 Then
	
		If Not objRs.Eof Then
			If objRs("mail") = strMailAdres Then
				saveClass = "warning"
				saveMessage = "Aynı mail adresi mevcut. Lütfen farklı bir mail adresi deneyin."

			ElseIf objRs("kulad") = strUserName Then
				saveClass = "warning"
				saveMessage = "Aynı kullanıcı adı mevcut. Lütfen farklı bir kullanıcı adı deneyin."
			End If
		End If

	ElseIf pageid > 0 Then

		Dim strMailStatus, strKuladStatus
		'strMailStatus = sqlQuery("SELECT mail FROM #___uyeler WHERE (Not id = "& pageid &" And (kulad = '"& strUserName &"' OR mail = '"& strMailAdres &"'));", "")
		'strKuladStatus = sqlQuery("SELECT kulad FROM #___uyeler WHERE (Not id = "& pageid &" And (kulad = '"& strUserName &"' OR mail = '"& strMailAdres &"'));", "")

		Set objRs2 = setExecute("SELECT mail, kulad FROM #___uyeler WHERE (Not id = "& pageid &" And (kulad = '"& strUserName &"' OR mail = '"& strMailAdres &"'));")
			If objRs2.Eof Then
				strMailStatus = ""
				strKuladStatus = ""
			Else
				strMailStatus = objRs2("mail")
				strKuladStatus = objRs2("kulad")
			End If
		Set objRs2 = Nothing

		If strMailStatus = strMailAdres Then
			saveClass = "warning"
			saveMessage = "Aynı mail adresi mevcut. Lütfen farklı bir mail adresi deneyin."

		ElseIf strKuladStatus = strUserName Then
			saveClass = "warning"
			saveMessage = "Aynı kullanıcı adı mevcut. Lütfen farklı bir kullanıcı adı deneyin."
		End If

		If objRs.Eof Then
			saveClass = "error"
			saveMessage = "Düzenlenecek kayıt bulunamadı!"
		End If

	End If

	If Len(saveMessage) = 0 Then

		If objRs.Eof Then objRs.AddNew()

		objRs("kulad") = strUserName
		objRs("mail") = strMailAdres
		If strPassword <> "" Then objRs("pass") = strPassword

		objRs("durum") = intYap(Request.Form("durum"), 0)
		objRs("uyetipi") = intYap(Request.Form("uyetipi"), 0)
		objRs("yetki") = intYap(Request.Form("yetki"), 0)
		objRs("adi") = Temizle(Request.Form("adi"), 1)
		objRs("soyadi") = Temizle(Request.Form("soyadi"), 1)
		objRs("tcno") = intYap(Request.Form("tcno"), 0)
		objRs("cinsiyet") = intYap(Request.Form("cinsiyet"), 0)
		objRs("dogumyeri") = intYap(Request.Form("dogumyeri"), 0)
		'objRs("dogumtarihi") = strDogumTarihi
		objRs("telcep") = Temizle(Request.Form("telcep"), 1)
		objRs("telis") = Temizle(Request.Form("telis"), 1)
		objRs("telfax") = Temizle(Request.Form("telfax"), 1)
		objRs("il") = intYap(Request.Form("il"), 0)
		objRs("ilce") = intYap(Request.Form("ilce"), 0)
		objRs("semt") = intYap(Request.Form("semt"), 0)
		objRs("adres") = Temizle(Request.Form("adres"), 1)
		objRs("web") = Temizle(Request.Form("web"), 1)
		'objRs("tarih") = CreateDate
		'If pageid = 0 Then objRs("songiris") = SonZiyaret
		'If pageid = 0 Then objRs("hit") = intYap(Request.Form("hit"), 0)
		objRs.Update

		saveid = objRs("id")
		Session("pageid") = saveid

		sqlExecute("UPDATE #___uyeler Set tarih = "& CreateDate &", dogumtarihi = "& strDogumTarihi &" WHERE id = "& saveid &";")

		If Len(saveMessage) = 0 And pageid = 0 Then saveMessage = "<em class=""red"">" & objRs("mail") & "</em> Kullanıcı Hesabı Başarıyla Eklendi."
		If Len(saveMessage) = 0 And pageid > 0 Then saveMessage = "<em class=""red"">" & objRs("mail") & "</em> Kullanıcı Hesabı Başarıyla Düzenlendi."

	End If

	CloseRs objRs

	'If Request.Form("mailgonder") = 1 Then
		'HTML = Empty
		'HTML = HTML & "<table style=""font: 18px/26px Georgia, ""Times New Roman"", ""Bitstream Charter"", Times, serif !important;"">"
		'HTML = HTML & "<tr><td>Merhaba <span style=""font-weight:700;"">"&objRs("adi")&" "&objRs("soyadi")&"</span></td></tr>"
		'HTML = HTML & "<tr><td> <span style=""font-weight:700;"">Kullanıcı Adınız:</span> <span style=""font-weight:700; color:red"">"&objRs("kulad")&"</span> veya <span style=""font-weight:700; color:red"">"&objRs("mail")&"</span></td></tr>"
		'HTML = HTML & "<tr><td> <span style=""font-weight:700;"">Şifreniz:</span> <span style=""font-weight:700; color:red"">"&StrPassword&"</span></td></tr>"
		'HTML = HTML & "<tr><td style=""padding-top:15px; color:#257ad1;""><em>Sisteme giriş yaparak şifrenizi değiştirebilirsiniz.</em></td></tr>"
		'HTML = HTML & "<tr><td style=""padding-top:15px; color:#257ad1;""><em>Bilgilerinizin güvenliği açısından şifrenizi kimseyle paylaşmayın.</em></td></tr>"
		'HTML = HTML & "<tr><td style=""padding-top:15px; color:#ff4a03;""><em>"&E_Siteismi&"</em></td></tr>"
		'HTML = HTML & "<tr><td style=""padding-top:5px; border-bottom:1px solid #cccccc"">&nbsp;</td></tr>"
		'HTML = HTML & "<tr><td style=""padding-top:5px; color:#4c6200;""><em>&copy; 2008 - "&Year(Date())&" Energy Web Yazılım Sistemi</em></td></tr>"
		'HTML = HTML & "<tr><td style=""padding-top:5px; color:#4c6200;""><a href=""mailto:bilgi@webtasarimx.net""><em>bilgi@webtasarimx.net</em></a> --- <a href=""http://www.webtasarimx.net/"" title=""Energy Web Tasarım / Yazılım""><em>www.webtasarimx.net</em></a></td></tr>"
		'HTML = HTML & "</table>"
		'Call MailSender(E_MailFrom, "Panel Şifreniz", objRs("mail"), "",  ""&E_Siteismi, HTML)
	'End If

End If

%>
