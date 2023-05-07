import 'package:app/constant/appformat.dart';

class ChickenPriceModel {
  final int price;
  final DateTime date;

  ChickenPriceModel({
    required this.price,
    required this.date,
  });

  factory ChickenPriceModel.fromJson(Map<String, dynamic> json) =>
      ChickenPriceModel(
        date: AppFormat.stringtoDateTime(json['date']),
        price: json['price'],
      );
}
