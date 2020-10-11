<%
If Not blnPostMethod Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
Response.Clear()

Response.Write("<form id=""fileUpdateSubmit"" action=""?mod=redirect&amp;task=fileUpdate&amp;id={id}"" method=""post"">" & vbCrLf)
Response.Write("<div class=""file_list clearfix"">" & vbCrLf)
	Response.Write("<div class=""file_list_wrap clearfix"">" & vbCrLf)
		Response.Write("<div class=""file_body clearfix"">" & vbCrLf)
		Response.Write("	<div class=""menu_content"">" & vbCrLf)
		Response.Write("		<div class=""images""><img {fileStyle} class=""medium_image"" src="""& GlobalConfig("vBase") &"images/blank.gif"" /></div>" & vbCrLf)
		Response.Write("		<div style=""float:left;"">" & vbCrLf)
		Response.Write("			<div class=""rows clearfix"" style=""width:437px;"">" & vbCrLf)
		Response.Write("				<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Dosya İsmi</span>" & vbCrLf)
		Response.Write("				<input style=""width:315px;"" disabled=""disabled"" value=""{fileName}"" class=""inputbox"" type=""text"" />" & vbCrLf)
		Response.Write("			</div>" & vbCrLf)
		Response.Write("			<div class=""rows clearfix"" style=""width:437px;"">" & vbCrLf)
		Response.Write("				<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Dosya Türü</span>" & vbCrLf)
		Response.Write("				<span class=""file_text normal"" style=""width:auto;"">{fileMimeType}</span>" & vbCrLf)
		Response.Write("			</div>" & vbCrLf)
		Response.Write("			<div class=""rows clearfix"" style=""width:437px;"">" & vbCrLf)
		Response.Write("				<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Ekleme Tarihi</span>" & vbCrLf)
		If GlobalConfig("general_admin") Then
		Response.Write("				<input style=""width:130px;"" name=""fileDateTime"" value=""{fileDateTime}"" class=""inputbox"" type=""text"" />" & vbCrLf)
		Else
		Response.Write("				<span class=""file_text normal"" style=""width:auto;"">{fileDateTime}</span>" & vbCrLf)
		End If
		Response.Write("			</div>" & vbCrLf)
		If Request.Form("p") = "imageFiles" Then
		Response.Write("			<div class=""rows clearfix"" style=""width:437px;"">" & vbCrLf)
		Response.Write("				<span class=""file_text"" style=""width:100px;""><i class=""nokta"">:</i> Resim Boyutları</span>" & vbCrLf)
		Response.Write("				<span class=""file_text normal"" style=""width:auto;"">" & vbCrLf)
		Response.Write("				<label>Küçük <input name=""fileBoyut"" value=""{fileThumbPath}"" class=""radioMargin"" type=""radio"" onclick=""$('input[name=filePath]').val(this.value);"" /></label>&nbsp;&nbsp;" & vbCrLf)
		Response.Write("				<label>Orta <input name=""fileBoyut"" value=""{fileMediumPath}"" class=""radioMargin"" type=""radio"" onclick=""$('input[name=filePath]').val(this.value);"" /></label>&nbsp;&nbsp;" & vbCrLf)
		Response.Write("				<label>Büyük <input name=""fileBoyut"" value=""{fileLargePath}"" class=""radioMargin"" checked=""checked"" type=""radio"" onclick=""$('input[name=filePath]').val(this.value);"" /></label>" & vbCrLf)
		Response.Write("				</span>" & vbCrLf)
		Response.Write("			</div>" & vbCrLf)
		End If
		Response.Write("		</div>" & vbCrLf)
		Response.Write("		<div class=""clr""></div>" & vbCrLf)
		Response.Write("		<div class=""rows clearfix"">" & vbCrLf)
		Response.Write("			<label class=""lb"">" & vbCrLf)
		Response.Write("				<span class=""file_text""><i class=""nokta"">:</i> Dosya URL'si</span>" & vbCrLf)
		Response.Write("				<span class=""relative clearfix"">" & vbCrLf)
		Response.Write("					<input readonly=""readonly"" name=""filePath"" value=""{fileLargePath}"" class=""inputbox"" type=""text"" onclick=""iSelected(this);"" />" & vbCrLf)
		Response.Write("				</span>" & vbCrLf)
		Response.Write("			</label>" & vbCrLf)
		Response.Write("		</div>" & vbCrLf)
		Response.Write("		<div class=""rows clearfix"">" & vbCrLf)
		Response.Write("			<label class=""lb"">" & vbCrLf)
		Response.Write("				<span class=""file_text""><i class=""nokta"">:</i> Dosya Başlığı</span>" & vbCrLf)
		Response.Write("				" & vbCrLf)
		Response.Write("				<input name=""fileTitle"" value=""{fileTitle}"" class=""inputbox"" type=""text"" />" & vbCrLf)
		Response.Write("			</label>" & vbCrLf)
		Response.Write("		</div>" & vbCrLf)
		Response.Write("		<div class=""rows clearfix"">" & vbCrLf)
		Response.Write("			<label class=""lb"">" & vbCrLf)
		Response.Write("				<span class=""file_text""><i class=""nokta"">:</i> Alternatif Metin <i class=""ops"" title=""Opsiyonal"">(ops.)</i></span>" & vbCrLf)
		Response.Write("				" & vbCrLf)
		Response.Write("				<input name=""fileAlt"" value=""{fileAlt}"" class=""inputbox"" type=""text"" />" & vbCrLf)
		Response.Write("			</label>" & vbCrLf)
		Response.Write("		</div>" & vbCrLf)
		Response.Write("		<div class=""rows clearfix"">" & vbCrLf)
		Response.Write("			<label class=""lb"">" & vbCrLf)
		Response.Write("				<span class=""file_text""><i class=""nokta"">:</i> Özel Açıklama <i class=""ops"" title=""Opsiyonal"">(ops.)</i></span>" & vbCrLf)
		Response.Write("				" & vbCrLf)
		Response.Write("				<textarea name=""fileText"">{fileText}</textarea>" & vbCrLf)
		Response.Write("			</label>" & vbCrLf)
		Response.Write("		</div>" & vbCrLf)
		Response.Write("		<div class=""rows clearfix"">" & vbCrLf)
		Response.Write("			<label class=""lb"">" & vbCrLf)
		Response.Write("				<span class=""file_text""><i class=""nokta"">:</i> Özel Bağlantı Adresi <i class=""ops"" title=""Opsiyonal"">(ops.)</i></span>" & vbCrLf)
		Response.Write("				<input name=""fileUrl"" value=""{fileUrl}"" class=""inputbox"" type=""text"" />" & vbCrLf)
		Response.Write("			</label>" & vbCrLf)
		Response.Write("		</div>" & vbCrLf)
		Response.Write("		<div class=""rows submit_btn clearfix"">" & vbCrLf)
		Response.Write("			<span class=""a"">" & vbCrLf)
		Response.Write("				<img class=""loading_img"" src="""& GlobalConfig("vBase") &"images/loading.gif"" alt=""Lütfen Bekleyin..."" />" & vbCrLf)
		Response.Write("				<span class=""ie_btn""><input type=""submit"" class=""btn"" value=""Kaydet"" title=""Değişiklikleri Kaydet"" /></span>" & vbCrLf)
		Response.Write("			</span>" & vbCrLf)
		Response.Write("			<b id=""fileResult"" style=""float:left; margin-top:7px; display:none; color:#f00;""></b>" & vbCrLf)
		Response.Write("		</div>" & vbCrLf)
		Response.Write("		<div class=""clr""></div>" & vbCrLf)
		Response.Write("	</div>" & vbCrLf)
		Response.Write("	<div class=""clr""></div>" & vbCrLf)
		Response.Write("</div>") 
	Response.Write("</div>") 
