import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';

import 'dart:async';

class StopwatchService {
  late StopwatchModel _stopwatchModel;
  late Timer _timer;

  StopwatchService() {
    _stopwatchModel = StopwatchModel(milliseconds: 0, isRunning: false);
  }

  StopwatchModel get stopwatchModel => _stopwatchModel;

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), _updateTime);
    _stopwatchModel.isRunning = true;
  }

  void stop() {
    _timer.cancel();
    _stopwatchModel.isRunning = false;
  }

  void reset() {
    stop();
    _stopwatchModel.milliseconds = 0;
  }

  void _updateTime(Timer timer) {
    _stopwatchModel.milliseconds += 1;
  }
}
