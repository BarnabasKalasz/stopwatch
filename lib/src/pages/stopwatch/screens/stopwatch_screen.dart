import 'package:flutter/material.dart';
import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:test_sopwatch/src/pages/stopwatch/services/stopwatch_service.dart';

class StopwatchPage extends StatefulWidget {
  final StopwatchService stopwatchService;

  const StopwatchPage({Key? key, required this.stopwatchService})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: widget.stopwatchService.stopwatchNotifier,
              builder: (context, value, _) {
                return Text(
                  _formatTime(value),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  key: const Key("elapsed-time-display"),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key("start-stop-button"),
              onPressed: _startStopwatch,
              child: Text(_stopwatchModel.isRunning ? 'Stop' : 'Start'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key("reset-buttton"),
              onPressed: _resetStopwatch,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int milliseconds) {
    int hours = milliseconds ~/ (1000 * 60 * 60);
    int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    int seconds = (milliseconds ~/ 1000) % 60;
    int hundredths = (milliseconds % 1000) ~/ 10;

    return '$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}:${_threeDigits(hundredths)}';
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  String _threeDigits(int n) {
    return n.toString().padLeft(3, '0');
  }

  void _startStopwatch() {
    if (_stopwatchModel.isRunning) {
      widget.stopwatchService.stop();
    } else {
      widget.stopwatchService.start();
    }

    setState(() {
      _stopwatchModel = widget.stopwatchService.stopwatchModel;
    });
  }

  void _resetStopwatch() {
    widget.stopwatchService.reset();
    setState(() {
      _stopwatchModel = widget.stopwatchService.stopwatchModel;
    });
  }
}
