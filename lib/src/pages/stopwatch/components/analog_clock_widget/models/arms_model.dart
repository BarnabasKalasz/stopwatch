import 'package:flutter/material.dart';

class ArmSize {
  final double armLength;
  final double armWidth;

  ArmSize({
    this.armLength = 0.5,
    this.armWidth = 0.3,
  });
}

class ArmData {
  final int secondsForFullRevolution;
  final ArmSize size;
  final Color color;

  ArmData(
      {required this.secondsForFullRevolution,
      required this.size,
      this.color = Colors.black});
}
