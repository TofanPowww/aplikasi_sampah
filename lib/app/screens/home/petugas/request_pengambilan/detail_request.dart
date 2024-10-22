import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../service/notification.dart';
import 'request_pengambilan_controller.dart';

class DetailRequestView extends StatefulWidget {
  const DetailRequestView({super.key});

  @override
  State<DetailRequestView> createState() => _DetailRequestVieqState();
}

class _DetailRequestVieqState extends State<DetailRequestView> {
  final RequestPengambilanController kirimC =
      Get.put(RequestPengambilanController());
  RxBool isLoading = false.obs;
  RxBool isWaiting = true.obs;
  RxBool isTolak = false.obs;
  RxBool isAmbil = false.obs;
  String token = "";
  int value = 0;
  int value2 = 0;

  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value == index) ? colorPrimary : colorGray,
            width: (value == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value == index) ? colorPrimary : colorGray,
              fontFamily: "Satoshi",
              fontWeight:
                  (value == index) ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  Widget customRadioButton2(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value2 == index) ? colorPrimary : colorGray,
            width: (value2 == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value2 = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value2 == index) ? colorPrimary : colorGray,
              fontFamily: "Satoshi",
              fontWeight:
                  (value2 == index) ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController jmlhOrganik = TextEditingController(text: "0.0");
    TextEditingController jmlhAnorganik = TextEditingController(text: "0.0");
    TextEditingController ket = TextEditingController(text: "-");
    final request =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String idPermintaan = request['id'];
    String emailWarga = request['email'];
    String tglPermintaan = request['tanggal'];

    Future wargaStream() async {
      return kirimC.usersDb.doc(emailWarga).get();
    }

    return Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          title: const Text("Detail Permintaan", style: appFontTitlePage),
          centerTitle: true,
          backgroundColor: colorPrimary,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: colorBackground)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: boxDecorationInput,
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Email", style: appFontFormInput),
                                const SizedBox(height: 4),
                                Text(request['email'], style: appFontHeding2),
                              ],
                            )),
                        const SizedBox(height: 8),
                        Container(
                            decoration: boxDecorationInput,
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Nama Warga",
                                    style: appFontFormInput),
                                const SizedBox(height: 4),
                                Text(request['nama'], style: appFontHeding2),
                              ],
                            )),
                        const SizedBox(height: 8),
                        Container(
                            decoration: boxDecorationInput,
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("RT/RW", style: appFontFormInput),
                                const SizedBox(height: 4),
                                Text("${request['rt']} / ${request['rw']}",
                                    style: appFontHeding2),
                              ],
                            )),
                        const SizedBox(height: 8),
                      ],
                    ),
                    Obx(() => isWaiting.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: boxDecorationInput,
                                  padding: const EdgeInsets.all(16),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Foto",
                                          style: appFontFormInput),
                                      const SizedBox(height: 8),
                                      Center(
                                        child: SizedBox(
                                            width: 300,
                                            height: 300,
                                            child: Image(
                                              image: NetworkImage(
                                                  request['foto_sampah']),
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color:
                                                                colorPrimary));
                                              },
                                            )),
                                      )
                                    ],
                                  )),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          backgroundColor: colorBackground2,
                                          barrierDismissible: false,
                                          title: "Konfirmasi",
                                          content: const Text(
                                            "Apakah yakin ingin ambil sampah?",
                                            style: appFontFormInput,
                                          ),
                                          titleStyle: appFontFormInputa,
                                          titlePadding: const EdgeInsets.only(
                                              top: 16, bottom: 8),
                                          contentPadding: const EdgeInsets.only(
                                              bottom: 16, right: 16, left: 16),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Tidak",
                                                    style: appFontFormInput)),
                                            ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          colorAccent),
                                                ),
                                                onPressed: () {
                                                  wargaStream().then((value) {
                                                    setState(() {
                                                      token = value['token'];
                                                    });
                                                  }).whenComplete(() {
                                                    FirebaseApi().sendPushMessage(
                                                        token,
                                                        "Permintaan Diterima",
                                                        "Petugas akan mengambil sampah Anda");
                                                  });
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    isWaiting.value = false;
                                                    isAmbil.value = true;
                                                    value = 7;
                                                  });
                                                },
                                                child: const Text("Ya",
                                                    style: appFontButtonb))
                                          ]);
                                    },
                                    style: btnStylePrimary,
                                    child: const Text("Ambil Sampah",
                                        style: appFontButton)),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          backgroundColor: colorBackground2,
                                          barrierDismissible: false,
                                          title: "Konfirmasi",
                                          content: const Text(
                                            "Apakah yakin menolak permintaan?",
                                            style: appFontFormInput,
                                          ),
                                          titleStyle: appFontFormInputa,
                                          titlePadding: const EdgeInsets.only(
                                              top: 16, bottom: 8),
                                          contentPadding: const EdgeInsets.only(
                                              bottom: 16, right: 16, left: 16),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Tidak",
                                                    style: appFontFormInput)),
                                            ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          colorAccent),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    isWaiting.value = false;
                                                    isTolak.value = true;
                                                  });
                                                },
                                                child: const Text("Ya",
                                                    style: appFontButtonb))
                                          ]);
                                    },
                                    style: btnStyleOutline,
                                    child: const Text(
                                      "Tolak Permintaan",
                                      style: appFontButtonb,
                                    )),
                              )
                            ],
                          )
                        : const SizedBox()),
                    Obx(() => isWaiting.value
                        ? const SizedBox()
                        : isTolak.value == true
                            ? _tolakPermintaan(
                                idPermintaan,
                                emailWarga,
                                tglPermintaan,
                                jmlhOrganik.text.trim(),
                                jmlhAnorganik.text.trim())
                            : isAmbil.value == true && isTolak.value == false
                                ? _ambilPermintaan(idPermintaan, emailWarga,
                                    tglPermintaan, jmlhAnorganik, ket)
                                : const SizedBox())
                  ])

              // const SizedBox(height: 16),
              // SizedBox(
              //     width: double.infinity,
              //     height: 56,
              //     child: Obx(() => ElevatedButton(
              //         onPressed: () {
              //           kirimC.isLoading.value
              //               ? null
              //               : status == "" || status == "Menunggu"
              //                   ? Get.snackbar("Gagal", "Tentukan status transaksi",
              //                       backgroundColor: appDanger,
              //                       snackPosition: SnackPosition.TOP,
              //                       margin: const EdgeInsets.only(
              //                           bottom: 10, right: 10, left: 10))
              //                   : value == 7 && status == "Diterima"
              //                       ? Get.snackbar(
              //                           "Gagal", "Tentukan jenis sampah Anorganik",
              //                           backgroundColor: appDanger,
              //                           snackPosition: SnackPosition.TOP,
              //                           margin: const EdgeInsets.only(
              //                               bottom: 10, right: 10, left: 10))
              //                       : value == 7 && status == "Ditolak"
              //                           ? kirimC.updateTransaksi(
              //                               request['id'].toString(),
              //                               request['email'].toString(),
              //                               request['tgl'].toString(),
              //                               double.parse(jmlhOrganik.text.trim()),
              //                               double.parse(
              //                                   jmlhAnorganik.text.trim()),
              //                               status!.trim(),
              //                               kirimC.keteranganC.text.trim(),
              //                               value)
              //                           : value == 6
              //                                Anorganik Tidak Ada
              //                               ? kirimC.updateTransaksi(
              //                                   request['id'].toString(),
              //                                   request['email'].toString(),
              //                                   request['tgl'].toString(),
              //                                   double.parse(kirimC
              //                                       .jumlahOrganikC.text
              //                                       .trim()),
              //                                   double.parse(jmlhAnorganik.text.trim()),
              //                                   status!.trim(),
              //                                   ket.text.trim(),
              //                                   0)
              //                               : value == 5
              //                                   ? kirimC.updateTransaksi(request['id'].toString(), request['email'].toString(), request['tgl'].toString(), double.parse(kirimC.jumlahOrganikC.text.trim()), double.parse(kirimC.jumlahAnorganikC.text.trim()), status!.trim(), ket.text.trim(), 15)
              //                                   : kirimC.updateTransaksi(request['id'].toString(), request['email'].toString(), request['tgl'].toString(), double.parse(kirimC.jumlahOrganikC.text.trim()), double.parse(kirimC.jumlahAnorganikC.text.trim()), status!.trim(), ket.text.trim(), value2);
              //         },
              //         style: btnStylePrimary,
              //         child: status == "Ditolak"
              //             ? kirimC.isLoading.value
              //                 ? const Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       CircularProgressIndicator(
              //                           color: colorBackground),
              //                       SizedBox(width: 16),
              //                       Text("Sedang memuat...",
              //                           style: appFontButton),
              //                     ],
              //                   )
              //                 : const Text("Konfirmasi Pembatalan",
              //                     style: appFontButton)
              //             : kirimC.isLoading.value
              //                 ? const Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       CircularProgressIndicator(
              //                           color: colorBackground),
              //                       SizedBox(width: 16),
              //                       Text("Sedang memuat...",
              //                           style: appFontButton),
              //                     ],
              //                   )
              //                 : const Text("Konfirmasi Pengambilan",
              //                     style: appFontButton)))),
              ),
        )));
  }

  _ambilPermintaan(String id, String email, String tgl,
      TextEditingController jmlhAnorganik, TextEditingController ket) {
    return Column(
      children: [
        Container(
          decoration: boxDecorationInput,
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height:
              value == 1 || value == 2 || value == 3 || value == 4 ? 500 : 400,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
              child: Text("Jumlah", style: appFontFormInput),
            ),
            const SizedBox(height: 8),
            const Text("Organik", style: appFontFormInput),
            const SizedBox(height: 4),
            Expanded(
                child: TextFormField(
              controller: kirimC.jumlahOrganikC,
              maxLines: 1,
              keyboardType: TextInputType.number,
              style: appFontHeding2,
              cursorColor: colorPrimary,
              cursorHeight: 25,
              decoration: const InputDecoration(
                  filled: true,
                  enabled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: focusInputBorder,
                  fillColor: colorSecondary,
                  enabledBorder: enableInputBorder),
            )),
            const SizedBox(height: 8),
            const Text("Anorganik", style: appFontFormInput),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: customRadioButton("Plastik", 1)),
                const SizedBox(width: 4),
                Expanded(child: customRadioButton("Kertas", 2)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: customRadioButton("Logam", 3)),
                const SizedBox(width: 4),
                Expanded(child: customRadioButton("Kaca", 4)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: customRadioButton("Campuran", 5)),
                const SizedBox(width: 4),
                Expanded(child: customRadioButton("Tidak Ada", 6)),
              ],
            ),
            const SizedBox(height: 4),
            value == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Jenis Plastik", style: appFontFormInput),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: customRadioButton2("Plastik Kemasan", 1)),
                          const SizedBox(width: 4),
                          Expanded(
                              child: customRadioButton2("Plastik Kresek", 2))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: customRadioButton2("Gelas/Botol", 3)),
                          const SizedBox(width: 4),
                          Expanded(
                              flex: 1,
                              child: customRadioButton2("Plastik Minum", 4)),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            value == 2
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Jenis Kertas", style: appFontFormInput),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: customRadioButton2("Arsip", 5)),
                          const SizedBox(width: 4),
                          Expanded(child: customRadioButton2("Koran", 6))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: customRadioButton2("Kardus", 7)),
                          const SizedBox(width: 4),
                          Expanded(
                              child: customRadioButton2("Kertas Campur", 8)),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            value == 3
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Jenis Logam", style: appFontFormInput),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: customRadioButton2("Seng", 9)),
                          const SizedBox(width: 4),
                          Expanded(child: customRadioButton2("Besi", 10))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: customRadioButton2("Aluminium", 11)),
                          const SizedBox(width: 4),
                          Expanded(child: customRadioButton2("Tembaga", 12)),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            value == 4
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Jenis Kaca", style: appFontFormInput),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: customRadioButton2("Beling", 13)),
                          const SizedBox(width: 4),
                          Expanded(child: customRadioButton2("Botol Kaca", 14))
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            Expanded(
                child: value == 6
                    ? TextFormField(
                        readOnly: true,
                        controller: jmlhAnorganik,
                        style: appFontHeding2,
                        decoration: const InputDecoration(
                            filled: true,
                            enabled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: focusInputBorder,
                            fillColor: colorSecondary,
                            enabledBorder: enableInputBorder),
                      )
                    : TextFormField(
                        controller: kirimC.jumlahAnorganikC,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style: appFontHeding2,
                        cursorColor: colorPrimary,
                        cursorHeight: 25,
                        decoration: const InputDecoration(
                            filled: true,
                            enabled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: focusInputBorder,
                            fillColor: colorSecondary,
                            enabledBorder: enableInputBorder),
                      )),
          ]),
        ),
        const SizedBox(height: 32),
        SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
                onPressed: () {
                  // Cek Apakah Jenis Anorganik Kosong?
                  value == 7
                      ? Get.snackbar("Gagal", "Tentukan jenis sampah Anorganik",
                          backgroundColor: appDanger,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.only(
                              bottom: 10, right: 10, left: 10))
                      : value == 6
                          // Anorganik Tidak Ada
                          ? kirimC
                              .updateTransaksi(
                                  id,
                                  email,
                                  tgl,
                                  double.parse(
                                      kirimC.jumlahOrganikC.text.trim()),
                                  double.parse(jmlhAnorganik.text.trim()),
                                  "Diterima",
                                  ket.text.trim(),
                                  0)
                              .whenComplete(() {
                              kirimC.jumlahOrganikC.clear();
                            })
                          : value == 5
                              // Anorganik Campuran
                              ? kirimC
                                  .updateTransaksi(
                                      id,
                                      email,
                                      tgl,
                                      double.parse(
                                          kirimC.jumlahOrganikC.text.trim()),
                                      double.parse(
                                          kirimC.jumlahAnorganikC.text.trim()),
                                      "Diterima",
                                      ket.text.trim(),
                                      15)
                                  .whenComplete(() {
                                  kirimC.jumlahOrganikC.clear();
                                  kirimC.jumlahOrganikC.clear();
                                })
                              : kirimC
                                  .updateTransaksi(
                                      id,
                                      email,
                                      tgl,
                                      double.parse(
                                          kirimC.jumlahOrganikC.text.trim()),
                                      double.parse(
                                          kirimC.jumlahAnorganikC.text.trim()),
                                      "Diterima",
                                      ket.text.trim(),
                                      value2)
                                  .whenComplete(() {
                                  kirimC.jumlahOrganikC.clear();
                                  kirimC.jumlahAnorganikC.clear();
                                });
                },
                style: btnStylePrimary,
                child: const Text("Konfirmasi Pengambilan",
                    style: appFontButton))),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
              onPressed: () {
                setState(() {
                  isWaiting.value = true;
                  isAmbil.value = false;
                });
              },
              child: const Text("Batal", style: appFontFormInputd)),
        )
      ],
    );
  }

  _tolakPermintaan(
      String id, String email, String tgl, String organik, String anorganik) {
    return Column(
      children: [
        Container(
          decoration: boxDecorationInput,
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Keterangan", style: appFontFormInput),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                    child: TextFormField(
                  controller: kirimC.keteranganC,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  keyboardType: TextInputType.text,
                  style: appFontFormInput,
                  cursorColor: colorPrimary,
                  cursorHeight: 25,
                  decoration: const InputDecoration(
                    filled: true,
                    enabled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: focusInputBorder,
                    fillColor: colorSecondary,
                    enabledBorder: enableInputBorder,
                  ),
                )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
                onPressed: () {
                  kirimC.updateTransaksi(
                      id,
                      email,
                      tgl,
                      double.parse(organik),
                      double.parse(anorganik),
                      "Ditolak",
                      kirimC.keteranganC.text.trim(),
                      16);
                },
                style: btnStylePrimary,
                child:
                    const Text("Konfirmasi Penolakan", style: appFontButton))),
        Center(
          child: TextButton(
              onPressed: () {
                setState(() {
                  isWaiting.value = true;
                  isTolak.value = false;
                });
              },
              child: const Text("Batal", style: appFontFormInputd)),
        )
      ],
    );
  }
}
