<%
Function MimeType(ByVal Ext)
	Ext = LCase( Replace(Ext, ".", "") )
	Dim mType
	Select Case Ext
		Case "jpg", "jpe", "jpeg", "pjpeg", "jfif", "pjp"
			mType = "image/jpeg"

		Case "gif"
			mType = "image/gif"

		Case "png"
			mType = "image/png"

		Case "tif", "tiff"
			mType = "image/tiff"

		Case "bmp"
			mType = "image/bmp"

		Case "txt"
			mType = "text/plain"

		Case "htm", "html"
			mType = "text/html"

		Case "css"
			mType = "text/css"

		Case "js"
			mType = "application/javascript"

		Case "pdf"
			mType = "application/pdf"

		Case "mp3"
			mType = "audio/mpeg"

		Case "mp4"
			mType = "video/mp4"

		Case "mpeg", "mpg", "mpe", "mpv", "mpegv"
			mType = "video/mpeg"

		Case "mpv2", "mp2v"
			mType = "video/x-mpeg2"

		Case "flv"
			mType = "video/x-flv"

		Case "3gp"
			mType = "video/3gpp"

		Case "mov"
			mType = "video/x-mpeg2"

		Case "avi"
			mType = "video/x-msvideo"

		Case "qt", "mov", "moov"
			mType = "video/quicktime"

		Case "zip"
			mType = "application/zip"

		Case "rar"
			mType = "application/x-compressed"

		Case "xml"
			mType = "text/xml"

		Case "cvs"
			mType = "text/csv"

		Case "pps", "ppt", "ppsx", "pptx", "ppa", "pot", "ppax", "potx"
			mType = "application/vnd.ms-powerpoint"

		Case "xls", "xlsx", "xlt", "xltx"
			mType = "application/vnd.ms-excel"

		Case "doc", "docx", "dot", "dotx"
			mType = "application/vnd.ms-word"

		Case "rtf"
			mType = "application/rtf"

		Case Else
			mType = ""

	End Select
	MimeType = mType
End Function
%>
