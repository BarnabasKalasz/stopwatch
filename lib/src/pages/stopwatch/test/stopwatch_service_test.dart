// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:test_sopwatch/src/pages/stopwatch/services/stopwatch_service.dart';

void main() {
  group('StopwatchService Tests', () {
    late StopwatchService stopwatchService;

    setUp(() {
      stopwatchService = StopwatchService();
    });

    test('Initial state is correct', () {
      expect(stopwatchService.stopwatchModel.milliseconds, 0);
      expect(stopwatchService.stopwatchModel.isRunning, false);
    });

    test('Start increases milliseconds', () async {
      stopwatchService.start();

      await Future.delayed(const Duration(milliseconds: 100));
      expect(stopwatchService.stopwatchModel.milliseconds, greaterThan(0));
    });

    test('Stop pauses the stopwatch', () async {
      stopwatchService.start();

      await Future.delayed(const Duration(milliseconds: 100));
      final initialMilliseconds = stopwatchService.stopwatchModel.milliseconds;
      stopwatchService.stop();

      await Future.delayed(const Duration(milliseconds: 100));
      expect(stopwatchService.stopwatchModel.milliseconds, initialMilliseconds);
    });

    test('Reset sets milliseconds to zero', () async {
      stopwatchService.start();

      await Future.delayed(const Duration(milliseconds: 100));
      stopwatchService.reset();
      expect(stopwatchService.stopwatchModel.milliseconds, 0);
    });

    test('Should be a value within 20 millisecdonds', () async {
      stopwatchService.start();

      await Future.delayed(const Duration(milliseconds: 123));
      stopwatchService.stop();
      expect(stopwatchService.stopwatchModel.milliseconds,
          inInclusiveRange(113, 133));
    });

    test(
        'Repeated pausing and stopping and resetting, doesnt cause unexpected behaviour',
        () async {
      stopwatchService.start();

      await Future.delayed(const Duration(milliseconds: 100));
      stopwatchService.stop();
      expect(stopwatchService.stopwatchModel.milliseconds,
          inInclusiveRange(90, 110));

      /// Pausing and starting to also test if the stopwatch continues from where it stopped
      stopwatchService.start();
      await Future.delayed(const Duration(milliseconds: 100));
      stopwatchService.stop();
      expect(stopwatchService.stopwatchModel.milliseconds,
          inInclusiveRange(180, 220));

      stopwatchService.start();
      await Future.delayed(const Duration(milliseconds: 50));
      stopwatchService.stop();
      expect(stopwatchService.stopwatchModel.milliseconds,
          inInclusiveRange(220, 240));

      stopwatchService.reset();
      expect(stopwatchService.stopwatchModel.milliseconds, 0);
      stopwatchService.start();

      await Future.delayed(const Duration(milliseconds: 100));
      stopwatchService.stop();
      expect(stopwatchService.stopwatchModel.milliseconds,
          inInclusiveRange(90, 110));
      stopwatchService.reset();
      expect(stopwatchService.stopwatchModel.milliseconds, 0);
    });
  });
}
