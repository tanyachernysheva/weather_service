import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_service/models/weather.dart';
import 'package:weather_service/repositories/weatherRepo/weather_repo.dart';
import 'package:weather_service/screens/weather_screen/bloc/weather_bloc.dart';
import 'package:weather_service/screens/weather_screen/widgets/card_temp_hourly.dart';
import 'package:weather_service/screens/weather_screen/widgets/data_island.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final WeatherBloc _bloc;
  final String date = DateFormat.MMMMd().format(DateTime.now());

  @override
  void initState() {
    _bloc = WeatherBloc(weatherRepo: ApiWeatherRepository());

    _bloc.add(const WeatherEvent.fetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(16, 13, 125, 1),
              Colors.black,
            ],
            end: Alignment.bottomRight,
            begin: Alignment.topCenter,
            stops: [0.6, 1]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocBuilder<WeatherBloc, WeatherState>(
              bloc: _bloc,
              builder: (context, state) {
                return switch (state) {
                  WeatherDataState() => Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: <Widget>[
                          //? Информация о местоположении
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                  '${state.weather?.city}, ${state.weather?.country}'),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Image.asset(setImage(state.weather?.state)),

                          //? Общая информация о погоде
                          Column(
                            children: <Widget>[
                              Text(
                                '${state.weather?.temperature}º',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text('${state.weather?.description}'),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                  'Max: ${state.weather?.tempMax}, Min: ${state.weather?.tempMin}'),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          //? Информация о погоде по часам
                          Expanded(
                            child: DataIsland(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text('Today'),
                                        Text(date),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: CardTempHourly(
                                              time: '14:00',
                                              icon: 'assets/icons/icon_sun.png',
                                              temperature: '25',
                                            ),
                                          ),
                                          Expanded(
                                            child: DataIsland(
                                              child: CardTempHourly(
                                                time: '15:00',
                                                icon:
                                                    'assets/icons/icon_sun.png',
                                                temperature: '24',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CardTempHourly(
                                              time: '16:00',
                                              icon: 'assets/icons/icon_sun.png',
                                              temperature: '23',
                                            ),
                                          ),
                                          Expanded(
                                            child: CardTempHourly(
                                              time: '17:00',
                                              icon: 'assets/icons/icon_sun.png',
                                              temperature: '22',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          //? Информация о ветре и влажности
                          DataIsland(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 16.0,
                                    bottom: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.air_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('${state.weather?.wind} м/с'),
                                        ],
                                      ),
                                      const Text('Ветер северо-восточный'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 16.0,
                                    top: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.water_drop_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('${state.weather?.humidity} %'),
                                        ],
                                      ),
                                      Text((state.weather?.humidity ?? 0) > 50
                                          ? 'Высокая влажность'
                                          : 'Низкая влажность'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  WeatherLoadingState() => const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
                  WeatherErrorState() =>
                    Center(child: Text(state.message ?? '')),
                };
              }),
        ),
      ),
    );
  }
}

String setImage(WeatherCondition? state) {
  return switch (state) {
    WeatherCondition.thunderstorm => 'assets/thunderstorm.png',
    WeatherCondition.drizzle => 'assets/small_rain.png',
    WeatherCondition.rain => 'assets/rain.png',
    WeatherCondition.snow => 'assets/snow.png',
    WeatherCondition.atmosphere => 'assets/sun.png',
    WeatherCondition.clear => 'assets/sun.png',
    WeatherCondition.clouds => 'assets/small_rain.png',
    _ => 'assets/sun.png',
  };
}
