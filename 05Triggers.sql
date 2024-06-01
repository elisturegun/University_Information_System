---------------------------------------------------------------------------------------
---UYRUK_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_UYRUK_ID
  before insert on uyruk  
  for each row
declare
  -- local variables here
begin
  :NEW.UYRUK_ID := SEQ_UYRUK_ID.NEXTVAL;
end BEF_TRIG_UYRUK_ID
/

---------------------------------------------------------------------------------------
---ILETISIM_TUR_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_ILETISIM_TUR_ID
  before insert on iletisim_tur  
  for each row
declare
  -- local variables here
begin
  :NEW.ILETISIM_TUR_ID := SEQ_ILETISIM_TUR_ID.NEXTVAL;
end BEF_TRIG_ILETISIM_TUR_ID
/

---------------------------------------------------------------------------------------
---YARIYIL_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_YARIYIL_ID
  before insert on yariyil  
  for each row
declare
  -- local variables here
begin
  :NEW.YARIYIL_ID := SEQ_YARIYIL_ID.NEXTVAL;
end BEF_TRIG_YARIYIL_ID
/

---------------------------------------------------------------------------------------
---ILETISIM_SAHIP_TUR_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_ILETISIM_SAHIP_TUR_ID
  before insert on iletisim_sahip_tur  
  for each row
declare
  -- local variables here
begin
  :NEW.ILETISIM_SAHIP_TUR_ID := SEQ_ILETISIM_SAHIP_TUR_ID.NEXTVAL;
end BEF_TRIG_ILETISIM_SAHIP_TUR_ID
/

---------------------------------------------------------------------------------------
---CINSIYET_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_CINSIYET_ID
  before insert on cinsiyet  
  for each row
declare
  -- local variables here
begin
  :NEW.CINSIYET_ID := SEQ_CINSIYET_ID.NEXTVAL;
end BEF_TRIG_CINSIYET_ID
/

---------------------------------------------------------------------------------------
---KIMLIK_TUR_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_KIMLIK_TUR_ID
  before insert on kimlik_tur  
  for each row
declare
  -- local variables here
begin
  :NEW.KIMLIK_TUR_ID := SEQ_KIMLIK_TUR_ID.NEXTVAL;
end BEF_TRIG_KIMLIK_TUR_ID
/

---------------------------------------------------------------------------------------
---GOREV_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_GOREV_ID
  before insert on gorev  
  for each row
declare
  -- local variables here
begin
  :NEW.GOREV_ID := SEQ_GOREV_ID.NEXTVAL;
end BEF_TRIG_GOREV_ID
/

---------------------------------------------------------------------------------------
---DONEM_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_DONEM_ID
  before insert on donem  
  for each row
declare
  -- local variables here
begin
  :NEW.DONEM_ID := SEQ_DONEM_ID.NEXTVAL;
end BEF_TRIG_DONEM_ID
/

---------------------------------------------------------------------------------------
---ORG_TUR_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_ORG_TUR_ID
  before insert on org_tur  
  for each row
declare
  -- local variables here
begin
  :NEW.ORG_TUR_ID := SEQ_ORG_TUR_ID.NEXTVAL;
end BEF_TRIG_ORG_TUR_ID
/

---------------------------------------------------------------------------------------
---NOT_TUR_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_NOT_TUR
  before insert on not_tur  
  for each row
declare
  -- local variables here
begin
  :NEW.NOT_TUR_ID := SEQ_NOT_TUR_ID.NEXTVAL;
end BEF_TRIG_NOT_TUR
/

---------------------------------------------------------------------------------------
---GUN_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_GUN_ID
  before insert on gun  
  for each row
declare
  -- local variables here
begin
  :NEW.GUN_ID := SEQ_GUN_ID.NEXTVAL;
end BEF_TRIG_GUN_ID
/

---------------------------------------------------------------------------------------
---ORG_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_ORG_ID
  before insert on org  
  for each row
