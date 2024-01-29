import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

class StopwatchService {
  late StopwatchModel _stopwatchModel;
  late Timer _timer;
  VoidCallback? _listener;

  StopwatchService() {
    _stopwatchModel = StopwatchModel(milliseconds: 0, isRunning: false);
  }

  StopwatchModel get stopwatchModel => _stopwatchModel;

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTime);
    _stopwatchModel.isRunning = true;
    _notifyListeners();
  }

  void stop() {
    _timer.cancel();
    _stopwatchModel.isRunning = false;
    _notifyListeners();
  }

  void reset() {
    stop();
    _stopwatchModel.milliseconds = 0;
    _notifyListeners();
  }

  void _updateTime(Timer timer) {
    _stopwatchModel.milliseconds += 10;
    _notifyListeners();
  }

  void addListener(VoidCallback listener) {
    _listener = listener;
  }

  void _notifyListeners() {
    _listener?.call();
  }
}
