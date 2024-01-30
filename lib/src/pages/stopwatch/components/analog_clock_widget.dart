import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  final double size;
  final int clockRange;
  final int displayNth;
  final int elapsedTimeMs;
  final bool useDate;

  const AnalogClock({
    Key? key,
    required this.size,
    required this.elapsedTimeMs,
    this.useDate = false,
    this.clockRange = 12,
    this.displayNth = 1,
  }) : super(key: key);

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
    return Column(
      children: [
        Text(
            '${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}'),
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _ClockPainter(widget.clockRange, widget.displayNth,
                widget.elapsedTimeMs, widget.useDate),
          ),
        ),
      ],
    );
  }
}

class _ClockPainter extends CustomPainter {
  final int clockRange;
  final int displayNth;
  final int elapsedTimeMs;
  final bool useDate;

  _ClockPainter(
      this.clockRange, this.displayNth, this.elapsedTimeMs, this.useDate);

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
    final angleStep = 2 * pi / clockRange;
    for (var i = clockRange; i > 0; i -= displayNth) {
      final angle = -pi / 2 + angleStep * i;
      final x = centerX + (radius - 20) * cos(angle);
      final y = centerY + (radius - 20) * sin(angle);
      textPainter.text = TextSpan(text: i.toString(), style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }

    /// Draw the arms
    final dateTime = DateTime.now();
    _drawHand(
        canvas,
        centerX,
        centerY,
        radius,
        (useDate
            ? ((dateTime.hour % 12 / 12 * 2 * pi) +
                (dateTime.minute / 60 * (2 * pi / 12)))
            : (elapsedTimeMs / (1000 * 60 * 60 * 86400) * 2 * pi)),

        //Angle for the hour arm
        0.5 * radius,
        4,
        Colors.black); // Hour hand
    _drawHand(
        canvas,
        centerX,
        centerY,
        radius,
        (useDate
            ? (dateTime.minute / 60 * 2 * pi)
            : ((elapsedTimeMs / (1000 * 60 * 3600)) * 2 * pi)),
        0.7 * radius,
        2,
        Colors.black); // Minute hand
    _drawHand(
        canvas,
        centerX,
        centerY,
        radius,
        (useDate
            ? (dateTime.second / 60 * 2 * pi)
            : (elapsedTimeMs / (1000 * 60) * 2 * pi)),
        0.8 * radius,
        1,
        Colors.red); // Second hand
  }

  void _drawHand(Canvas canvas, double centerX, double centerY, double radius,
      double angle, double length, double width, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    final x = length * cos(angle - pi / 2);
    final y = length * sin(angle - pi / 2);

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
