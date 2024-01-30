import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  final double size;

  const AnalogClock({Key? key, required this.size}) : super(key: key);

  @override
  AnalogClockState createState() => AnalogClockState();
}

class AnalogClockState extends State<AnalogClock> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _ClockPainter(),
      ),
    );
  }
}

class _ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    /// Draw the clock
    final facePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), radius, facePaint);

    /// Draw the border
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset(centerX, centerY), radius, borderPaint);

    /// Draw the dial
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (var i = 0; i < 60; i++) {
      final angle = 2 * pi / 60 * i;
      final lineLength = i % 5 == 0 ? 10 : 5;
      final startX = centerX + cos(angle) * (radius - lineLength);
      final startY = centerY + sin(angle) * (radius - lineLength);
      final endX = centerX + cos(angle) * radius;
      final endY = centerY + sin(angle) * radius;
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), linePaint);
    }

    /// Draw the numbers
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    const textStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    const angleStep = 2 * pi / 12;
    for (var i = 1; i <= 12; i++) {
      final angle = -pi / 2 + angleStep * i;
      final x = centerX + (radius - 20) * cos(angle);
      final y = centerY + (radius - 20) * sin(angle);
      textPainter.text = TextSpan(text: i.toString(), style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }

    // Draw the arms
    final dateTime = DateTime.now();
    _drawHand(
        canvas,
        centerX,
        centerY,
        radius,
        dateTime.hour % 12 / 12 * 2 * pi,
        0.5 * radius,
        4,
        Colors.black); // Hour hand
    _drawHand(canvas, centerX, centerY, radius, dateTime.minute / 60 * 2 * pi,
        0.7 * radius, 2, Colors.black); // Minute hand
    _drawHand(canvas, centerX, centerY, radius, dateTime.second / 60 * 2 * pi,
        0.8 * radius, 1, Colors.red); // Second hand
  }

  void _drawHand(Canvas canvas, double centerX, double centerY, double radius,
      double angle, double length, double width, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    final x = length * cos(angle);
    final y = length * sin(angle);

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(centerX + x, centerY + y),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
