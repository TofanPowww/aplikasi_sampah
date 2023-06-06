// ignore_for_file: await_only_futures

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/app/screens/home/admin/produk/produk_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProdukView extends StatefulWidget {
  const EditProdukView({super.key});

  @override
  State<EditProdukView> createState() => _EditProdukViewState();
}

class _EditProdukViewState extends State<EditProdukView> {
  RxBool isLoading = false.obs;
  final ProdukController produkC = Get.put(ProdukController());
  @override
  Widget build(BuildContext context) {
    final produkData = Get.arguments as Map<String, dynamic>;
    produkC.namaProdukC.text = produkData['nama'];
    produkC.desProdukC.text = produkData['deskripsi'];
    produkC.poinProdukC.text = produkData['poin'].toString();

    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Detail Produk", style: appFontTitlePage),
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
                const Text("Nama produk", style: appFontHeding3a),
                const SizedBox(height: 8),
                TextFormField(
                    controller: produkC.namaProdukC,
                    autocorrect: false,
                    style: appFontLabelForm,
                    keyboardType: TextInputType.name,
                    cursorColor: colorPrimary,
                    cursorHeight: 25,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: colorSecondary,
                        enabledBorder: enableInputBorder,
                        focusedBorder: focusInputBorder)),
                const SizedBox(height: 16),
                const Text("Deskripsi produk", style: appFontHeding3a),
                const SizedBox(height: 8),
                TextFormField(
                    controller: produkC.desProdukC,
                    autocorrect: false,
                    style: appFontLabelForm,
                    keyboardType: TextInputType.text,
                    cursorColor: colorPrimary,
                    cursorHeight: 25,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: colorSecondary,
                        enabledBorder: enableInputBorder,
                        focusedBorder: focusInputBorder)),
                const SizedBox(height: 16),
                const Text("Poin produk", style: appFontHeding3a),
                const SizedBox(height: 8),
                TextFormField(
                    controller: produkC.poinProdukC,
                    autocorrect: false,
                    style: appFontLabelForm,
                    keyboardType: TextInputType.number,
                    cursorColor: colorPrimary,
                    cursorHeight: 25,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: colorSecondary,
                        enabledBorder: enableInputBorder,
                        focusedBorder: focusInputBorder)),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                      onPressed: () {
                        produkC
                            .updateProduk(produkData['produk_id'])
                            .toString()
                            .trim();
                      },
                      style: btnStylePrimary,
                      child: const Text("Edit", style: appFontButton)),
                ),
                const SizedBox(height: 16),
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
                                  "Apakah ingin menghapus produk?",
                                  style: appFontFormInput),
                              titleStyle: appFontFormInputa,
                              titlePadding:
                                  const EdgeInsets.only(top: 16, bottom: 8),
                              contentPadding: const EdgeInsets.only(
                                  bottom: 16, left: 16, right: 16),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Tidak",
                                      style: appFontFormInput,
                                    )),
                                ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(colorAccent),
                                    ),
                                    onPressed: () async {
                                      produkC.deleteProduk(
                                          produkData['produk_id']
                                              .toString()
                                              .trim());
                                    },
                                    child:
                                        const Text("Ya", style: appFontButtonb))
                              ]);
                        },
                        style: btnStyleAccent,
                        child: const Text("Hapus", style: appFontButtonb)))
              ],
            )),
      )),
    );
  }
}
