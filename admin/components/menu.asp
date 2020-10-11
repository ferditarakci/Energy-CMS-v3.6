
<div class="notepad clearfix">
<table>
	<tr>
		<td width="50%" class="pageinfo menu">Menü yönetimi<%

If menutype <> "" Then
	strTitle = sqlQuery("SELECT title FROM #___content_menu_type WHERE durum = 1 And type = '"& menutype &"';", "")
	If strTitle <> "" Then Response.Write("<span> &raquo; "& strTitle &"</span>")
End If

%></td>
		<td width="50%">
			<div class="toolbar-list clearfix">
				<ul class="clearfix">
					<li><a id="listmenu_save" href="#" title="Sıralamayı Kaydet"><span class="save"></span>Sıralamayı Kaydet</a></li>
					<li><a id="settings" href="?mod=<%=mods%>_settings<%=Debug%>" title="Menü Ayarları"><span class="settings"></span>Menü Ayarları</a></li>
				</ul>
				<div class="clr"></div>
			</div>
		</td>
	</tr>
</table>
</div>

<%'clearfix GlobalConfig("site_lang")
Private Sub MenuList(ByVal strTbl, ByVal Parent, ByVal intAnaid, ByVal intLevel)
	Dim sSQL, objSubRs, y, tempSpaces, strSelected, strDisabled
	sSQL = ""
	sSQL = sSQL & "SELECT" & vbCrLf
	sSQL = sSQL & "    t1.id, t2.title, t2.parent, t2.lang" & vbCrLf
	sSQL = sSQL & "FROM #___"& strTbl &" As t1" & vbCrLf
	sSQL = sSQL & "INNER JOIN #___content As t2 ON t1.id = t2.parent_id" & vbCrLf
	sSQL = sSQL & "LEFT JOIN (SELECT durum, parent, parent_id, seflink FROM #___content_url WHERE lang = '"& GlobalConfig("site_lang") &"') As t3 ON t3.durum = 1 And t2.parent = t3.parent And t1.id = t3.parent_id And Not Left(t3.seflink, 4) = 'url='" & vbCrLf
	sSQL = sSQL & "WHERE (" & vbCrLf
	sSQL = sSQL & "    t1.anaid = "& intAnaid &"" & vbCrLf
	sSQL = sSQL & "    And t2.parent = "& Parent &"" & vbCrLf
	sSQL = sSQL & "    And t2.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	sSQL = sSQL & ")" & vbCrLf
	sSQL = sSQL & "ORDER BY t1.sira ASC, t1.id DESC;" & vbCrLf
	'sSQL = setQuery( sSQL )
	Set objSubRs = setExecute( sSQL )
	If objSubRs.Eof Then
		If intLevel = 0 Then  Response.Write("<div class=""warning""><div class=""messages""><span>Bu listede kayıt bulunamadı.</span></div></div>")
	Else

		Do While Not objSubRs.Eof
			tempSpaces = 15 * intLevel

			'strDisabled = ""
			'If (id = objSubRs("id")) Then strDisabled = " disabled=""disabled"""

			strTitle = BasHarfBuyuk(objSubRs("title"))

			Response.Write("<li style=""clear:left"" class=""clearfix"">")
				Response.Write("<input disabled=""disabled"" type=""hidden"" name=""id"" id=""menu_id_"& objSubRs("id") &""" value=""0"" />")
				Response.Write("<input disabled=""disabled"" type=""hidden"" name=""menu_parent"" id=""menu_parent_"& objSubRs("id") &""" value="""& objSubRs("parent") &""" />")
				Response.Write("<input disabled=""disabled"" type=""hidden"" name=""menu_lang"" id=""menu_lang_"& objSubRs("id") &""" value="""& objSubRs("lang") &""" />")
				Response.Write("<label class=""clearfix"" title="""& strTitle &""">")
				Response.Write("<input"& strDisabled &" style=""float:left; margin-left:"& tempSpaces &"px;"" type=""checkbox"" name=""menu_parentid"" value="""& objSubRs("id") &""" />")
				Response.Write("<span style=""float:left; margin-top:2px;"">"& KacKarekter(strTitle, 50) &"</span></label>")
			Response.Write("</li>")
			' onclick=""$(this).parent().parent().find('input').removeAttr('disabled');""
			MenuList strTbl, Parent, objSubRs("id"), intLevel + 1
		objSubRs.MoveNext() : Loop
	End If
	Set objSubRs = Nothing
End Sub
%>


<div class="notepad clearfix">
	<div id="menu_page" class="clearfix">
		<div class="menuleftbar">
			<!-- Add Page Menü -->
			<form class="EnergyAddMenu" data-menu-type="page" action="?mod=list_post&amp;task=menu&amp;menutype=<%=menutype & Debug%>" method="post">
				<div class="postbox" style="width:350px;">
					<div class="handle clearfix">
						<div class="on_off" title="Göster / Gizle" data-toggle-id="#menu_toggle_page" data-cookie="1">&nbsp;</div>
						<h3 class="h3_title">Sayfa Bağlantısı</h3>
					</div>
					<div class="menu_body clearfix">
						<div id="menu_toggle_page" class="menu_content clearfix">
							<div class="rows clearfix" style="overflow:auto; height:180px; margin-bottom:5px;">
								<ul class="menu_liste clearfix">
									<%
										Response.Write("<li style=""clear:left;"" class=""clearfix"">")
											Response.Write("<input type=""hidden"" name=""id"" id=""menu_id_home"" value=""0"" />")
											Response.Write("<input type=""hidden"" name=""menu_parent"" id=""menu_parent_home"" value="""& GlobalConfig("General_HomePN") &""" />")
											Response.Write("<input type=""hidden"" name=""menu_lang"" id=""menu_lang_home"" value="""& GlobalConfig("site_lang") &""" />")
											Response.Write("<label class=""clearfix"" title=""Ana Sayfa"">")
											Response.Write("<input style=""float:left; margin-left:0px;"" type=""checkbox"" name=""menu_parentid"" value=""0"" />")
											Response.Write("<span style=""float:left; margin-top:2px;"">Ana Sayfa</span></label>")
										Response.Write("</li>")

										Call MenuList("sayfa", GlobalConfig("General_PagePN"), 0, 0)
									%>
								</ul>
							</div>
							<div class="rows submit_btn clearfix">
								<span class="a">
									<img class="loading_img x" src="<%=GlobalConfig("vRoot")%>images/loading.gif" alt="Lütfen Bekleyin..." />
									<span class="ie_btn"><input type="submit" class="btn" value="Sayfayı Menüye Ekle" /></span>
								</span>
								<a class="private_link" href="#" title="Göster / Gizle" onclick="$(this).parents('form').find(':checkbox').toggleChecked(); return false;">Tümünü Seç</a>
							</div>
							<div class="clr"></div>
						</div>
						<div class="clr"></div>
					</div>
				</div>
			</form>
			<!-- /Add Page Menü -->

			<!-- Add Custom Menü -->
			<form class="EnergyAddMenu" data-menu-type="custom" action="?mod=list_post&amp;task=menu&amp;menutype=<%=menutype & Debug%>" method="post">
				<div class="postbox" style="width:350px;">
					<div class="handle clearfix">
						<div class="on_off" title="Göster / Gizle" data-toggle-id="#menu_toggle_custom" data-cookie="1">&nbsp;</div>
						<h3 class="h3_title">Özel Bağlantı</h3>
					</div>
					<div class="menu_body clearfix">
						<div id="menu_toggle_custom" class="menu_content">
							<div class="rows clearfix">
								<label class="lb" for="menu_url_custom" title="Örneğin: &quot;http://www.webtasarimx.net/&quot; şeklinde bir bağlantı girmelisiniz. — &quot;http://&quot; veya &quot;https://&quot; protokolünü yazmayı unutmayın.">
									<span class="menu_text">URL</span>
									<input name="menu_url" id="menu_url_custom" value="http://" class="inputbox" type="text" onblur="if($(this).val() == '') $(this).val('http:\/\/').css('color', '#aaa');" onfocus="if($(this).val() == 'http:\/\/') $(this).val('').css('color', '#2F3032');" />
								</label>
							</div>
							<div class="rows clearfix">
								<label class="lb" for="menu_tag_custom" title="Örneğin: &quot;Energy Web Tasarım&quot; şeklinde bir bağlantı etiketi girebilirsiniz.">
									<span class="menu_text">Etiket</span>
									<input name="menu_tag" id="menu_tag_custom" class="inputbox" type="text" />
								</label>
							</div>
							<div class="rows clearfix">
								<label class="lb" for="menu_title_custom" title="Kullanıcı fareyi bağlantı üzerine getirdiğinde tercihinize bağlı olarak bağlantının üzerinde ya da altında gözükecektir. Boş bırakıldığında &quot;Navigasyon Etiketi&quot; geçerli olacaktır.">
									<span class="menu_text">Title <i title="Opsiyonal">(ops.)</i></span>
									<input name="menu_title" id="menu_title_custom" class="inputbox" type="text" />
								</label>
							</div>
							<div class="rows clearfix">
								<label class="lb" for="menu_private_text_custom" title="Web tasarımınız destekliyorsa, açıklama menüde görüntülenir.">
									<span class="menu_text">Açıklama <i title="Opsiyonal">(ops.)</i></span>
									<textarea name="menu_private_text" id="menu_private_text_custom"></textarea>
								</label>
							</div>
							<div class="rows clearfix">
								<span class="menu_text" style="width:40px;" title="Bağlantının açılacağı hedef çerçeveyi seçin.">Hedef</span>
								<span class="menu_text" style="width:290px;">
									<label for="menu_target_custom_1" title="Aynı pencere ya da sekmede açılır.">
										target=&quot;&quot;
										<input name="menu_target" id="menu_target_custom_1" type="radio" value="0" checked="checked" class="radioMargin" />
									</label>&nbsp;
									<label for="menu_target_custom_2" title="Yeni pencerede ya da sekmede açılır.">
										target=&quot;_blank&quot;
										<input name="menu_target" id="menu_target_custom_2" type="radio" value="1" class="radioMargin" />
									</label>&nbsp;
									<label for="menu_target_custom_3" title="Frameli sayfalarda ana pencerede açılır.">
										target=&quot;_top&quot;
										<input name="menu_target" id="menu_target_custom_3" type="radio" value="2" class="radioMargin" />
									</label>
								</span>
							</div>
							<!--
							<div class="rows clearfix">
								<span class="menu_text" style="width:60px;">İlişki</span>
								<span class="menu_text" style="width:270px;">
									<label for="menu_rel_custom_1" title="Yeni pencerede ya da sekmede açılır.">
										rel=&quot;nofollow&quot;
										<input name="menu_rel" id="menu_rel_custom_1" type="checkbox" value="1" class="radioMargin" />
									</label>&nbsp;
									<label for="menu_rel_custom_2" title="Diğer internet adresiniz ise seçin.">
										rel=&quot;me&quot;
										<input name="menu_rel" id="menu_rel_custom_2" type="checkbox" value="2" class="radioMargin" />
									</label>&nbsp;
									<label for="menu_rel_custom_3" title="Aynı pencere ya da sekmede açılır.">
										rel=&quot;lightbox&quot;
										<input name="menu_rel" id="menu_rel_custom_3" type="checkbox" value="3" class="radioMargin" />
									</label>
								</span>
							</div>
							-->
							<div class="rows clearfix">
								<label class="lb" for="menu_rel_custom" title="Örneğin arama motorlarının eklediğiniz bir bağlantıyı takip etmesini engellemek için &quot;nofollow&quot; değerini girebilirisiz.">
									<span class="menu_text">İlişki <i title="Opsiyonal">(ops.)</i></span>
									<input name="menu_rel" id="menu_rel_custom" class="inputbox" type="text" />
								</label>
							</div>
							<div class="rows clearfix">
								<label class="lb" for="menu_class_custom" title="Menü için özel bir sınıf belirlenmiş ise buraya sınıf adını girin.">
									<span class="menu_text">CSS Sınıf <i title="Opsiyonal">(ops.)</i></span>
									<input name="menu_class" id="menu_class_custom" class="inputbox" type="text" />
								</label>
							</div>
							<div class="rows clearfix">
								<label class="lb" for="menu_style_custom" title="Menü için özel bir stil belirlemek istiyorsanız buraya css stilini girin.">
									<span class="menu_text">CSS Stil <i title="Opsiyonal">(ops.)</i></span>
									<input name="menu_style" id="menu_style_custom" class="inputbox" type="text" />
								</label>
							</div>

							<div class="rows submit_btn clearfix">
								<span class="a">
									<img class="loading_img x" src="<%=GlobalConfig("vRoot")%>images/loading.gif" alt="Lütfen Bekleyin..." />
									<span class="ie_btn"><input type="submit" class="btn" value="Özel Menüyü Oluştur" /></span>
								</span>
							</div>
							<div class="clr"></div>
						</div>
						<div class="clr"></div>
					</div>
				</div>
				<input type="hidden" name="id" value="0" />
				<input type="hidden" name="menu_anaid" value="0" />
				<input type="hidden" name="menu_lang" value="<%=GlobalConfig("site_lang")%>" />
				<input type="hidden" name="menu_parent" value="<%=GlobalConfig("General_CustomURLPN")%>" />
				<input type="hidden" name="menu_parentid" value="0" />
			</form>
			<!-- /Add Custom Menü -->

	<%If GlobalConfig("urun_yonetimi") Then%>
			<!-- Add Categories Menü -->
			<form class="EnergyAddMenu" data-menu-type="kategori" action="?mod=list_post&amp;task=menu&amp;menutype=<%=menutype & Debug%>" method="post">
				<div class="postbox" style="width:350px;">
					<div class="handle clearfix">
						<div class="on_off" title="Göster / Gizle" data-toggle-id="#menu_toggle_categories" data-cookie="1">&nbsp;</div>
						<h3 class="h3_title">Kategori Bağlantısı</h3>
					</div>
					<div class="menu_body clearfix">
						<div id="menu_toggle_categories" class="menu_content hidden">
							<div class="rows clearfix" style="overflow:auto; height:180px; margin-bottom:5px;">
								<ul class="menu_liste clearfix">
									<%
										'Response.Write("<li style=""clear:left"">")
										'	Response.Write("<input type=""hidden"" name=""id"" id=""menu_id_home"" value=""0"" />")
										'	Response.Write("<input type=""hidden"" name=""menu_parent"" id=""menu_parent_home"" value="""& GlobalConfig("General_HomePN") &""" />")
										'	Response.Write("<input type=""hidden"" name=""menu_lang"" id=""menu_lang_home"" value="""& GlobalConfig("site_lang") &""" />")
										'	Response.Write("<label class=""clearfix"" title=""Ana Sayfa"">")
										'	Response.Write("<input style=""float:left; margin-left:0px;"" type=""checkbox"" name=""menu_parentid"" value=""0"" />")
										'	Response.Write("<span style=""float:left; margin-top:2px;"">Ana Sayfa</span></label>")
										'Response.Write("</li>")
										Call MenuList("kategori", GlobalConfig("General_CategoriesPN"), 0, 0)
									%>
								</ul>
							</div>
							<div class="rows submit_btn clearfix">
								<span class="a">
									<img class="loading_img x2" src="<%=GlobalConfig("vRoot")%>images/loading.gif" alt="Lütfen Bekleyin..." />
									<span class="ie_btn"><input type="submit" class="btn" value="Kategoriyi Menüye Ekle" /></span>
								</span>
								<a class="private_link" href="#" title="Göster / Gizle" onclick="$(this).parents('form').find(':checkbox').toggleChecked(); return false;">Tümünü Seç</a>
							</div>
							<div class="clr"></div>
						</div>
						<div class="clr"></div>
					</div>
				</div>
			</form>
			<!-- /Add Categories Menü -->

			<!-- Add Products Menü -->
			<form class="EnergyAddMenu" data-menu-type="urun" action="?mod=list_post&amp;task=menu&amp;menutype=<%=menutype & Debug%>" method="post">
				<div class="postbox" style="width:350px;">
					<div class="handle clearfix">
						<div class="on_off" title="Göster / Gizle" data-toggle-id="#menu_toggle_products" data-cookie="1">&nbsp;</div>
						<h3 class="h3_title">Ürün Bağlantısı</h3>
					</div>
					<div class="menu_body clearfix">
						<div id="menu_toggle_products" class="menu_content hidden">
							<div class="rows clearfix" style="overflow:auto; height:180px; margin-bottom:5px;">
								<ul class="menu_liste clearfix">
									<%
										'Response.Write("<li style=""clear:left"">")
										'	Response.Write("<input type=""hidden"" name=""id"" id=""menu_id_home"" value=""0"" />")
										'	Response.Write("<input type=""hidden"" name=""menu_parent"" id=""menu_parent_home"" value="""& GlobalConfig("General_HomePN") &""" />")
										'	Response.Write("<input type=""hidden"" name=""menu_lang"" id=""menu_lang_home"" value="""& GlobalConfig("site_lang") &""" />")
										'	Response.Write("<label class=""clearfix"" title=""Ana Sayfa"">")
										'	Response.Write("<input style=""float:left; margin-left:0px;"" type=""checkbox"" name=""menu_parentid"" value=""0"" />")
										'	Response.Write("<span style=""float:left; margin-top:2px;"">Ana Sayfa</span></label>")
										'Response.Write("</li>")
										Call MenuList("products", GlobalConfig("General_ProductsPN"), 0, 0)
									%>
								</ul>
							</div>
							<div class="rows submit_btn clearfix">
								<span class="a">
									<img class="loading_img x" src="<%=GlobalConfig("vRoot")%>images/loading.gif" alt="Lütfen Bekleyin..." />
									<span class="ie_btn"><input type="submit" class="btn" value="Ürünü Menüye Ekle" /></span>
								</span>
								<a class="private_link" href="#" title="Göster / Gizle" onclick="$(this).parents('form').find(':checkbox').toggleChecked(); return false;">Tümünü Seç</a>
							</div>
							<div class="clr"></div>
						</div>
						<div class="clr"></div>
					</div>
				</div>
			</form>
			<!-- /Add Products Menü -->
<%End If%>

		</div> <!-- .menuleftbar End -->



		<div class="menurightbar">
			<div class="menuright-body">
				<div id="menu_list" class="menu_list clearfix">
<%
SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	a.id, a.anaid, a.parent, a.parent_id, a.menu_id, a.lang, b.id As typeid, " & vbCrLf
SQL = SQL & "	IF((a.menu_tag = '' Or a.menu_tag is Null), c.title, a.menu_tag) As menu_tag," & vbCrLf
SQL = SQL & "	IFNULL(a.title_attr, '') As title_attr," & vbCrLf
SQL = SQL & "	IFNULL(a.text_value, '') As text_value," & vbCrLf
SQL = SQL & "	IFNULL(a.rel_attr, '') As rel_attr," & vbCrLf
SQL = SQL & "	IFNULL(a.css_class, '') As css_class," & vbCrLf
SQL = SQL & "	IFNULL(a.css_style, '') As css_style," & vbCrLf
SQL = SQL & "	IFNULL(c.title, '') As orjtitle," & vbCrLf
SQL = SQL & "	a.menu_target" & vbCrLf
SQL = SQL & "FROM #___content_menu As a" & vbCrLf
SQL = SQL & "INNER JOIN #___content_menu_type As b ON a.menu_id = b.id" & vbCrLf
SQL = SQL & "LEFT JOIN (SELECT parent, parent_id, title FROM #___content WHERE lang = '"& GlobalConfig("site_lang") &"') As c ON c.parent = a.parent And c.parent_id = a.parent_id" & vbCrLf
'SQL = SQL & "LEFT JOIN #___content_menu As d ON a.id = d.anaid" & vbCrLf
SQL = SQL & "WHERE (" & vbCrLf
SQL = SQL & "	b.durum = 1" & vbCrLf
SQL = SQL & "	And a.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
SQL = SQL & "	And b.type = '"& menutype &"'" & vbCrLf
SQL = SQL & "	And a.anaid = {0}" & vbCrLf
SQL = SQL & ")" & vbCrLf
SQL = SQL & "ORDER BY a.sira ASC;"
'Clearfix setQuery(SQL)

Response.Write("<ul id=""menu_sortable"" class=""clearfix"">")
AdminMenuList SQL, 0, 0
Response.Write("</ul>")


Private Sub AdminMenuList(ByVal SQLs, ByVal intAnaid, ByVal intLevel)
	Dim SQL, objSubRs, strSayfaTuru, strDirection, strOrjTitle, strOrjTitle2

	SQL = Replace(SQLs, "{0}", intAnaid)
	Set objSubRs = setExecute( SQL )
	
	If objSubRs.Eof Then
		If intLevel = 0 Then  Response.Write("<div style=""margin-top:30px;"" class=""warning""><div class=""messages""><span>Bu menüde şuan kayıt bulunamadı.</span></div></div>")
	Else
		'If intLevel > 0 Then Response.Write("<ul>")

		Do While Not objSubRs.Eof

			strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " dir=""rtl"" lang=""ar"" xml:lang=""ar"""
			'strDirection = "" : If GlobalConfig("site_lang") = "AR" Then strDirection = " class=""rtl"""

			strTitle = objSubRs("menu_tag")
			strTitle2 = KacKarekter(strTitle, 50)

			strOrjTitle = objSubRs("orjtitle")
			'strOrjTitle2 = strOrjTitle

			GlobalConfig("General_Parent") = ParentNumber(objSubRs("parent"))
			'clearfix GlobalConfig("General_Parent")

			Select Case GlobalConfig("General_Parent")
				Case GlobalConfig("General_Home") strSayfaTuru = "Ana Sayfa" : strOrjTitle = "Ana Sayfa"
				Case GlobalConfig("General_Page") strSayfaTuru = "Sayfa"
				Case GlobalConfig("General_CustomURL") strSayfaTuru = "Özel"
				Case GlobalConfig("General_Categories") strSayfaTuru = "Kategori"
				Case GlobalConfig("General_Products") strSayfaTuru = "Ürün"
				Case GlobalConfig("General_Banner") strSayfaTuru = "Banner"
				Case GlobalConfig("General_Poll") strSayfaTuru = "Anket"
				Case Else strSayfaTuru = "Diğer"
			End Select

			strOrjTitle = BasHarfBuyuk(strOrjTitle)
			strOrjTitle2 = KacKarekter(strOrjTitle, 50)

			'strOrjTitle = strTitle
			'strOrjTitle2 = strTitle2
			'If GlobalConfig("General_Parent") = GlobalConfig("General_Home") Then
			'	strOrjTitle = BasHarfBuyuk(objSubRs("orjtitle"))
			'	strOrjTitle2 = KacKarekter(strOrjTitle, 50)
			'End If

			'Select Case Cdbl(objSubRs("parent"))
			'	Case GlobalConfig("General_HomePN") GlobalConfig("General_Parent") = GlobalConfig("General_Home")
			'	Case GlobalConfig("General_PagePN") GlobalConfig("General_Parent") = GlobalConfig("General_Page")
			'	Case GlobalConfig("General_CategoriesPN") GlobalConfig("General_Parent") = GlobalConfig("General_Categories")
			'	Case GlobalConfig("General_ProductsPN") GlobalConfig("General_Parent") = GlobalConfig("General_Products")
			'	Case GlobalConfig("General_PollPN") GlobalConfig("General_Parent") = GlobalConfig("General_Poll")
			'	Case GlobalConfig("General_CustomURLPN") GlobalConfig("General_Parent") = GlobalConfig("General_CustomURL")
			'End Select
			
			If GlobalConfig("General_Parent") = GlobalConfig("General_CustomURL") Then
				strLink = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Parent"), "", "", objSubRs("id"), "", "")
			Else
				strLink = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Parent"), "", "", objSubRs("parent_id"), "", "")
			End If
			'clearfix GlobalConfig("General_Parent")
			strLink = Replace(UrlDecode(strLink), "url=", "")

			'Response.Write("<tr id=""trid_"& objSubRs("menuid") &""" class="""& TabloModClass(intCounter) &""">" & vbcrlf) 
			'Response.Write("		<td><label style=""display:block;"" for=""cb"& intCounter-1 &""">"& intCounter &"</label></td>" & vbcrlf) 
			'Response.Write("		<td><input id=""cb"& intCounter-1 &""" onclick=""isChecked("& intCounter-1 &")"" name=""postid[]"" value="""& objSubRs("menuid") &""" type=""checkbox"" /></td>" & vbcrlf) 
			'Response.Write("		<td class=""left"">"& tempSpaces &" <div "& strDirection &"style=""display:inline;"" id=""u"& objSubRs("id") &""">"& strTitle &"</div>"& ZamanAsimi &"</td>" & vbcrlf) 
			'Response.Write("		<td><input class=""inputbox list-order"" id=""order_"& objSubRs("menuid") &""" name=""order[]"" value="""& objSubRs("sira") &""" maxlength=""3"" type=""text"" /></td>" & vbcrlf) 
			'Response.Write("		<td class=""left"">"& strSayfaTuru &"</td>" & vbcrlf) 
			'Response.Write("		<td class=""left nowrap"">"& objSubRs("TypeTitle") &"</td>" & vbcrlf) 
			'Response.Write("		<td>"& objSubRs("id") &"</td>" & vbcrlf)
			'Response.Write("		<td><a class=""url_list"" href=""?mod=url_list&amp;parent="& objSubRs("parent") &"&amp;parent_id="& objSubRs("id") & sLang &""" data-title="""& objSubRs("title") &""" title=""URL Liste"">URL Liste</a></td>" & vbcrlf) 
			'Response.Write("		<td><a class=""list-edit-icon"" href=""?mod="& objSubRs("parent") &"&amp;task=edit&amp;id="& objSubRs("id") & sLang &""" title=""Düzenle"">Düzenle</a></td>" & vbcrlf) 
			'Response.Write("		<td><a class=""list-delete-icon taskListSubmit"" data-number="""& intCounter-1 &""" data-status=""delete"" data-apply="""" title=""Menü Bağlantısını Kaldır"">Menü Bağlantısını Kaldır</a></td>" & vbcrlf) 
			'Response.Write("	</tr>" & vbcrlf)

%>
				<li id="menuid_<%=objSubRs("id")%>" class="clearfix">
					<form id="EnergyMenuList_<%=objSubRs("id")%>" class="EnergyAddMenu clearfix" data-menu-type="list" action="?mod=list_post&amp;task=menu&amp;menutype=<%=menutype & Debug%>" method="post">
						<div class="postbox" style="width:450px;">
							<div class="handle clearfix">
								<div class="on_off" title="Göster / Gizle" data-toggle-id="#menu_toggle_<%=objSubRs("id")%>" data-cookie="0">&nbsp;</div>
								<h3 class="h3_title" title="<%=BasHarfBuyuk(strTitle)%>">
									<a id="menu_remove2_<%=objSubRs("id")%>" class="menu_remove" href="#" title="Bu Menüyü Sil"><i class="hidden">Sil</i></a>
									<span><%=strSayfaTuru%></span>
									<%=BasHarfBuyuk(strTitle2)%>
								</h3>
							</div>
							<div class="menu_body clearfix">
								<div id="menu_toggle_<%=objSubRs("id")%>" class="menu_content hidden">
									<%
									If GlobalConfig("General_Parent") = GlobalConfig("General_CustomURL") Then
									%>
									<div class="rows clearfix">
										<label class="lb" for="menu_url_<%=objSubRs("id")%>" title="Örneğin: &quot;http://www.webtasarimx.net/&quot; şeklinde bir bağlantı girmelisiniz. — &quot;http://&quot; veya &quot;https://&quot; protokolünü yazmayı unutmayın.">
											<span class="menu_text">Navigasyon URL'si</span>
											<input name="menu_url" id="menu_url_<%=objSubRs("id")%>" value="<%=strLink%>" class="inputbox" type="text" onblur="if($(this).val() == '') $(this).val('http:\/\/').css('color', '#aaa');" onfocus="if($(this).val() == 'http:\/\/') $(this).val('').css('color', '#2F3032');" />
										</label>
									</div>
									<%Else%>
									<div class="rows clearfix">
										<span class="menu_text" title="Orjinal bağlantıları değiştirmek için geçerli kaydı düzenleme sayfasına gidin.">Orjinal Bağlantı</span>
										<a class="private_link" href="<%=strLink%>" target="_blank" title="<%=strOrjTitle%>"><%=strOrjTitle2%></a>
									</div>
									<%End If%>
									<div class="rows clearfix">
										<label class="lb" for="menu_tag_<%=objSubRs("id")%>" title="Örneğin: &quot;Energy Web Tasarım&quot; şeklinde bir bağlantı etiketi girebilirsiniz.">
											<span class="menu_text">Navigasyon Etiketi</span>
											<input name="menu_tag"<%=strDirection%> id="menu_tag_<%=objSubRs("id")%>" value="<%=strTitle%>" class="inputbox" type="text" />
										</label>
									</div>
									<div class="rows clearfix">
										<label class="lb" for="menu_title_<%=objSubRs("id")%>" title="Kullanıcı fareyi bağlantı üzerine getirdiğinde tercihinize bağlı olarak bağlantının üzerinde ya da altında gözükecektir. Boş bırakıldığında &quot;Navigasyon Etiketi&quot; geçerli olacaktır.">
											<span class="menu_text">Title Özniteliği</span>
											<input name="menu_title"<%=strDirection%> id="menu_title_<%=objSubRs("id")%>" value="<%=objSubRs("title_attr")%>" class="inputbox" type="text" />
										</label>
									</div>
									<div class="rows clearfix">
										<label class="lb" for="menu_private_text_<%=objSubRs("id")%>" title="Web tasarımınız destekliyorsa, açıklama menüde görüntülenir.">
											<span class="menu_text">Özel Açıklama <i title="Opsiyonal">(ops.)</i></span>
											<textarea name="menu_private_text"<%=strDirection%> id="menu_private_text_<%=objSubRs("id")%>"><%=objSubRs("text_value")%></textarea>
										</label>
									</div>
									<div class="rows clearfix">
										<span class="menu_text" title="Bağlantının açılacağı hedef çerçeveyi seçin.">Navigasyon Hedefi</span>
										<span class="menu_text" style="width:310px;">
											<label for="menu_target_<%=objSubRs("id")%>_1" title="Aynı pencere ya da sekmede açılır.">
												target=&quot;&quot;
												<input name="menu_target"<%=strDirection%> id="menu_target_<%=objSubRs("id")%>_1" type="radio" value="0"<%=eChecked(objSubRs("menu_target") = 0)%> class="radioMargin" />
											</label>&nbsp;
											<label for="menu_target_<%=objSubRs("id")%>_2" title="Yeni pencerede ya da sekmede açılır.">
												target=&quot;_blank&quot;
												<input name="menu_target" id="menu_target_<%=objSubRs("id")%>_2" type="radio" value="1"<%=eChecked(objSubRs("menu_target") = 1)%> class="radioMargin" />
											</label>&nbsp;
											<label for="menu_target_<%=objSubRs("id")%>_3" title="Frameli sayfalarda ana pencerede açılır.">
												target=&quot;_top&quot;
												<input name="menu_target" id="menu_target_<%=objSubRs("id")%>_3" type="radio" value="2"<%=eChecked(objSubRs("menu_target") = 2)%> class="radioMargin" />
											</label>
										</span>
									</div>
									<div class="rows clearfix">
										<label class="lb" for="menu_rel_<%=objSubRs("id")%>" title="Örneğin arama motorlarının eklediğiniz bir bağlantıyı takip etmesini engellemek için &quot;nofollow&quot; değerini girebilirisiz.">
											<span class="menu_text">Bağlantı İlişkisi <i title="Opsiyonal">(ops.)</i></span>
											<input name="menu_rel" id="menu_rel_<%=objSubRs("id")%>" value="<%=objSubRs("rel_attr")%>" class="inputbox" type="text" />
										</label>
									</div>
									<div class="rows clearfix">
										<label class="lb" for="menu_class_<%=objSubRs("id")%>" title="Menü için özel bir sınıf belirlenmiş ise buraya sınıf adını girin.">
											<span class="menu_text">CSS Sınıf <i title="Opsiyonal">(ops.)</i></span>
											<input name="menu_class" id="menu_class_<%=objSubRs("id")%>" value="<%=objSubRs("css_class")%>" class="inputbox" type="text" />
										</label>
									</div>
									<div class="rows clearfix">
										<label class="lb" for="menu_style_<%=objSubRs("id")%>" title="Menü için özel bir stil belirlemek istiyorsanız buraya css stilini girin.">
											<span class="menu_text">CSS Stil <i title="Opsiyonal">(ops.)</i></span>
											<input name="menu_style" id="menu_style_<%=objSubRs("id")%>" value="<%=objSubRs("css_style")%>" class="inputbox" type="text" />
										</label>
									</div>
									<div class="rows submit_btn clearfix">
										<span class="a">
											<img class="loading_img" src="<%=GlobalConfig("vRoot")%>images/loading.gif" alt="Lütfen Bekleyin..." />
											<span class="ie_btn"><input type="submit" class="addUrlSubmit btn" value="Menüyü Kaydet" /></span>
										</span>
										<span class="b">
											<a id="menu_remove_<%=objSubRs("id")%>" class="menu_remove" href="#" title="Bu Menüyü Sil">Menüyü Sil</a>
										</span>
									</div>
									<div class="clr"></div>
								</div>
								<div class="clr"></div>
							</div>
						</div>
						
						<input type="hidden" name="id" value="<%=objSubRs("id")%>" />
						<input type="hidden" name="menu_anaid" value="<%=objSubRs("anaid")%>" />
						<input type="hidden" name="menu_lang" value="<%=objSubRs("lang")%>" />
						<input type="hidden" name="menu_parent" value="<%=objSubRs("parent")%>" />
						<input type="hidden" name="menu_parentid" value="<%=objSubRs("parent_id")%>" />
					</form>
					<div class="ie7MarginFix clearfix"></div>
					<ul class="sublist clearfix">
						<%
							AdminMenuList SQLs, objSubRs("id"), intLevel + 1
						%>
					</ul>
				</li>
<%
		objSubRs.MoveNext() : Loop
		'If intLevel > 0 Then Response.Write("</ul>" & vbcrlf) 

	End If
Set objSubRs = Nothing
End Sub

%>


				</div> <!-- #menu_list End -->
			</div> <!-- .menuright-body End -->
		</div> <!-- .menurightbar End -->

	</div> <!-- .clearfix End -->

</div> <!-- .notepad End -->


