package com.company;

import java.sql.*;
import java.util.Scanner;

import static java.sql.DriverManager.getConnection;

public class veriTabani {
    private Scanner scanner = new Scanner(System.in);
    private int musteriId;
    private int personelId;

    private Connection baglan(){
        try{
            Connection conn = getConnection("jdbc:postgresql://localhost:5432/odev",
                    "postgres", "12345");
            return conn;
        }
        catch (SQLException e) {
            //System.out.println("Connection failure.");
            System.out.println(e.getMessage());
            //  e.printStackTrace();
            return null;
        }
    }

    public boolean personel_giris(String personel_adi, String personel_Sifre) throws SQLException {
        veriTabani b = new veriTabani();
        Connection conn = b.baglan();
        ResultSet rs = conn.createStatement().executeQuery("SELECT *  FROM personel");
        while (rs.next()) {
            if (rs.getString("personel_emill").equals(personel_adi)) {
                personelId = rs.getInt("personel_id");
                if (rs.getString("personel_sifre").equals(personel_Sifre)) {
                    rs.close();
                    conn.close();
                    return true;
                } else {
                    System.out.println("Sifre Yanlis.\n");
                    System.out.println("tekrar Sifre giriniz.\n");
                    personel_Sifre = scanner.nextLine();
                    if(personel_giris(personel_adi,personel_Sifre))
                        return true;
                    rs.close();
                    conn.close();
                    return false;
                }
            }
        }
        System.out.println("**********************************************");
        System.out.println("admin Adi ve Sifre yanlis.\n");
        System.out.println("**********************************************");
        System.out.println("yeniden adi ve sifre giriniz\n");
        System.out.println("**********************************************");
        personel_adi = scanner.nextLine();
        personel_Sifre = scanner.nextLine();
        if(personel_giris(personel_adi,personel_Sifre))
            return true;
        rs.close();
        conn.close();
        return false;
    }

    public boolean musteri_giris(String musteri_adi, String musteri_Sifre) throws SQLException {
        veriTabani b = new veriTabani();
        Connection conn = b.baglan();
        ResultSet rs = conn.createStatement().executeQuery("SELECT *  FROM musteri");

        while (rs.next()) {
            if (rs.getString("musteri_emilli").equals(musteri_adi)) {
                musteriId = rs.getInt("musteri_id");
                if (rs.getString("musteri_sifre").equals(musteri_Sifre)) {
                    rs.close();
                    conn.close();
                    return true;
                } else {
                    System.out.println("Sifre Yanlis.\n");
                    System.out.println("tekrar Sifre giriniz.\n");
                    musteri_Sifre = scanner.nextLine();
                    if(musteri_giris(musteri_adi,musteri_Sifre))
                        return true;
                    rs.close();
                    conn.close();
                    return false;
                }
            }
        }
        System.out.println("**********************************************");
        System.out.println("musteri Adi ve Sifre yanlis.\n");
        System.out.println("**********************************************");
        System.out.println("yeniden adi ve sifre giriniz\n");
        System.out.println("**********************************************");
        musteri_adi = scanner.nextLine();
       // scanner.nextLine();
        musteri_Sifre = scanner.nextLine();
        if(musteri_giris(musteri_adi,musteri_Sifre))
            return true;
        rs.close();
        conn.close();
        return false;
    }

    public boolean admin_giris(String admin_adi, String admin_Sifre) throws SQLException {
        veriTabani b = new veriTabani();
        Connection conn = b.baglan();
        ResultSet rs = conn.createStatement().executeQuery("SELECT *  FROM admin");
        while (rs.next()) {
            if (rs.getString("admin_adi").equals(admin_adi)) {
                if (rs.getString("sifre").equals(admin_Sifre)) {
                    rs.close();
                    conn.close();
                    return true;
                } else {
                    System.out.println("Sifre Yanlis.\n");
                    System.out.println("tekrar Sifre giriniz.\n");
                    admin_Sifre = scanner.nextLine();
                    if(admin_giris(admin_adi,admin_Sifre))
                        return true;
                    rs.close();
                    conn.close();
                    return false;
                }
            }
        }
        System.out.println("**********************************************");
        System.out.println("admin Adi ve Sifre yanlis.\n");
        System.out.println("**********************************************");
        System.out.println("yeniden adi ve sifre giriniz\n");
        System.out.println("**********************************************");
        admin_adi = scanner.nextLine();
        admin_Sifre = scanner.nextLine();
        if(admin_giris(admin_adi,admin_Sifre))
            return true;
        rs.close();
        conn.close();
        return false;
    }


