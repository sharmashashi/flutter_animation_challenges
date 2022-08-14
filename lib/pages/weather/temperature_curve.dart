import 'package:flutter/material.dart';

class TemperatureCurve extends CustomPainter {
  final List<double> temperatures;
  TemperatureCurve({required this.temperatures});
  @override
  void paint(Canvas canvas, Size size) {
    final yDifference = (size.width / temperatures.length) - 20;
    List<Offset> points = [];
    for (int i = 0; i < temperatures.length; i++) {
      points.add(Offset(yDifference * (i + 1), temperatures[i].abs() + 50));
    }
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    var paintSemiTransparent = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2;
    var arcPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5;
    arcPaint.style = PaintingStyle.stroke;
    for (int i = 0; i < points.length; i++) {
      ///

      if (i > 0) {
        final previousPoint = points[i - 1];
        final averageOffset = Offset((previousPoint.dx + points[i].dx) / 2,
            (previousPoint.dy + points[i].dy) / (i % 2 == 0 ? 1.3 : 3.5));
        Path path = Path();
        path.moveTo(previousPoint.dx, previousPoint.dy);
        path.quadraticBezierTo(
            averageOffset.dx, averageOffset.dy, points[i].dx, points[i].dy);
        canvas.drawPath(path, arcPaint);
      }

      ///
      ///
      canvas.drawCircle(points[i], 5, paint);
      canvas.drawCircle(points[i], 10, paintSemiTransparent);

      ///
      ///
      TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: "-${points[i].dy - 50}\u00b0"),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(points[i].dx - 20, points[i].dy - 40));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
