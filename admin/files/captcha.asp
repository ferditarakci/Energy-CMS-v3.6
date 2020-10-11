<%@ Language = VBScript Codepage = 65001 LCID = 1055%>
<%

With Session
	.Codepage = 65001
	.LCID = 1055
End With

With Response
	.Charset = "utf-8"
	.Codepage = 65001
	.LCID = 1055
End With



Dim newBitmap(21, 87)
Dim vDistort(4)
LDistortNum = 0
Const LeftMargin = 4
Const BottomMargin = 4
Const CharWidth = 24
Const CharHeight = 32
'Begin editable consts
Const CodeLength = 4 'Secure Code Length (Max:8)
Const Distort = True 'Vertical Image Distortion True/False
Const DistortEx = False 'Horizontal Image Distortion True/False
Const Noise = False 'Image Noise True/False
Const TClr = "000000" 'Text Color #CC0000
Const BClr = "EEEEEE" 'Background Color #FFFFFF
Const NClr = "FFFFFF" 'Noise Color #CC0000 (Recommend TClr=NClr)
'End editable consts
Const BmpHeader = "424D8C1500000000000036000000280000005600000015000000010018000000000056150000120B0000120B00000000000000000000"
Const BmpEndLine = "0000"

Sub IHex(iRow,iColumn,strHex,iRepeat)
	For x=0 To (iRepeat-1)
		newBitmap(iRow,iColumn+x) = strHex
	Next
End Sub

Function Random(valMin,valMax)
    Randomize(timer)
    RangeSize = ((valMax - valMin) + 1)
    Random = Int((RangeSize * Rnd()) + 1)
End Function

Sub AddNoise()
    For x=0 To 28
        ColX = (x*3) + Random(1,3)
        For y=0 To 6
            RowY = (y*3) + Random(1,3)
            IHex RowY,ColX,NClr,1
        Next
    Next
End Sub

