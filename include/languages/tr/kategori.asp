<%
Lang("k_urun_adi") = "Ürün Adı"
Lang("k_urun_kodu") = "Ürün Kodu"
Lang("k_urun_yeni") = "Yeni Ürün"
Lang("k_urun_var") = "Bu kategoride toplam [Count] ürün bulundu."
Lang("k_urun_yok") = "Bu kategoride hiç ürün bulununamadı."

'//---------------------------//
'// Bu kısmı değiştirmeyelim
Lang("k_urun_var") = Replace(Lang("k_urun_var"), "[Count]", "( <span style=""color:yellow"">[Count]</span> )", 1, -1, 1)
'//---------------------------//
%>
