import 'package:intl/intl.dart';

class DataHarianModel {
  final DateTime tanggal;
  final int umur;
  final int datang;
  final int pakai;
  final int std;
  final int stok;
  final int kematian;
  final int panen;
  final String obat;

  DataHarianModel(
      {required this.tanggal,
      required this.umur,
      required this.datang,
      required this.pakai,
      required this.std,
      required this.stok,
      required this.kematian,
      required this.panen,
      required this.obat});

  factory DataHarianModel.fromJson(Map<String, dynamic> json) {
    return DataHarianModel(
      kematian: json['kematian'],
      datang: json['datang'],
      std: json['std'],
      umur: json['umur'],
      pakai: json['pakai'],
      stok: json['stok'],
      tanggal: DateFormat('dd-MM-yyyy').parse(json['tanggal']),
      panen: json['panen'],
      obat: json['obat'] ?? '',
    );
  }
}