Sub WriteCanvas(valChar,iNumPart,iRow,iColumn)
	Select Case iNumPart
		Case 1
			Select Case valChar
				Case 0
					IHex iRow,iColumn+2,TClr,4
				Case 1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+2,TClr,4
				Case 3
					IHex iRow,iColumn+2,TClr,3
				Case 4
					IHex iRow,iColumn+5,TClr,2
				Case 5
					IHex iRow,iColumn+1,TClr,6
				Case 6
					IHex iRow,iColumn+2,TClr,4
				Case 7
					IHex iRow,iColumn,TClr,8
				Case 8
					IHex iRow,iColumn+2,TClr,4
				Case 9
					IHex iRow,iColumn+2,TClr,4
			End Select
		Case 2
			Select Case valChar
				Case 0
					IHex iRow,iColumn+1,TClr,6
				Case 1
					IHex iRow,iColumn+2,TClr,3
				Case 2
					IHex iRow,iColumn+1,TClr,6
				Case 3
					IHex iRow,iColumn+1,TClr,6
				Case 4
					IHex iRow,iColumn+4,TClr,3
				Case 5
					IHex iRow,iColumn+1,TClr,6
				Case 6
					IHex iRow,iColumn+1,TClr,6
				Case 7
					IHex iRow,iColumn,TClr,8
				Case 8
					IHex iRow,iColumn+1,TClr,6
				Case 9
					IHex iRow,iColumn+1,TClr,6
			End Select
		Case 3
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,3
					IHex iRow,iColumn+5,TClr,3
				Case 1
					IHex iRow,iColumn+1,TClr,4
				Case 2
					IHex iRow,iColumn,TClr,3
					IHex iRow,iColumn+5,TClr,3
				Case 3
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+5,TClr,2
				Case 4
					IHex iRow,iColumn+4,TClr,3
				Case 5
					IHex iRow,iColumn+1,TClr,2
				Case 6
					IHex iRow,iColumn+1,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 7
					IHex iRow,iColumn+6,TClr,1
				Case 8
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 9
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
			End Select
		Case 4
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 1
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 3
					IHex iRow,iColumn+5,TClr,2
				Case 4
					IHex iRow,iColumn+3,TClr,4
				Case 5
					IHex iRow,iColumn,TClr,2
				Case 6
					IHex iRow,iColumn,TClr,2
				Case 7
					IHex iRow,iColumn+5,TClr,2
				Case 8
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 9
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
			End Select
		Case 5
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 1
					IHex iRow,iColumn,TClr,1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+6,TClr,2
				Case 3
					IHex iRow,iColumn+5,TClr,2
				Case 4
					IHex iRow,iColumn+2,TClr,2
					IHex iRow,iColumn+5,TClr,2
				Case 5
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+3,TClr,3
				Case 6
					IHex iRow,iColumn,TClr,2
				Case 7
					IHex iRow,iColumn+4,TClr,2
				Case 8
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 9
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
			End Select
		Case 6
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+6,TClr,2
				Case 3
					IHex iRow,iColumn+3,TClr,3
				Case 4
					IHex iRow,iColumn+2,TClr,2
					IHex iRow,iColumn+5,TClr,2
				Case 5
					IHex iRow,iColumn,TClr,7
				Case 6
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+3,TClr,3
				Case 7
					IHex iRow,iColumn+4,TClr,2
				Case 8
					IHex iRow,iColumn+1,TClr,6
				Case 9
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+5,TClr,3
			End Select
		Case 7
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+5,TClr,2
				Case 3
					IHex iRow,iColumn+3,TClr,4
				Case 4
					IHex iRow,iColumn+1,TClr,2
					IHex iRow,iColumn+5,TClr,2
				Case 5
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 6
					IHex iRow,iColumn,TClr,7
				Case 7
					IHex iRow,iColumn+3,TClr,2
				Case 8
					IHex iRow,iColumn+1,TClr,6
				Case 9
					IHex iRow,iColumn+1,TClr,7
			End Select
		Case 8
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+4,TClr,2
				Case 3
					IHex iRow,iColumn+6,TClr,2
				Case 4
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+5,TClr,2
				Case 5
					IHex iRow,iColumn+6,TClr,2
				Case 6
					IHex iRow,iColumn,TClr,3
					IHex iRow,iColumn+6,TClr,2
				Case 7
					IHex iRow,iColumn+3,TClr,2
				Case 8
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 9
					IHex iRow,iColumn+2,TClr,3
					IHex iRow,iColumn+6,TClr,2
			End Select
		Case 9
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+3,TClr,2
				Case 3
					IHex iRow,iColumn+6,TClr,2
				Case 4
					IHex iRow,iColumn,TClr,9
				Case 5
					IHex iRow,iColumn+6,TClr,2
				Case 6
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 7
					IHex iRow,iColumn+3,TClr,2
				Case 8
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 9
					IHex iRow,iColumn+6,TClr,2
			End Select
		Case 10
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+2,TClr,2
				Case 3
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 4
					IHex iRow,iColumn,TClr,9
				Case 5
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 6
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 7
					IHex iRow,iColumn+3,TClr,2
				Case 8
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 9
					IHex iRow,iColumn+6,TClr,2
			End Select
		Case 11
			Select Case valChar
				Case 0
					IHex iRow,iColumn,TClr,3
					IHex iRow,iColumn+5,TClr,3
				Case 1
					IHex iRow,iColumn+3,TClr,2
				Case 2
					IHex iRow,iColumn+1,TClr,2
				Case 3
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 4
					IHex iRow,iColumn+5,TClr,2
				Case 5
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 6
					IHex iRow,iColumn+1,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 7
					IHex iRow,iColumn+2,TClr,2
				Case 8
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+6,TClr,2
				Case 9
					IHex iRow,iColumn,TClr,2
					IHex iRow,iColumn+5,TClr,2
			End Select
		Case 12
			Select Case valChar
				Case 0
					IHex iRow, iColumn + 1,TClr,6
				Case 1
					IHex iRow, iColumn + 3,TClr,2
				Case 2
					IHex iRow, iColumn,TClr,8
				Case 3
					IHex iRow, iColumn + 1,TClr,6
				Case 4
					IHex iRow, iColumn + 5,TClr,2
				Case 5
					IHex iRow, iColumn + 1,TClr,6
				Case 6
					IHex iRow, iColumn + 1,TClr,6
				Case 7
					IHex iRow, iColumn + 2,TClr,2
				Case 8
					IHex iRow, iColumn + 1,TClr,6
				Case 9
					IHex iRow, iColumn + 1,TClr,6
			End Select
		Case 13
			Select Case valChar
				Case 0
					IHex iRow, iColumn + 2, TClr, 4
				Case 1
					IHex iRow, iColumn + 3, TClr, 2
				Case 2
					IHex iRow, iColumn, TClr, 8
				Case 3
					IHex iRow, iColumn + 2, TClr, 4
				Case 4
					IHex iRow, iColumn + 5, TClr, 2
				Case 5
					IHex iRow, iColumn + 2, TClr, 4
				Case 6
					IHex iRow, iColumn + 2, TClr, 4
				Case 7
					IHex iRow, iColumn + 2, TClr, 2
				Case 8
					IHex iRow, iColumn + 2, TClr, 4
				Case 9
					IHex iRow, iColumn + 2, TClr, 4
			End Select
	End Select
