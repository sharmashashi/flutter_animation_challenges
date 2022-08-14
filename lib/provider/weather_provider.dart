import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherProvider = StateNotifierProvider(((ref) => WeatherProvider(ref)));

class WeatherProvider extends StateNotifier {
  final Ref ref;
  WeatherProvider(this.ref) : super(null);
  final backgroundColor1 = const Color(0xff444c4f);
  final backgroundColor2 = const Color(0xff1f2527);
  final foregroundColor1 = const Color(0xff7e8588);
  final foregroundColor2 = const Color(0xffe0e2e2);
  final foregroundColor3 = const Color(0xffbfc1c1);

  final currentTemperature = "-79\u00b0";
  final dateTitle = "TODAY: ";
  final dateValue =
      "${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}";
  final minimumTemperature = "-98\u00b0";
  final maximumTemperature = "-2\u00b0";
  final location = "Kathmandu, Nepal";
  final List<double> temperatureList = [
    -20,
    -50,
    -16,
    -37,
    -10,
  ];
  final weatherDescription = "Snow turn to Cloudy";
  final appBarText = "Weather";
}
