----------------------------------------------------------------------------------
------------------------ Derse ogrenci ekleme
----------------------------------------------------------------------------------
create or replace procedure SINIF_OGRENCI_EKLE("@OGRENCI_ID" in number, "@SINIF_ID" in number) is
  "@KONTENJAN"    number;
cursor c_kontenjan is
  select KONTENJAN
  from   SINIF
  where  SINIF_ID = "@SINIF_ID";

begin
  open c_kontenjan;
  fetch c_kontenjan into "@KONTENJAN";
  close c_kontenjan;
  if "@KONTENJAN" = 0 then
    RAISE_APPLICATION_ERROR(-20001, 'Sinifta kontenjan kalmamistir!');
  else
    insert into SINIF_OGRENCI(SINIF_ID, OGRENCI_ID)
                values ("@SINIF_ID", "@OGRENCI_ID");
    dbms_output.put_line('Ogrenci eklenmistir.'); 
  end if; 
end SINIF_OGRENCI_EKLE
/

----------------------------------------------------------------------------------
----------------------- Donem acma
----------------------------------------------------------------------------------
create or replace procedure DONEM_AC("@YARIYIL_ID" in number, "@YIL" in number, "@BASTARIH" in date, "@BITTARIH" in date) is
begin
  insert into DONEM(YARIYIL_ID, YIL, BAS_TARIH, BIT_TARIH)
              values("@YARIYIL_ID", "@YIL", to_date("@BASTARIH",'dd.mm.yyyy'), to_date("@BITTARIH", 'dd.mm.yyyy'));
end DONEM_AC
/

----------------------------------------------------------------------------------
----------------------- Kisi iletisim bilgisi guncelleme
----------------------------------------------------------------------------------
create or replace procedure KISI_ILETISIM_GUNCELLE("@ESKI_ILETISIM_ID" in number, "@KISI_ID" in number, "@ILETISIM_TUR_ID" in number,"@YENI_ILETISIM" in varchar ) is
begin
  update ILETISIM 
  set    BIT_TARIH = trunc(SYSDATE), 
         AKTIF = 0
  where  ILETISIM_ID = "@ESKI_ILETISIM_ID" ;
  
  insert into ILETISIM(ILETISIM_SAHIP_TUR_ID, ILETISIM_SAHIP_PK_ID, ILETISIM_TUR_ID, ILETISIM_BILGI, BAS_TARIH)
              values(1, "@KISI_ID", "@ILETISIM_TUR_ID", "@YENI_ILETISIM", trunc(SYSDATE));
  dbms_output.put_line('Iletisim bilgisi ' || "@YENI_ILETISIM" || ' olarak guncellenmistir.'); 
end KISI_ILETISIM_GUNCELLE
/


----------------------------------------------------------------------------------
---------------------- Ogretmen ofis bilgisi guncelleme
----------------------------------------------------------------------------------
create or replace procedure OGR_OFIS_GUNCELLE("@OGRETMEN_ID" in number,"@ORG_ID" in number) is
  "@ORG_TUR_ID" number;
  "@OGR_CHECK"  number;
cursor c_ofis is
  select ORG_TUR_ID
  from   ORG
  where ORG_ID = "@ORG_ID";
begin  
  open c_ofis;
  fetch c_ofis into "@ORG_TUR_ID";
  close c_ofis ;
  
  select count(*) into "@OGR_CHECK" 
  from OGRETMEN 
  where OGRETMEN_ID = "@OGRETMEN_ID" ;
  
  if "@OGR_CHECK" = 1 then
    if "@ORG_TUR_ID" = 9 then
      update OGRETMEN
      set    ORG_OFIS_ID = "@ORG_ID"
      where  OGRETMEN_ID = "@OGRETMEN_ID";
    else
      RAISE_APPLICATION_ERROR(-20002, 'Verilen ''org_id'' degeri bir ofise ait degildir!!');
    end if;
  else
    RAISE_APPLICATION_ERROR(-20003, 'Verilen ''ogretmen_id'' bulunamadı!!');
  end if;   
end OGR_OFIS_GUNCELLE
/

----------------------------------------------------------------------------------
-------------------------- Kisi, kisi-gorev ekleme
----------------------------------------------------------------------------------
create or replace procedure KISI_EKLE("@KIMLIK_TUR_ID" in number, "@KIMLIK_NO" in number,
                                       "@AD" in varchar, "@SOYAD" in varchar, 
                                       "@CINSIYET_ID" in number, "@DOGUM_TARIH" in date, 
                                       "@UYRUK_ID" in number , "@GOREV_ID" in number, 
                                       "@ORG_ID" in number) is
   "@KISI_ID" number;
begin
   insert into KISI(KIMLIK_TUR_ID, KIMLIK_NO, AD, SOYAD, CINSIYET_ID, DOGUM_TARIH, UYRUK_ID)
               values("@KIMLIK_TUR_ID", "@KIMLIK_NO", "@AD", "@SOYAD", "@CINSIYET_ID", to_date("@DOGUM_TARIH", 'dd.mm.yyyy'), "@UYRUK_ID");
   
   "@KISI_ID" := SEQ_KISI_ID.CURRVAL;
   
   insert into KISI_GOREV(KISI_ID, GOREV_ID, ORG_ID, "BAS_TARIH")
               values("@KISI_ID", "@GOREV_ID", "@ORG_ID", trunc(SYSDATE));
end KISI_EKLE
/


-------------------------------------------------------------------------------------------
------------- KISI OZEL GUN BELIRLEME (DOGUM TARIHI)
---------------------------------------------------------------------------------------------

create or replace procedure MAIL_SMS_DOLDUR is
  "@KISI_ID"          number;
  "@ILETISIM_TUR_ID"  number;
  "@ILETISIM_BILGI"   varchar(100);

  cursor c_dogumgun is  
    select K.KISI_ID, V.ILETISIM_TUR_ID, V.ILETISIM_BILGI
    from KISI K, V_OZELGUN_ILETISIM V
    where K.KISI_ID = V.KISI_ID
    and TO_CHAR(K.DOGUM_TARIH, 'dd.mm') = TO_CHAR(SYSDATE, 'dd.mm');

begin
  open c_dogumgun;
  fetch c_dogumgun into "@KISI_ID" , "@ILETISIM_TUR_ID", "@ILETISIM_BILGI";
  while c_dogumgun%FOUND loop
    insert into MAIL_SMS_GONDERIM(MAIL_SMS_ID, KISI_ID, ILETISIM_TUR_ID, ILETISIM_BILGI, MESAJ, DURUM)
                values(SEQ_DOGUMGUN.NEXTVAL, "@KISI_ID",  "@ILETISIM_TUR_ID", "@ILETISIM_BILGI",null, 0);

    fetch c_dogumgun into "@KISI_ID", "@ILETISIM_TUR_ID", "@ILETISIM_BILGI";
  end loop;
  close c_dogumgun;
end MAIL_SMS_DOLDUR;






