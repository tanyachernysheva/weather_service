part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {
  const WeatherState();
}

final class WeatherDataState extends WeatherState {
  final Weather? weather;

  const WeatherDataState({this.weather});
}

final class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

final class WeatherErrorState extends WeatherState {
  final String? message;
  const WeatherErrorState({this.message});
}
