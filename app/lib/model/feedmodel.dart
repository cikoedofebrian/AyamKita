import 'package:app/constant/appformat.dart';

class FeedModel {
  final String dataPakanId;
  final String peternakanId;
  final DateTime tanggal;
  bool pagi;
  bool sore;
  final String jamPagi;
  final String jamSore;

  FeedModel({
    required this.dataPakanId,
    required this.peternakanId,
    required this.tanggal,
    required this.pagi,
    required this.sore,
    required this.jamPagi,
    required this.jamSore,
  });

  factory FeedModel.fromJson(
          Map<String, dynamic> json, Map<String, dynamic> exjson, id) =>
      FeedModel(
        tanggal: AppFormat.stringtoDateTime(json['tanggal']),
        pagi: json['pagi'],
        sore: json['sore'],
        jamSore: exjson['sore'],
        jamPagi: exjson['pagi'],
        peternakanId: json['peternakanId'],
        dataPakanId: id,
      );
}
