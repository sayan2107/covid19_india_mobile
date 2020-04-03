import 'package:flutter/foundation.dart';

class Log {
  static bool _isLogEnabledInRelease = false;

  static void setEnableLogInRelease(bool val) {
    _isLogEnabledInRelease = val;
  }

  static void d(String tag, String message) {
    _writeLog(tag, message, LogLevel.DEBUG);
  }

  static void i(String tag, String message) {
    _writeLog(tag, message, LogLevel.INFO);
  }

  static void e(String tag, String message) {
    _writeLog(tag, message, LogLevel.ERROR);
  }

  static void a(String tag, String message) {
    _writeLog(tag, message, LogLevel.ASSERT);
  }

  static void _writeLog(String tag, String message, LogLevel logLevel) {
    if (_shouldLog()) {
      String formattedString =
          '[${logLevel.toString().replaceAll('LogLevel.', '')}]: $tag: $message';
      debugPrint(formattedString, wrapWidth: 1024);
    }
  }

  static bool _shouldLog() {
    if (kDebugMode) return true;
    return (kReleaseMode && _isLogEnabledInRelease);
  }
}

enum LogLevel { VERBOSE, INFO, DEBUG, ERROR, ASSERT, WARNING, WTF }
