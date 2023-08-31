part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {
  const WeatherEvent();

  const factory WeatherEvent.fetch() = _WeatherFetchEvent;
}

final class _WeatherFetchEvent implements WeatherEvent {
  const _WeatherFetchEvent();
}