declare
  -- local variables here
begin
  :NEW.ORG_ID := SEQ_ORG_ID.NEXTVAL;
end BEF_TRIG_ORG_ID
/

---------------------------------------------------------------------------------------
---OGRENCI_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_OGRENCI_ID
  before insert on ogrenci  
  for each row
declare
  -- local variables here
begin
  :NEW.OGRENCI_ID := SEQ_OGRENCI_ID.NEXTVAL;
end BEF_TRIG_OGRENCI_ID
/

---------------------------------------------------------------------------------------
---KISI_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_KISI_ID
  before insert on kisi  
  for each row
declare
  -- local variables here
begin
  :NEW.KISI_ID := SEQ_KISI_ID.NEXTVAL;
end BEF_TRIG_KISI_ID
/

---------------------------------------------------------------------------------------
---OGRENCI_DONEM_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_OGRENCI_DONEM_ID
  before insert on ogrenci_donem  
  for each row
declare
  -- local variables here
begin
  :NEW.OGRENCI_DONEM_ID := SEQ_OGRENCI_DONEM_ID.NEXTVAL;
end BEF_TRIG_OGRENCI_DONEM_ID
/

---------------------------------------------------------------------------------------
---DERS_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_DERS_ID
  before insert on ders  
  for each row
declare
  -- local variables here
begin
  :NEW.DERS_ID := SEQ_DERS_ID.NEXTVAL;
end BEF_TRIG_DERS_ID
/

---------------------------------------------------------------------------------------
---OGRETMEN_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------

 create or replace trigger BEF_TRIG_OGRETMEN_ID
  before insert on ogretmen  
  for each row
declare
  -- local variables here
begin
  :NEW.OGRETMEN_ID := SEQ_OGRETMEN_ID.NEXTVAL;
end BEF_TRIG_OGRETMEN_ID
/

---------------------------------------------------------------------------------------
---SINIF_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------

create or replace trigger BEF_TRIG_SINIF_ID
  before insert on sinif  
  for each row
declare
  -- local variables here
begin
  :NEW.SINIF_ID := SEQ_SINIF_ID.NEXTVAL;
end BEF_TRIG_SINIF_ID
/

---------------------------------------------------------------------------------------
---SINIF_OGRENCI_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_SINIF_OGRENCI_ID
  before insert on sinif_ogrenci  
  for each row
declare
  -- local variables here
begin
  :NEW.SINIF_OGRENCI_ID := SEQ_SINIF_OGRENCI_ID.NEXTVAL;
end BEF_TRIG_SINIF_OGRENCI_ID
/

---------------------------------------------------------------------------------------
---SINIF_GUN_SAAT_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_SINIF_GUN_SAAT_ID
  before insert on sinif_gun_saat  
  for each row
declare
  -- local variables here
begin
  :NEW.SINIF_GUN_SAAT_ID := SEQ_SINIF_GUN_SAAT_ID.NEXTVAL;
end BEF_TRIG_SINIF_GUN_SAAT_ID
/

---------------------------------------------------------------------------------------
---SINIF_NOT_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_SINIF_NOT_ID
  before insert on sinif_not  
  for each row
declare
  -- local variables here
begin
  :NEW.SINIF_NOT_ID := SEQ_SINIF_NOT_ID.NEXTVAL;
end BEF_TRIG_SINIF_NOT_ID
/

---------------------------------------------------------------------------------------
---KISI_GOREV_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_KISI_GOREV_ID
  before insert on kisi_gorev  
  for each row
declare
  -- local variables here
begin
  :NEW.KISI_GOREV_ID := SEQ_KISI_GOREV_ID.NEXTVAL;
end BEF_TRIG_KISI_GOREV_ID
/

---------------------------------------------------------------------------------------
---ILETISIM_ID SEQUENCE TRIGGER 
---------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_ILETISIM_ID
  before insert on iletisim  
  for each row
declare
  -- local variables here
