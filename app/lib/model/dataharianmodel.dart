import 'package:intl/intl.dart';

class DataHarianModel {
  final String tanggal;
  final int umur;
  final double pakan;
  final int hargaPakan;
  final int kematian;
  final int keluar;
  final String obat;
  final int hargaObat;

  DataHarianModel({
    required this.tanggal,
    required this.umur,
    required this.hargaObat,
    required this.hargaPakan,
    required this.keluar,
    required this.obat,
    required this.pakan,
    required this.kematian,
  });

  factory DataHarianModel.fromJson(Map<String, dynamic> json) {
    return DataHarianModel(
        tanggal: json['tanggal'],
        kematian: json['kematian'],
        umur: json['umur'],
        pakan: json['pakan'],
        keluar: json['keluar'],
        obat: json['obat'] ?? '',
        hargaObat: json['harga_obat'],
        hargaPakan: json['harga_pakan']);
  }
}
