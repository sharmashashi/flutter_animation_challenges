import 'package:flutter/material.dart';
import 'package:flutter_animation_challenges/pages/weather/cloud_icon_builder.dart';
import 'package:flutter_animation_challenges/pages/weather/temperature_curve.dart';
import 'package:flutter_animation_challenges/provider/weather_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage>
    with TickerProviderStateMixin {
  late AnimationController temperatureAnimation;
  late AnimationController dateAnimation;
  late AnimationController minmaxTemperatureAnimation;
  late AnimationController locationAnimation;
  late AnimationController arcAnimation;

  @override
  void dispose() {
    super.dispose();
    temperatureAnimation.dispose();
    dateAnimation.dispose();
    minmaxTemperatureAnimation.dispose();
    locationAnimation.dispose();
    arcAnimation.dispose();
  }

  @override
  void initState() {
    super.initState();
    temperatureAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    dateAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    minmaxTemperatureAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    locationAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    arcAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    temperatureAnimation.forward();
    dateAnimation.forward();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => minmaxTemperatureAnimation.forward());
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      locationAnimation.forward();
      Future.delayed(const Duration(seconds: 1))
          .then((value) => arcAnimation.forward());
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Scaffold(
        body: _body(ref, constraints),
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: Container(),
        ),
      ),
    );
  }

  _appBar(WidgetRef ref) {
    final foregroundColor = ref.read(weatherProvider.notifier).foregroundColor2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(color: foregroundColor),
        Text(
          ref.read(weatherProvider.notifier).appBarText,
          style: TextStyle(color: foregroundColor, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.settings,
            color: foregroundColor,
          ),
        ),
      ],
    );
  }

  _body(WidgetRef ref, BoxConstraints constraints) {
    return SizedBox(
      height: constraints.maxHeight,
      width: constraints.maxWidth,
      child: Stack(
        children: [
          _pageBackground(ref, constraints),
          _appBar(ref),
          const Positioned(
              top: 150,
              left: 10,
              right: 10,
              child: CloudIconBuilder(height: 200)),
          AnimatedBuilder(
              animation: temperatureAnimation,
              builder: (context, widget) {
                return Positioned(
                    top: 200,
                    left: -250 * (1 - temperatureAnimation.value),
                    child: _temperatureBuilder(ref));
              }),
          AnimatedBuilder(
              animation: dateAnimation,
              builder: (context, widget) {
                return Positioned(
                    top: 270,
                    left: -150 * (1 - dateAnimation.value),
                    child: _dateBuilder(ref));
              }),
          AnimatedBuilder(
              animation: minmaxTemperatureAnimation,
              builder: (context, widget) {
                return Positioned(
                    top: 320,
                    left: -150 * (1 - minmaxTemperatureAnimation.value),
                    child: _minMaxTempBuilder(ref));
              }),
          AnimatedBuilder(
              animation: locationAnimation,
              builder: (context, widget) {
                return Positioned(
                    top: 370,
                    left: -170 * (1 - locationAnimation.value),
                    child: _locationBuilder(ref));
              }),
          Positioned(
            bottom: 0,
            child: Container(
              color: ref.read(weatherProvider.notifier).backgroundColor2,
              width: constraints.maxWidth,
              height: constraints.maxHeight * .3,
              child: CustomPaint(
                painter: TemperatureCurve(
                    temperatures:
                        ref.read(weatherProvider.notifier).temperatureList),
              ),
            ),
          ),
          AnimatedBuilder(
              animation: arcAnimation,
              builder: (context, widget) {
                return Positioned(
                    bottom: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.transparent,
                              ref
                                  .read(weatherProvider.notifier)
                                  .backgroundColor2
                            ],
                                stops: [
                              arcAnimation.value,
                              arcAnimation.value
                            ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * .3));
              })
        ],
      ),
    );
  }

  _locationBuilder(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: ref.read(weatherProvider.notifier).foregroundColor2,
          ),
          Text(
            ref.read(weatherProvider.notifier).location,
            style: TextStyle(
                color: ref.read(weatherProvider.notifier).foregroundColor1),
          )
        ],
      ),
    );
  }

  _minMaxTempBuilder(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [for (int i = 0; i < 2; i++) _singleTemperatureRow(ref, i)],
      ),
    );
  }

  _singleTemperatureRow(WidgetRef ref, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          Icon(
            index == 0 ? Icons.arrow_upward : Icons.arrow_downward,
            color: ref.read(weatherProvider.notifier).foregroundColor1,
          ),
          Text(
            index == 0
                ? ref.read(weatherProvider.notifier).maximumTemperature
                : ref.read(weatherProvider.notifier).minimumTemperature,
            style: TextStyle(
                color: ref.read(weatherProvider.notifier).foregroundColor2),
          )
        ],
      ),
    );
  }

  _dateBuilder(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ref.read(weatherProvider.notifier).dateTitle,
                style: TextStyle(
                    color: ref.read(weatherProvider.notifier).foregroundColor1),
              ),
              Text(
                ref.read(weatherProvider.notifier).dateValue,
                style: TextStyle(
                    color: ref.read(weatherProvider.notifier).foregroundColor2),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            ref.read(weatherProvider.notifier).weatherDescription,
            style: TextStyle(
                color: ref.read(weatherProvider.notifier).foregroundColor1),
          ),
        ],
      ),
    );
  }

  _temperatureBuilder(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        ref.read(weatherProvider.notifier).currentTemperature,
        style: TextStyle(
            fontSize: 60,
            color: ref.read(weatherProvider.notifier).foregroundColor2),
      ),
    );
  }

  _pageBackground(WidgetRef ref, BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight * .7,
      decoration: BoxDecoration(
        gradient: LinearGradient(stops: const [
          0,
          0.9
        ], colors: [
          ref.read(weatherProvider.notifier).backgroundColor1,
          ref.read(weatherProvider.notifier).backgroundColor2
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
    );
  }
}
