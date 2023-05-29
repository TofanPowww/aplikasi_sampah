// // ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors
// import 'package:aplikasi_sampah/app/screens/index.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../constant/color.dart';
// import '../../../data/produkModel.dart';

// class ProdukCard extends StatelessWidget {
//   final Produk _produk;

//   const ProdukCard(this._produk);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 100,
//         width: Get.width,
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: appSecondarySoft.withOpacity(0.4),
//                 offset: const Offset(0, 2),
//                 blurRadius: 3,
//                 spreadRadius: 1)
//           ],
//           gradient:
//               const LinearGradient(colors: [appSecondary, appSecondarySoft]),
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${_produk.nama}",
//                     style: const TextStyle(
//                         fontSize: 20,
//                         fontFamily: "Satoshi",
//                         fontWeight: FontWeight.w500,
//                         color: appBackgroundPrimary),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "${_produk.poin} Poin",
//                     style: const TextStyle(
//                         fontSize: 24,
//                         fontFamily: "Satoshi",
//                         fontWeight: FontWeight.w600,
//                         color: appBackgroundPrimary),
//                   )
//                 ],
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const DetailProdukView(),
//                           settings: RouteSettings(
//                             arguments: _produk,
//                           )));
//                 },
//                 icon: const Icon(Icons.arrow_forward_ios_rounded),
//                 color: appBackgroundPrimary,
//               )
//             ],
//           ),
//         ));
//   }
// }
