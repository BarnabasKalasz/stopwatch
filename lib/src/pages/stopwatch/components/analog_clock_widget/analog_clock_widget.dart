import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_sopwatch/src/pages/stopwatch/components/analog_clock_widget/models/arms_model.dart';
import 'package:test_sopwatch/src/pages/stopwatch/components/analog_clock_widget/utils/analog_clock_utils.dart';

//TBD separate logic to make it less bulky

class AnalogClock extends StatefulWidget {
  final double size;
  final int clockRange;
  final int displayNth;
  final int elapsedTimeMs;
  final List<ArmData> clockArmsList;
  final bool useDate;
  final ThemeData theme;

  const AnalogClock({
    Key? key,
    required this.size,
    required this.elapsedTimeMs,
    required this.theme,
    required this.clockArmsList,
    this.useDate = false,
    this.clockRange = 12,
    this.displayNth = 1,
  }) : super(key: key);

  @override
  AnalogClockState createState() => AnalogClockState();
}

class AnalogClockState extends State<AnalogClock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
          painter: _ClockPainter(
              widget.clockRange,
              widget.displayNth,
              widget.elapsedTimeMs,
              widget.useDate,
              widget.theme,
              widget.clockArmsList)),
    );
  }
}

class _ClockPainter extends CustomPainter {
  final int clockRange;
  final int displayNth;
  final int elapsedTimeMs;
  final List<ArmData> clockArmsList;
  final bool useDate;
  final ThemeData theme;

  _ClockPainter(this.clockRange, this.displayNth, this.elapsedTimeMs,
      this.useDate, this.theme, this.clockArmsList);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    /// Draw the clock
    final facePaint = Paint()
      ..color = theme.colorScheme.background
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), radius, facePaint);

    /// Draw the border
    final borderPaint = Paint()
      ..color = theme.colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset(centerX, centerY), radius, borderPaint);

    /// Draw the dial
    final linePaint = Paint()
      ..color = theme.colorScheme.primary
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
    final textStyle = TextStyle(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);
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

    drawHands(clockArmsList, radius, canvas, centerX, centerY, elapsedTimeMs,
        useDate);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // Check if the theme has changed
    if (oldDelegate is _ClockPainter) {
      return theme != oldDelegate.theme ||
          elapsedTimeMs != oldDelegate.elapsedTimeMs ||
          useDate != oldDelegate.useDate;
    }
    return true;
  }
}
