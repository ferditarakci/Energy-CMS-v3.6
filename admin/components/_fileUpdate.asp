<%
If Not blnPostMethod Then ErrMsg "Geçersiz İşlem! <br />Parametreler doğrulanmadı."
Response.Clear()

Dim fileStyle, strFileSrc

SQL = ""
SQL = SQL & "SELECT" & vbCrLf
SQL = SQL & "	id, IFNULL(title, '') As title, IFNULL(alt, '') As alt," & vbCrLf
SQL = SQL & "	IFNULL(text, '') As text, IFNULL(url, '') As url," & vbCrLf
SQL = SQL & "	resim, mime_type, anaresim, durum, tarih, parent, parent_id, file_type" & vbCrLf
SQL = SQL & "FROM #___files WHERE id = "& id &";"

Set objRs = setExecute(SQL)
If Not objRs.Eof Then

	Select Case objRs("parent")
		Case GlobalConfig("General_CategoriesPN")
			If objRs("file_type") = 1 Then
				strFolderPath = kFolder(objRs("parent_id"), 1)
			Else
				strFolderPath = kFolder(objRs("parent_id"), 3)
			End If

		Case GlobalConfig("General_ProductsPN")
			If objRs("file_type") = 1 Then
				strFolderPath = pFolder(objRs("parent_id"), 1)
			Else
				strFolderPath = pFolder(objRs("parent_id"), 3)
			End If

		Case GlobalConfig("General_PagePN")
			If objRs("file_type") = 1 Then
				strFolderPath = sFolder(objRs("parent_id"), 1)
			Else
				strFolderPath = sFolder(objRs("parent_id"), 3)
			End If

		'Case GlobalConfig("General_UsersPN")
		'	strFolderPath = sFolder(objRs("parent_id"), 1)
	End Select

	strFolderPath = strFolderPath & "/" & objRs("resim")

	Select Case objRs("file_type")
		Case 1
			strFileSrc = strFolderPath
			fileStyle = imgAlign(strFileSrc, 120, 100, 120, 100)

		Case 2
			FileExt = Right(objRs("resim"), (Len(objRs("resim")) - inStrRev(objRs("resim"), ".")))
			strFileSrc = GlobalConfig("vRoot") & "images/icons/file_type/" & FileExt & "_file.png"
			fileStyle = imgAlign(strFileSrc, 120, 100, 120, 100)

		Case Else
			fileStyle = ""

		'Case GlobalConfig("General_UsersPN")
		'	strFolderPath = sFolder(objRs("parent_id"), 1)
	End Select

	strFolderPath = Right(strFolderPath, (Len(strFolderPath) - Len(GlobalConfig("sRoot"))))
	strFileSrc = Right(strFileSrc, (Len(strFileSrc) - Len(GlobalConfig("sRoot"))))

Dim FileContents
Set FileContents = jsObject()
	FileContents("fileid") = objRs("id")
	FileContents("fileTitle") = objRs("title")
	FileContents("fileAlt") = objRs("alt")
	FileContents("fileText") = objRs("text")
	FileContents("fileUrl") = objRs("url")
	FileContents("fileName") = objRs("resim")
	FileContents("fileThumbPath") = strFolderPath
	FileContents("fileMediumPath") = Replace(strFolderPath, "/thumb/", "/medium/")
	FileContents("fileLargePath") = Replace(strFolderPath, "/thumb/", "/")
	FileContents("fileSrc") = strFileSrc
	FileContents("fileStyle") = fileStyle
	FileContents("fileMimeType") = objRs("mime_type")
	FileContents("fileDefafult") = objRs("anaresim")
	FileContents("fileStatus") = objRs("durum")
	FileContents("fileDateTime") = objRs("tarih")
	FileContents.Flush
End If
Set objRs = Nothing


%>
