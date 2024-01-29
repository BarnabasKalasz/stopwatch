import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

class StopwatchService {
  late StopwatchModel _stopwatchModel;
  late Timer _timer;
  late ValueNotifier<int> _stopwatchNotifier;

  StopwatchService() {
    _stopwatchModel = StopwatchModel(milliseconds: 0, isRunning: false);
    _stopwatchNotifier = ValueNotifier(_stopwatchModel.milliseconds);
  }

  StopwatchModel get stopwatchModel => _stopwatchModel;
  ValueNotifier<int> get stopwatchNotifier => _stopwatchNotifier;

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

  void _notifyListeners() {
    _stopwatchNotifier.value = _stopwatchModel.milliseconds;
  }
}
