// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../app/screens/home/warga/tukar/tukar_controller.dart';

//TODO: Menambahkan Fungsi Delete Task Jika Transaksi Selesai

final db = FirebaseFirestore.instance;
const taskActive = "CodeActived";
const simpleDelayedTask = "DelayedCodeActived";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case taskActive:
        print("$taskActive was executed. inputData = $inputData");
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("test", true);
        print("Bool from prefs: ${prefs.getBool("test")}");
        // Update status transaksi
        await Firebase.initializeApp();
        final email = inputData!['email'];
        final idTransaksi = inputData['idTransaksi'];
        TukarController().updateData(idTransaksi);
        // CollectionReference userDB = db.collection("users");
        // CollectionReference transaksiTukarDB = db.collection("transaksiTukar");
        // final tukarUser = userDB.doc(email).collection("tukar");
        // tukarUser.doc(idTransaksi).update({"status": "Batal"});
        // transaksiTukarDB.doc(idTransaksi).update({"status": "Batal"});
        print("Email: $email");
        print("Email: $idTransaksi");
        print("$taskActive done!");
        break;
      case simpleDelayedTask:
        print("$simpleDelayedTask was executed. inputData = $inputData");
        final prefs = await SharedPreferences.getInstance();
        final email = inputData!["email"];
        final idTest = inputData["idTest"];
        prefs.setBool("test", true);
        print("Bool from prefs: ${prefs.getBool("test")}");
        print("Email: $email");
        print("Email: $idTest");
        break;
    }
    return Future.value(true);
  });
}
