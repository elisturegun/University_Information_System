----------------------------------------------------------------------------------
------- Ust Organizasyon ID
----------------------------------------------------------------------------------
create or replace function GetUstOrgID("@ORG_ID"  number) return number is
  "@UST_ORG_ID" number;
cursor c_org is
       select UST_ORG_ID
       from ORG
       where ORG_ID = "@ORG_ID";
begin
  open c_org ;
  fetch c_org into "@UST_ORG_ID";
  close c_org;
  return("@UST_ORG_ID");
end GetUstOrgID
/


DECLARE
  res VARCHAR2(1000);
BEGIN
  res := getustorgid(3);
  DBMS_OUTPUT.PUT_LINE(res);
END;



----------------------------------------------------------------------------------
---------- Kisi Iletisim Bilgileri
----------------------------------------------------------------------------------
create or replace function GetKisiIletisim ("@KISI_ID" number) return varchar is
       "@AD_ASC"           varchar(50);
       "@SOYAD_ASC"        varchar(50);
       "@ILETISIM_TUR_ADI" varchar(50);
       "@ILETISIM_BILGI"   varchar(70);
       "@FINALSTR"         varchar(400);
cursor c_kisi_iletisim is
       select K.AD_ASC, K.SOYAD_ASC, IT.ILETISIM_TUR_ADI, I.ILETISIM_BILGI
       from KISI K, ILETISIM I, ILETISIM_TUR IT
       WHERE K.KISI_ID = I.ILETISIM_SAHIP_PK_ID
       and   I.ILETISIM_TUR_ID = IT.ILETISIM_TUR_ID
       and   K.KISI_ID = "@KISI_ID";
begin
       "@FINALSTR" := '';
       open c_kisi_iletisim;
       loop
            fetch c_kisi_iletisim into "@AD_ASC", "@SOYAD_ASC", "@ILETISIM_TUR_ADI", "@ILETISIM_BILGI";
            exit when c_kisi_iletisim%NOTFOUND;
            "@FINALSTR" := "@FINALSTR"|| "@AD_ASC"|| ' ' ||"@SOYAD_ASC"|| '"in ' ||"@ILETISIM_TUR_ADI"||' : '|| "@ILETISIM_BILGI" || chr(10);
       end loop;
       close c_kisi_iletisim;
  return ("@FINALSTR");
end 
/


DECLARE
  res VARCHAR2(1000);
BEGIN
  res := getkisiiletisim(1);
  DBMS_OUTPUT.PUT_LINE(res);
END;

----------------------------------------------------------------------------------
----- Not Ortalama Hesaplama
----------------------------------------------------------------------------------
create or replace function NotOrtalama("@OGRENCI_NO" number, "@SINIF_ID" number) return number is
  "@NOTORT"       number;
  "@NOT"          number;
  "@NOT_AGIRLIK"  number;
cursor c_not is
       select NA.NOT_AGIRLIK, SN.NOTU
       from SINIF_OGRENCI SO, OGRENCI O, SINIF_NOT SN, NOT_AGIRLIK NA, SINIF S
       where O.OGRENCI_ID = SO.OGRENCI_ID
       and   SO.SINIF_OGRENCI_ID = SN.SINIF_OGRENCI_ID 
       and   SN.NOT_TUR_ID = NA.NOT_TUR_ID
       and   SO.SINIF_ID = NA.SINIF_ID
       and   NA.SINIF_ID = S.SINIF_ID
       and   O.OGRENCI_NO = "@OGRENCI_NO"
       and   S.SINIF_ID = "@SINIF_ID";
begin
  "@NOTORT" := 0;
  open c_not;
  loop
    fetch c_not into "@NOT_AGIRLIK", "@NOT";
    exit when c_not%NOTFOUND;
    "@NOTORT" := "@NOTORT" + ("@NOT" * "@NOT_AGIRLIK");
   end loop;
   close c_not;
  return("@NOTORT");
