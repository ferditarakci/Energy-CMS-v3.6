<div class="contact">
	<div class="left alpha">
<%

'// İletişim Bilgileri
strTitle = BasHarfBuyuk( GlobalConfig("PageTitle") )
strText = GlobalConfig("PageText")

With Response
	.Write("					<h1 class=""title""><a href="""& GlobalConfig("site_uri") &""" title="""& BasHarfBuyuk(strTitle) &""">"& strTitle &"</a></h1>" & vbCrLf)
	'.Write("<em class=""not""> </em>")
	.Write( strText )
	.Write( vbCrLf )
	.Write("					<div class=""clr""></div>" & vbCrLf)
End With

%>
	</div>
	<div class="left divider"></div>
	<div class="left omega">
		<h2 class="title"><%=BasHarfBuyuk(Lang("info_form_title"))%></h2>
		<em class="not"><%=Lang("info_form_title_mesaj")%></em>
		<form id="iletisim_formu" name="iletisim_formu" action="<%=UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Post"), "iletisim", "", "", "", "")%>" method="post" onsubmit="return EnergyFormSubmit(this.id);">
			<fieldset>
				<div class="row clearfix">
					<label for="info_isim"><span> :</span><%=Lang("info_form_isim")%></label>
					<input class="inputbox" id="info_isim" name="info_isim" title="<%=Lang("info_form_isim")%>" maxlength="50" type="text" />
				</div>
				<div class="row clearfix">
					<label for="info_tel"><span> :</span><%=Lang("info_form_tel")%></label>
					<input class="inputbox" id="info_tel" name="info_tel" title="<%=Lang("info_form_tel")%>" placeholder="0546 831 2073" maxlength="50" type="text" />
				</div> 
				<div class="row clearfix">
					<label for="info_mail"><span> :</span><%=Lang("info_form_mail")%></label>
					<input class="inputbox" id="info_mail" name="info_mail" title="<%=Lang("info_form_mail")%>" placeholder="isminiz@example.com" maxlength="50" type="text" />
				</div>
				<div class="row clearfix">
					<label for="info_konu"><span> :</span><%=Lang("info_form_konu")%></label>
					<input class="inputbox" id="info_konu" name="info_konu" title="<%=Lang("info_form_konu")%>" maxlength="50" type="text" />
				</div>
				<div class="row clearfix">
					<label for="info_mesaj"><span> :</span><%=Lang("info_form_mesaj")%></label>
					<textarea class="inputbox" id="info_mesaj" name="info_mesaj" title="<%=Lang("info_form_mesaj")%>" rows="5" cols="5"></textarea>
				</div>
				<div class="row check clearfix">
					<div><input class="checkbox" id="info_banadayolla" name="info_banadayolla" value="OK" title="<%=Lang("info_form_banada_gonder")%>" type="checkbox" /><label class="checkbox" for="info_banadayolla"><%=Lang("info_form_banada_gonder")%></label></div>
				</div>
				<div class="row buttons clearfix">
					<div>
						<span class="ie b1"><input class="button submit" id="submit" value="<%=Lang("info_form_buton_01")%>" title="<%=Lang("info_form_buton_01")%>" name="e-submit" type="submit" /></span>
						<span class="ie b2"><input class="button reset" id="reset" value="<%=Lang("info_form_buton_02")%>" title="<%=Lang("info_form_buton_02")%>" type="reset" /></span>
					</div>
				</div>
			</fieldset>
		</form>
		<div id="iletisim_formuMsj" class="hidden"></div>
	</div>

<%
If isTrue("ben ve sen :)") Then
%>
	<div class="clr"></div>
	<div class="ewy_hr" style="margin:20px 0px;"><hr /></div>
	<div class="clr"></div>

	<div style="margin-top:10px;">
		<iframe <%
If Not isTrue("W3C") Then
%>frameborder="0" scrolling="no" marginheight="0" marginwidth="0"<%
End If
%> src="http://maps.google.com/maps/ms?q=web+tasar%C4%B1m&amp;hq=web+tasar%C4%B1m&amp;hl=tr&amp;msa=0&amp;msid=201018603398521624997.0004bd4589d598373c37f&amp;ie=UTF8&amp;ll=41.015316,29.139218&amp;spn=0.073415,0.169086&amp;t=m&amp;output=embed"></iframe>
		<br />
		<p style="font-size:11px; text-align:right; color:#ca3437;"><em>Haritayı daha büyük görüntüle: <a style="font-size:11px; text-align:left;" href="http://maps.google.com/maps/ms?q=web+tasar%C4%B1m&amp;hq=web+tasar%C4%B1m&amp;msid=201018603398521624997.0004bd4589d598373c37f&amp;msa=0&amp;ie=UTF8&amp;ll=41.015316,29.139218&amp;spn=0.073415,0.169086&amp;t=m&amp;source=embed&amp;hl=tr" target="_blank">Energy Web Tasarım - Web Dizayn</a></em></p>
	</div>
<%
End If
%>


</div>
