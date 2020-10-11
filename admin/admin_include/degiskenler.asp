<%
Dim ViewsiD, inputSearch, arrSearch, SearchSQL
Dim sqlNotUser, strFolder

Dim arrTreeView : arrTreeView = Array()
Dim arrSubLevel : arrSubLevel = Array()
Dim arrSubLevel2 : arrSubLevel2 = Array()
Dim TreeViewShort : TreeViewShort = ""

Dim intDurumTumu, intDurumAktif, intDurumPasif, intDurumCop

Dim ToplamCount, SayfaLimiti, intSayfaSayisi, SayfaLimitStart, intSayfaNo, intToplamSayfaAdedi, intLimitStart, limitstart1

Dim intCounter, intLevel, spaces, tempSpaces, strDirection, strDirection2

Dim strTitle, strTitle2, CreateDate, ModifiedDate, StartDate, EndDate


Dim ZamanAsimi
Dim varPX
Dim strActive
Dim ToplamSecenek
Dim UyeYetki
Dim SonGiris
Dim BannerYeri


'// Edit Pages
Dim strLangTitle, strLangCode, strLC, strLT, strST, addTitle, strTabButton, strTabContent, strHits, strMoreText, strFiles, strPictures, strAppendPictures
Dim strContentiD, strContentTitle, strContentFixedTitle, strContentShortTitle, strContentLink, strContentText, strContentShortText
Dim strContentKeyword, strContentDescription, strContentHit, strEtiket



'// Edit Post Pages
Dim saveClass, saveMessage
Dim saveid, ArrMenuiD, intMenuSira, intMenuid
Dim intSira, yazar, ozelsayfa, pass, intAnaid, intDurum
Dim TitleStatus, ActiveLink, ActiveHome, yorumizin, HomeAlias
Dim typeAlias, intGetRow, intGetMenuRow
Dim strLng, strPostTitle, strTitleFix, strTitleShort, strTitleAlt, strLink, strDesc, strKeyword, strText, strTextShort, strMeta, strReadMoreText
Dim intGetContentRow, intGetLinkRow




'// Edit İmages Pages
Dim strChecked, strStatusChecked, strStatusText
Dim uiActiveClass, strCssHidden

Dim OptionWrite, strSelectedNone, strSelected

Dim EditiD, EditKatid, EditAnaiD, EditTypeAlias, EditSira, EditKodu
Dim EditFiyat, EditPara, EditYuzde, Editiskonto, EditCreateDate, EditModifiedDate
Dim EditStartDate, EditEndDate, EditStatus, EditStokNo, EditStokAdet
Dim EditYeni, EditAnasyf, EditAnasyfAlias, EditFlash, Secenekid, EditYer, EditType, EditResim
Dim EditAltMetin, EditUrl, MailWrite
Dim EditOzelSayfa, EditPass, EditYorumizin, EditYazar, EditTitleStatus, EditActiveLink, EditHit, EditTitle, EditSeflink, EditLang, EditAciklama



'// List Task İşlemleri
Dim jPostid, jCount, jOrder, jAddClass, jBoxChecked, jApply, jApply2, jUrl, jMessage, jTitle



'// Upload İşlemleri
Dim Upload, File, arrUpload, CookieLang, imgPath, imgPath2, imgPath3, TotalPic, iDefault, intSiraNo, Jpeg
Dim sUpFolder, addVitrinClass, UploadDurum, OrjFileName, Dosyaismi, ResimAdi, FileExt, post_id, files_id, dateTime, DosyaTuru





%>
