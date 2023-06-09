import 'package:app/constant/app_color.dart';
import 'package:app/constant/request_status.dart';
import 'package:app/model/m_akun.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MUsulanKonsultasi {
  String peternakanId;
  String judul;
  String deskripsi;
  String tanggal;
  String status;
  String downloadUrl;
  String pengelolaId;
  String usulanKonsultasiId;
  String musimId;

  MUsulanKonsultasi({
    required this.usulanKonsultasiId,
    required this.peternakanId,
    required this.pengelolaId,
    required this.deskripsi,
    required this.judul,
    required this.downloadUrl,
    required this.status,
    required this.tanggal,
    required this.musimId,
  });

  factory MUsulanKonsultasi.fromJson(Map<String, dynamic> json, id) {
    return MUsulanKonsultasi(
      usulanKonsultasiId: id,
      pengelolaId: json['pengelolaId'],
      deskripsi: json['deskripsi'],
      status: json['status'],
      judul: json['judul'],
      downloadUrl: json['downloadUrl'],
      peternakanId: json['peternakanId'],
      tanggal: json['tanggal'],
      musimId: json['musimId'],
    );
  }

  Future<MAkun> imageUrl() async {
    final result = await FirebaseFirestore.instance
        .collection('akun')
        .doc(pengelolaId)
        .get();
    return MAkun.fromJson(result.data()!, result.id);
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
