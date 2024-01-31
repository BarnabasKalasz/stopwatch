import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_sopwatch/src/pages/stopwatch/components/analog_clock_widget/models/arms_model.dart';

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

double _calculateAngle(int elapsedTime, int secondsForFullRevolution) {
  /// This function calculates the clock hands position based on how many milliceconds elapsed, and how many seconds it takes to make a full rotation. So that the clock widget is more customizable.
  double elapsedSeconds = elapsedTime / 1000;
  double fractionCompleted = elapsedSeconds / secondsForFullRevolution;
  double angle = 2 * pi * fractionCompleted;
  return angle;
}

void drawHands(List<ArmData> armsList, double radius, Canvas canvas,
    double centerX, double centerY, int elapsedTimeMs, bool useDate) {
  final dateTime = DateTime.now();
  double angleForHour = (dateTime.hour % 12 / 12 * 2 * pi) +
      (dateTime.minute / 60 * (2 * pi / 12));
  double angleForMinute = dateTime.minute / 60 * 2 * pi;
  double angleForSecond = dateTime.second / 60 * 2 * pi;
  if (useDate) {
    /// This if statement could use a lot of improvement, i wanted to keep the clock functionality to show time if needed so I put it in here, even if its not part of the task. Since it isnt a priority I will leave it as is for time's sake, but I would preferably separate and, refactor it for readability.
    _drawHand(canvas, centerX, centerY, radius, angleForHour, 0.5 * radius, 2,
        Colors.black);
    _drawHand(canvas, centerX, centerY, radius, angleForMinute, 0.7 * radius, 1,
        Colors.black);
    _drawHand(canvas, centerX, centerY, radius, angleForSecond, 0.9 * radius, 1,
        Colors.red);
  } else {
    /// this loop generates the clock arms from a list, allowing for more customizablity for the clock widget
    for (var arm in armsList) {
      double angle =
          _calculateAngle(elapsedTimeMs, arm.secondsForFullRevolution);
      double length = arm.size.armLength * radius;
      double width = arm.size.armWidth;
      Color color = arm.color;
      _drawHand(canvas, centerX, centerY, radius, angle, length, width, color);
    }
  }
}