end 
/


DECLARE
  res VARCHAR2(1000);
BEGIN
  res := notortalama(1,1);
  DBMS_OUTPUT.PUT_LINE(res);
END;

----------------------------------------------------------------------------------
--------------- Kisi Detay
----------------------------------------------------------------------------------
create or replace function GETKISIDETAY("@KISI_ID" number, "@OPTION" number) return varchar2 is
--- 1: Ad_Asc, 2: Soyad_Asc, 3: Kimlik Bilgi, 4: Görev, 5: Uyruk, 6: Cinsiyet
  "@VRES"                  varchar(200);
  "@AD_ASC"                varchar(50);
  "@SOYAD_ASC"             varchar(50);
  "@KIMLIK_TUR_ADI"        varchar(50);
  "@KIMLIK_NO"             varchar(50);
  "@UYRUK_ADI_ASC"         varchar(50);
  "@CINSIYET_ADI"          varchar(50);
  "@GOREV_ADI"             varchar(50);

cursor c_kisi is
       select K.AD_ASC, K.SOYAD_ASC, KT.KIMLIK_TUR_ADI, K.KIMLIK_NO,G.GOREV_ADI,
              U.UYRUK_ADI_ASC, C.CINSIYET_ADI
       from   KISI K LEFT OUTER JOIN KISI_GOREV KG ON K.KISI_ID = KG.KISI_ID
                     LEFT OUTER JOIN GOREV G ON G.GOREV_ID = KG.GOREV_ID
                     INNER JOIN CINSIYET C ON K.CINSIYET_ID = C.CINSIYET_ID
                     INNER JOIN UYRUK U ON U.UYRUK_ID = K.UYRUK_ID
                     INNER JOIN KIMLIK_TUR KT ON KT.KIMLIK_TUR_ID = K.KIMLIK_TUR_ID
       where K.KISI_ID = "@KISI_ID";
 
begin
  "@VRES" := '';
    open c_kisi;
    fetch c_kisi into "@AD_ASC", "@SOYAD_ASC", "@KIMLIK_TUR_ADI", "@KIMLIK_NO",
                      "@GOREV_ADI","@UYRUK_ADI_ASC", "@CINSIYET_ADI" ;
    if "@OPTION" = 1 then
      "@VRES" := "@AD_ASC";
    elsif "@OPTION" = 2 then
      "@VRES" := "@SOYAD_ASC";
    elsif "@OPTION" = 3 then
      "@VRES" := "@KIMLIK_TUR_ADI" ||' : '||"@KIMLIK_NO";
    elsif "@OPTION" = 4 then
      "@VRES" := "@GOREV_ADI";
    elsif "@OPTION" = 5 then
      "@VRES" := "@UYRUK_ADI_ASC";
    elsif "@OPTION" = 6 then
      "@VRES" := "@CINSIYET_ADI";
    end if;
    close c_kisi;
  return("@VRES");
end 
/


DECLARE
  res VARCHAR2(1000);
BEGIN
  res := getkisidetay(1,3);
  DBMS_OUTPUT.PUT_LINE(res);
END;


----------------------------------------------------------------------------------
------------------- Bolume gore donemde acilan dersler
----------------------------------------------------------------------------------
create or replace function GETDONEM_BOLUM_DERS("@DONEM_ID" number, "@BOLUM_ID" number) return varchar is
  "@VRES"         varchar(1000);
  "@c"            number;
  "@DERS_KODU"    varchar(10);
  "@KREDI"        number;
  "@YARIYIL_ADI"  varchar(10);
  "@YIL"          number; 
cursor c_ders is 
       select D.DERS_KODU, D.KREDI, Y.YARIYIL_ADI, DO.YIL
       from   DERS D, SINIF S, DONEM DO, ORG O, YARIYIL Y
       where  D.DERS_ID = S.DERS_ID
       and    DO.DONEM_ID = S.DONEM_ID
       and    O.ORG_ID = D.ORG_BOLUM_ID
       and    DO.YARIYIL_ID = Y.YARIYIL_ID
       and    D.ORG_BOLUM_ID = "@BOLUM_ID"
       and    DO.DONEM_ID = "@DONEM_ID"; 
