// ignore_for_file: file_names

class Riwayat {
  String? rt;
  String? rw;
  String? tgl;
  String? foto;

  Riwayat();

  Map<String, dynamic> toJson() =>
      {'rt': rt, 'rw': rw, 'tgl': tgl, 'foto': foto};

  Riwayat.fromSnapshot(snapshot)
      : rt = snapshot.data()['rt'],
        rw = snapshot.data()['rw'],
        tgl = snapshot.data()['tgl'],
        foto = snapshot.data()['foto'];
}
