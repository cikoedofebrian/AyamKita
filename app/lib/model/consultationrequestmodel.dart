import 'package:app/constant/appcolor.dart';
import 'package:app/constant/requeststatus.dart';
import 'package:app/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultationRequestModel {
  String peternakanId;
  String judul;
  String deskripsi;
  String tanggal;
  String status;
  String downloadUrl;
  String pengelolaId;
  String usulanKonsultasiId;

  ConsultationRequestModel({
    required this.usulanKonsultasiId,
    required this.peternakanId,
    required this.pengelolaId,
    required this.deskripsi,
    required this.judul,
    required this.downloadUrl,
    required this.status,
    required this.tanggal,
  });

  factory ConsultationRequestModel.fromJson(Map<String, dynamic> json, id) {
    return ConsultationRequestModel(
        usulanKonsultasiId: id,
        pengelolaId: json['pengelolaId'],
        deskripsi: json['deskripsi'],
        status: json['status'],
        judul: json['judul'],
        downloadUrl: json['downloadUrl'],
        peternakanId: json['peternakanId'],
        tanggal: json['tanggal']);
  }

  Future<UserModel> imageUrl() async {
    final result = await FirebaseFirestore.instance
        .collection('akun')
        .doc(pengelolaId)
        .get();
    return UserModel.fromJson(result.data()!, result.id);
  }

  Color getColor() {
    switch (status) {
      case RequestStatus.disetujui:
        return Colors.green;
      case RequestStatus.ditolak:
        return Colors.red;
      case RequestStatus.selesai:
        return AppColor.blue;
      default:
        return Colors.yellow;
    }
  }
}
