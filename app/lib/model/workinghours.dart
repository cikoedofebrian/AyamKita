import 'package:flutter/material.dart';

class WorkingHours {
  final String? dokterId;
  final int day;
  final TimeOfDay mulai;
  final TimeOfDay berakhir;

  WorkingHours({
    required this.dokterId,
    required this.mulai,
    required this.berakhir,
    required this.day,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) => WorkingHours(
        berakhir: json['berakhir'],
        day: json['hari'],
        dokterId: json['dokterId'],
        mulai: json['mulai'],
      );
}
