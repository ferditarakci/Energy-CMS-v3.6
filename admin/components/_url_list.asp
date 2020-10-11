<!--#include file="header.asp"-->
<style type="text/css">
/*html { overflow:auto !important; }*/
ol.text {margin:0 0 0 10px; padding:4px 0 4px 20px; text-shadow:none;}
ol.text li {margin:0; padding:0px 0 0px 0px; font-size:12px; font-weight:700;}
</style>
</head>
<body>
<%
parent = intYap(parent, 0)
If parent = GlobalConfig("General_PollPN") Then

	SQL = ""
	SQL = SQL & "SELECT t2.title, t1.seflink, t1.id, t1.parent, t1.parent_id, t1.lang, t1.durum" & vbCrLf
	SQL = SQL & "FROM #___content_url t1" & vbCrLf
	SQL = SQL & "INNER JOIN #___anket t2 ON t1.parent_id = t2.id" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "t1.parent = "& parent &"" & vbCrLf
	SQL = SQL & "And t1.parent_id = "& parent_id &"" & vbCrLf
	SQL = SQL & "And t1.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "And t2.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & ") ORDER BY t1.id ASC;"

Else

	SQL = ""
	SQL = SQL & "SELECT t2.title, t1.seflink, t1.id, t1.parent, t1.parent_id, t1.lang, t1.durum" & vbCrLf
	SQL = SQL & "FROM #___content_url t1" & vbCrLf
	SQL = SQL & "INNER JOIN #___content t2 ON t1.parent_id = t2.parent_id And t1.parent = t2.parent" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "t1.parent = "& parent &"" & vbCrLf
	SQL = SQL & "And t1.parent_id = "& parent_id &"" & vbCrLf
	SQL = SQL & "And t1.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & "And t2.lang = '"& GlobalConfig("site_lang") &"'" & vbCrLf
	SQL = SQL & ") ORDER BY t1.id ASC;"

End If

'SQL = setQuery( SQL )
'Clearfix SQL
Set objRs = setExecute( SQL )
If objRs.Eof Then

	Response.Write("<div class=""notepad clearfix""><div class=""warning""><div class=""messages""><span>Kayıt bulunamadı.</span></div></div></div>")

Else
%>

<form id="EnergyForm_<%=SifreUret( 10 )%>" action="<%=GlobalConfig("site_uri")%>" method="post" onsubmit="return false;">

<div style="margin-right:0;" class="maincolumn clearfix">
	<div style="margin-right:0;" class="maincolumn-body clearfix">
		<div class="m_box clearfix">
			<div class="title clearfix">
				<span class="refresh"><a href="#" onclick="window.location.reload(); return false;" title="Yenile">Yenile</a></span>
				<span class="addLink" style="float:right;"><a id="addNewLink" data-parent="<%=objRs("parent")%>" data-parentid="<%=objRs("parent_id")%>" href="#" onclick="return false;" title="Yeni Ekle">Ekle</a></span> 
				<h3 style="font-size:11px;" class="box-title">Permalink: &quot;<%=objRs("title")%>&quot;</h3>
			</div>
			<div class="head clearfix">
				<div class="form-table clearfix">
<%
i = 1
While Not objRs.Eof

strChecked = ""
If Cbool(objRs("durum")) Then strChecked = " checked"

Response.Write("	<div class=""row clearfix"">" & vbcrlf) 
Response.Write("		<div class=""l clearfix"" style=""padding-top:4px;""><label for=""url_"& objRs("id") &"""><span>:</span>Permalink #"& i &"</label></div>" & vbcrlf) 
Response.Write("		<div class=""r clearfix"" style=""overflow:hidden;"">" & vbcrlf)
Response.Write("			<div style=""float:right; width:13%; height:25px; margin-left:5px; padding-top:5px;"">" & vbcrlf)
Response.Write("				<a id=""url-status-"& objRs("id") &""" class=""url_status "& StatusStyle(objRs("durum"), "list-passive-icon", "list-active-icon") &""" style=""float: right; margin-left:10px;"" href=""?mod=redirect&amp;task=url_status&amp;id="& objRs("id") &"&amp;parent="& objRs("parent")  &"&amp;parent_id="& objRs("parent_id") & sLang & Debug &""" title=""Varsayılan bağlantı yap"">Varsayılan bağlantı yap</a>" & vbcrlf) 
Response.Write("				<a id=""url-save-"& objRs("id") &""" class=""url_save"" style=""float: right; margin-left:5px;"" href=""?mod=redirect&amp;task=url_save&amp;id="& objRs("id") &"&amp;parent="& objRs("parent") &"&amp;parent_id="& objRs("parent_id") & sLang & Debug &""" title=""Bağlantı kaydet"">Bağlantı kaydet</a>" & vbcrlf) 
'Response.Write("				<small id=""small_"& objRs("id") &""" style=""float:left; width:16px; height:16px; margin-left:5px; margin-right:5px;""></small>" & vbcrlf) 
Response.Write("			</div>" & vbcrlf)
Response.Write("			<div style=""float:left; width:84%; height:25px;"">" & vbcrlf)
Response.Write("				<input style=""width:100%;"" class=""inputbox url-text"" id=""url-text-"& objRs("id") &""" value="""& URLDecode(objRs("seflink")) &""" autocomplete=""off"" type=""text"" />" & vbcrlf) 
Response.Write("			</div>" & vbcrlf) 
Response.Write("		</div>" & vbcrlf) 
Response.Write("	</div>") 
i = i + 1
objRs.MoveNext() : Wend
%>

				</div>
			</div>
		</div>
	</div>
</div>
<div class="maincolumn" style="margin-right:-4px">
	<div class="maincolumn-body" style="margin-right:4px">
		<div class="m_box">
			<div class="head clearfix">
				<div class="form-table clearfix">
					<ol class="text">
						<li>Durumu pasif olan permalinke tıklandığında aktif olan permalinke yönlenir.</li>
						<li>Yeni bir permalink eklediğinizde diğerlerinin durumu otomatik pasik olarak değiştirilir.</li>
						<li>Permalinkleri silemezsiniz ancak varolan permalinki değiştirebilirsiniz.</li>
						<li style="list-style:none;">Not: Bağlantılarınızın her daim aktif olması için permalinkleri değiştirmenizi önermeyiz.</li>
						<li style="list-style:none;">Bunun yerine yeni bir permalink oluşturabilirsiniz</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
</form>

<div id="system-message" class="hidden">

	<div class="messages">

		<span>Energy Web Yazılım</span>

		<div class="close"></div>

	</div>

</div>


<%
End If
Set objRs = Nothing

%>
	</body>
</html>
