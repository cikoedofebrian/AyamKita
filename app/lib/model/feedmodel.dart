class FeedModel {
  final String id;
  final String date;
  final List<dynamic> isfeeded;
  final Map<String, dynamic> time;
  final int weight;

  FeedModel({
    required this.id,
    required this.date,
    required this.isfeeded,
    required this.time,
    required this.weight,
  });

  factory FeedModel.fromJson(
          Map<String, dynamic> json, Map<String, dynamic> exjson, id) =>
      FeedModel(
        date: json['date'],
        isfeeded: json['isfeeded'],
        time: exjson['time'],
        weight: exjson['weight'],
        id: id,
        // time: extrajson['time'],
        // weight: extrajson['weight'],
      );
}
