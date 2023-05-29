import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CetakTransaksiSampah extends StatefulWidget {
  const CetakTransaksiSampah({super.key});

  @override
  State<CetakTransaksiSampah> createState() => _CetakTransaksiSampahState();
}

class _CetakTransaksiSampahState extends State<CetakTransaksiSampah> {
  int value = 0;
  int value2 = 0;
  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value == index) ? colorPrimary : appSecondary,
            width: (value == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value == index) ? colorPrimary : appSecondary,
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
            color: (value2 == index) ? colorPrimary : appSecondary,
            width: (value2 == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value2 = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value2 == index) ? colorPrimary : appSecondary,
              fontFamily: "Satoshi",
              fontWeight:
                  (value2 == index) ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: const Text("Transaksi Sampah", style: appFontTitlePage),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: colorBackground)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
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
                    const Text("Status Transaksi", style: appFontLabelForm),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        customRadioButton("Semua", 1),
                        const SizedBox(width: 8),
                        customRadioButton("Diterima", 2),
                        const SizedBox(width: 8),
                        customRadioButton("Ditolak", 3),
                      ],
                    )
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
                    const Text("Waktu Transaksi", style: appFontLabelForm),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          customRadioButton2("Semua", 1),
                          const SizedBox(width: 8),
                          customRadioButton2("Hari ini", 2),
                          const SizedBox(width: 8),
                          customRadioButton2("Bulan", 3)
                        ])
                  ],
                )),
            value2 == 3 ? const SizedBox(height: 8) : const SizedBox(),
            value2 == 3
                ? Container(
                    decoration: boxDecorationInput,
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Waktu Transaksi", style: appFontLabelForm)
                        ]))
                : const SizedBox()
          ],
        ),
      )),
    );
  }
}