begin
  :NEW.ILETISIM_ID := SEQ_ILETISIM_ID.NEXTVAL;
end BEF_TRIG_ILETISIM_ID
/

----------------------------------------------------------------------------------------------
------------- NOT_AGIRLIK_ID TRIGGER
----------------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_NOT_AGIRLIK_ID
  before insert on not_agirlik  
  for each row
declare
  -- local variables here
begin
  :NEW.NOT_AGIRLIK_ID := SEQ_NOT_AGIRLIK_ID.NEXTVAL;
end BEF_TRIG_NOT_AGIRLIK_ID
/


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
----- SINIF KONTENJAN TRIGGER ----------------------
---------------------------------------------------------------------------------------
create or replace trigger AFT_TRIG_DERS_KONTENJAN
  after delete or insert on sinif_ogrenci  
  for each row
declare
  -- local variables here
begin
  if deleting then
     update SINIF set KONTENJAN = KONTENJAN + 1
     where SINIF_ID = :OLD.SINIF_ID;
  elsif inserting then
     update SINIF set KONTENJAN = KONTENJAN -1
     where SINIF_ID = :NEW.SINIF_ID;
  end if;
end AFT_TRIG_DERS_KONTENJAN
/


----------------------------------------------------------------------------------------------
------------- DERS_ADI_ASC TRIGGER
----------------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_DERS_ADI_ASC
  before insert on ders  
  for each row
declare
  -- local variables here
begin
  :NEW.DERS_ADI_ASC := UPPER(TRANSLATE(:NEW.DERS_ADI, 'ĞŞÇİÖÜğşçıöü', 'GSCIOUgsciou'));
end BEF_TRIG_DERS_ADI_ASC
/

----------------------------------------------------------------------------------------------
------------- GOREV_ADI_ASC TRIGGER
----------------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_GOREV_ADI_ASC
  before insert on gorev  
  for each row
declare
  -- local variables here
begin
  :NEW.GOREV_ADI_ASC := UPPER(TRANSLATE(:NEW.GOREV_ADI, 'ĞŞÇİÖÜğşçıöü', 'GSCIOUgsciou'));
end BEF_TRIG_GOREV_ADI_ASC
/

----------------------------------------------------------------------------------------------
------------- UYRUK_ADI_ASC TRIGGER
----------------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_UYRUK_ADI_ASC
  before insert on uyruk  
  for each row
declare
  -- local variables here
begin
  :NEW.UYRUK_ADI_ASC := UPPER(TRANSLATE(:NEW.UYRUK_ADI, 'ĞŞÇİÖÜğşçıöü', 'GSCIOUgsciou'));
end BEF_TRIG_UYRUK_ADI_ASC
/


----------------------------------------------------------------------------------------------
------------- KISI_AD_SOYAD_ASC TRIGGER
----------------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_KISI_AD_SOYAD_ASC
  before insert on kisi  
  for each row
declare
  -- local variables here
begin
  :NEW.AD_ASC := UPPER(TRANSLATE(:NEW.AD, 'ĞŞÇİÖÜğşçıöü', 'GSCIOUgsciou'));
  :NEW.SOYAD_ASC := UPPER(TRANSLATE(:NEW.SOYAD, 'ĞŞÇİÖÜğşçıöü', 'GSCIOUgsciou'));
end BEF_TRIG_KISI_AD_SOYAD_ASC
/

----------------------------------------------------------------------------------------------
------------- ORG_ADI_ASC TRIGGER
----------------------------------------------------------------------------------------------
create or replace trigger BEF_TRIG_ORG_ADI_ASC
  before insert on org  
  for each row
declare
  -- local variables here
begin
  :NEW.ORG_ADI_ASC := UPPER(TRANSLATE(:NEW.ORG_ADI, 'ĞŞÇİÖÜğşçıöü', 'GSCIOUgsciou'));
end BEF_TRIG_ORG_ADI_ASC
/





