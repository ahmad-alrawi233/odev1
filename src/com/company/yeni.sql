--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: calisma_saat_guncele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calisma_saat_guncele() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."calisma_zamani" <> OLD."calisma_zamani" THEN
        INSERT INTO "personel_saat"("id", "eskisaat", "yenisaat", "time")
        VALUES(OLD."personel_id", OLD."calisma_zamani", NEW."calisma_zamani", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;


    RETURN NEW;
END;
$$;


ALTER FUNCTION public.calisma_saat_guncele() OWNER TO postgres;

--
-- Name: kdv(real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kdv(fiyat real, OUT kdvdahil real) RETURNS real
    LANGUAGE plpgsql
    AS $$
BEGIN
    kdvDahil := 1.6 * fiyat;
END;
$$;


ALTER FUNCTION public.kdv(fiyat real, OUT kdvdahil real) OWNER TO postgres;

--
-- Name: maasguncele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.maasguncele() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."maas" <> OLD."maas" THEN
        INSERT INTO "personel_maas"("id", "eskimaas", "yenimaas","time")
        VALUES(OLD."personel_id", OLD."maas", NEW."maas", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.maasguncele() OWNER TO postgres;

--
-- Name: menudegis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.menudegis() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."menus" <> OLD."menus" THEN
        INSERT INTO "menu_guncele"("menuid", "eskimenu", "yenimenu", "time")
        VALUES(OLD."menu_id", OLD."menus", NEW."menus", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.menudegis() OWNER TO postgres;

--
-- Name: musteriara(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musteriara(musteriadi text) RETURNS TABLE(id integer, ad text, soyadi text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "kisi_id", "adi", "soy_ad" FROM kisiler
                WHERE "adi" = musteriadi AND "turu" = 'musteri';
END;
$$;


ALTER FUNCTION public.musteriara(musteriadi text) OWNER TO postgres;

--
-- Name: musterirezaara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musterirezaara(musteriid integer) RETURNS TABLE(zamani text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "rezervasyon_zaman" FROM rezervasyon
                WHERE "musteri_id" = musteriId;
END;
$$;


ALTER FUNCTION public.musterirezaara(musteriid integer) OWNER TO postgres;

--
-- Name: restoranadiara(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.restoranadiara(restoranadi text) RETURNS TABLE(ad text, saat text, res_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "restoran_ad" , "calisma_saat" , "restoran_id" FROM restoran
                 WHERE "restoran_ad" = restoranAdi;
END;
$$;


ALTER FUNCTION public.restoranadiara(restoranadi text) OWNER TO postgres;

--
-- Name: restoraniletisimara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.restoraniletisimara(restoranid integer) RETURNS TABLE(id integer, adresss text, telefonn text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "restoran__id" , "adress" , "telefon" FROM r_iletişim_bilgisi
                 WHERE "restoran__id" = restoranid;
END;
$$;


ALTER FUNCTION public.restoraniletisimara(restoranid integer) OWNER TO postgres;

--
-- Name: rezervasyonGuncele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."rezervasyonGuncele"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."rezervasyon_zaman" <> OLD."rezervasyon_zaman" THEN
        INSERT INTO "rezervasyon_degis"("rezervasyonid", "eskirezervasyon", "yenirezervasyon")
        VALUES(OLD."rezervasyon_id", OLD."rezervasyon_zaman", NEW."rezervasyon_zaman");
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."rezervasyonGuncele"() OWNER TO postgres;

--
-- Name: sehirGuncel(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."sehirGuncel"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."adi" <> OLD."adi" THEN
        INSERT INTO "sehir_degisme"("sehirid", "eskiSehir", "yenisehir", "time")
        VALUES(OLD."sehir_id", OLD."adi", NEW."adi", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."sehirGuncel"() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    admin_id integer NOT NULL,
    admin_adi text NOT NULL,
    sifre text NOT NULL
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: admin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_admin_id_seq OWNER TO postgres;

--
-- Name: admin_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_admin_id_seq OWNED BY public.admin.admin_id;


--
-- Name: cadde; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cadde (
    cadde_id integer NOT NULL,
    cadde text NOT NULL,
    il_id integer NOT NULL
);


ALTER TABLE public.cadde OWNER TO postgres;

--
-- Name: cadde_cadde_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cadde_cadde_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cadde_cadde_id_seq OWNER TO postgres;

--
-- Name: cadde_cadde_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cadde_cadde_id_seq OWNED BY public.cadde.cadde_id;


--
-- Name: cadde_il_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cadde_il_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cadde_il_id_seq OWNER TO postgres;

--
-- Name: cadde_il_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cadde_il_id_seq OWNED BY public.cadde.il_id;


--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    adi text NOT NULL,
    il_id integer NOT NULL,
    sehir_id integer NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: il_il_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.il_il_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.il_il_id_seq OWNER TO postgres;

--
-- Name: il_il_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.il_il_id_seq OWNED BY public.il.il_id;


--
-- Name: il_sehir_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.il_sehir_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.il_sehir_id_seq OWNER TO postgres;

--
-- Name: il_sehir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.il_sehir_id_seq OWNED BY public.il.sehir_id;


--
-- Name: ilanlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilanlar (
    ilan_id integer NOT NULL,
    personel_id integer NOT NULL,
    ilan text NOT NULL
);


ALTER TABLE public.ilanlar OWNER TO postgres;

--
-- Name: ilanlar_ilan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ilanlar_ilan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ilanlar_ilan_id_seq OWNER TO postgres;

--
-- Name: ilanlar_ilan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ilanlar_ilan_id_seq OWNED BY public.ilanlar.ilan_id;


--
-- Name: ilanlar_personel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ilanlar_personel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ilanlar_personel_id_seq OWNER TO postgres;

--
-- Name: ilanlar_personel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ilanlar_personel_id_seq OWNED BY public.ilanlar.personel_id;


--
-- Name: istekler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.istekler (
    istek_id integer NOT NULL,
    musteri_id integer NOT NULL,
    istek text NOT NULL,
    restoran_id integer NOT NULL
);


ALTER TABLE public.istekler OWNER TO postgres;

--
-- Name: istekler_istek_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.istekler_istek_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.istekler_istek_id_seq OWNER TO postgres;

--
-- Name: istekler_istek_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.istekler_istek_id_seq OWNED BY public.istekler.istek_id;


--
-- Name: istekler_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.istekler_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.istekler_musteri_id_seq OWNER TO postgres;

--
-- Name: istekler_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.istekler_musteri_id_seq OWNED BY public.istekler.musteri_id;


--
-- Name: k_iletişim_bilgisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."k_iletişim_bilgisi" (
    adress text NOT NULL,
    kisi_id integer NOT NULL,
    sehir_id integer NOT NULL,
    telefon text NOT NULL,
    "k_iletişim_id" integer NOT NULL
);


ALTER TABLE public."k_iletişim_bilgisi" OWNER TO postgres;

--
-- Name: k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq" OWNER TO postgres;

--
-- Name: k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq" OWNED BY public."k_iletişim_bilgisi"."k_iletişim_id";


--
-- Name: kisiler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kisiler (
    adi text,
    soy_ad text,
    kisi_id integer NOT NULL,
    turu text
);


ALTER TABLE public.kisiler OWNER TO postgres;

--
-- Name: kisiler_kisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kisiler_kisi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kisiler_kisi_id_seq OWNER TO postgres;

--
-- Name: kisiler_kisi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kisiler_kisi_id_seq OWNED BY public.kisiler.kisi_id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    menu_id integer NOT NULL,
    menus text NOT NULL,
    restoran_id integer NOT NULL,
    fiyat integer NOT NULL
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: menu_guncele; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_guncele (
    menuid integer NOT NULL,
    eskimenu text NOT NULL,
    yenimenu text NOT NULL,
    "time" text NOT NULL,
    menu__id integer NOT NULL
);


ALTER TABLE public.menu_guncele OWNER TO postgres;

--
-- Name: menu_guncele_menu__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_guncele_menu__id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_guncele_menu__id_seq OWNER TO postgres;

--
-- Name: menu_guncele_menu__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_guncele_menu__id_seq OWNED BY public.menu_guncele.menu__id;


--
-- Name: menu_guncele_menuid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_guncele_menuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_guncele_menuid_seq OWNER TO postgres;

--
-- Name: menu_guncele_menuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_guncele_menuid_seq OWNED BY public.menu_guncele.menuid;


--
-- Name: menu_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_menu_id_seq OWNER TO postgres;

--
-- Name: menu_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_menu_id_seq OWNED BY public.menu.menu_id;


--
-- Name: menu_restoran_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_restoran_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_restoran_id_seq OWNER TO postgres;

--
-- Name: menu_restoran_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_restoran_id_seq OWNED BY public.menu.restoran_id;


--
-- Name: musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri (
    musteri_id integer NOT NULL,
    musteri_sifre text NOT NULL,
    musteri_emilli text NOT NULL
);


ALTER TABLE public.musteri OWNER TO postgres;

--
-- Name: musteri_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.musteri_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.musteri_musteri_id_seq OWNER TO postgres;

--
-- Name: musteri_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.musteri_musteri_id_seq OWNED BY public.musteri.musteri_id;


--
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    personel_id integer NOT NULL,
    maas integer NOT NULL,
    restoran_id integer NOT NULL,
    personel_emill text NOT NULL,
    personel_sifre text NOT NULL
);


ALTER TABLE public.personel OWNER TO postgres;

--
-- Name: personel_maas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_maas (
    id integer NOT NULL,
    eskimaas integer NOT NULL,
    yenimaas integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    personel_maas_id integer NOT NULL
);


ALTER TABLE public.personel_maas OWNER TO postgres;

--
-- Name: personel_maas_personel_maas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_maas_personel_maas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_maas_personel_maas_id_seq OWNER TO postgres;

--
-- Name: personel_maas_personel_maas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_maas_personel_maas_id_seq OWNED BY public.personel_maas.personel_maas_id;


--
-- Name: personel_personel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_personel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_personel_id_seq OWNER TO postgres;

--
-- Name: personel_personel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_personel_id_seq OWNED BY public.personel.personel_id;


--
-- Name: personel_restoran_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_restoran_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_restoran_id_seq OWNER TO postgres;

--
-- Name: personel_restoran_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_restoran_id_seq OWNED BY public.personel.restoran_id;


--
-- Name: personel_saat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_saat (
    id integer NOT NULL,
    eskisaat integer NOT NULL,
    yenisaat integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    personel_saat_id integer NOT NULL
);


ALTER TABLE public.personel_saat OWNER TO postgres;

--
-- Name: personel_saat_personel_saat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_saat_personel_saat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_saat_personel_saat_id_seq OWNER TO postgres;

--
-- Name: personel_saat_personel_saat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_saat_personel_saat_id_seq OWNED BY public.personel_saat.personel_saat_id;


--
-- Name: r_iletişim_bilgisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."r_iletişim_bilgisi" (
    adress text NOT NULL,
    restoran__id integer NOT NULL,
    sehir_id integer NOT NULL,
    telefon text NOT NULL,
    iletisim_id integer NOT NULL
);


ALTER TABLE public."r_iletişim_bilgisi" OWNER TO postgres;

--
-- Name: r_iletişim_bilgisi_iletisim_bilgi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."r_iletişim_bilgisi_iletisim_bilgi_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."r_iletişim_bilgisi_iletisim_bilgi_id_seq" OWNER TO postgres;

--
-- Name: r_iletişim_bilgisi_iletisim_bilgi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."r_iletişim_bilgisi_iletisim_bilgi_id_seq" OWNED BY public."r_iletişim_bilgisi".iletisim_id;


--
-- Name: restoran; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restoran (
    restoran_id integer NOT NULL,
    restoran_ad text NOT NULL,
    calisma_saat text NOT NULL
);


ALTER TABLE public.restoran OWNER TO postgres;

--
-- Name: restoran_restoran_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.restoran_restoran_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restoran_restoran_id_seq OWNER TO postgres;

--
-- Name: restoran_restoran_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.restoran_restoran_id_seq OWNED BY public.restoran.restoran_id;


--
-- Name: rezervasyon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rezervasyon (
    musteri_id integer NOT NULL,
    rezervasyon_id integer NOT NULL,
    rezervasyon_zaman text NOT NULL,
    restoran_id integer NOT NULL
);


ALTER TABLE public.rezervasyon OWNER TO postgres;

--
-- Name: rezervasyon_degis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rezervasyon_degis (
    rezervasyonid integer NOT NULL,
    eskirezervasyon text NOT NULL,
    yenirezervasyon text NOT NULL,
    rezervasyon__id integer NOT NULL
);


ALTER TABLE public.rezervasyon_degis OWNER TO postgres;

--
-- Name: rezervasyon_degis_rezervasyon__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rezervasyon_degis_rezervasyon__id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rezervasyon_degis_rezervasyon__id_seq OWNER TO postgres;

--
-- Name: rezervasyon_degis_rezervasyon__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rezervasyon_degis_rezervasyon__id_seq OWNED BY public.rezervasyon_degis.rezervasyon__id;


--
-- Name: rezervasyon_degis_rezervasyonid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rezervasyon_degis_rezervasyonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rezervasyon_degis_rezervasyonid_seq OWNER TO postgres;

--
-- Name: rezervasyon_degis_rezervasyonid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rezervasyon_degis_rezervasyonid_seq OWNED BY public.rezervasyon_degis.rezervasyonid;


--
-- Name: rezervasyon_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rezervasyon_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rezervasyon_musteri_id_seq OWNER TO postgres;

--
-- Name: rezervasyon_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rezervasyon_musteri_id_seq OWNED BY public.rezervasyon.musteri_id;


--
-- Name: rezervasyon_restoran_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rezervasyon_restoran_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rezervasyon_restoran_id_seq OWNER TO postgres;

--
-- Name: rezervasyon_restoran_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rezervasyon_restoran_id_seq OWNED BY public.rezervasyon.restoran_id;


--
-- Name: rezervasyon_rezervasyon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rezervasyon_rezervasyon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rezervasyon_rezervasyon_id_seq OWNER TO postgres;

--
-- Name: rezervasyon_rezervasyon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rezervasyon_rezervasyon_id_seq OWNED BY public.rezervasyon.rezervasyon_id;


--
-- Name: sehir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sehir (
    sehir_id integer NOT NULL,
    adi text NOT NULL
);


ALTER TABLE public.sehir OWNER TO postgres;

--
-- Name: sehir_degisme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sehir_degisme (
    sehirid text NOT NULL,
    yenisehir text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "eskiSehir" text NOT NULL,
    sehir_degisme_id integer NOT NULL
);


ALTER TABLE public.sehir_degisme OWNER TO postgres;

--
-- Name: sehir_degisme_sehir_degisme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sehir_degisme_sehir_degisme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sehir_degisme_sehir_degisme_id_seq OWNER TO postgres;

--
-- Name: sehir_degisme_sehir_degisme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sehir_degisme_sehir_degisme_id_seq OWNED BY public.sehir_degisme.sehir_degisme_id;


--
-- Name: sehir_sehir_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sehir_sehir_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sehir_sehir_id_seq OWNER TO postgres;

--
-- Name: sehir_sehir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sehir_sehir_id_seq OWNED BY public.sehir.sehir_id;


--
-- Name: subeler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subeler (
    sube_id integer NOT NULL,
    restoran_id integer NOT NULL,
    calisma_saatler text NOT NULL
);


ALTER TABLE public.subeler OWNER TO postgres;

--
-- Name: subeler_restoran_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subeler_restoran_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subeler_restoran_id_seq OWNER TO postgres;

--
-- Name: subeler_restoran_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subeler_restoran_id_seq OWNED BY public.subeler.restoran_id;


--
-- Name: subeler_sube_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subeler_sube_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subeler_sube_id_seq OWNER TO postgres;

--
-- Name: subeler_sube_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subeler_sube_id_seq OWNED BY public.subeler.sube_id;


--
-- Name: tekdir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tekdir (
    musteri_id integer NOT NULL,
    tekdir text NOT NULL,
    tekdir_id integer NOT NULL,
    restoran_id integer NOT NULL
);


ALTER TABLE public.tekdir OWNER TO postgres;

--
-- Name: tekdir_musteri_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tekdir_musteri_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tekdir_musteri_id_seq OWNER TO postgres;

--
-- Name: tekdir_musteri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tekdir_musteri_id_seq OWNED BY public.tekdir.musteri_id;


--
-- Name: tekdir_restoran_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tekdir_restoran_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tekdir_restoran_id_seq OWNER TO postgres;

--
-- Name: tekdir_restoran_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tekdir_restoran_id_seq OWNED BY public.tekdir.restoran_id;


--
-- Name: tekdir_tekdir_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tekdir_tekdir_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tekdir_tekdir_id_seq OWNER TO postgres;

--
-- Name: tekdir_tekdir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tekdir_tekdir_id_seq OWNED BY public.tekdir.tekdir_id;


--
-- Name: tekdir_tekdir_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tekdir_tekdir_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tekdir_tekdir_seq OWNER TO postgres;

--
-- Name: tekdir_tekdir_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tekdir_tekdir_seq OWNED BY public.tekdir.tekdir;


--
-- Name: admin admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN admin_id SET DEFAULT nextval('public.admin_admin_id_seq'::regclass);


--
-- Name: cadde cadde_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cadde ALTER COLUMN cadde_id SET DEFAULT nextval('public.cadde_cadde_id_seq'::regclass);


--
-- Name: cadde il_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cadde ALTER COLUMN il_id SET DEFAULT nextval('public.cadde_il_id_seq'::regclass);


--
-- Name: il il_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il ALTER COLUMN il_id SET DEFAULT nextval('public.il_il_id_seq'::regclass);


--
-- Name: il sehir_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il ALTER COLUMN sehir_id SET DEFAULT nextval('public.il_sehir_id_seq'::regclass);


--
-- Name: ilanlar ilan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilanlar ALTER COLUMN ilan_id SET DEFAULT nextval('public.ilanlar_ilan_id_seq'::regclass);


--
-- Name: ilanlar personel_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilanlar ALTER COLUMN personel_id SET DEFAULT nextval('public.ilanlar_personel_id_seq'::regclass);


--
-- Name: istekler istek_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istekler ALTER COLUMN istek_id SET DEFAULT nextval('public.istekler_istek_id_seq'::regclass);


--
-- Name: istekler musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istekler ALTER COLUMN musteri_id SET DEFAULT nextval('public.istekler_musteri_id_seq'::regclass);


--
-- Name: k_iletişim_bilgisi k_iletişim_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi" ALTER COLUMN "k_iletişim_id" SET DEFAULT nextval('public."k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq"'::regclass);


--
-- Name: kisiler kisi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisiler ALTER COLUMN kisi_id SET DEFAULT nextval('public.kisiler_kisi_id_seq'::regclass);


--
-- Name: menu menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN menu_id SET DEFAULT nextval('public.menu_menu_id_seq'::regclass);


--
-- Name: menu restoran_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN restoran_id SET DEFAULT nextval('public.menu_restoran_id_seq'::regclass);


--
-- Name: menu_guncele menuid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_guncele ALTER COLUMN menuid SET DEFAULT nextval('public.menu_guncele_menuid_seq'::regclass);


--
-- Name: menu_guncele menu__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_guncele ALTER COLUMN menu__id SET DEFAULT nextval('public.menu_guncele_menu__id_seq'::regclass);


--
-- Name: musteri musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri ALTER COLUMN musteri_id SET DEFAULT nextval('public.musteri_musteri_id_seq'::regclass);


--
-- Name: personel personel_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel ALTER COLUMN personel_id SET DEFAULT nextval('public.personel_personel_id_seq'::regclass);


--
-- Name: personel restoran_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel ALTER COLUMN restoran_id SET DEFAULT nextval('public.personel_restoran_id_seq'::regclass);


--
-- Name: personel_maas personel_maas_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_maas ALTER COLUMN personel_maas_id SET DEFAULT nextval('public.personel_maas_personel_maas_id_seq'::regclass);


--
-- Name: personel_saat personel_saat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_saat ALTER COLUMN personel_saat_id SET DEFAULT nextval('public.personel_saat_personel_saat_id_seq'::regclass);


--
-- Name: r_iletişim_bilgisi iletisim_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi" ALTER COLUMN iletisim_id SET DEFAULT nextval('public."r_iletişim_bilgisi_iletisim_bilgi_id_seq"'::regclass);


--
-- Name: restoran restoran_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restoran ALTER COLUMN restoran_id SET DEFAULT nextval('public.restoran_restoran_id_seq'::regclass);


--
-- Name: rezervasyon musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon ALTER COLUMN musteri_id SET DEFAULT nextval('public.rezervasyon_musteri_id_seq'::regclass);


--
-- Name: rezervasyon rezervasyon_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon ALTER COLUMN rezervasyon_id SET DEFAULT nextval('public.rezervasyon_rezervasyon_id_seq'::regclass);


--
-- Name: rezervasyon restoran_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon ALTER COLUMN restoran_id SET DEFAULT nextval('public.rezervasyon_restoran_id_seq'::regclass);


--
-- Name: rezervasyon_degis rezervasyonid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon_degis ALTER COLUMN rezervasyonid SET DEFAULT nextval('public.rezervasyon_degis_rezervasyonid_seq'::regclass);


--
-- Name: rezervasyon_degis rezervasyon__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon_degis ALTER COLUMN rezervasyon__id SET DEFAULT nextval('public.rezervasyon_degis_rezervasyon__id_seq'::regclass);


--
-- Name: sehir sehir_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir ALTER COLUMN sehir_id SET DEFAULT nextval('public.sehir_sehir_id_seq'::regclass);


--
-- Name: sehir_degisme sehir_degisme_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir_degisme ALTER COLUMN sehir_degisme_id SET DEFAULT nextval('public.sehir_degisme_sehir_degisme_id_seq'::regclass);


--
-- Name: subeler sube_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeler ALTER COLUMN sube_id SET DEFAULT nextval('public.subeler_sube_id_seq'::regclass);


--
-- Name: subeler restoran_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeler ALTER COLUMN restoran_id SET DEFAULT nextval('public.subeler_restoran_id_seq'::regclass);


--
-- Name: tekdir musteri_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tekdir ALTER COLUMN musteri_id SET DEFAULT nextval('public.tekdir_musteri_id_seq'::regclass);


--
-- Name: tekdir tekdir; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tekdir ALTER COLUMN tekdir SET DEFAULT nextval('public.tekdir_tekdir_seq'::regclass);


--
-- Name: tekdir tekdir_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tekdir ALTER COLUMN tekdir_id SET DEFAULT nextval('public.tekdir_tekdir_id_seq'::regclass);


--
-- Name: tekdir restoran_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tekdir ALTER COLUMN restoran_id SET DEFAULT nextval('public.tekdir_restoran_id_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admin VALUES
	(1, 'ahmad', '123');


--
-- Data for Name: cadde; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cadde VALUES
	(1, 'cadde', 1),
	(2, 'cadde2', 2);


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il VALUES
	('keciyoren', 1, 1),
	('kec', 2, 1),
	('adabazari', 3, 2);


--
-- Data for Name: ilanlar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: istekler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.istekler VALUES
	(4, 4, 'dawdawd', 1),
	(5, 5, 'dawdawdawdawd', 1),
	(2, 1, 'dwadw', 1);


--
-- Data for Name: k_iletişim_bilgisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."k_iletişim_bilgisi" VALUES
	('dwadw', 1, 1, '561', 1),
	('11dwadwad', 2, 1, '11561', 2);


--
-- Data for Name: kisiler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kisiler VALUES
	(NULL, NULL, 3, 'personel'),
	(NULL, NULL, 4, 'personel'),
	('omar', 'a', 1, 'musteri'),
	('ahmad', 'w', 2, 'musteri'),
	('omawr', 'daw', 17, 'musteri'),
	(NULL, NULL, 5, 'musteri'),
	(NULL, NULL, 6, 'musteri'),
	(NULL, NULL, 7, 'musteri'),
	(NULL, NULL, 8, 'musteri'),
	(NULL, NULL, 9, 'musteri'),
	('10', NULL, 10, 'musteri'),
	(NULL, NULL, 11, 'musteri'),
	('musteri', NULL, 12, 'musteri'),
	(NULL, NULL, 13, 'musteri'),
	(NULL, NULL, 14, 'musteri'),
	(NULL, NULL, 15, 'musteri'),
	(NULL, NULL, 16, 'musteri'),
	(NULL, NULL, 18, 'musteri'),
	(NULL, NULL, 19, 'personel');


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.menu VALUES
	(1, 'dwadwadfwafd', 1, 651),
	(2, 'dawdawd', 1, 12);


--
-- Data for Name: menu_guncele; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.menu_guncele VALUES
	(2, 'dwaefdwefw', 'ewdagfesfwef2131d1dcawc', '2020-07-22 15:57:56.042645', 1);


--
-- Data for Name: musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteri VALUES
	(1, '1', 'ah1'),
	(2, '1', 'ah'),
	(3, '1', 'a'),
	(4, '1', 'w'),
	(5, '2', 'q'),
	(6, '3', 'q'),
	(7, '2', 'q');


--
-- Data for Name: personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personel VALUES
	(8, 565, 1, 'a', 'a');


--
-- Data for Name: personel_maas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personel_maas VALUES
	(1, 1500, 1989, '2020-07-23 22:18:44.851133', 1);


--
-- Data for Name: personel_saat; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personel_saat VALUES
	(1, 5, 16, '2020-07-23 22:23:32.750018', 1);


--
-- Data for Name: r_iletişim_bilgisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."r_iletişim_bilgisi" VALUES
	('dxwadw', 1, 1, '898498498', 3),
	('dw', 2, 2, '89889', 4),
	('dwqdw', 3, 3, '999', 2),
	('edwa', 4, 4, '998205', 1);


--
-- Data for Name: restoran; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.restoran VALUES
	(9, 'dwqdawd', '99'),
	(3, 'ak', '2'),
	(10, 'qw', ''),
	(1, 'we', '498'),
	(2, 'rq', '3'),
	(4, 'qq', '8'),
	(5, 'ww', '24'),
	(6, 'wwe', '24'),
	(7, 'ee', '15'),
	(8, 'r', '16'),
	(11, 'dw', '1736654'),
	(12, 'asdwd', '65'),
	(13, 'adw', '123'),
	(14, 'ddwadwfa', '213'),
	(15, 'dwadwfawf', '14'),
	(16, 'dwafwagawg', '123');


--
-- Data for Name: rezervasyon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rezervasyon VALUES
	(2, 7, '15', 1);


--
-- Data for Name: rezervasyon_degis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rezervasyon_degis VALUES
	(1, '1666512', '255', 1);


--
-- Data for Name: sehir; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sehir VALUES
	(3, 'istanbul'),
	(4, ''),
	(5, ''),
	(6, ''),
	(7, ''),
	(2, 'awd'),
	(1, 'afwfaw');


--
-- Data for Name: sehir_degisme; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sehir_degisme VALUES
	('2', 'awd', '2020-07-23 19:07:32.729938', 'ankara', 1),
	('1', 'afwfaw', '2020-07-29 21:00:42.184849', 'sakarya', 2);


--
-- Data for Name: subeler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subeler VALUES
	(1, 1, '665'),
	(2, 1, '65');


--
-- Data for Name: tekdir; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tekdir VALUES
	(2, 'dwafwafwafwaf', 3, 1),
	(2, 'dewadw', 2, 2),
	(1, 'dwad', 1, 2),
	(2, 'sdw', 4, 2),
	(2, 'dawdawd', 8, 5),
	(3, 'dwadawdawd', 10, 1);


--
-- Name: admin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_admin_id_seq', 1, false);


--
-- Name: cadde_cadde_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cadde_cadde_id_seq', 1, false);


--
-- Name: cadde_il_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cadde_il_id_seq', 1, false);


--
-- Name: il_il_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.il_il_id_seq', 1, false);


--
-- Name: il_sehir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.il_sehir_id_seq', 1, false);


--
-- Name: ilanlar_ilan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilanlar_ilan_id_seq', 1, false);


--
-- Name: ilanlar_personel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilanlar_personel_id_seq', 1, false);


--
-- Name: istekler_istek_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.istekler_istek_id_seq', 5, true);


--
-- Name: istekler_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.istekler_musteri_id_seq', 5, true);


--
-- Name: k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."k_iletişim_bilgisi_k_iletişim_bilgisi_id_seq"', 7, true);


--
-- Name: kisiler_kisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kisiler_kisi_id_seq', 19, true);


--
-- Name: menu_guncele_menu__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_guncele_menu__id_seq', 1, true);


--
-- Name: menu_guncele_menuid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_guncele_menuid_seq', 1, false);


--
-- Name: menu_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_menu_id_seq', 2, true);


--
-- Name: menu_restoran_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_restoran_id_seq', 1, true);


--
-- Name: musteri_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.musteri_musteri_id_seq', 14, true);


--
-- Name: personel_maas_personel_maas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_maas_personel_maas_id_seq', 1, true);


--
-- Name: personel_personel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_personel_id_seq', 3, true);


--
-- Name: personel_restoran_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_restoran_id_seq', 1, true);


--
-- Name: personel_saat_personel_saat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_saat_personel_saat_id_seq', 1, true);


--
-- Name: r_iletişim_bilgisi_iletisim_bilgi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."r_iletişim_bilgisi_iletisim_bilgi_id_seq"', 4, true);


--
-- Name: restoran_restoran_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.restoran_restoran_id_seq', 16, true);


--
-- Name: rezervasyon_degis_rezervasyon__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rezervasyon_degis_rezervasyon__id_seq', 1, true);


--
-- Name: rezervasyon_degis_rezervasyonid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rezervasyon_degis_rezervasyonid_seq', 1, false);


--
-- Name: rezervasyon_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rezervasyon_musteri_id_seq', 1, false);


--
-- Name: rezervasyon_restoran_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rezervasyon_restoran_id_seq', 1, false);


--
-- Name: rezervasyon_rezervasyon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rezervasyon_rezervasyon_id_seq', 7, true);


--
-- Name: sehir_degisme_sehir_degisme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sehir_degisme_sehir_degisme_id_seq', 2, true);


--
-- Name: sehir_sehir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sehir_sehir_id_seq', 5, true);


--
-- Name: subeler_restoran_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subeler_restoran_id_seq', 1, false);


--
-- Name: subeler_sube_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subeler_sube_id_seq', 1, true);


--
-- Name: tekdir_musteri_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tekdir_musteri_id_seq', 1, false);


--
-- Name: tekdir_restoran_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tekdir_restoran_id_seq', 1, false);


--
-- Name: tekdir_tekdir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tekdir_tekdir_id_seq', 10, true);


--
-- Name: tekdir_tekdir_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tekdir_tekdir_seq', 1, false);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);


--
-- Name: il il_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT il_pkey PRIMARY KEY (il_id);


--
-- Name: ilanlar ilanlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilanlar
    ADD CONSTRAINT ilanlar_pkey PRIMARY KEY (ilan_id);


--
-- Name: k_iletişim_bilgisi k_iletişim_bilgisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi"
    ADD CONSTRAINT "k_iletişim_bilgisi_pkey" PRIMARY KEY ("k_iletişim_id");


--
-- Name: menu_guncele menu_guncele_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_guncele
    ADD CONSTRAINT menu_guncele_pkey PRIMARY KEY (menu__id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (menu_id);


--
-- Name: personel personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_pkey PRIMARY KEY (personel_id);


--
-- Name: r_iletişim_bilgisi r_iletişim_bilgisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "r_iletişim_bilgisi_pkey" PRIMARY KEY (iletisim_id);


--
-- Name: rezervasyon rezervasyon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon
    ADD CONSTRAINT rezervasyon_pkey PRIMARY KEY (rezervasyon_id);


--
-- Name: sehir_degisme sehir_degisme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir_degisme
    ADD CONSTRAINT sehir_degisme_pkey PRIMARY KEY (sehir_degisme_id);


--
-- Name: sehir sehir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_pkey PRIMARY KEY (sehir_id);


--
-- Name: subeler subeler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeler
    ADD CONSTRAINT subeler_pkey PRIMARY KEY (sube_id);


--
-- Name: admin unique_admin_admin_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT unique_admin_admin_id UNIQUE (admin_id);


--
-- Name: cadde unique_cadde_cadde; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cadde
    ADD CONSTRAINT unique_cadde_cadde UNIQUE (cadde);


--
-- Name: cadde unique_cadde_cadee_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cadde
    ADD CONSTRAINT unique_cadde_cadee_id PRIMARY KEY (cadde_id);


--
-- Name: cadde unique_cadde_il_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cadde
    ADD CONSTRAINT unique_cadde_il_id UNIQUE (il_id);


--
-- Name: il unique_il_il_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT unique_il_il_id UNIQUE (il_id);


--
-- Name: ilanlar unique_ilanlar_ilan_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilanlar
    ADD CONSTRAINT unique_ilanlar_ilan_id UNIQUE (ilan_id);


--
-- Name: r_iletişim_bilgisi unique_iletişim_bilgisi_adress; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "unique_iletişim_bilgisi_adress" UNIQUE (adress);


--
-- Name: r_iletişim_bilgisi unique_iletişim_bilgisi_restoran_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "unique_iletişim_bilgisi_restoran_id" UNIQUE (restoran__id);


--
-- Name: r_iletişim_bilgisi unique_iletişim_bilgisi_sehir_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "unique_iletişim_bilgisi_sehir_id" UNIQUE (sehir_id);


--
-- Name: r_iletişim_bilgisi unique_iletişim_bilgisi_telefon; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "unique_iletişim_bilgisi_telefon" UNIQUE (telefon);


--
-- Name: istekler unique_istekler_istek_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istekler
    ADD CONSTRAINT unique_istekler_istek_id PRIMARY KEY (istek_id);


--
-- Name: k_iletişim_bilgisi unique_k_iletişim_bilgisi_adress; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi"
    ADD CONSTRAINT "unique_k_iletişim_bilgisi_adress" UNIQUE (adress);


--
-- Name: k_iletişim_bilgisi unique_k_iletişim_bilgisi_k_iletişim_bilgisi_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi"
    ADD CONSTRAINT "unique_k_iletişim_bilgisi_k_iletişim_bilgisi_id" UNIQUE ("k_iletişim_id");


--
-- Name: k_iletişim_bilgisi unique_k_iletişim_bilgisi_kisi_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi"
    ADD CONSTRAINT "unique_k_iletişim_bilgisi_kisi_id" UNIQUE (kisi_id);


--
-- Name: k_iletişim_bilgisi unique_k_iletişim_bilgisi_telefon; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi"
    ADD CONSTRAINT "unique_k_iletişim_bilgisi_telefon" UNIQUE (telefon);


--
-- Name: kisiler unique_kisiler_kisi_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisiler
    ADD CONSTRAINT unique_kisiler_kisi_id PRIMARY KEY (kisi_id);


--
-- Name: musteri unique_musteri_musteri_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT unique_musteri_musteri_id PRIMARY KEY (musteri_id);


--
-- Name: personel_maas unique_personel_maas_personel_maas_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_maas
    ADD CONSTRAINT unique_personel_maas_personel_maas_id PRIMARY KEY (personel_maas_id);


--
-- Name: personel unique_personel_personel_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT unique_personel_personel_id UNIQUE (personel_id);


--
-- Name: personel_saat unique_personel_saat_personel_saat_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel_saat
    ADD CONSTRAINT unique_personel_saat_personel_saat_id PRIMARY KEY (personel_saat_id);


--
-- Name: r_iletişim_bilgisi unique_r_iletişim_bilgisi_iletisim_bilgi_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "unique_r_iletişim_bilgisi_iletisim_bilgi_id" UNIQUE (iletisim_id);


--
-- Name: restoran unique_restoran_restoran_ad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restoran
    ADD CONSTRAINT unique_restoran_restoran_ad UNIQUE (restoran_ad);


--
-- Name: restoran unique_restoran_restoran_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restoran
    ADD CONSTRAINT unique_restoran_restoran_id PRIMARY KEY (restoran_id);


--
-- Name: rezervasyon_degis unique_rezervasyon_degis_rezervasyon__id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon_degis
    ADD CONSTRAINT unique_rezervasyon_degis_rezervasyon__id UNIQUE (rezervasyon__id);


--
-- Name: rezervasyon_degis unique_rezervasyon_degis_rezervasyonid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon_degis
    ADD CONSTRAINT unique_rezervasyon_degis_rezervasyonid PRIMARY KEY (rezervasyonid);


--
-- Name: rezervasyon unique_rezervasyon_musteri_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon
    ADD CONSTRAINT unique_rezervasyon_musteri_id UNIQUE (musteri_id);


--
-- Name: sehir_degisme unique_sehir_degisme_sehir_degisme_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir_degisme
    ADD CONSTRAINT unique_sehir_degisme_sehir_degisme_id UNIQUE (sehir_degisme_id);


--
-- Name: sehir_degisme unique_sehir_degisme_sehirid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir_degisme
    ADD CONSTRAINT unique_sehir_degisme_sehirid UNIQUE (sehirid);


--
-- Name: sehir unique_sehir_sehir_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT unique_sehir_sehir_id UNIQUE (sehir_id);


--
-- Name: tekdir unique_tekdir_tekdir_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tekdir
    ADD CONSTRAINT unique_tekdir_tekdir_id PRIMARY KEY (tekdir_id);


--
-- Name: personel calismagunceleme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER calismagunceleme BEFORE UPDATE ON public.personel FOR EACH ROW EXECUTE FUNCTION public.calisma_saat_guncele();


--
-- Name: personel maasgunceleme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER maasgunceleme BEFORE UPDATE ON public.personel FOR EACH ROW EXECUTE FUNCTION public.maasguncele();


--
-- Name: menu menuGunc; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "menuGunc" BEFORE UPDATE ON public.menu FOR EACH ROW EXECUTE FUNCTION public.menudegis();


--
-- Name: rezervasyon rezervasyonGuncel; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "rezervasyonGuncel" BEFORE UPDATE ON public.rezervasyon FOR EACH ROW EXECUTE FUNCTION public."rezervasyonGuncele"();


--
-- Name: sehir sehirGun; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "sehirGun" BEFORE UPDATE ON public.sehir FOR EACH ROW EXECUTE FUNCTION public."sehirGuncel"();


--
-- Name: cadde il_cadde; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cadde
    ADD CONSTRAINT il_cadde FOREIGN KEY (il_id) REFERENCES public.il(il_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: k_iletişim_bilgisi k_iletişim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi"
    ADD CONSTRAINT "k_iletişim" FOREIGN KEY (kisi_id) REFERENCES public.kisiler(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: musteri kisi_musteri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT kisi_musteri FOREIGN KEY (musteri_id) REFERENCES public.kisiler(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personel kisi_pers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT kisi_pers FOREIGN KEY (personel_id) REFERENCES public.kisiler(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: istekler musteri_istek; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istekler
    ADD CONSTRAINT musteri_istek FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rezervasyon musteri_rezer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon
    ADD CONSTRAINT musteri_rezer FOREIGN KEY (musteri_id) REFERENCES public.musteri(musteri_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ilanlar personel_ilan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilanlar
    ADD CONSTRAINT personel_ilan FOREIGN KEY (personel_id) REFERENCES public.personel(personel_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: r_iletişim_bilgisi res_iletişim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "res_iletişim" FOREIGN KEY (restoran__id) REFERENCES public.restoran(restoran_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: istekler res_istek; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.istekler
    ADD CONSTRAINT res_istek FOREIGN KEY (restoran_id) REFERENCES public.restoran(restoran_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu res_menu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT res_menu FOREIGN KEY (restoran_id) REFERENCES public.restoran(restoran_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personel res_personel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT res_personel FOREIGN KEY (restoran_id) REFERENCES public.restoran(restoran_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rezervasyon res_reza; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rezervasyon
    ADD CONSTRAINT res_reza FOREIGN KEY (restoran_id) REFERENCES public.restoran(restoran_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subeler res_sube; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeler
    ADD CONSTRAINT res_sube FOREIGN KEY (sube_id) REFERENCES public.restoran(restoran_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tekdir res_tekdir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tekdir
    ADD CONSTRAINT res_tekdir FOREIGN KEY (restoran_id) REFERENCES public.restoran(restoran_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: k_iletişim_bilgisi s_iletişim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."k_iletişim_bilgisi"
    ADD CONSTRAINT "s_iletişim" FOREIGN KEY (sehir_id) REFERENCES public.sehir(sehir_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: il sehir_il; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT sehir_il FOREIGN KEY (sehir_id) REFERENCES public.sehir(sehir_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: r_iletişim_bilgisi sehir_iletişim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."r_iletişim_bilgisi"
    ADD CONSTRAINT "sehir_iletişim" FOREIGN KEY (sehir_id) REFERENCES public.sehir(sehir_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

