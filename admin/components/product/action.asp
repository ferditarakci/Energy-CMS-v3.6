<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	If jBoxChecked = "sort-order" Then jOrder = intYap(Request.Form("order[]")(i), 0)

	OpenRs objRs, "SELECT id, durum, anasyf, sira FROM #___products WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			jTitle = sqlQuery("SELECT title FROM #___content WHERE (parent_id = "& jPostid &" And parent = "& GlobalConfig("General_ProductsPN") &" And lang = '"& GlobalConfig("site_lang") &"')", "")

			jApply2 = ""

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("durum")) Then
					objRs("durum") = 1
					jApply2 = "status-true"
					jAddClass = "success"
					jMessage = i & " Ürün aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("durum")) Then
					objRs("durum") = 0
					jApply2 = "status-false"
					jAddClass = "success"
					jMessage = i & " Ürün pasif edildi."
				End If

			'Anasayfa
			ElseIf jBoxChecked = "frontpage" Then
				If (jApply = "true" or jApply = "") And Not CBool(objRs("anasyf")) Then
					objRs("anasyf") = 1
					jApply2 = "frontpage-true"
					jAddClass = "success"
					jCount = jCount + 1
					jMessage = i & " Ürün vitrin ürünleri arasına yerleştirildi."
			
				ElseIf (jApply = "false" or jApply = "") And CBool(objRs("anasyf")) Then
					objRs("anasyf") = 0
					jApply2 = "frontpage-false"
					jAddClass = "success"
					jCount = jCount + 1
					jMessage = i & " Ürün vitrin ürünlerinden kaldırıldı."
				End If

			'Sira
			ElseIf jBoxChecked = "sort-order" Then
				objRs("sira") = jOrder
				jAddClass = "success"
				jMessage = "Ürün sıralaması değiştirildi."

			'Delete
			ElseIf jBoxChecked = "delete" Then
				Call ContentDelete(jPostid, GlobalConfig("General_ProductsPN"))
				jAddClass = "success"
				jCount = jCount + 1
				jMessage = i & " Ürün silindi."
				jApply2 = "delete-true"
				objRs.Delete
			End If
			objRs.Update

			jUrl = ""
			If jApply2 = "status-true" Then jUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Products"), "", "", jPostid, "", "")

			Call ArrJSON(jPostid, jTitle, jUrl, jApply2)

		End If
	CloseRs objRs
Next
%>
