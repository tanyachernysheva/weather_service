final class Weather {
  final int? temperature;
  final String? description;
  final String? city;
  final int? feelsLike;
  final int? wind;
  final int? humidity;
  final int? tempMin;
  final int? tempMax;
  final String? country;
  final WeatherCondition state;

  Weather({
    this.description,
    this.temperature,
    this.city,
    this.feelsLike,
    this.wind,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.country,
    required this.state,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['main']['temp'] as double).toInt(),
      description: json['weather'][0]['description'] as String,
      country: json['sys']['country'] as String,
      city: json['name'] as String,
      feelsLike: (json['main']['feels_like'] as double).toInt(),
      humidity: (json['main']['humidity']).toInt(),
      wind: (json['wind']['speed']).toInt(),
      state: WeatherCondition.fromValue(json['weather'][0]['main']),
      tempMax: (json['main']['temp_max'] as double).toInt(),
      tempMin: (json['main']['temp_min'] as double).toInt(),
    );
  }
}

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds,
  unknown;

  factory WeatherCondition.fromValue(String value) {
    return switch (value.toLowerCase()) {
      'thunderstorm' => thunderstorm,
      'drizzle' => drizzle,
      'rain' => rain,
      'snow' => snow,
      'atmosphere' => atmosphere,
      'clear' => clear,
      'clouds' => clouds,
      _ => unknown,
    };
  }
}
