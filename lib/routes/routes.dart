// import 'package:flutter/widgets.dart';
import 'package:aplikasi_sampah/app/screens/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:aplikasi_sampah/app/screens/index.dart';
import 'links.dart';

class AppRoutes {
  final HomeController homeC = Get.put(HomeController());
  static final pages = [
    GetPage(
      name: AppLinks.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppLinks.SIGNUP,
      page: () => const DaftarScreen(),
    ),
    GetPage(
        name: AppLinks.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: AppLinks.PROFIL,
        page: () => const ProfilView(),
        binding: ProfilBinding()),
    GetPage(
      name: AppLinks.PROFIL_SAYA,
      page: () => const ProfilWargaView(),
    ),
    GetPage(
      name: AppLinks.PROFIL_RESET,
      page: () => const ResetPasswordView(),
    ),

    //Warga//
    GetPage(
        name: AppLinks.KIRIM_SAMPAH,
        page: () => const KirimSampahView(),
        binding: KirimBinding()),
    GetPage(
        name: AppLinks.TUKAR_POIN,
        page: () => const TukarPoinView(),
        binding: TukarBinding()),
    GetPage(
      name: AppLinks.TUKAR_POIN_HISTORY,
      page: () => const RiwayatTukarView(),
    ),
    // GetPage(
    //   name: AppLinks.TUKAR_POIN_PRODUK,
    //   page: () => const DetailProdukView(poinW: null,),
    // ),
    GetPage(
      name: AppLinks.TUKAR_POIN_DETAIL,
      page: () => const DetailPenukaranView(),
    ),
    GetPage(
        name: AppLinks.RIWAYAT,
        page: () => const RiwayatView(),
        binding: RiwayatBinding()),

    //Petugas//
    GetPage(
        name: AppLinks.PROFIL_PETUGAS,
        page: () => const ProfilPetugas(),
        binding: ProfilPetugasBinding()),
    GetPage(
        name: AppLinks.RIWAYAT_PENGAMBILAN,
        page: () => RiwayatPengambilan(),
        binding: RiwayatPengambilanBinding()),
    GetPage(
        name: AppLinks.REQUEST_PENGAMBILAN,
        page: () => const RequestPengambilan(),
        binding: RequestPengambilanBinding()),

    //Admin//
    GetPage(
        name: AppLinks.PROFIL_ADMIN,
        page: () => const ProfilAdmin(),
        binding: ProfilAdminBinding()),
    GetPage(
        name: AppLinks.KELOLA_PETUGAS,
        page: () => const KelolaPetugas(),
        binding: AddPetugasBinding()),
    GetPage(
        name: AppLinks.TAMBAH_PETUGAS,
        page: () => const AddPetugas(),
        binding: AddPetugasBinding()),
    GetPage(
        name: AppLinks.KELOLA_PRODUK,
        page: () => const ProdukView(),
        binding: ProdukBinding()),
    GetPage(
        name: AppLinks.TAMBAH_PRODUK,
        page: () => const TambahProdukView(),
        binding: ProdukBinding()),
    GetPage(
        name: AppLinks.EDIT_PRODUK,
        page: () => const EditProdukView(),
        binding: ProdukBinding()),
    GetPage(
        name: AppLinks.TRANSAKSI_POIN,
        page: () => const TransaksiPoinView(),
        binding: TransaksiPoinBinding()),
    GetPage(
        name: AppLinks.DETAIL_TRANSAKSI_POIN,
        page: () => const DetailTransaksiPoin(),
        binding: TransaksiPoinBinding()),
    GetPage(
        name: AppLinks.TRANSAKSI_SAMPAH,
        page: () => const TransaksiSampahView(),
        binding: TransaksiSampahBinding()),
    GetPage(
        name: AppLinks.DETAIL_TRANSAKSI_SAMPAH,
        page: () => const DetailTransaksiSampah(),
        binding: TransaksiSampahBinding()),
    GetPage(
        name: AppLinks.CETAK_TRANSAKSI_SAMPAH,
        page: () => const CetakTransaksiSampah(),
        binding: TransaksiSampahBinding()),
  ];
}
