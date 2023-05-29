// To parse this JSON data, do
//
//     final kirimModel = kirimModelFromJson(jsonString);

import 'dart:convert';

KirimModel kirimModelFromJson(String str) =>
    KirimModel.fromJson(json.decode(str));

String kirimModelToJson(KirimModel data) => json.encode(data.toJson());

class KirimModel {
  KirimModel({
    this.id,
    this.email,
    this.nama,
    this.rt,
    this.rw,
    this.tgl,
    this.fotoSampah,
    this.jumlah,
    this.poin,
    this.status,
    this.creationTime,
    this.confirmTime,
  });

  String? id;
  String? email;
  String? nama;
  String? rt;
  String? rw;
  String? tgl;
  String? fotoSampah;
  int? jumlah;
  String? poin;
  String? status;
  String? creationTime;
  String? confirmTime;

  factory KirimModel.fromJson(Map<String, dynamic> json) => KirimModel(
        id: json['id'],
        email: json["email"],
        nama: json["nama"],
        rt: json["rt"],
        rw: json["rw"],
        tgl: json["tgl"],
        fotoSampah: json["foto_sampah"],
        jumlah: json["jumlah"],
        poin: json["poin"],
        status: json["status"],
        creationTime: json["creationTime"],
        confirmTime: json["confirmTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nama": nama,
        "rt": rt,
        "rw": rw,
        "tgl": tgl,
        "foto_sampah": fotoSampah,
        "jumlah": jumlah,
        "poin": poin,
        "status": status,
        "creationTime": creationTime,
        "confirmTime": confirmTime,
      };
}
