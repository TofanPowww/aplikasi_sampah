import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/app/screens/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tukar_controller.dart';

class DetailProdukView extends StatefulWidget {
  const DetailProdukView({super.key, required this.poinW});

  final int poinW;
  @override
  State<DetailProdukView> createState() => _DetailProdukViewState();
}

class _DetailProdukViewState extends State<DetailProdukView> {
  @override
  void initState() {
    super.initState();
  }

  RxBool isLoading = false.obs;

  final AuthController authC = Get.put(AuthController());
  final TukarController tukarC = Get.put(TukarController());
  @override
  Widget build(BuildContext context) {
    // print("${authC.user.value.poin}");
    final produk = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
          title: const Text("Detail Produk", style: appFontTitlePage),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: colorBackground)),
          backgroundColor: colorPrimary),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama Produk", style: appFontFormInput),
                    const SizedBox(height: 8),
                    Text(produk['nama'], style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 16),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Deskripsi Produk", style: appFontFormInput),
                    const SizedBox(height: 8),
                    Text(produk['deskripsi'], style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 16),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Poin Produk", style: appFontFormInput),
                    const SizedBox(height: 8),
                    Text(produk['poin'].toString(), style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 24),
            SizedBox(
                width: double.infinity,
                height: 56,
                child: widget.poinW >= produk['poin']
                    ? ElevatedButton(
                        onPressed: () async {
                          if (isLoading.isFalse) return;
                          isLoading(true);
                          await tukarC.transaksiTukar(
                              produk['nama'].toString().trim(),
                              int.parse(produk['poin'].toString().trim()));
                          isLoading(false);
                          // Get.defaultDialog(
                          //     backgroundColor: colorBackground2,
                          //     barrierDismissible: false,
                          //     title: "Konfirmasi Penukaran",
                          //     content: const Text(
                          //       "Apakah yakin ingin menukar?",
                          //       style: appFontFormInput,
                          //     ),
                          //     titleStyle: appFontFormInputa,
                          //     titlePadding:
                          //         const EdgeInsets.only(top: 16, bottom: 8),
                          //     contentPadding: const EdgeInsets.only(bottom: 16),
                          //     actions: [
                          //       TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //           child: const Text("Tidak",
                          //               style: appFontFormInput)),
                          //       ElevatedButton(
                          //           style: const ButtonStyle(
                          //             backgroundColor:
                          //                 MaterialStatePropertyAll(colorAccent),
                          //           ),
                          //           onPressed: () {
                          //             setState(() {
                          //               tukarC.transaksiTukar(
                          //                   produk['nama'].toString().trim(),
                          //                   int.parse(produk['poin']
                          //                       .toString()
                          //                       .trim()));
                          //             });
                          //           },
                          //           child:
                          //               const Text("Ya", style: appFontButtonb))
                          //     ]);
                          // });
                        },
                        style: btnStylePrimary,
                        child: Obx(() => isLoading.isFalse
                            ? const Text(
                                "Tukar",
                                style: appFontButton,
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                      color: colorBackground),
                                  SizedBox(width: 24),
                                  Text('Sedang memuat...', style: appFontButton)
                                ],
                              )))
                    : ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(colorBackground),
                            side: MaterialStatePropertyAll(BorderSide(
                                width: 1.5, color: Colors.grey.shade500)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        child: Text("Poin Tidak Cukup",
                            style: TextStyle(
                                fontFamily: "Satoshi",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500))))
          ],
        ),
      ))),
    );
  }
}
