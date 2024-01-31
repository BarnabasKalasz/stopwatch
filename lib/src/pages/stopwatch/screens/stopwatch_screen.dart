import 'package:flutter/material.dart';
import 'package:test_sopwatch/src/pages/stopwatch/components/analog_clock_widget/analog_clock_widget.dart';

import 'package:test_sopwatch/src/pages/stopwatch/components/lap_list_builder/lap_list_builder.dart';
import 'package:test_sopwatch/src/pages/stopwatch/components/stopwatch_swipable_display_widget/stopwatch_swipable_display.dart';
import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:test_sopwatch/src/pages/stopwatch/services/stopwatch_service.dart';
import 'package:test_sopwatch/src/common/utils/value_listenable_builder_3.dart';

import '../utils/utilities.dart';

class StopwatchPage extends StatefulWidget {
  final StopwatchService stopwatchService;

  const StopwatchPage({Key? key, required this.stopwatchService})
      : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late StopwatchModel _stopwatchModel;

  @override
  void initState() {
    super.initState();
    _stopwatchModel = widget.stopwatchService.stopwatchModel;
  }

  @override
  void dispose() {
    widget.stopwatchService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder3<bool, List<int>, int>(
          first: widget.stopwatchService.stopwatchisRunningNotifier,
          second: widget.stopwatchService.stopwatchLapNotifier,
          third: widget.stopwatchService.stopwatchTimeNotifier,
          builder: (context, isRunning, laps, milliseconds, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwipeableStopwatchDisplay(children: [
                  Text(
                    formatTime(milliseconds),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    key: const Key("elapsed-time-display"),
                  ),
                  AnalogClock(
                    key: ValueKey<int>(milliseconds),
                    elapsedTimeMs: milliseconds,
                    size: 180,
                    clockRange: 12,
                    displayNth: 3,
                  ),
                  AnalogClock(
                    key: ValueKey<int>(milliseconds),
                    elapsedTimeMs: milliseconds,
                    size: 180,
                    clockRange: 60,
                    displayNth: 5,
                  ),
                ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      key: const Key("start-stop-button"),
                      onPressed: _startStopwatch,
                      child: Text(isRunning ? 'Stop' : 'Start'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      key: const Key("lap-button"),
                      onPressed: isRunning ? _lap : null,
                      child: const Text('Lap'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      key: const Key("reset-button"),
                      onPressed: _resetStopwatch,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                LapList(
                  laps: laps,
                  onClear: (index) => widget.stopwatchService.clearLap(index),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _startStopwatch() {
    if (_stopwatchModel.isRunning) {
      widget.stopwatchService.stop();
    } else {
      widget.stopwatchService.start();
    }
  }

  void _lap() {
    widget.stopwatchService.lap();
  }

  void _resetStopwatch() {
    widget.stopwatchService.reset();
  }
}
