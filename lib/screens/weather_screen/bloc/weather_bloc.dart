import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_service/models/weather.dart';
import 'package:weather_service/repositories/weatherRepo/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherBloc({required this.weatherRepo}) : super(const WeatherDataState()) {
    on<_WeatherFetchEvent>(_fetch);
  }

  Future<void> _fetch(
      _WeatherFetchEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(const WeatherLoadingState());

      final Position location = await _getCurrentLocation();
      final latitude = location.latitude;
      final longitude = location.longitude;

      final Weather? weather = await weatherRepo.getWeatherByLocation(
          latitude: latitude, longitude: longitude);

      emit(WeatherDataState(weather: weather));
    } catch (error, stackTrace) {
      emit(WeatherErrorState(message: error.toString()));

      log(stackTrace.toString());
    }
  }

  Future<Position> _getCurrentLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      return Future.error('Location services are disable!');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
