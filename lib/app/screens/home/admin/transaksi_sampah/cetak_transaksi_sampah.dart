// ignore_for_file: avoid_print

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'transaksisampah_controller.dart';

class CetakTransaksiSampah extends StatefulWidget {
  const CetakTransaksiSampah({super.key});

  @override
  State<CetakTransaksiSampah> createState() => _CetakTransaksiSampahState();
}

class _CetakTransaksiSampahState extends State<CetakTransaksiSampah> {
  final TransaksiSampahController control =
      Get.put(TransaksiSampahController());
  int value1 = 0;
  int value2 = 0;
  int value3 = 0;
  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value1 == index) ? colorPrimary : colorGray,
            width: (value1 == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value1 = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value1 == index) ? colorPrimary : colorGray,
              fontFamily: "Satoshi",
              fontWeight:
                  (value1 == index) ? FontWeight.w700 : FontWeight.w500)),
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

  Widget customRadioButton3(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value3 == index) ? colorPrimary : colorGray,
            width: (value3 == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value3 = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value3 == index) ? colorPrimary : colorGray,
              fontFamily: "Satoshi",
              fontWeight:
                  (value3 == index) ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: const Text("Cetak Transaksi", style: appFontTitlePage),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Waktu Transaksi",
                              style: appFontLabelForm),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                customRadioButton3("Mei", 1),
                                const SizedBox(width: 8),
                                customRadioButton3("Juni", 2),
                                const SizedBox(width: 8),
                                customRadioButton3("Juli", 3)
                              ])
                        ]))
                : const SizedBox(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                  onPressed: () {
                    if (value1 == 1 && value2 == 1) {
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Semua jenis transaksi semua waktu");
                    }
                    if (value1 == 1 && value2 == 2) {
                      print("Semua jenis transaksi hari ini");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 1) {
                      print("Semua jenis transaksi bulan Mei");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 2) {
                      print("Semua jenis transaksi bulan Juni");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 3) {
                      print("Semua jenis transaksi bulan Juli");
                    }
                    if (value1 == 2 && value2 == 1) {
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Transaksi diterima semua waktu");
                    }
                    if (value1 == 2 && value2 == 2) {
                      print("Transaksi diterima hari ini");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 1) {
                      print("Transaksi diterima bulan mei");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 2) {
                      print("Transaksi diterima bulan juni");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 3) {
                      print("Transaksi diterima bulan juli");
                    }
                    if (value1 == 3 && value2 == 1) {
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Transaksi ditolak semua waktu");
                    }
                    if (value1 == 3 && value2 == 2) {
                      print("Transaksi ditolak hari ini");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 1) {
                      print("Transaksi diterima bulan mei");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 2) {
                      print("Transaksi diterima bulan juni");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 3) {
                      print("Transaksi diterima bulan juli");
                    }
                  },
                  style: btnStylePrimary,
                  child: const Text("Cetak Transaksi", style: appFontButton)),
            )
          ],
        ),
      )),
    );
  }
}
