class Api {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/forecast?";
  static const apiKey = "81ffc2ddca6b4448afce3e5018be62a9";
  static const latitude = "-8.184486";
  static const longitude = "113.668076";
  static const units = "metric";
  static const url =
      "${baseUrl}lat=$latitude&lon=$longitude&units=$units&appid=$apiKey";
}
