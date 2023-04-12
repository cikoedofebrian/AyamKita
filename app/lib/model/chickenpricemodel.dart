class ChickenPriceModel {
  final int price;
  final String date;

  ChickenPriceModel({
    required this.price,
    required this.date,
  });

  factory ChickenPriceModel.fromJson(Map<String, dynamic> json) =>
      ChickenPriceModel(
        date: json['date'],
        price: json['price'],
      );
}
