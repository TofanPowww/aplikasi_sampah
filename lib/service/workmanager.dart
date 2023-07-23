// ignore_for_file: avoid_print

import 'package:aplikasi_sampah/app/screens/home/profil/profil_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

// import '../app/screens/home/warga/tukar/tukar_controller.dart';

//TODO: Menambahkan Fungsi Delete Task Jika Transaksi Selesai

final db = FirebaseFirestore.instance;
const taskActive = "CodeActived";
const testTask = "Test";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == testTask) {
        print("$testTask was executed.");
        String emailuy = inputData!['email'];
        String iduy = inputData['idTest'];
        print("Email = $emailuy");
        print("ID = $iduy");
        await Firebase.initializeApp();
        await initializeDateFormatting('id_ID', null)
            .then((_) => ProfilController().coba(emailuy));
      }
    } catch (e) {
      debugPrint('$callbackDispatcher error: $e');
    }
    return Future.value(true);
    // switch (task) {
    //   case taskActive:
    //     print("$taskActive was executed. inputData = $inputData");
    //     final prefs = await SharedPreferences.getInstance();
    //     prefs.setBool("test", true);
    //     print("Bool from prefs: ${prefs.getBool("test")}");
    //     // Update status transaksi
    //     await Firebase.initializeApp();
    //     final email = inputData!['email'];
    //     final idTransaksi = inputData['idTransaksi'];
    //     TukarController().updateData(idTransaksi, email);
    //     // CollectionReference userDB = db.collection("users");
    //     // CollectionReference transaksiTukarDB = db.collection("transaksiTukar");
    //     // final tukarUser = userDB.doc(email).collection("tukar");
    //     // tukarUser.doc(idTransaksi).update({"status": "Batal"});
    //     // transaksiTukarDB.doc(idTransaksi).update({"status": "Batal"});
    //     print("Email: $email");
    //     print("Email: $idTransaksi");
    //     print("$taskActive done!");
    //     break;
    //   case simpleDelayedTask:
    //     print("$simpleDelayedTask was executed. inputData = $inputData");
    //     await Firebase.initializeApp();
    //     await initializeDateFormatting('id_ID', null);
    //     final email = inputData!["email"];
    //     final idTest = inputData["idTest"];
    //     ProfilController().coba(email);
    //     print("Email: $email");
    //     print("Email: $idTest");
    //     break;
    // }
    // return Future.value(true);
  });
}
