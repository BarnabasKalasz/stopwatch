import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:test_sopwatch/src/pages/stopwatch/screens/stopwatch_screen.dart';
import 'package:test_sopwatch/src/pages/stopwatch/services/stopwatch_service.dart';

class TestStopwatchService implements StopwatchService {
  // ignore: prefer_final_fields
  late StopwatchModel _stopwatchModel;
  late final ValueNotifier<int> _stopwatchNotifier;

  TestStopwatchService({
    required StopwatchModel stopwatchModel,
  })  : _stopwatchModel = stopwatchModel,
        _stopwatchNotifier = ValueNotifier(stopwatchModel.milliseconds);

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
  }

  @override
  ValueNotifier<int> get stopwatchNotifier => _stopwatchNotifier;
}

void main() {
  group('StopwatchPage', () {
    late TestStopwatchService testStopwatchService;

    setUp(() {
      testStopwatchService = TestStopwatchService(
        stopwatchModel: StopwatchModel(milliseconds: 0, isRunning: false),
      );
    });

    testWidgets('Test UI Rendering', (WidgetTester tester) async {
      await tester
          .pumpWidget(StopwatchPage(stopwatchService: testStopwatchService));

      expect(find.byKey(const Key('start-stop-button')), findsOneWidget);
      expect(find.byKey(const Key('reset-button')), findsOneWidget);
    });

    testWidgets('Test Start/Stop Button Functionality',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: StopwatchPage(stopwatchService: testStopwatchService)));

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
