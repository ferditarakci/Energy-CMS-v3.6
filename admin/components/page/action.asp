<%
For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	If jBoxChecked = "sort-order" Then jOrder = intYap(Request.Form("order[]")(i), 0)

	OpenRs objRs, "SELECT id, durum, sira FROM #___sayfa WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			jTitle = sqlQuery("SELECT title FROM #___content WHERE (parent_id = "& jPostid &" And parent = "& GlobalConfig("General_PagePN") &" And lang = '"& GlobalConfig("site_lang") &"')", "")

			jApply2 = ""

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("durum")) Then
					objRs("durum") = 1
					jApply2 = "status-true"
					jAddClass = "success"
					jMessage = i & " Sayfa aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("durum")) Then
					objRs("durum") = 0
					jApply2 = "status-false"
					jAddClass = "success"
					jMessage = i & " Sayfa pasif edildi."
				End If

			'Anasayfa
			'ElseIf jBoxChecked = "frontpage" Then
			'	If (jApply = "true" or jApply = "") And Not CBool(objRs("anasyf")) Then
			'		objRs("anasyf") = 1
			'		jApply2 = "frontpage-true"
			'		jAddClass = "success"
			'		jMessage = i & " Sayfa anasayfada yayınlandı."
			'
			'	ElseIf (jApply = "false" or jApply = "") And CBool(objRs("anasyf")) Then
			'		objRs("anasyf") = 0
			'		jApply2 = "frontpage-false"
			'		jAddClass = "success"
			'		jMessage = i & " Sayfa anasayfadan kaldırıldı."
			'	End If

			'Sira
			ElseIf jBoxChecked = "sort-order" Then
				objRs("sira") = jOrder
				jAddClass = "success"
				jMessage = "Sayfa sıralaması değiştirildi."

			'Delete
			ElseIf jBoxChecked = "delete" Then
				Call ContentDelete(jPostid, GlobalConfig("General_PagePN"))
				jAddClass = "success"
				jMessage = i & " Sayfa silindi."
				jApply2 = "delete-true"
				objRs.Delete
			End If
			objRs.Update

			jUrl = ""
			If jApply2 = "status-true" Then jUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", jPostid, "", "")

			Call ArrJSON(jPostid, jTitle, jUrl, jApply2)

			If Not (jBoxChecked = "sort-order") Then Call SubPages(jPostid, jBoxChecked, jApply2)

		End If
	CloseRs objRs
Next


































Private Sub SubPages(byVal sPostid, byVal sBoxChecked, byRef sApply)
	Dim objSubRs, Oid, Otitle, sUrl, sApply2

	OpenRs objSubRs, "SELECT id, durum, sira FROM #___sayfa WHERE (anaid = "& sPostid &" And id Not IN ("& Temizle(Request.Form("postid[]"), 1) &"));"
		Do While Not objSubRs.Eof
			Oid = objSubRs("id")
			Otitle = sqlQuery("SELECT title FROM #___content WHERE (parent_id = "& Oid &" And parent = "& GlobalConfig("General_PagePN") &" And lang = '"& GlobalConfig("site_lang") &"')", "")

			sApply2 = ""

			'Durum
			If sBoxChecked = "status" Then
				If (sApply = "status-true" Or sApply = "") And Not CBool(objSubRs("durum")) Then
					objSubRs("durum") = 1
					sApply2 = "status-true"
					jAddClass = "success"
					i = i + 1
					jMessage = i & " Sayfa aktif edildi."

				ElseIf (sApply = "status-false" Or sApply = "") And CBool(objSubRs("durum")) Then
					objSubRs("durum") = 0
					sApply2 = "status-false"
					jAddClass = "success"
					i = i + 1
					jMessage = i & " Sayfa pasif edildi."
				End If

			'Anasayfa
			'ElseIf sBoxChecked = "frontpage" Then
			'	If (sApply = "frontpage-true" or sApply = "") And Not CBool(objSubRs("anasyf")) Then
			'		objSubRs("anasyf") = 1
			'		sApply2 = "frontpage-true"
			'		jAddClass = "success"
			'		i = i + 1
			'		jMessage = i & " Sayfa anasayfada yayınlandı."
			'
			'	ElseIf (sApply = "frontpage-false" or sApply = "") And CBool(objSubRs("anasyf")) Then
			'		objSubRs("anasyf") = 0
			'		sApply2 = "frontpage-false"
			'		jAddClass = "success"
			'		i = i + 1
			'		jMessage = i & " Sayfa anasayfadan kaldırıldı."
			'	End If

			'Delete
			ElseIf sBoxChecked = "delete" Then
				Call ContentDelete(Oid, GlobalConfig("General_PagePN"))
				jAddClass = "success"
				i = i + 1
				jMessage = i & " Sayfa silindi."
				sApply2 = "delete-true"
				objSubRs.Delete
			End If

			objSubRs.Update

			sUrl = ""
			If sApply2 = "status-true" Then sUrl = UrlWrite(GlobalConfig("sDomain"), GlobalConfig("site_lang"), GlobalConfig("General_Page"), "", "", Oid, "", "")

			Call SubPages(Oid, sBoxChecked, sApply)

			Call ArrJSON(Oid, Otitle, sUrl, sApply2)

		objSubRs.MoveNext() : Loop
	CloseRs objSubRs
End Sub
%>
