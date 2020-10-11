
53502464444

5350246444

156.154.70.25
156.154.71.25

<div class="hazir-paketler">
	<h3 class="paket-title">Kobi Paketi</h3>
	<ul>
		<li><span><em>:</em> Alan Adı</span> 1 Adet </li>
		<li><span><em>:</em> Web Alanı</span> 500 Mb </li>
		<li><span><em>:</em> Aylık Trafik</span> 5000 Mb (5 Gb) </li>
		<li><span><em>:</em> E-Mail Hesabı</span> 50 Adet </li>
		<li><span><em>:</em> Mail Kutusu Boyutu</span> 250 Mb./Hesap</li>
		<li><span><em>:</em> SMTP - POP3 - IMAP</span> <span class="icon">Var</span></li>
		<li><span><em>:</em> Web Mail Desteği</span> <span class="icon">Var</span></li>
		<li><span><em>:</em> Anti-Spam/Anti-Virus</span> <span class="icon">Var</span></li>
		<li><span><em>:</em> Otomatik Cevaplama</span> <span class="icon">Var</span></li>
		<li><span><em>:</em> E-Mail Takma Ad</span> <span class="icon">Var</span></li>
		<li><span><em>:</em> E-Mail Yönlendirme</span> <span class="icon">Var</span></li>
		<li><span><em>:</em> Türkçe Kontrol Paneli</span> <span class="icon">Var</span></li>
		<li><span><em>:</em> Host. Panel Erişimi</span> <span class="icon n">Yok</span></li>
		<li><span><em>:</em> FTP Doğrudan Erişim</span> <span class="icon n">Yok</span></li>
		<li><span><em>:</em> 7/24 Destek</span> <span class="icon">Var</span></li>
		<li style="padding-right:10px; text-align:right;"><a href="demo-cms/v3.5/">Demo için tıklayın</a></li>
	</ul>
	<div class="paket-bottom">
		<div class="button"><a href="web-tasarim-kobi-paketi.html">Sipariş Ver</a></div>
		<div class="f">
			<div class="fiyat">300</div>
			<div class="birim">TL</div>
		</div>
	</div>
	<p style="font-weight:normal; clear:both; color:#666;">Küçük ve orta ölçekli işletmeler için ideal firma tanıtım sistemi. Tüm içeriğin yönetim panelinden yönetilebildiği gelişmiş bir sistemdir.</p>
</div>

<div class="clr"></div>

<%
strPageTitle = UCase2( GlobalConfig("PageTitle") )

strPageCDate = TarihFormatla(GlobalConfig("PageDate"))
'strPageMDate = TarihFormatla(objRs("m_date"))
'strPageCDate = DateSqlFormat(objRs("c_date"), "dd.mm.yy", 3)

strPageText = GlobalConfig("PageText")
strPageText = BSayfaLink(GlobalConfig("request_sayfaid"), strPageTitle, strPageText)	&	RegExpSayfaBol( strPageText )

With Response
	.Write("<div class=""contents"">" & vbCrLf)
	.Write("	<div class=""sutun"">" & vbCrLf)
	.Write("		<div class=""d"">" & vbCrLf)
	.Write("			<div class=""x"">" & vbCrLf)
	.Write("				<div class=""padding"">" & vbCrLf)

	SharedUrl = Server.UrlEncode( GlobalConfig("site_uri") )
	SharedUrl = Replace(SharedUrl, "%2E", ".", 1, -1, 1)
	.Write("					<div class=""share-button clearfix"">" & vbCrLf)
	.Write("						<div class=""tweet_share""><a href=""#"" onclick=""window.open('http://twitter.com/?status="& UrlEncode( ""& strPageTitle ) &" - "& SharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Twitter&apos;da Paylaş"" target=""_blank"">Twitter&apos;da Paylaş</a></div>" & vbCrLf)
	.Write("						<div class=""face_share""><a href=""#"" onclick=""window.open('http://www.facebook.com/sharer.php?u="& SharedUrl &"','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=400,top=100'); return false;"" title=""Facebook&apos;da Paylaş"" target=""_blank"">Facebook&apos;da Paylaş</a></div>" & vbCrLf)
	'If Site_REMOTE_ADDR = "z127.0.0.1" Then _
	'.Write("						<div class=""face_like""><iframe style=""border:none; overflow:hidden; width:110px; height:21px"" src=""http://www.facebook.com/plugins/like.php?href="& SharedUrl &"&amp;layout=button_count&amp;show_faces=true&amp;width=110&amp;action=like&amp;colorscheme=light&amp;height=21"" frameborder=""0"" scrolling=""no""></iframe></div>" & vbCrLf)
	.Write("					</div>" & vbCrLf)

	.Write("					<h2 class=""title"" title="""& strPageTitle &"""><a href="""& iUrlWrite &""" title="""& strPageTitle &""">"& strPageTitle &"</a></h2>" & vbCrLf) 
	.Write("					<span class=""tarih hidden"">"& Replace(Lang("page_tarih"), "[tarih]", strPageCDate) &"</span>" & vbCrLf)
	.Write("					<div class=""clr""></div>" & vbCrLf)

	.Write( strPageText )
	.Write( vbCrLf )

	.Write("					<div class=""clr""></div>" & vbCrLf)
	.Write("				</div>" & vbCrLf)
	.Write("			</div>" & vbCrLf)
	.Write("		</div>" & vbCrLf)
	.Write("	</div>" & vbCrLf)
	.Write("</div>" & vbCrLf)
End With
%>


