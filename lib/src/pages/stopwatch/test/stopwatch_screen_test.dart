import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:test_sopwatch/src/pages/stopwatch/screens/stopwatch_screen.dart';
import 'package:test_sopwatch/src/pages/stopwatch/services/stopwatch_service.dart';

/// Eaiser to mock this way than to import a whole mock package like nockito
class TestStopwatchService implements StopwatchService {
  // ignore: prefer_final_fields
  late StopwatchModel _stopwatchModel;
  late final ValueNotifier<int> _stopwatchTimeNotifier;
  late final ValueNotifier<List<int>> _stopwatchLapNotifier;
  late final ValueNotifier<bool> _stopwatchisRunningNotifier;

  TestStopwatchService({
    required StopwatchModel stopwatchModel,
  })  : _stopwatchModel = stopwatchModel,
        _stopwatchTimeNotifier = ValueNotifier(stopwatchModel.milliseconds),
        _stopwatchisRunningNotifier = ValueNotifier(stopwatchModel.isRunning),
        _stopwatchLapNotifier = ValueNotifier(stopwatchModel.laps);

  @override
  StopwatchModel get stopwatchModel => _stopwatchModel;

  @override
  void start() {
    _stopwatchModel.isRunning = true;
  }

  @override
  void stop() {
    _stopwatchModel.isRunning = false;
  }

  @override
  void reset() {
    _stopwatchModel.milliseconds = 0;
    _stopwatchModel.isRunning = false;
  }

  @override
  void lap() {
    _stopwatchModel.laps = [];
  }
 
  @override
  void clearLap(int lapIndex) {
    _stopwatchModel.laps = [];
  }

  @override
  ValueNotifier<int> get stopwatchTimeNotifier => _stopwatchTimeNotifier;

  @override
  ValueNotifier<List<int>> get stopwatchLapNotifier => _stopwatchLapNotifier;

  @override
  ValueNotifier<bool> get stopwatchisRunningNotifier =>
      _stopwatchisRunningNotifier;
      
}

void main() {
  group('StopwatchPage', () {
    late TestStopwatchService testStopwatchService;

    setUp(() {
      testStopwatchService = TestStopwatchService(
        stopwatchModel:
            StopwatchModel(milliseconds: 0, isRunning: false, laps: []),
      );
    });

    testWidgets('Test UI Rendering', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: StopwatchPage(stopwatchService: testStopwatchService)));

      expect(find.byKey(const Key('start-stop-button')), findsOneWidget);
      expect(find.byKey(const Key('reset-button')), findsOneWidget);
      expect(find.byKey(const Key('lap-button')), findsOneWidget);
    });

    testWidgets('Test Start/Stop Button Functionality',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: StopwatchPage(stopwatchService: testStopwatchService)));

      expect(find.text('Start'), findsOneWidget);

      await tester.tap(find.byKey(const Key('start-stop-button')));
      await tester.pump();

      expect(find.text('Stop'), findsOneWidget);

      await tester.tap(find.byKey(const Key('start-stop-button')));
      await tester.pump();

      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('Test Reset Button Functionality', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: StopwatchPage(stopwatchService: testStopwatchService)));

      await tester.tap(find.byKey(const Key('reset-button')));
      await tester.pump();

      expect(find.text('00:00:000'), findsOneWidget);
    });
  });
}
