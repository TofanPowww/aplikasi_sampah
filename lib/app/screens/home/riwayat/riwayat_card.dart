// ignore_for_file: use_key_in_widget_constructors

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:flutter/material.dart';
import '../../../data/riwayatModel.dart';

class RiwayatCard extends StatelessWidget {
  final Riwayat _riwayat;

  const RiwayatCard(this._riwayat);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      color: appBackgroundSecondary,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${_riwayat.tgl}",
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Satoshi",
                  fontWeight: FontWeight.w600,
                  color: appPrimary),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "RT/RW",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Satoshi",
                      fontWeight: FontWeight.w500,
                      color: appSecondary),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "${_riwayat.rt} / ${_riwayat.rw}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Satoshi",
                      fontWeight: FontWeight.w400,
                      color: appSecondary),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
