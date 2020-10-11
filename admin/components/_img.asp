<%
Select Case task
Case "", "genel"
%>
<!--#include file="header.asp"-->
		<style type="text/css">
			<!-- 
			body{overflow:hidden !important;}
			-->
		 </style>
		<link href="<%=GlobalConfig("vRoot")%>javascript/imagelist/popup-image.css" type="text/css" rel="stylesheet" />
		<script src="<%=GlobalConfig("vRoot")%>javascript/imagelist/popup-image-manager.min.js" type="text/javascript"></script><%
	'If inStr(1, Site_HTTP_USER_AGENT, "MSIE 6", 1) Then
	'	Response.Write(vbCrLf & "		<!--[if IE 6]><style type=""text/css""><!-- img{behavior: url("& GlobalConfig("vRoot") & "css/ieforpngfix.htc)} --></style><![endif]-->")
	'End If
	strFolder = Temizle(Request.QueryString("sub"), 0)
	%>
		<script type="text/javascript">
			/*<![CDATA[*/
			jQuery(function( $ ) {
				var frame = $("#iframe > iframe");
				frame.attr({"src" : frame.attr("src") + '&sub=<%=strFolder%>'});
				// ie7 link dotted clear fix
				$(document).on("focus", "a", function(){ if (this.blur) this.blur() });
			});
			/*]]>*/
		</script>
	</head>
	<body>
		<div id="iframe"><!-- iframe append --></div>
		<fieldset>
			<table style="width:99%;">
				<tr>
					<td><label for="file_url">Bağlantı</label></td>
					<td><input onclick="iSelected(this.id);" class="inputbox" type="text" id="file_url" /></td>
					<td><label for="file_width">Genişlik</label></td>
					<td><input style="width:45px" class="inputbox" type="text" id="file_width" maxlength="4" /></td>
					<td><label for="file_align">Hizala</label></td>
					<td colspan="3">
						<select style="width:130px" size="1" id="file_align">
							<option value="" selected="selected">Ayarlanmamış</option>
							<option value="left">Sola yasla</option>
							<option value="right">Sağa yasla</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="file_title">Başlık</label></td>
					<td><input class="inputbox" type="text" id="file_title" /></td>
					<td><label for="file_height">Yükseklik</label></td>
					<td><input style="width:45px" class="inputbox" type="text" id="file_height" maxlength="4" /></td>
					<td><label for="file_lightbox">Lightbox</label></td>
					<td colspan="3"><input type="checkbox" id="file_lightbox" value="on" title="Resminize ön sayfada tıklandığında lightbox olarak açmak amaçlı düşünülmüş bir özelliktir. (Önsayfada bu özellik desteklenmiyor olabilir.)" /></td>
				</tr>
				<tr>
					<td><label for="file_alt">Alt. Metin</label></td>
					<td colspan="4"><input class="inputbox" type="text" id="file_alt" /></td>
					<!--<td><label for="file_caption">Alt Başlık</label></td>-->
					<!--<td><input type="checkbox" id="file_caption" /></td>-->
					<td>
						<div style="float:right;">
							<button class="btn" type="button" onclick="EnergyInsertEditor('<%=Request.QueryString("e_name")%>');">Ekle</button>&nbsp;
							<button class="btn" type="button" onclick="window.parent.$.fancybox.close();">İptal</button>
						</div>
					</td>
				</tr>
			</table>
		</fieldset>
	</body>
</html>
<%



Case "browser"

'On Error Resume Next
'Const strFileUploadPath = GlobalConfig("uploadFolder")

Dim strFolderPath, strFolderDizin
strFolderPath = GlobalConfig("uploadFolder")

Dim strSubFolderUp
strSubFolderUp = ""

Dim strSubFolderName
strSubFolderName = Temizle(Request.QueryString("sub"), -1)

