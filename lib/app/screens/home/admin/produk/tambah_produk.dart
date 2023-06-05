import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'produk_controller.dart';

class TambahProdukView extends StatefulWidget {
  const TambahProdukView({super.key});

  @override
  State<TambahProdukView> createState() => _TambahProdukViewState();
}

class _TambahProdukViewState extends State<TambahProdukView> {
  RxBool isLoading = false.obs;
  final ProdukController control = Get.put(ProdukController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Tambah Produk", style: appFontTitlePage),
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
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama produk", style: appFontHeding3a),
            const SizedBox(height: 8),
            TextFormField(
                controller: control.namaProdukAdd,
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
                controller: control.poinProdukAdd,
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
            const SizedBox(height: 16),
            const Text("Deskripsi produk", style: appFontHeding3a),
            const SizedBox(height: 8),
            TextFormField(
                controller: control.desProdukAdd,
                maxLines: 3,
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
            const SizedBox(height: 32),
            SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                    onPressed: () async {
                      await control
                          .tambahProduk(
                        control.namaProdukAdd.text.trim(),
                        control.desProdukAdd.text.trim(),
                        int.parse(control.poinProdukAdd.text.trim()),
                      )
                          .whenComplete(() {
                        control.namaProdukAdd.clear();
                        control.desProdukAdd.clear();
                        control.poinProdukAdd.clear();
                      });
                    },
                    style: btnStylePrimary,
                    child: const Text("Tambah", style: appFontButton)))
          ],
        )),
      )),
    );
  }
}