    public void  restoran_ekle()throws SQLException{
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO restoran" + " (restoran_ad,calisma_saat) " + "VALUES (?,?)");

        System.out.println("adi girin\n");
        String ad = scanner.nextLine();
        st.setString(1, ad);

        System.out.println("calisma saat girin\n");
        ad = scanner.nextLine();
        st.setString(2, ad);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void  subeler_ekle()throws SQLException{
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO subeler"
                + " (sube_id,restoran_id,calisma_saatler) "
                + "VALUES (?,?,?)");

        System.out.println("sube_id\n");
        int id = Integer.parseInt(scanner.nextLine());
        st.setInt(1, id);

        System.out.println("restoran_id\n");
        id = Integer.parseInt(scanner.nextLine());
        st.setInt(2, id);

        System.out.println("calisma_saatler\n");
        String ad = scanner.nextLine();
        st.setString(3, ad);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void  kisi_ekle()throws SQLException{
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO kisiler"
                + " (adi,soy_ad,turu) "
                + "VALUES (?,?,?)");

        System.out.println("adi\n");
        String ad = scanner.nextLine();
        st.setString(1, ad);

        System.out.println("soy_ad\n");
        ad = scanner.nextLine();
        st.setString(2, ad);

        System.out.println("turu\n");
        ad = scanner.nextLine();
        st.setString(3, ad);
        if (ad=="musteri") {
            st = conn.prepareStatement("INSERT INTO musteri"
                    + " (musteri_emilli,musteri_sifre) "
                    + "VALUES (?,?)");
            System.out.println("musteri_emilli\n");
            ad = scanner.nextLine();
            st.setString(1, ad);

            System.out.println("musteri_sifre\n");
            ad = scanner.nextLine();
            st.setString(2, ad);
        }
        else if(ad=="personel") {
            st = conn.prepareStatement("INSERT INTO personel"
                    + " (maas,calisma_zamani,restoran_id) "
                    + "VALUES (?,?,?)");
            System.out.println("maas\n");
            ad = scanner.nextLine();
            st.setString(1, ad);

            System.out.println("calisma_zamani\n");
            ad = scanner.nextLine();
            st.setString(2, ad);

            System.out.println("restoran_id\n");
            ad = scanner.nextLine();
            st.setInt(3, Integer.parseInt(ad));
        }
        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }

