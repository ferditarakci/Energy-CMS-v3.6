<%
Lang("anasayfa") = "Ana Sayfa"

Lang("post_err") = "Geçersiz İşlem! Parametreler doğrulanmadı."

Lang("err_not_found") = "404 - Kaynak Bulunamadı."

Lang("ewyLoading") = "İşlem yapılıyor, Lütfen bekleyin."
Lang("ewyError") = "Üzgünüm! Bir hata oluştu."

'// Arama
Lang("ara_title") = "Site İçi Arama"
Lang("ara_arama") = "aranacak kelime..."
Lang("ara_01") = "Lütfen aranacak bir kelime giriniz..."
Lang("ara_02") = "Ara"
Lang("ara_03") = "Site içi arama sonuçları --- [Search]"

'//---------------------------//
'// Bu kısmı değiştirmeyelim
Lang("ara_03") = Replace(Lang("ara_03"), "[Search]", "&ldquo; [Search] &rdquo;", 1, -1, 1)
'//---------------------------//

Lang("ara_04") = "[Search] Aramasında hiç sonuç bulunamadı (!)"

'//---------------------------//
'// Bu kısmı değiştirmeyelim
Lang("ara_04") = Replace(Lang("ara_04"), "[Search]", "&ldquo;<span class=""kirmizi""><em>[Search]</em></span>&rdquo;", 1, -1, 1)
'//---------------------------//

Lang("ara_05") = "[Search]<!--googleoff: index--> aramasında toplam ([Count]) sonuç bulundu.<!--googleon: index-->"

'//---------------------------//
'// Bu kısmı değiştirmeyelim
Lang("ara_05") = Replace(Lang("ara_05"), "[Search]", "&ldquo;<span class=""kirmizi""><em>[Search]</em></span>&rdquo;", 1, -1, 1)
Lang("ara_05") = Replace(Lang("ara_05"), "[Count]", "<span class=""kirmizi"">[Count]</span>", 1, -1, 1)
'//---------------------------//


'Modules Lang
Lang("anamenu") = "ANA MENÜ"
Lang("makaleler") = "Makaleler"
Lang("faydali") = "Faydalı Bilgiler"
Lang("haberler") = Array("HABERLER", "Yukarı", "Aşağı")
Lang("face_title") = "Facebook'ta Takip Et!"
Lang("twitter_title") = "Twitter'da Takip Et!"
Lang("googleplus_title") = "Google Plus'da Takip Et!"
Lang("rss_title") = "RSS Beslemesi"
Lang("face_paylas") = "Facebook'ta Paylaş!"
Lang("twitter_paylas") = "Twitter'da Paylaş!"
Lang("googleplus_paylas") = "Google Plus'da Paylaş!"
Lang("havadurumu_title") = "HAVA DURUMU"


'// Etiket Lang
Lang("EtiketTitle") = "ETİKET"
Lang("tagsTitles") = "Etiketler"

'Mailist Lang
Lang("mailist_title") = "Haberdar Olun"
Lang("mailist_text") = "Mail listemize kayıt olarak sizde kampanyalardan yararlanma şansını yakalayın."
Lang("mailist_isim_gir") = "İsminizi Giriniz"
Lang("mailist_mail_adresi_gir") = "Email Adresinizi Giriniz"
Lang("mailist_kaydol") = "Kaydol"


Lang("mailist_err_01") = "İsminizi girmediniz, <br />Lütfen isminizi giriniz."
Lang("mailist_err_02") = "İsminiz çok kısa, <br />Lütfen doğru giriniz."
Lang("mailist_err_03") = "Mail adresinizi girmediniz yada hatalı girdiniz, <br />Lütfen mail adresinizi kontrol ediniz."
Lang("mailist_err_04") = "Teşekkürler; <br />Mail adresiniz başarıyla kaydedildi."
Lang("mailist_err_05") = "Mail adresiniz daha önce kayıt edilmiş, <br />Lütfen farklı bir mail adresi deneyin."


'Lang("istatistik_title") = "İSTATİSTİKLER"
'Lang("istatistik_online") = "Online Ziyaretçi"
'Lang("istatistik_bugun") = "Bugünkü Ziyaretçi"
'Lang("istatistik_toplam") = "Toplam Ziyaretçi"

Lang("tcmb_title") = "TCMB Döviz Kurları"
Lang("tcmb_dolar_alis") = "ABD Doları Alış"
Lang("tcmb_dolar_satis") = "ABD Doları Satış"
Lang("tcmb_euro_alis") = "Euro Alış"
Lang("tcmb_euro_satis") = "Euro Satış"
Lang("tcmb_sterlin_alis") = "İngiliz Sterlini Alış"
Lang("tcmb_sterlin_satis") = "İngiliz Sterlini Satış"


'Lang("gunaydin") = "Günaydın"
'Lang("tunaydin") = "Tünaydın"
'Lang("iyi_aksamlar") = "İyi akşamlar"
'Lang("iyi_geceler") = "İyi geceler"
'Lang("hos_geldiniz") = "Web Sitemize HoşGeldiniz"
'Lang("zaman") = "Bugün [Now]" 'Bugün 19 Mayıs 2011, Perşembe


'// Mail
Lang("mailsender_err_01") = "Bilinmeyen bir hata oluştu!"
Lang("mailsender_err_02") = "Mail gönderilemedi. Bu durumdan dolayı özür dileriz. Hata Kodu: [err]"

'//---------------------------//
'// Bu kısmı değiştirmeyelim
Lang("mailsender_err_02") = Replace(Lang("mailsender_err_02"), "[err]", "&ldquo; [err] &rdquo;", 1, -1, 1)
'//---------------------------//

Lang("mailsender_err_03") = "Teşekkürler, mesajınız başarıyla gönderildi."

'// Internet Explorer 6 Uyarısı
Lang("ie6_title") = "Eski sürüm web tarayıcısı (Internet Explorer 6) kullanıyorsunuz!"
Lang("ie6_text") = "Web sitemizi sorunsuz görüntülemeniz ve internette daha hızlı dolaşabilmeniz için önerdiğimiz popüler web tarayıcılarından bazıları."


%>
