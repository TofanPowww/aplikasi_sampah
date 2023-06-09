// ignore_for_file: file_names
class TransaksiSampahModel {
  final String id;
  final String email;
  final String nama;
  final String petugas;
  final String tanggal;
  final String status;
  final String rt;
  final String rw;
  final String fotoSampah;
  final int jumlah;
  final int poin;
  final String keterangan;
  final String tanggalKonfirmasi;
  final String creationTime;
  final String confirmTime;

  TransaksiSampahModel({
    required this.id,
    required this.email,
    required this.nama,
    required this.petugas,
    required this.tanggal,
    required this.status,
    required this.rt,
    required this.rw,
    required this.fotoSampah,
    required this.jumlah,
    required this.poin,
    required this.keterangan,
    required this.tanggalKonfirmasi,
    required this.creationTime,
    required this.confirmTime,
  });

  factory TransaksiSampahModel.fromJson(Map<String, dynamic> json) =>
      TransaksiSampahModel(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        nama: json["nama"] ?? "",
        petugas: json["petugas"] ?? "",
        tanggal: json["tanggal"] ?? "",
        status: json["status"] ?? "",
        rt: json["rt"] ?? "",
        rw: json["rw"] ?? "",
        fotoSampah: json["foto_sampah"] ?? "",
        jumlah: json["jumlah"] ?? 0,
        poin: json["poin"] ?? 0,
        keterangan: json["keterangan"] ?? "",
        tanggalKonfirmasi: json["tanggalKonfirmasi"] ?? "",
        creationTime: json["creationTime"] ?? "",
        confirmTime: json["confirmTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nama": nama,
        "petugas": petugas,
        "tanggal": tanggal,
        "status": status,
        "rt": rt,
        "rw": rw,
        "foto_sampah": fotoSampah,
        "jumlah": jumlah,
        "poin": poin,
        "keterangan": keterangan,
        "tanggalKonfirmasi": tanggalKonfirmasi,
        "creationTime": creationTime,
        "confirmTime": confirmTime,
      };
}
