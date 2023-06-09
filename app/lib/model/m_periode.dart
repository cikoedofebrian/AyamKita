import 'package:app/model/m_data_harian.dart';

class MPeriode {
  final String musimId;
  final String peternakanId;
  final String tipe;
  final int jumlah;
  final int harga;
  final String mulai;
  bool status;
  List<MDataHarian> list;

  MPeriode({
    required this.musimId,
    required this.peternakanId,
    required this.harga,
    required this.jumlah,
    required this.tipe,
    required this.list,
    required this.mulai,
    required this.status,
  });

  factory MPeriode.fromJson(
          Map<String, dynamic> json, String id, List<MDataHarian> list) =>
      MPeriode(
          harga: json['harga'],
          mulai: json['mulai'],
          jumlah: json['jumlah'],
          list: list,
          musimId: id,
          peternakanId: json['peternakanId'],
          status: json['status'],
          tipe: json['tipe']);
}
