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
                  (value3 == index) ? FontWeight.w600 : FontWeight.w500)),
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
                          const Text("Bulan Transaksi",
                              style: appFontLabelForm),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: customRadioButton3("Januari", 1)),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: customRadioButton3("Februari", 2)),
                                const SizedBox(width: 8),
                                Expanded(child: customRadioButton3("Maret", 3)),
                                const SizedBox(width: 8),
                              ]),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: customRadioButton3("April", 4)),
                              const SizedBox(width: 8),
                              Expanded(child: customRadioButton3("Mei", 5)),
                              const SizedBox(width: 8),
                              Expanded(child: customRadioButton3("Juni", 6)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: customRadioButton3("Juli", 7)),
                              const SizedBox(width: 4),
                              Expanded(
                                  flex: 2,
                                  child: customRadioButton3("Agustus", 8)),
                              const SizedBox(width: 4),
                              Expanded(
                                  flex: 2,
                                  child: customRadioButton3("September", 9)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: customRadioButton3("Oktober", 10)),
                              const SizedBox(width: 4),
                              Expanded(
                                  child: customRadioButton3("November", 11)),
                              const SizedBox(width: 4),
                              Expanded(
                                  child: customRadioButton3("Desember", 12))
                            ],
                          )
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
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Semua jenis transaksi hari ini");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 1) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 1");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 2) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 2");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 3) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 3");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 4) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 4");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 5) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 5");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 6) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 6");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 7) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 7");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 8) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 8");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 9) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 9");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 10) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 10");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 11) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 11");
                    }
                    if (value1 == 1 && value2 == 3 && value3 == 12) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Semua jenis transaksi bulan 12");
                    }
                    if (value1 == 2 && value2 == 1) {
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Transaksi diterima semua waktu");
                    }
                    if (value1 == 2 && value2 == 2) {
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Transaksi diterima hari ini");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 1) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 1");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 2) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 2");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 3) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 3");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 4) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 4");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 5) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 5");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 6) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 6");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 7) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 7");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 8) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 8");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 9) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 9");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 10) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 10");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 11) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 11");
                    }
                    if (value1 == 2 && value2 == 3 && value3 == 12) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 12");
                    }
                    if (value1 == 3 && value2 == 1) {
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Transaksi ditolak semua waktu");
                    }
                    if (value1 == 3 && value2 == 2) {
                      control.cetakTransaksiSampah(value1, value2, 0);
                      print("Transaksi ditolak hari ini");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 1) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 1");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 2) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 2");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 3) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 3");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 4) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 4");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 5) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 5");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 6) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 6");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 7) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 7");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 8) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 8");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 9) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 9");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 10) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 10");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 11) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 11");
                    }
                    if (value1 == 3 && value2 == 3 && value3 == 12) {
                      control.cetakTransaksiSampah(value1, value2, value3);
                      print("Transaksi diterima bulan 12");
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