begin
       "@VRES" := '';
       "@c"    := 0;
       open c_ders;
       loop
            fetch c_ders into "@DERS_KODU", "@KREDI", "@YARIYIL_ADI", "@YIL";
            exit when c_ders%NOTFOUND;
            if "@c" < 1 then
              "@VRES" :=  "@YIL" || ' - ' || UPPER("@YARIYIL_ADI") || ' DONEMI' || chr(10)|| 'Ders Kodu     Kredi'||chr(10);
              "@c" := "@c" + 1;
              end if;
            "@VRES" := "@VRES" || "@DERS_KODU" || '         ' || "@KREDI" ||chr(10);
        end loop;
        close c_ders;
  return("@VRES");
end GETDONEM_BOLUM_DERS
/

DECLARE
  res VARCHAR2(1000);
BEGIN
  res := getdonem_bolum_ders(1,4);
  DBMS_OUTPUT.PUT_LINE(res);
END;


----------------------------------------------------------------------------------
-------------- Veli Bilgi
---------------------------------------------------------------------------------- 
create or replace function VELIBILGI("@OGRENCI_NO" in number) return varchar2 is
  "@VELIBILGI"             varchar2(300);
  "@AD"                    varchar2(50);
  "@SOYAD"                 varchar2(50);
  "@ILETISIM_TUR"          varchar2(40);
  "@ILETISIM_BILGI"        varchar2(80);
  cursor c_veli is
         select       K.AD_ASC, K.SOYAD_ASC, IT.ILETISIM_TUR_ADI, I.ILETISIM_BILGI
         from         OGRENCI O 
         left join    KISI K on O.VELI_KISI_ID = K.KISI_ID
         left join    ILETISIM I on K.KISI_ID = I.ILETISIM_SAHIP_PK_ID
         left join    ILETISIM_TUR IT on IT.ILETISIM_TUR_ID = I.ILETISIM_TUR_ID
         where        O.OGRENCI_NO = "@OGRENCI_NO";  
