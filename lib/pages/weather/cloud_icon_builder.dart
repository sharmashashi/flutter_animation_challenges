import 'package:flutter/material.dart';
import 'package:flutter_animation_challenges/provider/weather_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CloudIconBuilder extends ConsumerStatefulWidget {
  final double height;
  const CloudIconBuilder({Key? key,required this.height}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CloudIconBuilderState();
}

class _CloudIconBuilderState extends ConsumerState<CloudIconBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, widget) {
          return SizedBox(
              height: this.widget.height,
              width: 100,
              child: Transform.translate(
                offset: Offset(0, -80 * animationController.value),
                child: _cloud(ref),
              ));
        });
  }

  _cloud(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_outlined,
          color: ref.read(weatherProvider.notifier).foregroundColor2,
          size: 100,
        ),
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ref.read(weatherProvider.notifier).foregroundColor2),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ref.read(weatherProvider.notifier).foregroundColor2),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ref.read(weatherProvider.notifier).foregroundColor2),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ref.read(weatherProvider.notifier).foregroundColor3),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ref.read(weatherProvider.notifier).foregroundColor3),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ref.read(weatherProvider.notifier).foregroundColor3),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ref.read(weatherProvider.notifier).foregroundColor3),
        )
      ],
    );
  }
}
