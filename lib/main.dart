import 'package:flutter/material.dart';
import 'package:flutter_animation_challenges/pages/homepage.dart';
import 'package:flutter_animation_challenges/pages/weather/weather_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    ),
  ));
}
