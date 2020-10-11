<!--#include file="header.asp"-->
		<style type="text/css">
			/*html { overflow:hidden !important; }*/
			.form-table ul {float:left; margin:0; padding:0; list-style:none;}
			.form-table li {margin:0; padding:7px !important; font-weight:bold; border-bottom:2px solid #eee;}
			.form-table li span {float:left; width:160px; display:block; padding-right:4px;}
			.form-table li span em {float:right; width:8px; font-style:normal;}
			.form-table li em {font-style:normal;}
			.form-table li .mini {font-size:9px;}
			.form-table li pre {width:350px; font-size:12px; line-height:15px; border-width:1px; white-space:pre-wrap;}
		</style>
	</head>
	<body>

		<div class="maincolumn" style="margin-right:0px">
			<div class="maincolumn-body" style="margin-right:0px">

				<div class="m_box">
					<div class="title"><span class="refresh"><a href="#" onclick="window.location.reload(); return false;" title="Yenile">Yenile</a></span> <h3 class="box-title">Sistem Özellikleri</h3></div>
					<div class="head clearfix">
						<div class="form-table clearfix" style="background:url(<%=GlobalConfig("vRoot")%>images/energy-logo.png) no-repeat center 40px;">
							<ul style="float:right;">
								<li>
									<span>
										<em>:</em>
										Persits AspUpload
									</span>
									<%=testObject("Persits.Upload")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Persits AspJpeg
									</span>
									<%=testObject("Persits.JPEG")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Persits AspEmail
									</span>
									<%=testObject("Persits.MailSender")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Persits AspPDF
									</span><%
									'Response.write Not Server.CreateObject("JMail.Message") is Nothing
									'dim sss
									'set sss = server.createobject("Persits.Pdf")
									'sss.RegKey = "38159-u7679-50228"
									%>
									<%=testObject("Persits.Pdf")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Persits AspEncrypt
									</span>
									<%=testObject("Persits.CryptoManager")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Persits AspGrid
									</span>
									<%=testObject("Persits.Grid")%>
								</li>
								<li>
									<span>
										<em>:</em>
										CDOSYS Mail
									</span>
									<%=testObject("CDO.Message")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Dimac JMail
									</span>
									<%=testObject("JMail.Message")%>
								</li>
								<li>
									<span>
										<em>:</em>
										CDONTS Mail
									</span>
									<%=testObject("CDONTS.NewMail")%>
								</li>
							</ul>
							<ul style="float:left;">
								<li>
									<span>
										<em>:</em>
										Sunucu Tarihi / Saati
									</span>
									<%=Now()%>
								</li>
								<li>
									<span>
										<em>:</em>
										Sunucu Yazılımı
									</span>
									<%=Request.ServerVariables("SERVER_SOFTWARE")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Sayfa Kodlaması
									</span>
									<%=Response.LCid & " / " & Response.CodePage & " - " & UCase(Response.CharSet) & " / " & Response.ContentType%>
								</li>
								<li>
									<span>
										<em>:</em>
										Protocol
									</span>
									<%=Request.ServerVariables("SERVER_PROTOCOL")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Host
									</span>
									<%=Request.ServerVariables("HTTP_HOST")%>
								</li>
								<li>
									<span>
										<em>:</em>
										İstemci IP Adresi
									</span>
									<%=Request.ServerVariables("REMOTE_HOST")%>
								</li>
								<li>
									<span>
										<em>:</em>
										Snucu IP Adresi
									</span>
									<%=Request.ServerVariables("LOCAL_ADDR")%>
								</li><%If GlobalConfig("general_admin") Then%>
								<li>
									<span>
										<em>:</em>
										FTP Boyutu
									</span>
									<% Dim strAPPL_PHYSiCAL_PATH, FtpBoyutu
									strAPPL_PHYSiCAL_PATH = Request.ServerVariables("APPL_PHYSiCAL_PATH")
									strAPPL_PHYSiCAL_PATH = Left(strAPPL_PHYSiCAL_PATH, inStrRev(Left(strAPPL_PHYSiCAL_PATH, Len(strAPPL_PHYSiCAL_PATH)-1), "\"))
									FtpBoyutu = Server.Createobject("Scripting.FileSystemObject").GetFolder(strAPPL_PHYSiCAL_PATH).Size %>
									<%=FormatNumber(MaxBytes(FtpBoyutu), 2) & " MB" & "<i style=""font-style:normal; color:#a2a2a2;""> ( " & FormatNumber(FtpBoyutu, 0) & " Bayt )</i>"%>
								</li><%End If%>
								<li>
									<span>
										<em>:</em>
										Site Boyutu
									</span>
									<%
									Dim strPATH_TRANSLATED, siteBoyutu
									strPATH_TRANSLATED = Request.ServerVariables("PATH_TRANSLATED")
									strPATH_TRANSLATED = Left(strPATH_TRANSLATED, (inStrRev(strPATH_TRANSLATED, "\") - Len(GlobalConfig("admin_folder"))) + 1)
									siteBoyutu = Server.Createobject("Scripting.FileSystemObject").GetFolder(strPATH_TRANSLATED).Size %> 
									<%=FormatNumber(MaxBytes(siteBoyutu), 2) & " MB" & "<i style=""font-style:normal; color:#a2a2a2;""> ( " & FormatNumber(siteBoyutu, 0) & " Bayt )</i>"%>
								</li>
								<%
								If GlobalConfig("general_admin") Then
								%>
								<li style="border:none;">
									<span>
										Çerezler
									</span><br />
									<pre><%
										For Each i In Request.Cookies
										  If Request.Cookies(i).HasKeys Then
											Response.Write(i & vbCrLf)
											For Each x In Request.Cookies(i)
											  Response.Write(vbTab & x & " = " & Request.Cookies(i)(x) & vbCrLf)
											Next
										  Else
											Response.Write(i & " = " & Request.Cookies(i) & vbCrLf)
										  End If
											Response.Write(vbCrLf)
										Next
									%></pre>
								</li>
								<li style="border:none;">
									<span>
										Oturumlar
									</span><br />
									<pre><%
										For Each i In Session.Contents
											Response.Write(i & vbCrLf & ClearHtml(Session.Contents(i)) & vbCrLf & vbCrLf)
										Next
									%></pre>
								</li>
								<%End If%>
							</ul>

							<div class="clr"></div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</body>
</html>
<%
'EnergyList(36) = Array( "Persits ASP JPEG","Persits.Jpeg", "V", "JPEG" )
'EnergyList(37) = Array( "Persits ASPEmail","Persits.MailSender", "N", "Email" )
'EnergyList(38) = Array( "Persits ASPEncrypt","Persits.CryptoManager", "N", "ASPEncrypt" )
'EnergyList(39) = Array( "Persits File Upload","Persits.Upload", "N", "Upload" )
%>
<%
	Function testObject(ByVal Bilesen)
		On Error Resume Next
		Dim createObj, xx
		xx = ""
		testObject = "<em class=""red"">Bileşen mevcut değil</em>"
		Err = 0
		Set createObj = Server.CreateObject(Bilesen)
		If Err = 0 Then testObject = "<em class=""green"">Bileşen mevcut</em>"
		xx = "<em class=""mini""> (v " & createObj.Version & ")</em>"
		If Err = 0 Then testObject = testObject & xx
		Set createObj = Nothing
		Err = 0
	End Function
%>
