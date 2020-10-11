<%
'"Call RecursiveMenu("& intAnaid &", '"& GlobalConfig("site_lang") &"', '"& strMenuType &"', '"& tablePrefix &"');"

Private Function RecursiveMenu(ByVal intUstid, ByVal strMType, ByVal strLNG, ByVal strAlts)
	Dim SQL
	SQL = ""
	SQL = SQL & "# Genel sayfa bağlantısı için menü sorgusu" & vbCrLf
	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, b.title, b.short_title, b.parent, c.sira As sirala," & vbCrLf
	SQL = SQL & "	(" & vbCrLf
	SQL = SQL & "		SELECT Count(a1.id) As cn" & vbCrLf
	SQL = SQL & "		FROM #___sayfa As a1" & vbCrLf
	SQL = SQL & "		INNER JOIN #___content_menu As a2 ON a1.id = a2.parent_id" & vbCrLf
	SQL = SQL & "		WHERE (" & vbCrLf
	SQL = SQL & "			IF(a1.durum, 1, 0)" & vbCrLf
	SQL = SQL & "			And a1.anaid = a.id" & vbCrLf
	SQL = SQL & "			And a2.parent = b.parent" & vbCrLf
	SQL = SQL & "		)" & vbCrLf
	SQL = SQL & "		Limit 1" & vbCrLf
	SQL = SQL & "	) As alt_menu," & vbCrLf
	SQL = SQL & "	IF (" & vbCrLf
	SQL = SQL & "		(" & vbCrLf
	SQL = SQL & "			SELECT IF(Left(a2.seflink, 4) = 'url=', 1, 0) As d" & vbCrLf
	SQL = SQL & "			FROM #___content_url As a2" & vbCrLf
	SQL = SQL & "			WHERE (" & vbCrLf
	SQL = SQL & "				IF(a2.durum, 1, 0)" & vbCrLf
	SQL = SQL & "				And a2.parent_id = a.id" & vbCrLf
	SQL = SQL & "				And a2.parent = b.parent" & vbCrLf
	SQL = SQL & "			)" & vbCrLf
	SQL = SQL & "			Limit 1" & vbCrLf
	SQL = SQL & "		) is Null, 1, 0" & vbCrLf
	SQL = SQL & "	) As dis_baglanti" & vbCrLf
	SQL = SQL & "FROM #___sayfa a" & vbCrLf
	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "INNER JOIN #___content_menu As c ON a.id = c.parent_id And b.parent = c.parent" & vbCrLf
	SQL = SQL & "INNER JOIN #___content_menu_type As d ON c.menu_id = d.id" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	IF(a.durum, 1, 0)" & vbCrLf
	If strAlts = "AltMenuOK" Then SQL = SQL & "	And a.anaid = "& intUstid &"" & vbCrLf
	SQL = SQL & "	And d.type = '"& strMType &"'" & vbCrLf
	SQL = SQL & "	And b.lang = '"& strLNG &"'" & vbCrLf
	SQL = SQL & ")" & vbCrLf

	SQL = SQL & "# Kategori bağlantısı için menü sorgusu" & vbCrLf
	SQL = SQL & "UNION ALL" & vbCrLf

	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, b.title, b.short_title, b.parent, c.sira As sirala," & vbCrLf
	SQL = SQL & "	(" & vbCrLf
	SQL = SQL & "		SELECT Count(a1.id)" & vbCrLf
	SQL = SQL & "		FROM #___kategori As a1" & vbCrLf
	SQL = SQL & "		INNER JOIN #___content_menu As a2 ON a1.id = a2.parent_id" & vbCrLf
	SQL = SQL & "		WHERE (" & vbCrLf
	SQL = SQL & "			IF(a1.durum, 1, 0)" & vbCrLf
	SQL = SQL & "			And a1.anaid = a.id" & vbCrLf
	SQL = SQL & "			And a2.parent = b.parent" & vbCrLf
	SQL = SQL & "		)" & vbCrLf
	SQL = SQL & "		Limit 1" & vbCrLf
	SQL = SQL & "	) As alt_menu," & vbCrLf
	SQL = SQL & "	0 As dis_baglanti" & vbCrLf
	SQL = SQL & "FROM #___kategori As a" & vbCrLf
	SQL = SQL & "INNER JOIN #___content As b ON a.id = b.parent_id" & vbCrLf
	SQL = SQL & "INNER JOIN #___content_menu As c ON a.id = c.parent_id And b.parent = c.parent" & vbCrLf
	SQL = SQL & "INNER JOIN #___content_menu_type As d ON c.menu_id = d.id" & vbCrLf
	SQL = SQL & "WHERE (" & vbCrLf
	SQL = SQL & "	IF(a.durum, 1, 0)" & vbCrLf
	If strAlts = "AltMenuOK" Then SQL = SQL & "	And a.anaid = "& intUstid &"" & vbCrLf
	SQL = SQL & "	And d.type = '"& strMType &"'" & vbCrLf
	SQL = SQL & "	And b.lang = '"& strLNG &"'" & vbCrLf
	SQL = SQL & ")" & vbCrLf

	SQL = SQL & "# Ürün bağlantısı için menü sorgusu" & vbCrLf
	SQL = SQL & "UNION ALL" & vbCrLf

	SQL = SQL & "SELECT" & vbCrLf
	SQL = SQL & "	a.id, b.title, b.short_title, b.parent, c.sira As sirala," & vbCrLf
	SQL = SQL & "	0 As alt_menu," & vbCrLf
	SQL = SQL & "	0 As dis_baglanti" & vbCrLf
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

	SQL = SQL & "ORDER BY sirala ASC;"

RecursiveMenu = SQL
End Function

%>
