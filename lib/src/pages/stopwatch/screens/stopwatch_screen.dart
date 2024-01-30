import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('Stopwatch App'),
      ),
      body: Center(
        child: ValueListenableBuilder3<bool, List<int>, int>(
          first: widget.stopwatchService.stopwatchisRunningNotifier,
          second: widget.stopwatchService.stopwatchLapNotifier,
          third: widget.stopwatchService.stopwatchTimeNotifier,
          builder: (context, isRunning, laps, milliseconds, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatTime(milliseconds),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  key: const Key("elapsed-time-display"),
                ),
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
                _buildLapList(),
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

  Widget _buildLapList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lap Times:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < _stopwatchModel.laps.length; i++)
          Text(
            'Lap ${i + 1}: ${formatTime(_stopwatchModel.laps[i])}',
          ),
      ],
    );
  }

  void _resetStopwatch() {
    widget.stopwatchService.reset();
  }
}
