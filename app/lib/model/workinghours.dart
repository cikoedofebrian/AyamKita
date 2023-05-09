import 'package:app/constant/appformat.dart';
import 'package:flutter/material.dart';

class WorkingHours {
  final String? jamKerjaId;
  final String? dokterId;
  final int day;
  final TimeOfDay mulai;
  final TimeOfDay berakhir;

  WorkingHours({
    required this.jamKerjaId,
    required this.dokterId,
    required this.mulai,
    required this.berakhir,
    required this.day,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json, id) => WorkingHours(
        jamKerjaId: id,
        berakhir: AppFormat.timeOfDayParser(json['berakhir']),
        day: json['hari'],
        dokterId: json['dokterId'],
        mulai: AppFormat.timeOfDayParser(json['mulai']),
      );
}
