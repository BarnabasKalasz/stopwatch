import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

class StopwatchService {
  late StopwatchModel _stopwatchModel;
  late Timer _timer;
  late ValueNotifier<int> _stopwatchTimeNotifier;
  late ValueNotifier<List<int>> _stopwatchLapNotifier;
  late ValueNotifier<bool> _stopwatchisRunningNotifier;

  StopwatchService() {
    _stopwatchModel =
        StopwatchModel(milliseconds: 0, isRunning: false, laps: []);
    _stopwatchTimeNotifier = ValueNotifier(_stopwatchModel.milliseconds);
    _stopwatchLapNotifier = ValueNotifier(_stopwatchModel.laps);
    _stopwatchisRunningNotifier = ValueNotifier(_stopwatchModel.isRunning);
  }

  StopwatchModel get stopwatchModel => _stopwatchModel;
  ValueNotifier<int> get stopwatchTimeNotifier => _stopwatchTimeNotifier;
  ValueNotifier<List<int>> get stopwatchLapNotifier => _stopwatchLapNotifier;
  ValueNotifier<bool> get stopwatchisRunningNotifier =>
      _stopwatchisRunningNotifier;

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTime);
    _stopwatchModel.isRunning = true;
    _notifyTimeListeners();
    _notifyisRunningListeners();
  }

  void stop() {
    _timer.cancel();
    _stopwatchModel.isRunning = false;
    _notifyisRunningListeners();
  }

  void reset() {
    stop();
    _stopwatchModel.milliseconds = 0;
    _stopwatchModel.laps = [];
    _notifyisRunningListeners();
    _notifyTimeListeners();
    _notifyLapListeners();
  }

  void _updateTime(Timer timer) {
    _stopwatchModel.milliseconds += 10;
    _notifyTimeListeners();
    _notifyisRunningListeners();
  }

  void lap() {
    if (_stopwatchModel.isRunning) {
      _stopwatchModel.laps.add(_stopwatchModel.milliseconds);
      _notifyLapListeners();
    }
  }

  void clearLap(int index) {
    /// This condition is there to make sure we arent trying to clear from a nonexistent index. In theory it cannot happen, but in practice it has.
    if (_stopwatchModel.laps.length >= index + 1) {
      _stopwatchModel.laps.removeAt(index);
      _notifyLapListeners();
    }
  }

  /// This was necessary in order to eliminate rebuilding the UI everytime one of the stopwatch model values updated.
  /// The reason they have separate notifiers, is because "ValueNotifier" uses "==" operator to check values, and that would always return true in this case.

  void _notifyisRunningListeners() {
    _stopwatchisRunningNotifier.value = _stopwatchModel.isRunning;
  }

  void _notifyLapListeners() {
    _stopwatchLapNotifier.value = _stopwatchModel.laps;
  }

  void _notifyTimeListeners() {
    _stopwatchTimeNotifier.value = _stopwatchModel.milliseconds;
  }
}
