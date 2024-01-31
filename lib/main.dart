import "package:flutter/material.dart";
import 'package:test_sopwatch/src/pages/stopwatch/screens/stopwatch_screen.dart';
import 'package:test_sopwatch/src/pages/stopwatch/services/stopwatch_service.dart';
import 'package:test_sopwatch/src/common/theme/theme.dart';

void main() {
  runApp(const StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightThemeDataCustom,
        darkTheme: darkThemeDataCustom,
        home: StopwatchPage(
          stopwatchService: StopwatchService(),
        ));
  }
}
