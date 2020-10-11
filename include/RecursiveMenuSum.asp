<%
'"Call RecursiveMenuSum(0, '"& GlobalConfig("site_lang") &"', '"& strMenuType &"', '"& tablePrefix &"');"

Private Function RecursiveMenuSum(ByVal intUstid, ByVal strMType, ByVal strLNG, ByVal strAlts)
	Dim SQL
	SQL = ""
	SQL = SQL & "SELECT Sum(val) As Toplam FROM (" & vbCrLf

	SQL = SQL & "	# Genel Sayfa için üst menü adeti" & vbCrLf
	SQL = SQL & "	SELECT Count(a.id) As val" & vbCrLf
	SQL = SQL & "	FROM #___sayfa As a" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content_menu As c ON a.id = c.parent_id And b.parent = c.parent" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content_menu_type As d ON c.menu_id = d.id" & vbCrLf
	SQL = SQL & "	WHERE (" & vbCrLf
	SQL = SQL & "		IF(a.durum, 1, 0)" & vbCrLf
	If strAlts = "AltMenuOK" Then SQL = SQL & "		And a.anaid = "& intUstid &"" & vbCrLf
	SQL = SQL & "		And d.type = '"& strMType &"'" & vbCrLf
	SQL = SQL & "		And b.lang = '"& strLNG &"'" & vbCrLf
	SQL = SQL & "	)" & vbCrLf

	SQL = SQL & "	# Kategori için üst menü adeti" & vbCrLf
	SQL = SQL & "	UNION ALL" & vbCrLf

	SQL = SQL & "	SELECT Count(a.id) As val" & vbCrLf
	SQL = SQL & "	FROM #___kategori As a" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content_menu As c ON a.id = c.parent_id And b.parent = c.parent" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content_menu_type As d ON c.menu_id = d.id" & vbCrLf
	SQL = SQL & "	WHERE (" & vbCrLf
	SQL = SQL & "		IF(a.durum, 1, 0)" & vbCrLf
	If strAlts = "AltMenuOK" Then SQL = SQL & "		And a.anaid = "& intUstid &"" & vbCrLf
	SQL = SQL & "		And d.type = '"& strMType &"'" & vbCrLf
	SQL = SQL & "		And b.lang = '"& strLNG &"'" & vbCrLf
	SQL = SQL & "	)" & vbCrLf

	SQL = SQL & "	# Ürün için üst menü adeti" & vbCrLf
	SQL = SQL & "	UNION ALL" & vbCrLf

	SQL = SQL & "	SELECT Count(a.id) As val" & vbCrLf
	SQL = SQL & "	FROM #___products As a" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content_menu As c ON a.id = c.parent_id And b.parent = c.parent" & vbCrLf
	SQL = SQL & "	INNER JOIN #___content_menu_type As d ON c.menu_id = d.id" & vbCrLf
	SQL = SQL & "	WHERE (" & vbCrLf
	SQL = SQL & "		IF(a.durum, 1, 0)" & vbCrLf
	If strAlts = "AltMenuOK" Then SQL = SQL & "		And a.anaid = "& intUstid &"" & vbCrLf
	SQL = SQL & "		And d.type = '"& strMType &"'" & vbCrLf
	SQL = SQL & "		And b.lang = '"& strLNG &"'" & vbCrLf
	SQL = SQL & "	)" & vbCrLf

	SQL = SQL & ") As toplam;"

RecursiveMenuSum = SQL
End Function
%>