If strSubFolderName <> "" Then
	strSubFolderName = Replace(strSubFolderName, "../", "")
	strSubFolderName = Replace(strSubFolderName, "..\", "")
	strSubFolderName = Replace(strSubFolderName, "./", "")
	strSubFolderName = Replace(strSubFolderName, ".\", "")
	strFolderPath = strFolderPath &  strSubFolderName
	strSubFolderUp = Mid(strSubFolderName, 1, (Len(strSubFolderName) - Len(Mid(strSubFolderName, inStrRev(strSubFolderName, "\")))))
End If

strFolderDizin = GlobalConfig("uploadFolder") & Replace(strSubFolderName, "\", "/")

Set Jpeg = Server.CreateObject("Persits.Jpeg")

Dim objFSO, objFSOfolder
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Clearfix Server.MapPath( strFolderPath )
If Not objFSO.FolderExists( Server.MapPath( strFolderPath ) ) Then ErrMsg "Hatalı Klasör Adı"

Set objFSOfolder = objFSO.GetFolder( Server.MapPath( strFolderPath ) )

%>
<!--#include file="header.asp"-->
<link href="<%=GlobalConfig("vRoot")%>javascript/imagelist/popup-image-manager.css" type="text/css" rel="stylesheet" />
		<style type="text/css"><!--
		/*html{overflow:auto !important;}*/
		--></style>
		<script type="text/javascript">
			/*<![CDATA[*/
			$(document).ready(function() {
				var Ttip = $(".tooltip");
				if(Ttip.length > 0){ Ttip.tipTip({edgeOffset:5})}
				// ie7 link dotted clear fix
				$("a").bind("focus", function () {if (this.blur) this.blur()});
			});
			function subFolder(sub){
				self.document.location.href = "?mod=img&task=browser&sub=<%=Replace(strSubFolderName, "\", "\\")%>\\" + sub;
			}
			function upFolder(){
				self.document.location.href = "?mod=img&task=browser&sub=<%=Replace(strSubFolderUp, "\", "\\")%>";
			}
			function fileClick(file) {
				window.parent.document.getElementById("file_url").value = "upload<%=Replace(strSubFolderName, "\", "/")%>/" + file;
				//$("#file_url", window.parent.document).val("upload<%=Replace(strSubFolderName, "\", "/")%>/" + file);
			}
			function deleteFolder(foldername){
				if(confirm('Dikkat!\n"' + foldername.toUpperCase() + '" isimli klasör kalıcı olarak silinecektir.\nDevam etmek istiyormusunuz?')){
					document.location.href = '?mod=img&task=delete.folder&folder.name=upload<%=Replace(strSubFolderName, "\", "/")%>/'+ foldername;
					return false;
				}
			}
			function deleteFile(imagename){
				if(confirm('Dikkat!\n"' + imagename.toUpperCase() + '" isimli resim kalıcı olarak silinecektir.\nDevam etmek istiyormusunuz?')){
					document.location.href = '?mod=img&task=delete.file&file.name=upload<%=Replace(strSubFolderName, "\", "/")%>/'+ imagename;
					return false;
				}
			}
			/*]]>*/
		</script>
	</head>
	<body>
		<div id="imageList">
<%
Response.Write("			<div class=""message"">" & GlobalConfig("sDomain") & strFolderDizin & "/</div>" & vbCrLf)
Response.Write("			<div class=""clr""></div>" & vbCrLf)

If strSubFolderName <> "" Then
	With Response
		.Write("			<div class=""item"">" & vbCrLf)
		.Write("				<a class=""up-folder"" href=""javascript:upFolder();"" title=""Üst Klasöre Çık""><span>Üst Klasöre Çık</span></a>" & vbCrLf)
		.Write("			</div>" & vbCrLf)
	End With
	'strUpFolderName = Replace(strSubFolderName, "\", "/") 
	'strUpFolderName = Right(strUpFolderName, Len(strUpFolderName) - 1) & "/"
End If

Dim FolderName
Dim objFSOsubFolder
Dim varSub
Dim FolderClass

For Each objFSOsubFolder in objFSOfolder.SubFolders
If Not objFSOsubFolder.Name = "logo" Then
	FolderName = objFSOsubFolder.Name
	varSub = False
	With objFSO.GetFolder(Server.MapPath(strFolderDizin & "/" & FolderName))
		For Each item In .SubFolders
			varSub = True
			If varSub Then Exit For
		Next
		If Not varSub Then
			For Each item In .Files
				varSub = True
				If varSub Then Exit For
			Next
		End If
	End With
	
	FolderClass = ""
	If varSub Then FolderClass = " var"

	With Response
		.Write("			<div class=""item"">" & vbCrLf) 
		.Write("				<a class=""delete"" href=""javascript:deleteFolder('"& FolderName &"');"" title=""Sil"">Sil</a>" & vbCrLf) 
		.Write("				<a class=""folder"& FolderClass &""" href=""javascript:subFolder('"& FolderName &"');"" title="""& FolderName &"""><span>"& FolderName &"</span></a>" & vbCrLf) 
		.Write("			</div>" & vbCrLf) 
	End With
End If
Next

'Dim strFileTypes, iFileType
'strFileTypes = Array("jpg", "jpeg", "gif", "png", "pdf", "xls", "xlsx", "doc", "docx", "psd", "swf", "bmp", "ai", "cdr", "eps", "tiff", "fla", "ico", "avi", "mov")
'iFileType = Array("pdf", "xls", "xlsx", "doc", "docx", "psd", "swf", "bmp", "ai", "cdr", "eps", "tiff", "fla", "ico", "avi", "mov")
'Clearfix Join(iFileType, " | ")

Dim FilesPath
Const iWidth = 110
Const iHeight = 90
Dim imgName
Dim imgTitle
Dim strFileName
Dim strFileType
Dim intFileSize
Dim objFSOfile
Dim FileCount
Dim strSubFolder

Dim JpegOriginalHeight
Dim JpegOriginalWidth
Dim JpegWidth
Dim JpegHeight

For Each objFSOfile in objFSOfolder.Files

	For Each strFileName in ArrFileExt

		If LCase(objFSO.GetExtensionName(objFSOfile.Name)) = LCase(strFileName) Then

			strFileName   = objFSOfile.Name
			strFileType   = KacKarekter(objFSOfile.Type, 50)
			intFileSize   = Replace(FormatNumber((objFSOfile.Size / 1024), 2), ",", ".")

			strSubFolder = Replace(strSubFolderName, "\", "/")

			imgName = strFileName
			If strSubFolder <> "" Then _
				imgName = Right(strSubFolder, Len(strSubFolder) - 1) & "/" & strFileName


			FileExt = Right(strFileName, (Len(strFileName) - inStrRev(strFileName, ".") + 1))
			FileExt = UzantiKabul(FileExt, ArrPictureExt)

			If FileExt Then

				JpegOriginalHeight = ""
				JpegOriginalWidth = ""
				JpegWidth = ""
				JpegHeight = ""

				FilesPath = Server.MapPath(strFolderDizin & "/" & strFileName)
				With Jpeg
					.Open( FilesPath )

						If (.OriginalWidth > iWidth Or .OriginalHeight > iHeight) Then
							.PreserveAspectRatio = True
							If (.OriginalWidth > .OriginalHeight) Then
								.Width = iWidth
								.Height = (.OriginalHeight * .Width) / .OriginalWidth
							Else
								.Height = iHeight
								.Width = (.OriginalWidth * .Height) / .OriginalHeight
							End If
						End If

						JpegOriginalHeight = .OriginalHeight
						JpegOriginalWidth = .OriginalWidth
						JpegWidth = .Width
						JpegHeight = .Height
					.Close
				End With
			End If

			imgTitle = ""
			imgTitle = imgTitle & "<strong>Dosya ismi:</strong> <span style=&quot;color:#c4e3f4&quot;>"& strFileName &"</span><br />"
			If FileExt Then _
			imgTitle = imgTitle & "<strong>Çözünürlük:</strong> <span style=&quot;color:#c4e3f4&quot;>"& JpegOriginalWidth &" &times; "& JpegOriginalHeight &" px ( "& JpegWidth &" &times; "& JpegHeight &" px boyutuna ölçeklendi )</span><br />"
			imgTitle = imgTitle & "<strong>Dosya Türü:</strong> <span style=&quot;color:#c4e3f4&quot;>"& strFileType &"</span><br />"
			imgTitle = imgTitle & "<strong>Dosya Boyutu:</strong> <span style=&quot;color:#c4e3f4&quot;>"& intFileSize &" KB</span>"

			'If inStr(1, Join(iFileType, " | "), ""& LCase(objFSO.GetExtensionName(objFSOfile.Name)), 1) Then
			
			With Response
				.Write("			<div class=""item"">" & vbCrLf)
				If FileExt Then
					.Write("				<a class=""delete"" href=""javascript:deleteFile('"& strFileName &"');"" title=""Sil"">Sil</a>" & vbCrLf)
					.Write("				<a class=""image tooltip"" href=""javascript:fileClick('"& objFSOfile.Name &"');"" title="""& imgTitle &""">" & vbCrLf) 
					.Write("					<img src=""index.asp?mod=img&amp;task=sendbinary&amp;name="& imgName &"&amp;width="& JpegWidth &"&amp;height="& JpegHeight &""" width="""& JpegWidth &""" height="""& JpegHeight &""" style=""margin-top: expression(( 80 - "& JpegHeight &" ) / 2);"" />" & vbCrLf) 
					.Write("					<span>" & KacKarekter(objFSOfile.Name, 20) & "</span>" & vbCrLf)
					.Write("				</a>" & vbCrLf)
				Else
					.Write("				<a class=""delete"" href=""javascript:deleteFile('"& strFileName &"');"" title=""Sil"">Sil</a>" & vbCrLf)
					.Write("				<a class=""image tooltip"" href=""javascript:fileClick('"& objFSOfile.Name &"');"" title="""& imgTitle &""">" & vbCrLf)
					.Write("					<img src=""images/icons/file_type/"& LCase(objFSO.GetExtensionName(objFSOfile.Name)) &"_file.png"" />" & vbCrLf) 
					.Write("					<span>" & KacKarekter(strFileName, 20) & "</span>" & vbCrLf)
					.Write("				</a>" & vbCrLf)
				End If
				.Write("			</div>" & vbCrLf)
			End With
		End If

	Next

Next

Set Jpeg = Nothing
Set objFSOsubFolder = Nothing
Set objFSOfile = Nothing	
Set objFSOfolder = Nothing
Set objFSO = Nothing  

%>			<div class="clr"></div>
		</div>
	</body>
</html>
<%



Case "sendbinary"

	On Error Resume Next
	With Response
		.Clear()
		.Buffer = True
		.ContentType = "image/jpeg"
		.AddHeader "Content-Disposition", "inline; filename=energy"
		.CacheControl = "no-cache"
		.AddHeader "Pragma", "no-cache"
		.Expires = 0
	End With

	Dim strWidth, strHeight, strSrc
	strWidth  = intYap(Request.QueryString("width"), 110)
	strHeight = intYap(Request.QueryString("height"), 90)
	strSrc  = GlobalConfig("uploadFolder") & "/" & Temizle(Request.QueryString("name"), 1)

	If Not FilesKontrol(strSrc) Then strSrc = GlobalConfig("sRoot") & "/images/blank.gif"

	With Server.CreateObject("Persits.Jpeg")
		.Open(Server.MapPath(strSrc))
		.ToRGB
		If AspJpegVersiyon(.Version) And inStr(1, strSrc, ".png", 1) > 0 Then .PNGOutput = True

		If (.OriginalWidth > strWidth Or .OriginalHeight > StrHeight) Then
			.PreserveAspectRatio = True
			If (.OriginalWidth > .OriginalHeight) Then
				.Width = strWidth
				.Height = (.OriginalHeight * .Width) / .OriginalWidth
			Else
				.Height = StrHeight
				.Width = (.OriginalWidth * .Height) / .OriginalHeight
			End If
		End If
		'JpegOriginalHeight = .OriginalHeight
		'JpegOriginalWidth = .OriginalWidth
		'JpegWidth = .Width
		'JpegHeight = .Height
		.Quality = 80
		.SendBinary
		'Response.BinaryWrite .Binary
		.Close
	End With

	On Error Goto 0





Case "delete.file"
	If GlobalConfig("admin_yetki") Then Call DeleteFile( GlobalConfig("sRoot") & Request.QueryString("file.name") )
	Response.Redirect( Site_HTTP_REFERER )
	Response.End





Case "delete.folder"
	If GlobalConfig("admin_yetki") Then Call DeleteFolder( GlobalConfig("sRoot") & Request.QueryString("folder.name") )
	Response.Redirect( Site_HTTP_REFERER )
	Response.End

End Select
%>