begin
  "@VELIBILGI" := '';
  open c_veli;
  loop
       fetch c_veli into "@AD", "@SOYAD","@ILETISIM_TUR" ,"@ILETISIM_BILGI";
       exit when c_veli%NOTFOUND;
       "@VELIBILGI" := "@VELIBILGI" || "@AD" || ' ' || "@SOYAD" ||'''in iletisim tur ve bilgisi = '||"@ILETISIM_TUR" || ' : '|| "@ILETISIM_BILGI" ||chr(10);
  end loop;
  close c_veli;
  return("@VELIBILGI");
end VELIBILGI
/


DECLARE
  res VARCHAR2(1000);
BEGIN
  res := velibilgi(1);
  DBMS_OUTPUT.PUT_LINE(res);
END;

----------------------------------------------------------------------------------
---------------- Turune gore organizasyon sayıları
----------------------------------------------------------------------------------
create or replace function ORGTUR_SAY("@ORG_TUR_ID" in number) return varchar2 is
  "@ORG_TUR_ADET" number;
  "@ORG_TUR_AD"   varchar2(50);
  cursor c_org is
         select count(O.ORG_ID), OT.ORG_TUR_ADI
         from ORG_TUR OT 
         left join ORG O on OT.ORG_TUR_ID = O.ORG_TUR_ID 
         where OT.ORG_TUR_ID = "@ORG_TUR_ID"
         group by OT.ORG_TUR_ADI;
begin
  open c_org;
  fetch c_org into "@ORG_TUR_ADET", "@ORG_TUR_AD";
  close c_org;
  
  return("@ORG_TUR_AD"|| ' sayisi : '|| "@ORG_TUR_ADET");
end ORGTUR_SAY
/


DECLARE
  res VARCHAR2(1000);
BEGIN
  res := orgtur_say(5);
  DBMS_OUTPUT.PUT_LINE(res);
END;
----------------------------------------------------------------------------------
-------------------- Goreve gore eski calisanlari getirme
----------------------------------------------------------------------------------
create or replace function GETESKICALISAN("@GOREV_ID" number) return varchar2 is
  "@VRES"         varchar(2000);
  "@AD"           varchar(70);
  "@SOYAD"        varchar(70);
  "@GOREV"        varchar(50);
  "@c"            number;

cursor c_eski_calisan is
       select K.AD_ASC, K.SOYAD_ASC, G.GOREV_ADI_ASC
       from   KISI K, GOREV G, KISI_GOREV KG
       where  K.KISI_ID = KG.KISI_ID
       and    G.GOREV_ID = KG.GOREV_ID
       and    G.GOREV_ID = "@GOREV_ID"
       and    KG.BIT_TARIH is not null;     
begin
    "@VRES" := '';
    "@c" := 0;
    open c_eski_calisan;
    loop
      fetch c_eski_calisan into "@AD", "@SOYAD", "@GOREV";
      exit when c_eski_calisan%NOTFOUND;
      if "@c" < 1 then
        "@VRES" := 'Eski calisanlar - ' || "@GOREV" || chr(10);
        "@c" := "@c" + 1;
      end if; 
      "@VRES" := "@VRES" || "@AD" || ' ' || "@SOYAD" || chr(10);
      end loop;
      close c_eski_calisan;
  return("@VRES");
end GETESKICALISAN
/


DECLARE
  res VARCHAR2(1000);
BEGIN
  res := geteskicalisan(1);
  DBMS_OUTPUT.PUT_LINE(res);
END;

-----------------------------------------------------------------------------------------------
-------------------------------- PIVOT TABLE ------------------------------------------
-----------------------------------------------------------------------------------------------
select *
from(
  select DERS_KODU, GUN, SAAT
  from V_OGRENCI_DERS_TAKVIM
  where ogrenci_no = 1 
  )
pivot (
  max(DERS_KODU) ----------?? 
  for GUN in ('pzt' as PAZARTESI, 'sal' as SALI, 'cars' as CARSAMBA, 'pers' as PERSEMBE, 'cum' as CUMA)
)
order by SAAT
/

-----------------------------------------------------------------------------------------------
-------------------- PIVOT TABLE (DERS CAKISMA DURUMUNDA) -------------------------------------
-----------------------------------------------------------------------------------------------

select *
from(
  select distinct DERS_KODU, GUN, SAAT
  from V_OGRENCI_DERS_TAKVIM
  )
pivot (
  listagg(DERS_KODU, ',') WITHIN GROUP (ORDER BY DERS_KODU) 
  for GUN in ('pzt' as PAZARTESI, 'sal' as SALI, 'cars' as CARSAMBA, 'pers' as PERSEMBE, 'cum' as CUMA)
)
order by SAAT
/

-----------------------------------------------------------------------------------------------
----------------------------- TABLE FUNCTION - DERS PROGRAMI OLUSTURMA ---------------------------
-----------------------------------------------------------------------------------------------

create or replace type DersProg_row as object( --- TYPE OLUSTURMA ( ROW )
  "-"    	varchar(20),
  "GUN1"   	varchar(20),
  "GUN2"       varchar(20),
  "GUN3"    	varchar(20),
  "GUN4"    	varchar(20),
  "GUN5"       varchar(20)
)
/

create or replace type DersProg_tab is table of DersProg_row -- ROWLARDAN OLUSAN TABLE TYPE OLUSTURMA
/


CREATE OR REPLACE FUNCTION Get_DersProg("@OGRENCI_NO" number) RETURN DersProg_tab AS ---FUNCTION RETURNS TABLE
  "@GUN_SIRA"   varchar(10);
  "@DERS_KODU" 	varchar(10);
  ders_tab     	dersprog_tab := dersprog_tab();
  "@SAAT"      	varchar(10);
  "@GUN1"	varchar(20);
  "@GUN2"	varchar(20);
  "@GUN3"	varchar(20);
  "@GUN4"	varchar(20);
  "@GUN5"	varchar(20);
  "@D_GUN1"     varchar(20);
  "@D_GUN2"     varchar(20);
  "@D_GUN3"    	varchar(20);
  "@D_GUN4"    	varchar(20);
  "@D_GUN5"     varchar(20);
  TYPE str_list IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
  saatler str_list;


  cursor c_ders(ders_saat varchar) is
    select ders_kodu, gun_sira
    from v_ogrenci_ders_takvim v , gun g
    where v.gun = g.gun_kisa_adi
    and saat = ders_saat
    and ogrenci_no = "@OGRENCI_NO" ;

  cursor c_gun(gun_s number) IS
    select gun_adi
    from gun
    where gun_sira = gun_s;


BEGIN
  for j in 1..5
  LOOP
    open c_gun(j);
	       if j = 1 then
	          fetch c_gun into "@GUN1";
	        elsif j = 2 then
	          fetch c_gun into "@GUN2";
	        elsif j = 3 then
	          fetch c_gun into "@GUN3";
	        elsif j = 4 then
	          fetch c_gun into "@GUN4";
	        elsif j = 5 then
	          fetch c_gun into "@GUN5";
          end if;
    close c_gun;
  END LOOP;
  ders_tab.extend;
  ders_tab(ders_tab.last) := dersprog_row('Saat/Gun', "@GUN1", "@GUN2", "@GUN3", "@GUN4", "@GUN5");

  saatler(1) := '08:00';
  saatler(2) := '09:00';
  saatler(3) := '10:00';
  saatler(4) := '11:00';
  saatler(5) := '12:00';
  saatler(6) := '13:00';
  saatler(7) := '14:00';
  saatler(8) := '15:00';
  saatler(9) := '16:00';
  for i in 1..9
  LOOP
    "@SAAT" := saatler(i);
    ders_tab.extend;
    "@D_GUN1"  := '';
    "@D_GUN2"  := '';
    "@D_GUN3" := '';
    "@D_GUN4" := '';
    "@D_GUN5"  := '';

    open c_ders("@SAAT");
    LOOP
      fetch c_ders into "@DERS_KODU", "@GUN_SIRA";
      exit when c_ders%NOTFOUND;
      if "@GUN_SIRA" = 1 then
        "@D_GUN1" := "@DERS_KODU";
      elsif "@GUN_SIRA" = 2 then
        "@D_GUN2" := "@DERS_KODU";
      elsif "@GUN_SIRA" = 3 then
        "@D_GUN3" := "@DERS_KODU";
      elsif "@GUN_SIRA" = 4 then
        "@D_GUN4" := "@DERS_KODU";
      elsif "@GUN_SIRA" = 5 then
        "@D_GUN5" := "@DERS_KODU";
      end if;
    END LOOP;
    close c_ders;

    ders_tab(ders_tab.last) := dersprog_row("@SAAT", "@D_GUN1", "@D_GUN2", "@D_GUN3", "@D_GUN4", "@D_GUN5");

  END LOOP;
  RETURN ders_tab;
END;
/


SELECT * FROM TABLE(Get_DersProg(2));


----------------------------------------------------------------------------------
------------------ STRING AYIRMA (TABLE FUNCTION)---------------------------------
----------------------------------------------------------------------------------

create or replace type STR_PARCALA_ROW as object(
  SUB_STR         varchar(200)
)
/


create or replace type STR_PARCALA_TAB is table of str_parcala_row
/


create or replace function STR_PARCALA("@p_str" varchar, "@p_ayrac" varchar) return STR_PARCALA_TAB is
  tab STR_PARCALA_TAB := STR_PARCALA_TAB();
  "@sub_str" varchar(300);
begin
  for i in 1..length("@p_str") loop
    if substr("@p_str", i, 1) = "@p_ayrac" then
      tab.extend;
      tab(tab.last) := STR_PARCALA_ROW("@sub_str");
      "@sub_str" := '';
    else
      "@sub_str" := "@sub_str" || substr("@p_str", i, 1);
    end if;
  end loop;
    tab.extend;
    tab(tab.last) := STR_PARCALA_ROW("@sub_str");
  return tab;
end;
/
























select sysdate, 
        trunc(sysdate), 
        trunc(sysdate) + (8/24) + (30/(24*60.0)),
        sysdate+(5/(24*60.0))
from dual;

select sysdate-trunc(sysdate),
        (sysdate-trunc(sysdate)) * 24 * 60 * 60,
        sysdate+1,
        to_char(to_date('01.01.1000','dd.mm.yyyy') + (sysdate-trunc(sysdate)), 'hh24:mi:ss'),
        trunc((sysdate-trunc(sysdate)) * 24)||':'||
        trunc((sysdate-trunc(sysdate)) * 24 * 60)||':'||
        trunc((sysdate-trunc(sysdate)) * 24 * 60 * 60),
        MOD(12,5)
        
from dual;




-- -------------------- TarihFarkGunAyYil --------------------------------
create or replace function TarihFarkGunAyYil("@TARIH" date,  "@BAZTAR" date, "@FARK_TUR" varchar) return number is -- FARK_TUR = (G)un, (A)y, (Y)ıl, (AF) Ay Farkı
"@TARIH_YIL" integer;
"@TARIH_AY" integer;
"@TARIH_GUN" integer;

"@NOW" date;
"@NOW_YIL" integer;
"@NOW_AY" integer;
"@NOW_GUN" integer;

"@FARK_GUN" integer;
"@FARK_AY" integer;
"@FARK_YIL" integer;

"@GUN_ONDALIK" number;
"@NUM_RES" number;
"@VRES" number;
begin
  "@VRES" := 0;
  if nvl("@TARIH", trunc(sysdate-40000)) <> trunc(sysdate-40000) then
    "@NOW" := sysdate;
    if nvl("@BAZTAR",trunc(sysdate-40000)) <> trunc(sysdate-40000) then
       "@NOW" := "@BAZTAR";
    end if;
       
    if "@FARK_TUR" = 'G' then
       "@VRES" := trunc("@NOW" - "@TARIH");
    elsif "@FARK_TUR" = 'D' then -- dogum gun farki
       "@NUM_RES" := months_between("@NOW", "@TARIH") - trunc(months_between("@NOW", "@TARIH")/12)*12 ;
       "@NUM_RES" := "@NUM_RES" - trunc("@NUM_RES"); ---- ?? trunc("@NUM_RES") hep 0  --> now ve tarih farki 1 yildan az ise degil.
       "@GUN_ONDALIK" := trunc(months_between("@NOW", "@NOW"-1)); ----??? "@GUN_ONDALIK" hep 0 ? ------------------
       if "@GUN_ONDALIK" <> 0 then
          "@VRES" := trunc("@NUM_RES" / ("@GUN_ONDALIK" * 1.0));
       else
          "@VRES" := 0;
       end if;          
    elsif "@FARK_TUR" = 'A' then
       "@VRES" := trunc(months_between("@NOW", "@TARIH")) - trunc(months_between("@NOW", "@TARIH")/12)*12;
       "@VRES" := trunc("@VRES"); ------ ?? ---------
    elsif "@FARK_TUR" = 'AF' then
       "@VRES" := months_between("@NOW", "@TARIH");
    elsif "@FARK_TUR" = 'Y' then
       "@VRES" := trunc(months_between("@NOW", "@TARIH")/12);
    end if;     
  end if;
  return("@VRES");
end;
/















