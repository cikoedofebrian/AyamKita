import 'package:app/model/dataharianmodel.dart';

class MusimModel {
  final String musimId;
  final String peternakanId;
  final String tipe;
  final int jumlah;
  final int harga;
  final String mulai;
  bool status;
  List<DataHarianModel> list;

  MusimModel({
    required this.musimId,
    required this.peternakanId,
    required this.harga,
    required this.jumlah,
    required this.tipe,
    required this.list,
    required this.mulai,
    required this.status,
  });

  factory MusimModel.fromJson(
          Map<String, dynamic> json, String id, List<DataHarianModel> list) =>
      MusimModel(
          harga: json['harga'],
          mulai: json['mulai'],
          jumlah: json['jumlah'],
          list: list,
          musimId: id,
          peternakanId: json['peternakanId'],
          status: json['status'],
          tipe: json['tipe']);
}
