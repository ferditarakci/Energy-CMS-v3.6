# ENERGY CMS v3.6 / webtasarimx.net
 Ünvanımın **"WEBMASTER"** olduğu sektördeki ilk yıllarımda **Klasik ASP** / **MYSQL** teknolojileriyle yazıp geliştirdiğim
 ve **ENERGY CMS** ismini verdiğim içerik yönetim sistemim. 😊

### Bazı Özellikleri
**SEF / SEO LINK**
- Eski yöntem 404 hata sayfası aracılığıyla full seo seflink uyumlu yapıya sahiptir.

**ÇOKLU DİL**
- Çoklu dil desteğine sahiptir.
- Veritabanındaki **languages** tablosundan istenen dillerin **durum** değerini 1 yapılması yeterlidir.
- Admin panelde sayfa eklerken aktif diller için ayrı ayrı içerik alanları otomatik oluşmaktadır.

**UPLOAD**
- Sayfalara toplu görsel upload işlemi yapılabilir.
- Upload işlemi sırasında sayfa ID'si ile upload klasörü içinde bir klasör olupturup yüklenen görselin orijinal halinin yanısıra medium ve thumb boyutlarını da ekleyecek şekilde ayarlanmıştır.
- Upload işlemlerini **PERSITS** firmasının geliştirdiği **AspUPLOAD** / **Persits.Upload** resim işleme işlemlerini ise **AspJPEG** / **Persits.Jpeg** modulüyle gerçekleştirmektedir.

**E-POSTA**
- Admin panel ve iletişim sayfalarındaki formlar aracılığıyla e-posta gönderilebiliyor.
- E-postalar yine **PERSITS** firmasının geliştirdiği **AspEmail** / **Persits.MailSender** modulüyle gerçekleştirmektedir.

**MENÜ**
- Admin panelden sürükle bırak yöntemiyle çalışan ve **recursive menü** yapısına uygun şekilde oluşturulmuş hiyararşik menü özelliği bulunmaktadır.

**YORUM**
- Sistemde yorum yazma ve yazılan yoruma cevap, cevaba cevap gibi alt alta yorum yazabilme özelliği mevcuttur.


**VE SAYAMADIĞIM ONLARCA ÖZELLİK...**

### Kullanılan Teknolojiler

```
XHTML
CSS2, CSS3
JAVASCRIPT / JQUERY
ASP (VBScript, JScript)
MYSQL

ASP MODÜLLERİ (Persits.Upload, Persits.Jpeg, Persits.MailSender)
```


**KURULUM VE ADMİN PANEL GİRİŞ BİLGİLERİ**

```
1- Microsoft ASP (Klasik ASP) desteği olan bir sunucuya (plesk vb) dosyaları yükleyin.
2- Bir MySQL veritabanı oluşturun.
3- PhpMyAdmin ile bağlanıp webtsrmx_2014-02-28.sql isimli dosyayı import edin.
4- Oluşturduğunuz MySQL veritabanı username ve password'unu admin/include/database.asp dosyasında 77. satırdan itibaren tanımlayın.
5- Hata verirse hemen altındaki MySQL ODBC satırlarını güncelleyin.
```
```
Kullanıcı Adı: yonetici
Şifre: 123456
```


 **Not:** Kurcalamak isteyenler olursa içinde ihtiyaca yönelik yazılmış farklı şeylerde bulabilir 😀

\#2014-02-28
