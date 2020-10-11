<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	If jBoxChecked = "sort-order" Then jOrder = intYap(Request.Form("order[]")(i), 0)

	OpenRs objRs, "SELECT id, durum, sira FROM #___kategori WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			'jPostid = objRs("id")
			'jTitle = objRs("title")
			jTitle = sqlQuery("SELECT title FROM #___content WHERE (parent_id = "& jPostid &" And parent = "& GlobalConfig("General_CategoriesPN") &" And lang = '"& GlobalConfig("site_lang") &"')", "")

			jApply2 = ""

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("durum")) Then
					objRs("durum") = 1
					jApply2 = "status-true"
					jAddClass = "success"
					jMessage = i & " Kategori aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("durum")) Then
					objRs("durum") = 0
					jApply2 = "status-false"
					jAddClass = "success"
					jMessage = i & " Kategori pasif edildi."
				End If

			'Sira
			ElseIf jBoxChecked = "sort-order" Then
				objRs("sira") = jOrder
				jAddClass = "success"
				jMessage = "Kategori sıralaması değiştirildi."

			'Delete
			ElseIf jBoxChecked = "delete" Then
				Call ContentDelete(jPostid, GlobalConfig("General_CategoriesPN"))
				Call productDelete( jPostid )
				jAddClass = "success"
				jCount = jCount + 1
				jMessage = i & " Kategori silindi."
				jApply2 = "delete-true"
				objRs.Delete
			End If
			objRs.Update

			jUrl = ""
			If jApply2 = "status-true" Then jUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Categories"), "", "", jPostid, "", "")

			Call ArrJSON(jPostid, jTitle, jUrl, jApply2)

			If Not (jBoxChecked = "sort-order") Then Call SubCategoriesPost(jPostid, jBoxChecked, jApply2)

		End If
	CloseRs objRs
Next




























'// Ürün Ve Resmileri Sil
Private Sub productDelete(ByVal intAnaid)
	Dim objDel
	OpenRs objDel, "SELECT id FROM #___products WHERE anaid = "& intAnaid &";"
		Do While Not objDel.Eof
			Call ContentDelete(objDel("id"), GlobalConfig("General_ProductsPN"))
			objDel.Delete
		objDel.MoveNext() : Loop
	CloseRs objDel
End Sub























Private Sub SubCategoriesPost(ByVal sPostid, ByVal sBoxChecked, ByRef sApply)
	Dim objSubRs, Oid, Otitle, sUrl, sApply2
	OpenRs objSubRs, "SELECT id, durum, sira FROM #___kategori WHERE (anaid = "& sPostid &" And id Not IN ("& Temizle(Request.Form("postid[]"), 1) &"));"
		Do While Not objSubRs.Eof
			Oid = objSubRs("id")
			Otitle = sqlQuery("SELECT title FROM #___content WHERE (parent_id = "& Oid &" And parent = "& GlobalConfig("General_CategoriesPN") &" And lang = '"& GlobalConfig("site_lang") &"')", "")

			sApply2 = ""

			'Durum
			If sBoxChecked = "status" Then
				If (sApply = "status-true" Or sApply = "") And Not CBool(objSubRs("durum")) Then
					objSubRs("durum") = 1
					sApply2 = "status-true"
					jAddClass = "success"
					i = i + 1
					jMessage = i & " Kategori aktif edildi."

				ElseIf (sApply = "status-false" Or sApply = "") And CBool(objSubRs("durum")) Then
					objSubRs("durum") = 0
					sApply2 = "status-false"
					jAddClass = "success"
					i = i + 1
					jMessage = i & " Kategori pasif edildi."
				End If

				'Delete
				ElseIf sBoxChecked = "delete" Then
					Call ContentDelete(Oid, GlobalConfig("General_PagePN"))
					Call productDelete( Oid )
					jAddClass = "success"
					i = i + 1
					jMessage = i & " Kategori silindi."
					sApply2 = "delete-true"
					objSubRs.Delete
				End If
				objSubRs.Update

			sUrl = ""
			If sApply2 = "status-true" Then sUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Categories"), "", "", Oid, "", "")

			Call SubCategoriesPost(Oid, sBoxChecked, sApply)

			Call ArrJSON(Oid, Otitle, sUrl, jApply2)

		objSubRs.MoveNext() : Loop
	CloseRs objSubRs
End Sub
%>
