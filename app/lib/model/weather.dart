class Weather {
  Weather({
    required this.dt,
    required this.main,
    required this.weather,
  });

  final int dt;
  final Main main;
  final List<WeatherElement> weather;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        dt: json["dt"],
        main: Main.fromJson(json["main"]),
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
      );
}

class Main {
  Main({
    required this.temp,
  });

  final double temp;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
      );
}

class WeatherElement {
  WeatherElement({
    required this.id,
  });

  final int id;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
      );
}
