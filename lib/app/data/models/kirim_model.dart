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
    this.petugas,
    this.jumlah,
    this.poin,
    this.status,
    this.keterangan,
    this.tanggalKonfirmasi,
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
  String? petugas;
  int? jumlah;
  String? poin;
  String? status;
  String? keterangan;
  String? tanggalKonfirmasi;
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
        petugas: json["petugas"],
        jumlah: json["jumlah"],
        poin: json["poin"],
        status: json["status"],
        keterangan: json["keterangan"],
        tanggalKonfirmasi: json["tanggalKonfirmasi"],
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
        "petugas": petugas,
        "jumlah": jumlah,
        "poin": poin,
        "status": status,
        "keterangan": keterangan,
        "tanggalKonfirmasi": tanggalKonfirmasi,
        "creationTime": creationTime,
        "confirmTime": confirmTime,
      };
}
