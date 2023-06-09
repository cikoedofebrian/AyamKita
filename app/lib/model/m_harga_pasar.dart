import 'package:app/constant/app_format.dart';

class MHargaPasar {
  final int price;
  final DateTime date;

  MHargaPasar({
    required this.price,
    required this.date,
  });

  factory MHargaPasar.fromJson(Map<String, dynamic> json) => MHargaPasar(
        date: AppFormat.stringtoDateTime(json['date']),
        price: json['price'],
      );
}
