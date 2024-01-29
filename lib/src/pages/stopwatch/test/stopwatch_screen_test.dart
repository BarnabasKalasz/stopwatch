// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_sopwatch/src/pages/stopwatch/models/stopwatch_model.dart';
import 'package:test_sopwatch/src/pages/stopwatch/screens/stopwatch_screen.dart';
import 'package:test_sopwatch/src/pages/stopwatch/services/stopwatch_service.dart';

class MockStopwatchService extends Mock
    implements StopwatchService {} //TBD Fix the mocking

void main() {
  group('StopwatchPage', () {
    late MockStopwatchService mockStopwatchService;

    setUp(() {
      mockStopwatchService = MockStopwatchService();

      when(mockStopwatchService.stopwatchModel)
          .thenReturn(StopwatchModel(milliseconds: 0, isRunning: false));
    });

    testWidgets('Test UI Rendering', (WidgetTester tester) async {
      await tester
          .pumpWidget(StopwatchPage(stopwatchService: mockStopwatchService));

      expect(find.byKey(const Key('start-stop-button')), findsOneWidget);
      expect(find.byKey(const Key('reset-button')), findsOneWidget);
    });

    testWidgets('Test Start/Stop Button Functionality',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: StopwatchPage(stopwatchService: mockStopwatchService)));

      await tester.tap(find.byKey(const Key('start-stop-button')));
      await tester.pump();

      expect(find.text('Stop'), findsOneWidget);

      await tester.tap(find.byKey(const Key('start-stop-button')));
      await tester.pump();

      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('Test Reset Button Functionality', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: StopwatchPage(stopwatchService: mockStopwatchService)));

      await tester.tap(find.byKey(const Key('reset-button')));
      await tester.pump();

      expect(find.text('00:00:000'), findsOneWidget);
    });
  });
}
