import 'package:app/constant/app_format.dart';
import 'package:flutter/material.dart';

class MJamKerja {
  final String? jamKerjaId;
  final String? dokterId;
  final int day;
  final TimeOfDay mulai;
  final TimeOfDay berakhir;

  MJamKerja({
    required this.jamKerjaId,
    required this.dokterId,
    required this.mulai,
    required this.berakhir,
    required this.day,
  });

  factory MJamKerja.fromJson(Map<String, dynamic> json, id) => MJamKerja(
        jamKerjaId: id,
        berakhir: AppFormat.timeOfDayParser(json['berakhir']),
        day: json['hari'],
        dokterId: json['dokterId'],
        mulai: AppFormat.timeOfDayParser(json['mulai']),
      );
}