End Sub




Function LeftTracking(iNumber)
	Select Case iNumber
		Case 1 LeftTracking = 2
		Case 4 LeftTracking = 0
		Case Else LeftTracking = 1
	End Select
End Function




'http://support.microsoft.com/default.aspx?scid=kb;en-us;320375
Function CreateGUID(tmpLength)
  Randomize Timer
  Dim tmpCounter, tmpGUID
  Const strValid = "01234567890"
  For tmpCounter = 1 To tmpLength
    tmpGUID = tmpGUID & Mid(strValid, Int(Rnd(1) * Len(strValid)) + 1, 1)
  Next
  CreateGUID = tmpGUID
End Function




Function GetStartColumn(iNumber,iLine)
	If DistortEx = True Then
		DistortNum = (Random(1, 3) - 1)
		If DistortNum = 0 Then
		    DistortNum = LDistortNum
		End If
		LDistortNum = DistortNum
	Else
		DistortNum = 0
	End If
	GetStartColumn =  LeftMargin + ((CharWidth * (iLine - 1)) + LeftTracking(iNumber)) + DistortNum
End Function




Sub SendHex(valHex)
	For i = 1 To Len(valHex)
		strHex = "&H" & Mid(valHex, i, 2)
		Response.BinaryWrite ChrB(CInt(strHex))
		i = i + 1
	Next
End Sub




Sub SendClient()

	If Request.QueryString("nocache") = "" Then Response.Redirect("../")

	With Response
		.Buffer = True
		.ContentType = "image/bmp"
		.AddHeader "Content-Disposition", "inline; filename=energy_cms_captcha"
		.CacheControl = "no-cache"
		.AddHeader "Pragma", "no-cache"
		.Expires = -1
	End With

    If Noise = True Then
        AddNoise()
    End If

	SendHex(BmpHeader)

	For y = 1 To 21
		For x = 1 To 86
			tmpHex = newBitmap(y, x)
			If tmpHex = vbNullString Then
				SendHex(BClr)
			Else
				SendHex(tmpHex)
			End If

			If x = 86 Then
				SendHex(BmpEndLine)
			End If
		Next
	Next
	SendHex(BmpEndLine)
	Response.Flush
End Sub






secureCode = CreateGUID(CodeLength)
'Dim SessionPrefix : SessionPrefix = Request.QueryString("prefix")
'Session("captcha" & SessionPrefix) = secureCode
Session("captcha") = secureCode

For i = 1 To CharHeight
	rowNum = (21 - (BottomMargin + (i - 1)))
	For j = 1 To Len(secureCode)
		If (Distort = True) And (i = 1) Then
			vDistort(j) = (Random(1, 6) - 3)
		ElseIf (i = 1) Then
			vDistort(j) = 0
		End If
		tmpNum = CInt(Mid(secureCode, j, 1))
		clmNum = GetStartColumn(tmpNum, j)
		WriteCanvas tmpNum, i, (rowNum + vDistort(j)), clmNum
	Next
Next

SendClient()
%>
