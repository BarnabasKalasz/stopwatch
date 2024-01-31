import 'package:flutter/material.dart';
import 'package:test_sopwatch/src/pages/stopwatch/components/analog_clock_widget/models/arms_model.dart';

/// This is just a file that contains the arm settings for the two clock widgets displayed on the app. The analog clock and the stopwatch

List<ArmData> analogClockArms = [
  ArmData(
      secondsForFullRevolution: 60,
      size: ArmSize(armLength: 0.8, armWidth: 1),
      color: Colors.red),
  ArmData(
      secondsForFullRevolution: 3600,
      size: ArmSize(armLength: 0.7, armWidth: 2)),
  ArmData(
      secondsForFullRevolution: 3600 * 12,
      size: ArmSize(armLength: 0.5, armWidth: 2.5)),
];

List<ArmData> stopWatchArm = [
  ArmData(
      secondsForFullRevolution: 60,
      size: ArmSize(armLength: 0.8, armWidth: 1),
      color: Colors.red)
];
