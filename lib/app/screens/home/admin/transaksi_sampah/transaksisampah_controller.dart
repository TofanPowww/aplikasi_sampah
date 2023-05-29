import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransaksiSampahController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> transaksiSampahStream() {
    return db
        .collection("transaksiSampah")
        .where("status", isNotEqualTo: "Menunggu")
        .snapshots();
  }
}
