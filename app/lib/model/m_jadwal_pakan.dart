import 'package:app/constant/app_format.dart';

class MJadwalPakan {
  final String dataPakanId;
  final String peternakanId;
  final DateTime tanggal;
  bool pagi;
  bool sore;
  final String jamPagi;
  final String jamSore;

  MJadwalPakan({
    required this.dataPakanId,
    required this.peternakanId,
    required this.tanggal,
    required this.pagi,
    required this.sore,
    required this.jamPagi,
    required this.jamSore,
  });

  factory MJadwalPakan.fromJson(
          Map<String, dynamic> json, Map<String, dynamic> exjson, id) =>
      MJadwalPakan(
        tanggal: AppFormat.stringtoDateTime(json['tanggal']),
        pagi: json['pagi'],
        sore: json['sore'],
        jamSore: exjson['sore'],
        jamPagi: exjson['pagi'],
        peternakanId: json['peternakanId'],
        dataPakanId: id,
      );
}
