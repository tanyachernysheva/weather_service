import 'package:flutter/material.dart';

class CardTempHourly extends StatelessWidget {
  final String time;
  final String icon;
  final String temperature;

  const CardTempHourly({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(time),
          Image.asset(icon),
          Text('$temperatureº'),
        ],
      ),
    );
  }
}
