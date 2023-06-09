// ignore_for_file: file_names

class TransaksiTukarModel {
  final String id;
  final String kode;
  final String email;
  final String namaProduk;
  final int poinProduk;
  final String status;
  final String tanggal;
  final String tanggalKonfirmasi;
  final String creationTime;
  final String confirmTime;

  TransaksiTukarModel({
    required this.id,
    required this.kode,
    required this.email,
    required this.namaProduk,
    required this.poinProduk,
    required this.status,
    required this.tanggal,
    required this.tanggalKonfirmasi,
    required this.creationTime,
    required this.confirmTime,
  });

  factory TransaksiTukarModel.fromJson(Map<String, dynamic> json) =>
      TransaksiTukarModel(
        id: json["id"] ?? "",
        kode: json["kode"] ?? "",
        email: json["email"] ?? "",
        namaProduk: json["nama_produk"] ?? "",
        poinProduk: json["poin_produk"] ?? 0,
        status: json["status"] ?? "",
        tanggal: json["tanggal"] ?? "",
        tanggalKonfirmasi: json["tanggalKonfirmasi"] ?? "",
        creationTime: json["creationTime"] ?? "",
        confirmTime: json["confirmTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "email": email,
        "nama_produk": namaProduk,
        "poin_produk": poinProduk,
        "status": status,
        "tanggal": tanggal,
        "tanggalKonfirmasi": tanggalKonfirmasi,
        "creationTime": creationTime,
        "confirmTime": confirmTime,
      };
}
