<%
Private Sub EbeveynKategori(ByVal intAnaid, ByVal intLevel, ByVal intEbeveyn)
	Dim sSQL, objSubRs, y, tempSpaces, spaces, strSelected, strDisabled
	sSQL = ""
	sSQL = sSQL & "SELECT t1.id, t2.title FROM #___kategori t1 "
	sSQL = sSQL & "LEFT JOIN #___content t2 ON t1.id = t2.parent_id "
	sSQL = sSQL & "WHERE t1.anaid = "& intAnaid &" And t2.parent = "& GlobalConfig("General_CategoriesPN") &" And t2.lang = '"& GlobalConfig("site_lang") &"' "
	sSQL = sSQL & "ORDER BY t1.sira ASC, t1.id DESC;"
	'sSQL = setQuery( sSQL )
	Set objSubRs = setExecute( sSQL )
		If objSubRs.Eof Then Exit Sub
		Do While Not objSubRs.Eof
			tempSpaces = ""
			If intLevel = 0 Then intLevel = 1
			For y = 1 To intLevel' * 5
				tempSpaces = tempSpaces & "¦&nbsp;&nbsp;&nbsp;&nbsp;"
			Next
			'If intLevel > 0 Then tempSpaces = tempSpaces & "&#8211;"

			strSelected = ""
			If (intEbeveyn = objSubRs("id")) Then strSelected = " selected=""selected"""
	
			strDisabled = ""
			If (id = objSubRs("id")) Then strDisabled = " disabled=""disabled"""

			Response.Write("<option"& strDisabled & strSelected &" value="""& objSubRs("id") &""">"& tempSpaces & "" & BasHarfBuyuk(objSubRs("title")) &"</option>")

			If (id <> objSubRs("id")) Then	Call EbeveynKategori(Cdbl(objSubRs("id")), intLevel +1, intEbeveyn)

		objSubRs.MoveNext() : Loop
	If Not objSubRs Is Nothing Then objSubRs.Close
	Set objSubRs = Nothing
End Sub
%>
