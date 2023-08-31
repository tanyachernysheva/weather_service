import 'package:weather_service/httpClient/http_client.dart';
import 'package:weather_service/models/weather.dart';
import 'package:weather_service/shared/shared.dart';

abstract interface class WeatherRepo {
  Future<Weather?> getWeatherByLocation(
      {required double latitude, required double longitude});
}

final class ApiWeatherRepository implements WeatherRepo {
  final HttpClient _httpClient;

  ApiWeatherRepository() : _httpClient = HttpClient();

  @override
  Future<Weather?> getWeatherByLocation({
    required double latitude,
    required double longitude,
  }) async {
    final json = await _httpClient.get(
      baseUrl: Api.baseUrl,
      path: Api.weather,
      query: {
        'lat': '$latitude',
        'lon': '$longitude',
        'units': 'metric',
        'appid': '1413fb56113bd06e0f43c8afa06a41c5',
      },
    );

    return Weather.fromJson(json);
  }
}
