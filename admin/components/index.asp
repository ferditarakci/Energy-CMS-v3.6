<%Response.Redirect("?mod=login")%>
	
<style>

.notification{height:40px;margin-bottom:10px;position:relative}
.notification .messages{color:#2b2b2b;font-size:12px;font-weight:700;position:relative;margin:1px;padding:13px 0 13px 50px}
.notification .messages .close{position:absolute;top:15px;right:10px;cursor:pointer}
.info{border:1px solid #acdbef}
.info .messages{background:#daeffb url(images/message/info.png) no-repeat 20px 9px}


</style>

<div class="notification info">
	<div class="messages">E-Posta / Kullanıcı Adı veya Şifre Geçersiz !
	<div class="close"><img src="images/message/close.png" alt="close" /></div></div>
</div>

