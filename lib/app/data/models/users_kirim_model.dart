import 'dart:convert';

UsersKirimModel usersModelFromJson(String str) =>
    UsersKirimModel.fromJson(json.decode(str));

String usersModelToJson(UsersKirimModel data) => json.encode(data.toJson());

class UsersKirimModel {
  UsersKirimModel(
      {this.tanggal,
      this.fotoSampah,
      this.petugas,
      this.jumlah,
      this.poin,
      this.status,
      this.keterangan,
      this.tanggalKonfirmasi,
      this.creationTime,
      this.confirmTime});

  String? tanggal;
  String? fotoSampah;
  String? petugas;
  int? jumlah;
  int? poin;
  String? status;
  String? keterangan;
  String? tanggalKonfirmasi;
  String? creationTime;
  String? confirmTime;

  factory UsersKirimModel.fromJson(Map<String, dynamic> json) =>
      UsersKirimModel(
        tanggal: json["tgl"],
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
        "tgl": tanggal,
        "foto_sampah": fotoSampah,
        "petugas": petugas,
        "jumlah": jumlah,
        "poin": poin,
        "status": status,
        "keterangan": keterangan,
        "tanggalKonfirmasi": tanggalKonfirmasi,
        "creationTime": creationTime,
        "confirmTime": confirmTime
      };
}
