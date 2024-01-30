
  String formatTime(int milliseconds) {
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
