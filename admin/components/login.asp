<%

Dim LoginMsg, LogimMsgClass, strLoginUserName, strLoginPassWord, strSqlLoginUserName, capt1, capt2

If (task = "" Or task = "login") Then
%>
<script type="text/javascript">
//<![CDATA[
$(document).ready(function() {
	$("#loginform").validate({
		rules: {
			username: {
				required : true,
				minlength: 4
			},
			passwd: {
				required : true,
				minlength: 4
			},
			captcha: {
				required : true,
				minlength: 4
			}
		},
		messages: {
			username: {
				required : "* Zorunlu",
				minlength: "* Min. 4 karekter"
			},
			passwd: {
				required : "* Zorunlu",
				minlength: "* Min. 4 karekter"
			},
			captcha: {
				required : "* Zorunlu",
				minlength: "* Min. 4 karekter"
			}
		}
	});
	var strSelectorid = "a#reload_strCaptcha";
	$(strSelectorid).click(function(e) {
		e.preventDefault();
		$("#imgCaptcha").attr({"src" : "<%=GlobalConfig("vRoot")%>files/captcha.asp?nocache=" + Math.floor(Math.random() * 1000) });
	});
	window.setInterval(
		function(){
			$(strSelectorid).click()
		},
		60000
	)
});
//]]>
</script>
<%
LoginMsg = "" : LogimMsgClass = " hidden"
If Session("logout") Then LogimMsgClass = " success" : LoginMsg = "Başarıyla çıkış yaptınız."
If Session("logerror") Then LogimMsgClass = " warning" : LoginMsg = "Üzgünüm! sisteme giriş yetkiniz bulunmuyor."
If Session("passerror") Then LogimMsgClass = " warning" : LoginMsg = "Kullanıcı adı ve/veya şifreniz doğrulanmadı."
If Session("captchaerror") Then LogimMsgClass = " warning" : LoginMsg = "Güvenlik kodu doğrulanmadı."
If LoginMsg <> "" Then _
	Response.Write("<div style=""width:480px; margin:0 auto;"" class=""bgcolor"& LogimMsgClass &"""><div class=""messages""><span>"& LoginMsg &"</span></div></div>")

Session.Contents.Remove("logout")
Session.Contents.Remove("logerror")
Session.Contents.Remove("passerror")
Session.Contents.Remove("captchaerror")

%>
<div id="login">
	<form name="loginform" id="loginform" action="?mod=<%=GlobalConfig("General_Login")%>&amp;task=kontrol<%=Debug%>" method="post">
	<input name="redirect_to" value="<%=Site_HTTP_REFERER%>" type="hidden" />
	<div class="login-form">
		<p>
			<label for="username">Kullanıcı adınız / Mail adresiniz</label>
			<label for="username" class="error" generated="true"></label><br />
			<input class="inputbox" name="username" title="Kullanıcı adı veya mail adresini gir" value="<%=Session("login_username")%><%Session.Contents.Remove("login_username")%>" id="username" type="text" maxlength="50" />
		</p>
		<p>
			<label for="passwd">Parola</label>
			<label for="passwd" class="error" generated="true"></label><br />
			<input class="inputbox" name="passwd" id="passwd" type="password" maxlength="20" autocomplete="off" title="Şifreni gir" />
		</p>
		<p>
			<label for="captcha">Güvenlik kodu</label>
			<label for="captcha" class="error" generated="true"></label><br />
			<input class="inputbox" name="captcha" id="captcha" type="text" maxlength="4" autocomplete="off" title="Güvenlik kodunu gir" />
			<span><img id="imgCaptcha" src="<%=GlobalConfig("vBase")%>files/captcha.asp?nocache=<%Randomize : Response.Write(int(1000 * Rnd))%>" alt="" /> <br /><span style="line-height:22px;"><a href="#" id="reload_strCaptcha">Güvenlik kodunu yenile</a></span></span>
		</p>
		<p class="submit">
			<input class="login-btn" value="Giriş Yap" title="Sisteme giriş yap" type="submit" />
		</p>
	</div>
	</form>
	<div class="locked bgimg">&nbsp;</div>
	<div id="sifremi-unuttum"><a href="?mod=<%=GlobalConfig("General_Login")%>&amp;task=recover<%=Debug%>" title="Bağlantıya tıklayıp yeni bir şifre talep et">Şifreni mi unuttun?</a></div>
</div>

<%















ElseIf task = "kontrol" Then
	Response.Clear()

	If Not blnPostMethod Then Response.Redirect("?mod=" & GlobalConfig("General_Login") & Debug2) : Response.End()

	'// Güvenlik kodunun doğruluğunu kontrol edelim
	capt1 = intYap(Request.Form("captcha"), 0)
	capt2 = intYap(Session("captcha"), 1)
	Session.Contents.Remove("captcha")

	If capt1 <> capt2 Then
		Session("error_pass") = intYap(Session("error_pass"), 0) + 1
		Session("captchaerror") = True
		Response.Redirect("?mod=" & GlobalConfig("General_Login") & Debug2)
		Response.End()
	End If

	'// Kullanıcı adı ve şifremizi alalım
	strLoginUserName = Request.Form("username")
	strLoginPassWord = MD5(Trim(Temizle(ClearHtml(Request.Form("passwd")), 1)))
	strSqlLoginUserName = Trim(Temizle(ClearHtml(strLoginUserName), 1))

	'// Kayıtsetimizi açalım ve kullanıcı adı ile şifreyi doğrulayalım
	OpenRs objRs, "SELECT id, adi, soyadi, kulad, yetki, songiris FROM #___uyeler WHERE (durum = 1 And uyetipi = 0 And (kulad = '"& strSqlLoginUserName &"' Or mail = '"& strSqlLoginUserName &"') And pass = '"& strLoginPassWord &"');"
	If objRs.Eof Then

		'// Kullancı adı veya şifre yanlış ise hata kaydı yapalım
		sqlExecute("INSERT INTO #___login_error (kulad, pass, tarih) VALUES ('"& Temizle(strLoginUserName, 1) &"', '"& Temizle(Request.Form("passwd"), 1) &"', Now());")
		'sqlExecute("insert into uyeresim(uyeid, yol) VALUES(@@identity, 'resim.jpg');")

		Session("passerror") = True
		Session("login_username") = HtmlEncode(strLoginUserName)
		Response.Redirect("?mod=" & GlobalConfig("General_Login") )
		Response.End()

	Else

		'// Oturum bilgilerini ayarlayalım
		Session.TimeOut = 60
		Session("admin_login_" & SefUrl(GlobalConfig("sRoot"))) = True
		Session("admin_username" & SefUrl(GlobalConfig("sRoot"))) = Cstr(objRs("kulad"))
		Session("admin_yetki" & SefUrl(GlobalConfig("sRoot"))) = CBool(objRs("yetki"))
		Session("admin_name" & SefUrl(GlobalConfig("sRoot"))) = CStr(objRs("adi") & " " & objRs("soyadi"))
		If isDate(objRs("songiris")) Then
			Session("admin_login_time" & SefUrl(GlobalConfig("sRoot"))) = CDate(objRs("songiris"))
		Else
			Session("admin_login_time" & SefUrl(GlobalConfig("sRoot"))) = Now()
		End If

		If GlobalConfig("super_admin") = Cstr(objRs("kulad")) Then Debug2 = "&debug=true"

		'// Beni hatırla seçilmişse kullanıcının bilgisayarına çerez bırakalım
		'If UCase(Request.Form("rememberme")) = "OK" Then
		'	Response.Cookies("energy" & SefUrl(GlobalConfig("sRoot")))("AdminLogin") = True
		'	Response.Cookies("energy" & SefUrl(GlobalConfig("sRoot")))("admin_userid") = objRs("id")
		'	Response.Cookies("energy" & SefUrl(GlobalConfig("sRoot"))).Expires = Now() + 30
		'	Response.Cookies("energy" & SefUrl(GlobalConfig("sRoot"))).Path = GlobalConfig("vRoot")
		'End If

		'Application.Lock
		'Application("kackisi") = Cint(Application("kackisi")) + 1
		'Application.UnLock

		'// Yeni oturum tarihini veritabanına kaydedelim
		'objRs("songiris") = DateSqlFormat(Now(), "yy-mm-dd", 1)
		'objRs("songiris") = Now()
		'objRs("hit") = objRs("hit") + 1
		'objRs.Update()

		sqlExecute("UPDATE #___uyeler Set hit = (hit + 1), songiris = Now() WHERE id = "& objRs("id") &";")

		'// Gereksiz oturumları silelim
		Session.Contents.Remove("error_pass")
		Session.Contents.Remove("login_username")
		Session.Contents.Remove("passerror")
		Session.Contents.Remove("captchaerror")

		'// Giriş başarılı olduğundan sayfamızı yönlendirelim
		If CBool(inStr(1, Request.Form("redirect_to"), GlobalConfig("admin_folder"), 1)) Then
			Response.Redirect(Request.Form("redirect_to") & Debug2)
			Response.End()
		Else
			Response.Redirect("?mod=" & GlobalConfig("General_Page") & Debug2)
			Response.End()
		End If

	End If
	CloseRs objRs























ElseIf task = "logout" Then
	Response.Clear()

	'// Kullanıcı oturumunu silelim
	'Session.Abandon
	'Session.Contents.RemoveAll()
	Session.Contents.Remove("admin_login_" & SefUrl(GlobalConfig("sRoot")))
	Session.Contents.Remove("admin_username" & SefUrl(GlobalConfig("sRoot")))
	Session.Contents.Remove("admin_yetki" & SefUrl(GlobalConfig("sRoot")))
	Session.Contents.Remove("admin_name" & SefUrl(GlobalConfig("sRoot")))
	Session.Contents.Remove("admin_login_time" & SefUrl(GlobalConfig("sRoot")))
	Session.Contents.Remove("site_status" & SefUrl(GlobalConfig("sRoot")))

	'Response.Cookies("energy" & SefUrl(GlobalConfig("sRoot"))).Expires = Now() - 1

	'Application.Lock
	'Application("kackisi") = CInt(Application("kackisi")) - 1
	'Application.UnLock

	If Not Session("logerror") Then Session("logout") = True
	Response.Redirect("?mod=" & GlobalConfig("General_Login"))
	Response.End()











ElseIf task = "recover" Then

	If blnPostMethod Then

		'// Güvenlik kodunun doğruluğunu kontrol edelim
		capt1 = intYap(Request.Form("captcha"), 0)
		capt2 = intYap(Session("captcha"), 1)
		Session.Contents.Remove("captcha")

		If capt1 <> capt2 Then
			Session("captchaerror") = True
			Response.Redirect("?mod="& GlobalConfig("General_Login") &"&task=recover" & Debug2)
			Response.End()
		End If

		'// Kullanıcı adı ve şifremizi alalım
		strLoginUserName = Request.Form("username")
		'strLoginPassWord = MD5(Trim(Temizle(ClearHtml(Request.Form("passwd")), 1)))
		strSqlLoginUserName = Trim(Temizle(ClearHtml(strLoginUserName), 1))

		'// Kayıtsetimizi açalım
		OpenRs objRs, "SELECT id, adi, soyadi, kulad, mail, pass FROM #___uyeler WHERE durum = 1 And uyetipi = 0 And (/*kulad = '"& strSqlLoginUserName &"' Or */mail = '"& strSqlLoginUserName &"');"
		If objRs.Eof Then
			Session("kuladerror") = True
		Else
			Dim strMail, NewPassword
			strMail = Cstr(objRs("mail"))
			NewPassword = SifreUret( 8 )
			If Not GlobalConfig("admin_folder") = "/panel/" Then
				objRs("pass") = MD5(NewPassword)
				objRs.Update
			End If
			Session.Contents.Remove("kuladerror")

			HTML = ""
			HTML = HTML & "<table style=""font: 18px/26px Georgia, ""Times New Roman"", ""Bitstream Charter"", Times, serif !important;"">"
			HTML = HTML & "<tr><td>Merhaba <span style=""font-weight:700;"">"& objRs("adi") &" "& objRs("soyadi") &"</span></td></tr>"
			HTML = HTML & "<tr><td> <span style=""font-weight:700;"">Kullanıcı Adınız:</span> <span style=""font-weight:700; color:red"">"& objRs("kulad") &"</span> veya <span style=""font-weight:700; color:red"">"& objRs("mail") &"</span></td></tr>"
			HTML = HTML & "<tr><td> <span style=""font-weight:700;"">Şifreniz:</span> <span style=""font-weight:700; color:red"">"& NewPassword &"</span></td></tr>"
			HTML = HTML & "<tr><td style=""padding-top:15px; color:#257ad1;""><em>Sisteme giriş yaparak şifrenizi değiştirebilirsiniz.</em></td></tr>"
			HTML = HTML & "<tr><td style=""padding-top:15px; color:#257ad1;""><em>Bilgilerinizin güvenliği açısından şifrenizi kimseyle paylaşmayın.</em></td></tr>"
			HTML = HTML & "<tr><td style=""padding-top:15px; color:#ff4a03;""><em>"& GlobalConfig("default_site_ismi") &"</em></td></tr>"
			'HTML = HTML & "<tr><td style=""padding-top:15px; color:#ff4a03;""><em>"& GlobalConfig("copyright") &"</em></td></tr>"
			HTML = HTML & "<tr><td style=""padding-top:5px; border-bottom:1px solid #cccccc"">&nbsp;</td></tr>"
			HTML = HTML & "<tr><td style=""padding-top:5px; color:#4c6200;""><em>&copy; 2008 - "& Year(Date()) &" Energy Web Yazılım Sistemi</em></td></tr>"
			HTML = HTML & "<tr><td style=""padding-top:5px; color:#4c6200;""><a href=""mailto:bilgi@webtasarimx.net""><em>bilgi@webtasarimx.net</em></a> --- <a href=""http://www.webtasarimx.net/"" title=""Energy Web Tasarım / Yazılım""><em>www.webtasarimx.net</em></a></td></tr>"
			'HTML = HTML & "<tr><td style=""padding-top:15px; color:#4c6200;""></td></tr>"
			'HTML = HTML & ""& CHR(10)
			'HTML = HTML & "http://"&site&"/"& CHR(10)
			'HTML = HTML & "" & siteismi & ""& CHR(10)
			'HTML = HTML & "" & copy & ""& CHR(10)
			HTML = HTML & "</table>"
			'Call MailSender(E_MailFrom, "Panel Şifreniz", objRs("mail"), "",  ""&GlobalConfig("default_site_ismi"), HTML)
			'strMail Gönderme Fonksiyonunu Çalıştır
			Call MailSender( _
				Cstr(GlobalConfig("mail_from")), _
				Cstr("Panel Şifreniz"), _
				strMail, _
				"", _
				Cstr(GlobalConfig("default_site_ismi")), _
				Cstr(HTML), _
				0 _
			)
			Session("passok") = True
			Response.Redirect("?mod="& GlobalConfig("General_Login") &"&task=recover" & Debug2)
		End If
		CloseRs objRs
	End If
%>

<script type="text/javascript">
//<![CDATA[
$(document).ready(function() {
	$("#loginform").validate({
		rules: {
			username: {
				required : true,
				minlength: 4
			},
			captcha: {
				required : true,
				minlength: 4
			}
		},
		messages: {
			username: {
				required : "* Zorunlu",
				minlength: "* Min. 4 karekter"
			},
			captcha: {
				required : "* Zorunlu",
				minlength: "* Min. 4 karekter"
			}
		}
	});
	var strSelectorid = "a#reload_strCaptcha";
	$(strSelectorid).click(function(e) {
		e.preventDefault();
		$("#imgCaptcha").attr({"src" : "<%=GlobalConfig("vRoot")%>files/captcha.asp?nocache=" + Math.floor(Math.random() * 1000) });
	});
	window.setInterval(
		function(){
			$(strSelectorid).click()
		},
		60000
	)
});
//]]>
</script>
<%
LoginMsg = "" : LogimMsgClass = ""
If Session("passok") Then LogimMsgClass = " success block" : LoginMsg = "Yeni şifreniz mail adresinize gönderildi."
If Session("kuladerror") Then LogimMsgClass = " warning block" : LoginMsg = "Kullanıcı adı veya mail adresi doğrulanmadı."
If Session("captchaerror") Then LogimMsgClass = " warning block" : LoginMsg = "Güvenlik kodu doğrulanmadı."

If LoginMsg <> "" Then _
	Response.Write("<div style=""width:380px; margin:0 auto;"" class=""bgcolor"& LogimMsgClass &"""><div class=""messages""><span>"& LoginMsg &"</span></div></div>")


Session.Contents.Remove("passok")
Session.Contents.Remove("kuladerror")
Session.Contents.Remove("captchaerror")

%>
<div id="login" class="recover">
	<form name="loginform" id="loginform" action="?<%=Temizle(Site_Query_String, 0)%>" method="post">
	<div class="login-form clearfix">
		<p>
			<label for="username"><span><!--Kullanıcı adınız /-->Mail adresiniz</span></label>
			<label class="error" for="username" generated="true"></label><br />
			<input class="inputbox" name="username" title="Sistemde kayıtlı mail adresinizi girin" value="<%=HtmlEncode(strLoginUserName)%>" id="username" type="text" maxlength="100" />
		</p>
		<p>
			<label for="captcha"><span>Güvenlik kodu</span></label>
			<label class="error" for="captcha" generated="true"></label><br />
			<input class="inputbox" name="captcha" id="captcha" type="text" maxlength="4" autocomplete="off" title="Güvenlik kodunu gir" />
			<span><img id="imgCaptcha" src="<%=GlobalConfig("vBase")%>files/captcha.asp?nocache=<%Randomize : Response.Write(int(1000 * Rnd))%>" alt="" /> <br /><span style="display:inline-block; margin-top:4px;"><a href="#" id="reload_strCaptcha">Güvenlik kodunu yenile</a></span></span>
		</p>
		<p class="submit">
			<input class="login-btn back" value="Geri Dön" title="Giriş sayfasına dön" type="button" onclick="window.document.location.href='?mod=login<%=Duzenle(Debug)%>'; return false;" />
			<input class="login-btn recover" value="Şifremi Gönder" title="Şifremi mail adresime gönder" type="button" onclick="$('#loginform').submit();" />
		</p>
		<p class="italic">
			Şifrenizi size gönderebilmemiz için yukarıdaki alana sistemde kayıtlı mail adresini girmelisiniz.
		</p>
	</div>
	</form>
</div>
<%
End If
'If (task = "admin" Or task = "adminlogin") Then LoginSuperAdmin()
%>
