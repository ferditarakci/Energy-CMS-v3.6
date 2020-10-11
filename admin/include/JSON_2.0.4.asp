<%
'	VBS JSON 2.0.3
'	Copyright (c) 2009 Tuğrul Topuz
'	Under the MIT (MIT-LICENSE.txt) license.

Const JSON_OBJECT = 0
Const JSON_ARRAY = 1

Class jsCore
	Public Collection
	Public Count
	Public QuotedVars
	Public Kind ' 0 = object, 1 = array

	Private Sub Class_Initialize
		Set Collection = Server.CreateObject("Scripting.Dictionary")
		QuotedVars = True
		Count = 0
	End Sub

	Private Sub Class_Terminate
		Set Collection = Nothing
	End Sub

	' counter
	Private Property Get Counter 
		Counter = Count
		Count = Count + 1
	End Property

	' - data maluplation
	' -- pair
	Public Property Let Pair(p, v)
		If isNull(p) Then p = Counter
		Collection(p) = v
	End Property

	Public Property Set Pair(p, v)
		If isNull(p) Then p = Counter
		If TypeName(v) <> "jsCore" Then
			Err.Raise &hD, "class: class", "Incompatible types: '" & TypeName(v) & "'"
		End If
		Set Collection(p) = v
	End Property

	Public Default Property Get Pair(p)
		If isNull(p) Then p = Count - 1
		If isObject(Collection(p)) Then
			Set Pair = Collection(p)
		Else
			Pair = Collection(p)
		End If
	End Property
	' -- pair
	Public Sub Clean
		Collection.RemoveAll
	End Sub

	Public Sub Remove(vProp)
		Collection.Remove vProp
	End Sub
	' data maluplation

	' encoding
	Function jsEncode(str)
		Dim charmap(127), haystack()
		charmap(8)  = "\b"
		charmap(9)  = "\t"
		charmap(10) = "\n"
		charmap(12) = "\f"
		charmap(13) = "\r"
		charmap(34) = "\"""
		charmap(47) = "\/"
		charmap(92) = "\\"

		Dim strlen : strlen = Len(str) - 1
		ReDim haystack(strlen)

		Dim i, charcode
		For i = 0 To strlen
			haystack(i) = Mid(str, i + 1, 1)

			charcode = AscW(haystack(i)) And 65535
			If charcode < 127 Then
				If Not isEmpty(charmap(charcode)) Then
					haystack(i) = charmap(charcode)
				ElseIf charcode < 32 Then
					haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
				End If
			Else
				haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
			End If
		Next

		jsEncode = Join(haystack, "")
	End Function

	' converting
	Public Function toJSON(vPair)
		Select Case VarType(vPair)
			Case 0	' Empty
				toJSON = "null"
			Case 1	' Null
				toJSON = "null"
			Case 7	' Date
				' toJSON = "new Date(" & (vPair - CDate(25569)) * 86400000 & ")"	' let in only utc time
				toJSON = """" & CStr(vPair) & """"
			Case 8	' String
				toJSON = """" & jsEncode(vPair) & """"
			Case 9	' Object
				Dim bFI,i 
				bFI = True
				If vPair.Kind Then toJSON = toJSON & "[" & vbCrLf Else toJSON = toJSON & vbTab & "{" & vbCrLf
				For Each i In vPair.Collection
					If bFI Then bFI = False Else toJSON = toJSON & "," & vbCrLf

					If vPair.Kind Then 
						toJSON = toJSON & toJSON(vPair(i))
					Else
						If QuotedVars Then
							toJSON = toJSON & vbTab & vbTab & """" & i & """:" & toJSON(vPair(i))
						Else
							toJSON = toJSON & i & ":" & toJSON(vPair(i))
						End If
					End If
				Next
				If vPair.Kind Then toJSON = toJSON & vbCrLf & "]" Else toJSON = toJSON & vbCrLf & vbTab & "}"
			Case 11
				If vPair Then toJSON = "true" Else toJSON = "false"
			Case 12, 8192, 8204
				toJSON = RenderArray(vPair, 1, "")
			Case Else
				toJSON = Replace(vPair, ",", ".")
		End select
	End Function

	Function RenderArray(arr, depth, parent)
		Dim first : first = LBound(arr, depth)
		Dim last : last = UBound(arr, depth)

		Dim index, rendered
		Dim limiter : limiter = ","

		'RenderArray = "["
		For index = first To last
			If index = last Then
				limiter = ""
			End If 

			On Error Resume Next
			rendered = RenderArray(arr, depth + 1, parent & index & "," )

			If Err = 9 Then
				On Error GoTo 0
				RenderArray = RenderArray & toJSON(Eval("arr(" & parent & index & ")")) & limiter
			Else
				RenderArray = RenderArray & rendered & "" & limiter
			End If
		Next
		'RenderArray = RenderArray & "]"
	End Function

	Public Property Get jsString
		jsString = toJSON(Me)
	End Property

	Sub Flush
		If TypeName(Response) <> "Empty" Then 
			Response.Write(jsString)
		ElseIf WScript <> Empty Then 
			WScript.Echo(jsString)
		End If
	End Sub

	Public Function Clone
		Set Clone = ColClone(Me)
	End Function

	Private Function ColClone(core)
		Dim jsc, i
		Set jsc = new jsCore
		jsc.Kind = core.Kind
		For Each i In core.Collection
			If IsObject(core(i)) Then
				Set jsc(i) = ColClone(core(i))
			Else
				jsc(i) = core(i)
			End If
		Next
		Set ColClone = jsc
	End Function

End Class

Function jsObject
	Set jsObject = new jsCore
	jsObject.Kind = JSON_OBJECT
End Function

Function jsArray
	Set jsArray = new jsCore
	jsArray.Kind = JSON_ARRAY
End Function

Function toJSON(val)
	toJSON = (new jsCore).toJSON(val)
End Function


Function QueryToJSON(dbc, sql)
        Dim rs, jsa, col
        Set rs = dbc.Execute(setQuery( sql ))
        Set jsa = jsArray()
        While Not (rs.EOF Or rs.BOF)
			Set jsa( Null ) = jsObject()
			For Each col In rs.Fields
				jsa(Null)( col.Name ) = col.Value
			Next
        rs.MoveNext
        Wend
        Set QueryToJSON = jsa
End Function


'Dim az(1,1)
'az(0,0) = "zero - zero"
'az(0,1) = "zero - one"
'az(1,0) = "one - zero"
'az(1,1) = "one - one"
'Clearfix toJSON(az)

'// QueryToJSON(dbconn, "SELECT name, surname, date FROM members WHERE age < 30").Flush
'// QueryToJSON(data, "Select * From tbl_uyeler;").Flush
'// QueryToJSON(data, "Select kulad, mail, adi, soyadi From #___uyeler;").Flush



%>
