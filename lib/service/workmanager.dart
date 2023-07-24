// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workmanager/workmanager.dart';

import '../app/screens/home/warga/tukar/tukar_controller.dart';

final db = FirebaseFirestore.instance;
const taskActive = "CodeActived";
const testTask = "Test";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // try {
    //   if (task == testTask) {
    //     print("$testTask was executed.");
    //     String emailuy = inputData!['email'];
    //     String iduy = inputData['idTest'];
    //     print("Email = $emailuy");
    //     print("ID = $iduy");
    //     await Firebase.initializeApp();
    //     await initializeDateFormatting('id_ID', null)
    //         .then((_) => ProfilController().coba(emailuy));
    //   }
    // } catch (e) {
    //   debugPrint('$callbackDispatcher error: $e');
    // }
    // return Future.value(true);
    switch (task) {
      case taskActive:
        print("$taskActive was executed. inputData = $inputData");
        String email = inputData!['email'];
        String idTransaksi = inputData['idTransaksi'];
        await Firebase.initializeApp();
        await initializeDateFormatting('id_ID', null).then((_) => 
        TukarController().updateData(idTransaksi, email));
        print("Email: $email");
        print("ID: $idTransaksi");
        print("$taskActive done!");
        break;
    }
    return Future.value(true);
  });
}
