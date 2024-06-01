---------------------------------------------------------------------------
-------------- OGRENCI DERS TAKVIMI 
---------------------------------------------------------------------------
create or replace view v_ogrenci_ders_takvim as
select O.OGRENCI_NO, D.DERS_KODU, D.DERS_ADI_ASC, G.GUN_KISA_ADI AS GUN, to_char(SGS.BAS_SAAT,'hh24:mi') as SAAT, ORG.ORG_ADI AS DERSLIK
    from OGRENCI O, DERS D,SINIF S, SINIF_OGRENCI SO, SINIF_GUN_SAAT SGS, GUN G, ORG
    where O.OGRENCI_ID = SO.OGRENCI_ID and SO.SINIF_ID = S.SINIF_ID and S.DERS_ID = D.DERS_ID and
          S.SINIF_ID = SGS.SINIF_ID and SGS.GUN_ID = G.GUN_ID and ORG_ID = S.ORG_DERSLIK_ID
    order by G.GUN_SIRA, SAAT ASC
/

---------------------------------------------------------------------------
-------------- OGRENCI NOTLARI
---------------------------------------------------------------------------
create or replace view v_ogrenci_not as
select O.OGRENCI_NO, D.DERS_KODU, NT.NOT_TUR_ADI, SN.NOTU
    from OGRENCI O, SINIF_OGRENCI SO, SINIF S, SINIF_NOT SN, NOT_TUR NT, DERS D
    where O.OGRENCI_ID = SO.OGRENCI_ID and SO.SINIF_OGRENCI_ID = SN.SINIF_OGRENCI_ID and
          SO.SINIF_ID = S.SINIF_ID and S.DERS_ID = D.DERS_ID and SN.NOT_TUR_ID = NT.NOT_TUR_ID
/
	  	  
----------------------------------------------------------------------------
-------------- OGRETMEN BOLUM ve OFISLERI 
-----------------------------------------------------------------------------
create or replace view V_BOLUM_OGRETMENLERI as
  select K.AD_ASC, K.SOYAD_ASC, ORG1.ORG_ADI as BOLUM, ORG2.ORG_ADI as OFIS
    from KISI K, KISI_GOREV KG, GOREV G, OGRETMEN O, ORG ORG1, ORG ORG2
    where KG.KISI_ID = K.KISI_ID and O.KISI_ID = K.KISI_ID and 
          O.ORG_OFIS_ID = ORG2.ORG_ID and ORG1.ORG_ID = KG.ORG_ID and G.GOREV_ID = KG.GOREV_ID
/

---------------------------------------------------------------------
----------------- KISI ILETISIM BILGILERI
---------------------------------------------------------------------
create or replace view V_KISI_ILETISIM as
  select K.AD_ASC as AD, K.SOYAD_ASC as SOYAD, IT.ILETISIM_TUR_ADI as ILETISIM_TUR, I.ILETISIM_BILGI
    from KISI K, ILETISIM_TUR IT, ILETISIM I, ILETISIM_SAHIP_TUR IST
    where IST.ILETISIM_SAHIP_TUR_ID = I.ILETISIM_SAHIP_TUR_ID and K.KISI_ID = I.ILETISIM_SAHIP_PK_ID and
          IT.ILETISIM_TUR_ID = I.ILETISIM_TUR_ID and I.ILETISIM_SAHIP_TUR_ID = 1
/  


---------------------------------------------------------------------
----------------- SINIFLARA GORE OGRENCI SAYISI
---------------------------------------------------------------------
create or replace view v_ders_ogrenci_say as
select S.SINIF_ID , D.DERS_KODU AS DERS, COUNT(*) AS "OGRENCI SAYISI"
    from SINIF_OGRENCI SO, DERS D, SINIF S
    where SO.SINIF_ID = S.SINIF_ID
    and   D.DERS_ID = S.DERS_ID
    group by S.SINIF_ID, D.DERS_KODU
/



----------------------------------------------------------------------
-------------------- DOGUM GUNU OLAN KISILERIN MAIL VE TELEFON BILGILERI
------------------------------------------------------------------------
  create or replace view v_ozelgun_iletisim as
select K.KISI_ID,
       K.AD_ASC            as AD,
       K.SOYAD_ASC         as SOYAD,
       IT.ILETISIM_TUR_ID  as ILETISIM_TUR_ID,
       I.ILETISIM_BILGI
  from KISI K, ILETISIM_TUR IT, ILETISIM I, ILETISIM_SAHIP_TUR IST
 where IST.ILETISIM_SAHIP_TUR_ID = I.ILETISIM_SAHIP_TUR_ID
   and K.KISI_ID = I.ILETISIM_SAHIP_PK_ID
   and IT.ILETISIM_TUR_ID = I.ILETISIM_TUR_ID
   and I.ILETISIM_SAHIP_TUR_ID = 1
   and I.ILETISIM_TUR_ID in (2, 7)
   and I.AKTIF = 1
   and I.TERCIH_SIRA_NO = 1;

  
  