    public void rezervasyonEkle() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO rezervasyon"
                + " (restoran_id,musteri_id,rezervasyon_zaman) "
                + "VALUES (?,?,?)");

        System.out.println("restoran_id\n");
        String ad = scanner.nextLine();
        st.setInt(1, Integer.parseInt(ad));

        System.out.println("musteri_id :" + musteriId + "\n");
        st.setInt(2, musteriId);

        System.out.println("rezervasyon_zaman\n");
        ad = scanner.nextLine();
        st.setString(3, ad);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void menuEkle() throws SQLException  {

        Connection conn = baglan();
        String menus;
        int fiyat ,restoran_id,menu_id;

        System.out.println("restoran_id\n");
        restoran_id = scanner.nextInt();

        System.out.println("menu_id\n");
        menu_id = scanner.nextInt();

        System.out.println("menus\n");
        menus = scanner.nextLine();

        System.out.println("fiyat\n");
        fiyat = scanner.nextInt();


        PreparedStatement st = conn.prepareStatement("SELECT * FROM KDV(?)");
        st.setInt(1,fiyat);
        ResultSet rs = st.executeQuery();
        rs.next();
        fiyat = rs.getInt(1);
        st.execute();

        st = conn.prepareStatement("INSERT INTO menu" + " (restoran_id,menus,fiyat) " + "VALUES (?,?,?)");

        st.setInt(1, restoran_id);
        st.setString(2, menus);
        st.setInt(3, fiyat);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void ilanEkle() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO ilanlar"
                + " (ilan,personel_id) "
                + "VALUES (?,?)");

        System.out.println("personel_id:"+personelId+"\n\n");
        st.setInt(2, personelId);


        System.out.println("ilan\n");
        String ad = scanner.nextLine();
        st.setString(1, ad);


        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void istekEkle() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO istekler"
                + " (restoran_id,istek) "
                + "VALUES (?,?,?)");

        System.out.println("restoran_id\n");
        String ad = scanner.nextLine();
        st.setInt(1, Integer.parseInt(ad));


        System.out.println("istek\n");
        ad = scanner.nextLine();
        st.setString(2, ad);
        st.setInt(3, musteriId);


        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void tekdirEkle() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO tekdir"
                + " (musteri_id,restoran_id,tekdir) "
                + "VALUES (?,?,?)");

        System.out.println("musteri_id :" + musteriId + "\n");


        System.out.println("restoran_id\n");
        int resID = scanner.nextInt();
        scanner.nextLine();
        System.out.println("tekdir\n");
        String tekdir = scanner.nextLine();

        ResultSet rs = conn.createStatement().executeQuery("SELECT *  FROM tekdir");
        boolean durum = true;
        while (rs.next()) {
            if (rs.getInt("musteri_id") == musteriId) {
                if (rs.getInt("restoran_id") == resID) {
                    durum = false;
                }
            }
        }
        if (durum) {
            st.setInt(1, musteriId);
            st.setString(3, tekdir);
            st.setInt(2, resID);
            st.executeUpdate();
            conn.close();
            st.close();
            System.out.println("islem yapildi\n");
        }else{

        System.out.println("islem yapilmaz ayna restorana birdan fazla takdir edilemaz\n");
        }


    }
    public void Mİletişim_bilgiEkle() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO k_iletişim_bilgisi"
                + " (kisi_id,adress,telefon) "
                + "VALUES (?,?,?)");



        System.out.println("musteri_id :" + musteriId + "\n");

        st.setInt(1, musteriId);


        System.out.println("adress\n");
        String ad = scanner.nextLine();
        st.setString(2, ad);


        System.out.println("telefon\n");
        ad = scanner.nextLine();
        st.setString(3, ad);


        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void Pİletişim_bilgiEkle() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("INSERT INTO p_iletişim_bilgisi"
                + " (sehir_id,restoran_id,adress,telefon) "
                + "VALUES (?,?,?)");


        System.out.println("musteri_id :" + musteriId + "\n");

        st.setInt(1, musteriId);


        System.out.println("adress\n");
        String ad = scanner.nextLine();
        st.setString(2, ad);


        System.out.println("telefon\n");
        ad = scanner.nextLine();
        st.setString(3, ad);


        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }


    public void restoranArama() throws SQLException {
        Connection conn = baglan();
        String adi = "awd";
        System.out.println("restoran adi giriniz");
        int id;
        adi = scanner.nextLine();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM restoranAdiAra(?)");
        st.setString(1,adi);
        ResultSet rs = st.executeQuery();
        String adresss = " ",telefonn = " ";
        if (rs.next()) {
            id = rs.getInt(3);
            st = conn.prepareStatement("SELECT * FROM restoranIletisimAra(?)");
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()){
                adresss = rs.getString(2);
                telefonn = rs.getString(3);
                System.out.println("----------------------------------------------");
                System.out.println("restoran adi :"+adi);
                System.out.println("restoran adresss :"+adresss);
                System.out.println("restoran telefonn :"+telefonn);
                System.out.println("----------------------------------------------");
            }
        }else
            System.out.println("bulunmadi!!!");


        st.execute();
        conn.close();
    }
    public void musteriRezAra() throws SQLException {
        Connection conn = baglan();
        String adi = "awd";
        System.out.println("musteri adi giriniz");

        adi = scanner.nextLine();
        int id;
        PreparedStatement st = conn.prepareStatement("SELECT * FROM musteriAra(?)");
        st.setString(1,adi);
        ResultSet rs = st.executeQuery();
        String zaman = " ";
        if (rs.next()) {
            id = rs.getInt(1);
            st = conn.prepareStatement("SELECT * FROM musteriRezaAra(?)");
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()){
                zaman = rs.getString(1);
            }
        }
        System.out.println("----------------------------------------------");
        System.out.println("musteri adi :"+adi);
        System.out.println("zaman       :"+zaman);
        System.out.println("----------------------------------------------");
        // System.out.println(adi + " " + adresss +" " + telefonn);
        st.execute();
        conn.close();
    }

    public void rezervasyonGuncele() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("UPDATE rezervasyon "
                + "SET rezervasyon_zaman = ? "
                + "WHERE rezervasyon_id = ?");

        System.out.println("rezervasyon_id\n");
        String ad = scanner.nextLine();
        st.setInt(2, Integer.parseInt(ad));

        System.out.println("rezervasyon_zaman\n");
        ad = scanner.nextLine();
        st.setString(1, ad);


        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void menuGuncele() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("UPDATE menu "
                + "SET menus = ? "
                + "WHERE menu_id = ?");

        System.out.println("menu_id\n");
        String ad = scanner.nextLine();
        st.setInt(2, Integer.parseInt(ad));

        System.out.println("menus\n");
        ad = scanner.nextLine();
        st.setString(1, ad);

        System.out.println("menus\n");
        ad = scanner.nextLine();
        st.setString(1, ad);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void SehirGuncele() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("UPDATE sehir "
                + "SET adi = ? "
                + "WHERE sehir_id = ?");

        System.out.println("sehir_id\n");
        String ad = scanner.nextLine();
        st.setInt(2, Integer.parseInt(ad));

        System.out.println("adi\n");
        ad = scanner.nextLine();
        st.setString(1, ad);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }

    public void MaasGuncele() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("UPDATE personel "
                + "SET maas = ? "
                + "WHERE personel_id = ?");

        System.out.println("personel_id:"+personelId+"\n\n");
        st.setInt(2, personelId);

        System.out.println("mass\n");
        String ad = scanner.nextLine();
        st.setInt(1, Integer.parseInt(ad));

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void SaatGuncele() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("UPDATE personel "
                + "SET calisma_zamani = ? "
                + "WHERE personel_id = ?");

        System.out.println("personel_id:"+personelId+"\n\n");
        st.setInt(2, personelId);

        System.out.println("calisma_zamani\n");
        String ad = scanner.nextLine();
        st.setInt(1, Integer.parseInt(ad));


        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }



    public void rezervasyonSil() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("DELETE FROM rezervasyon WHERE rezervasyon_id = ?");
        System.out.println("rezervasyon_id\n");
        int id = scanner.nextInt();
        st.setInt(1, id);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void menuSil() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("DELETE FROM menu WHERE menu_id = ?");
        System.out.println("menu_id\n");
        int id = scanner.nextInt();
        st.setInt(1, id);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void ilanSil() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("DELETE FROM ilanlar WHERE ilan_id = ?");
        System.out.println("ilan_id\n");
        int id = scanner.nextInt();
        st.setInt(1, id);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }
    public void istekSil() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("DELETE FROM istekler WHERE istek_id = ?");
        System.out.println("istek_id\n");
        int id = scanner.nextInt();
        st.setInt(1, id);

        st.executeUpdate();
        conn.close();
        st.close();
        System.out.println("islem yapildi\n");
    }


    public void menuGoster() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM menu WHERE menu_id = ?");
        System.out.println("menu_id");
        int id = scanner.nextInt();
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next())
        {
            for (int i = 1; i < rsmd.getColumnCount()+1;i++)
            {
                System.out.println(rsmd.getColumnName(i)+" : " + rs.getString(i)+" : "+rsmd.getColumnTypeName(i));
            }
        }
        rs.close();
        st.close();
        conn.close();
    }
    public void ilanGoster() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM ilanlar WHERE ilan_id = ?");
        System.out.println("ilan_id");
        int id = scanner.nextInt();
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next())
        {
            for (int i = 1; i < rsmd.getColumnCount()+1;i++)
            {
                System.out.println(rsmd.getColumnName(i)+" : " + rs.getString(i)+" : "+rsmd.getColumnTypeName(i));
            }
        }
        rs.close();
        st.close();
        conn.close();
    }
    public void istekGoster() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM istekler WHERE istek_id = ?");
        System.out.println("istek_id");

        int id = scanner.nextInt();
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next())
        {
            for (int i = 1; i < rsmd.getColumnCount()+1;i++)
            {
                System.out.println(rsmd.getColumnName(i)+" : " + rs.getString(i)+" : "+rsmd.getColumnTypeName(i));
            }
        }
        rs.close();
        st.close();
        conn.close();
    }
    public void restorantGoster() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM restoran WHERE restoran_id = ?");
        System.out.println("restoran_id");

        int id = scanner.nextInt();
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next())
        {
            for (int i = 1; i < rsmd.getColumnCount()+1;i++)
            {
                System.out.println(rsmd.getColumnName(i)+" : " + rs.getString(i)+" : "+rsmd.getColumnTypeName(i));
            }
        }
        rs.close();
        st.close();
        conn.close();
    }
    public void rezervasyonGoster() throws SQLException {
        Connection conn = baglan();
        PreparedStatement st = conn.prepareStatement("SELECT * FROM rezervasyon WHERE rezervasyon_id = ?");
        System.out.println("rezervasyon_id");

        int id = scanner.nextInt();
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next())
        {
            for (int i = 1; i < rsmd.getColumnCount()+1;i++)
            {
                System.out.println(rsmd.getColumnName(i)+" : " + rs.getString(i)+" : "+rsmd.getColumnTypeName(i));
            }
        }
        rs.close();
        st.close();
        conn.close();
    }

}