Response.Write("</div>") 
Response.Write("</form>") 
%>











<%
If Request.Form("p") = "yyy" Then
%>
<div id="LoadFileEdit" class="">
<form id="fileUpdateSubmit" action="<%=GlobalConfig("vBase")%>index.asp?mod=redirect&amp;task=fileUpdate&amp;id={id}" method="post">
	<div class="file_list clearfix">
		<div class="file_list_wrap clearfix">
			<div class="file_body clearfix">
				<div class="menu_content">
					<div class="images"><img {fileStyle} class="medium_image" src="<%=GlobalConfig("vBase")%>images/blank.gif" /></div>
					<div style="float:left;">
						<div class="rows clearfix" style="width:437px;">
							<span class="file_text" style="width:100px;"><i class="nokta">:</i> Dosya İsmi</span>
							<input style="width:315px;" disabled="disabled" value="{fileName}" class="inputbox" type="text" />
						</div>
						<div class="rows clearfix" style="width:437px;">
							<span class="file_text" style="width:100px;"><i class="nokta">:</i> Dosya Türü</span>
							<span class="file_text normal" style="width:auto;">{fileMimeType}</span>
						</div>
						<div class="rows clearfix" style="width:437px;">
							<span class="file_text" style="width:100px;"><i class="nokta">:</i> Ekleme Tarihi</span><%
							If GlobalConfig("general_admin") Then
							%>
							<input style="width:130px;" name="fileDateTime" value="{fileDateTime}" class="inputbox" type="text" /><%
							
							Else
							%>
							<span class="file_text normal" style="width:auto;">{fileDateTime}</span><%
							
							End If
							%>
						</div>
					</div><%

					If Request.Form("p") = "imageFiles" Then
					%>
					<div class="rows clearfix" style="width:437px;">
						<span class="file_text" style="width:100px;"><i class="nokta">:</i> Resim Boyutları</span>
						<span class="file_text normal" style="width:auto;">
						<label>Küçük <input name="fileBoyut" value="{fileThumbPath}" class="radioMargin" type="radio" onclick="$('input[name=filePath]').val(this.value);" /></label>&nbsp;&nbsp;
						<label>Orta <input name="fileBoyut" value="{fileMediumPath}" class="radioMargin" type="radio" onclick="$('input[name=filePath]').val(this.value);" /></label>&nbsp;&nbsp;
						<label>Büyük <input name="fileBoyut" value="{fileLargePath}" class="radioMargin" checked="checked" type="radio" onclick="$('input[name=filePath]').val(this.value);" /></label>
						</span>
					</div><%

					End If
					%>
					<div class="clr"></div>
					<div class="rows clearfix">
						<label class="lb">
							<span class="file_text"><i class="nokta">:</i> Dosya URL'si</span>
							<span class="relative clearfix">
								<input readonly="readonly" name="filePath" value="{fileLargePath}" class="inputbox" type="text" />
							</span>
						</label>
					</div>
					<div class="rows clearfix">
						<label class="lb">
							<span class="file_text"><i class="nokta">:</i> Dosya Başlığı</span>
							<input name="fileTitle" value="{fileTitle}" class="inputbox" type="text" />
						</label>
					</div>
					<div class="rows clearfix">
						<label class="lb">
							<span class="file_text"><i class="nokta">:</i> Alternatif Metin <i class="ops" title="Opsiyonal">(ops.)</i></span>
							<input name="fileAlt" value="{fileAlt}" class="inputbox" type="text" />
						</label>
					</div>
					<div class="rows clearfix">
						<label class="lb">
							<span class="file_text"><i class="nokta">:</i> Özel Açıklama <i class="ops" title="Opsiyonal">(ops.)</i></span>
							<textarea name="fileText">{fileText}</textarea>
						</label>
					</div>
					<div class="rows clearfix">
						<label class="lb">
							<span class="file_text"><i class="nokta">:</i> Özel Bağlantı Adresi <i class="ops" title="Opsiyonal">(ops.)</i></span>
							<input name="fileUrl" value="{fileUrl}" class="inputbox" type="text" />
						</label>
					</div>
					<div class="rows submit_btn clearfix">
						<span class="a">
							<img class="loading_img" src="<%=GlobalConfig("vBase")%>images/loading.gif" alt="Lütfen Bekleyin..." />
							<span class="ie_btn"><input type="submit" class="btn" value="Kaydet" title="Değişiklikleri Kaydet" /></span>
						</span>
						<b id="fileResult" style="float:left; margin-top:7px; display:none; color:#f00;"></b>
					</div>
					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
		</div>
	</div>
</form>
</div>
<%
End If
%>












