package com.company;

import java.sql.SQLException;
import java.util.Scanner;

import static java.sql.DriverManager.getConnection;

public class Main {
    static veriTabani v = new veriTabani();
    static String adi;
    static String sifre;
    static Scanner scanner = new Scanner(System.in);

    private static int AMenuyuGoster() {
        System.out.println("**********************************************");
        System.out.println("islemler : ");
        System.out.println("restoran eklemek icin '1' basiniz");
        System.out.println("restoran sube eklemek icin '2' basiniz");
        System.out.println("kisi eklemek icin '3' basiniz");
        System.out.println("cikis icin '4' basiniz");
        System.out.println("secim yapiniz:");
        System.out.println("**********************************************");
        return scanner.nextInt();
    }
    private static int MMenuyuGoster() {
        System.out.println("**********************************************");
        System.out.println("islemler : ");
        System.out.println("rezervasyon eklemek icin '1' basiniz");
        System.out.println("istek eklemek icin '2' basiniz");
        System.out.println("takdir eklemek icin '3' basiniz");
        System.out.println("Musteri İletişim bilgi eklemek icin '4' basiniz");
        System.out.println("restoran Arama icin '5' basiniz");
        System.out.println("rezervasyon Guncelemek icin '6' basiniz");
        System.out.println("Sehir Guncelemek icin '7' basiniz");
        System.out.println("rezervasyon Silmek icin '8' basiniz");
        System.out.println("istek Silmek icin '9' basiniz");
        System.out.println("menu Gostermek icin '10' basiniz");
        System.out.println("rezervasyon Gostermek icin '11' basiniz");
        System.out.println("ilan Gostermek icin '12' basiniz");
        System.out.println("restorant Gostermek icin '13' basiniz");
        System.out.println("istek Gostermek icin '14' basiniz");
        System.out.println("cikis icin '15' basiniz");
        System.out.println("secim yapiniz:");
        System.out.println("**********************************************");
        return scanner.nextInt();
    }
    private static int PMenuyuGoster() {
        System.out.println("**********************************************");
        System.out.println("islemler : ");
        System.out.println("rezervasyon eklemek icin '1' basiniz");
        System.out.println("ilan eklemek icin '2' basiniz");
        System.out.println("menu eklemek icin '3' basiniz");
        System.out.println("personel İletişim bilgi eklemek icin '4' basiniz");
        System.out.println("musteri Rez Arama icin '5' basiniz");
        System.out.println("rezervasyon Guncelemek icin '6' basiniz");
        System.out.println("menu Guncelemek icin '7' basiniz");
        System.out.println("calisma Saat Guncelemek icin '8' basiniz");
        System.out.println("menu Silmek icin '9' basiniz");
        System.out.println("ilan Silmek icin '10' basiniz");
        System.out.println("cikis icin '11' basiniz");
        System.out.println("secim yapiniz:");
        System.out.println("**********************************************");
        return scanner.nextInt();
    }

    private static void adminIslemleri() throws SQLException {
        System.out.println("adi giriniz\n");
//workaround
       scanner.nextLine();

        adi = scanner.nextLine();
        System.out.println("sifre giriniz\n");
        sifre = scanner.nextLine();
        if (v.admin_giris(adi,sifre)) {
            int sec;
            do {
                sec = AMenuyuGoster();
                switch (sec)
                {
                    case 1:
                        v.restoran_ekle();
                        break;
                    case 2:
                        v.subeler_ekle();
                        break;
                    case 3:
                        v.kisi_ekle();
                        break;
                    case 4:
                        break;
                    default:
                        AMenuyuGoster();
                }
            }while(sec != 4);
    }
    }
    private static void musteriIslemleri() throws SQLException {
    System.out.println("adi giriniz\n");
        scanner.nextLine();
        adi = scanner.nextLine();
    System.out.println("sifre giriniz\n");
    sifre = scanner.nextLine();
    if (v.musteri_giris(adi,sifre) == true) {
        int sec;
        do {
            sec =MMenuyuGoster();
        switch (sec)
        {
            case 1:
                v.rezervasyonEkle();
                break;
            case 2:
                v.istekEkle();
                break;
            case 3:
                v.tekdirEkle();
                break;
            case 4:
                v.Mİletişim_bilgiEkle();
                break;
            case 5:
                v.restoranArama();
                break;
            case 6:
                v.rezervasyonGuncele();
                break;
            case 7:
                v.SehirGuncele();
                break;
            case 8:
                v.rezervasyonSil();
                break;
            case 9:
                v.istekSil();
                break;
            case 10:
                v.menuGoster();
                break;
            case 11:
                v.rezervasyonGoster();
                break;
            case 12:
                v.ilanGoster();
                break;
            case 13:
                v.restorantGoster();
                break;
            case 14:
                v.istekGoster();
                break;
            case 15:
                break;
            default:
                MMenuyuGoster();
        }
        }while(sec != 15);

    }
}
    private static void personelIslemleri() throws SQLException {
        System.out.println("adi giriniz\n");
        scanner.nextLine();
        adi = scanner.nextLine();
        System.out.println("sifre giriniz\n");
        sifre = scanner.nextLine();
        if(v.personel_giris(adi,sifre)) {
            int sec;
            do {
                sec = PMenuyuGoster();
                switch (sec) {
                    case 1:
                        v.rezervasyonEkle();
                        break;
                    case 2:
                        v.ilanEkle();
                        break;
                    case 3:
                        v.menuEkle();
                        break;
                    case 4:
                        v.Pİletişim_bilgiEkle();
                        break;
                    case 5:
                        v.musteriRezAra();
                        break;
                    case 6:
                        v.menuGuncele();
                        break;
                    case 7:
                        v.MaasGuncele();
                        break;
                    case 8:
                        v.SaatGuncele();
                        break;
                    case 9:
                        v.menuSil();
                        break;
                    case 10:
                        v.ilanSil();
                        break;
                    case 11:
                        break;
                    default:
                        PMenuyuGoster();
                }
            }while (sec != 11);
        }
    }



    public static void main(String[] args) throws SQLException {

        System.out.println("**********************************************");
        System.out.println("mortitata uygulamaya hos geldiniz");
        System.out.println("**********************************************");
        System.out.println("kulanci girisi seciniz\n");
        System.out.println("admin girisi icin 1 basiniz\n");
        System.out.println("musteri girisi icin 2 basiniz\n");
        System.out.println("personel girisi icin 3 basiniz\n");
        System.out.println("**********************************************");
        int secenek = scanner.nextInt();

        if (secenek==1){
            adminIslemleri();
        }
        else if (secenek == 2){
            musteriIslemleri();
        }
        else if (secenek == 3) {
            personelIslemleri();
        }
        else {
            System.out.println("yanlis giris .\n\n\n\n");
            main(args);
        }
        System.out.println("baska bir hesap giris icin 4 basiniz\n");
        secenek = scanner.nextInt();
        if(secenek == 4)
            main(args);
    }
}
