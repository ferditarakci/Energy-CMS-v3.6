<%
'If Not GlobalConfig("admin_yetki") Then _
	'Call ArrJSON(0, "", "", "", "Üzgünüz, Kullanıcı hesapları üzerinde işlem yapma yetkiniz bulunmuyor.", "warning") : arrListPost.Flush : Response.End

Dim jKulAdi

For i = 1 To Request.Form("postid[]").Count
	jPostid = Cdbl( Request.Form("postid[]")(i) )

	'If jBoxChecked = "sort-order" Then jOrder = intYap(Request.Form("order[]")(i), 0)

	OpenRs objRs, "SELECT id, adi, soyadi, durum, kulad FROM #___uyeler WHERE id = "& jPostid &";"
		If Not objRs.Eof Then
			jTitle = Cstr(objRs("adi") & " " & objRs("soyadi"))
			jKulAdi = objRs("kulad")

			jApply2 = ""

			'Durum
			If jBoxChecked = "status" Then
				If (jApply = "true" Or jApply = "") And Not CBool(objRs("durum")) Then
					objRs("durum") = 1
					jApply2 = "status-true"
					jAddClass = "success"
					jMessage = i & " Üye hesabı aktif edildi."

				ElseIf (jApply = "false" Or jApply = "") And CBool(objRs("durum")) Then
					objRs("durum") = 0
					jApply2 = "status-false"
					jAddClass = "success"
					jMessage = i & " Üye hesabı pasif edildi."
				End If

			'Delete
			ElseIf jBoxChecked = "delete" Then
				jAddClass = "success"
				jMessage = i & " Üye hesabı silindi."
				jApply2 = "delete-true"
				If jKulAdi = GlobalConfig("super_admin") Then jAddClass = "warning" : jMessage = " Sistem Yöneticisi Silinemez."
				If jKulAdi <> GlobalConfig("super_admin") Then
					Call ContentDelete(jPostid, GlobalConfig("General_UsersPN"))
					objRs.Delete
				End If
			End If

			objRs.Update

			Call ArrJSON(jPostid, jTitle, "", jApply2)

		End If
	CloseRs objRs
Next
%>
