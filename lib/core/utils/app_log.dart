import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class AppLog {
  AppLog._();

  static const _maxLength = 800;

  static void d(String message, {String tag = 'DEBUG'}) {
    _log(message, level: LogLevel.debug, tag: tag);
  }

  static void i(String message, {String tag = 'INFO'}) {
    _log(message, level: LogLevel.info, tag: tag);
  }

  static void w(String message, {String tag = 'WARN'}) {
    _log(message, level: LogLevel.warning, tag: tag);
  }

  static void e(
    String message, {
    String tag = 'ERROR',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      level: LogLevel.error,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _log(
    String message, {
    required LogLevel level,
    required String tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    // Disable debug/info logs in release
    if (kReleaseMode && level != LogLevel.error) return;

    final time = DateTime.now().toIso8601String();
    final formatted = '[$time][$tag] $message';

    // Split long logs (important for Android)
    if (formatted.length > _maxLength) {
      _printLong(formatted, tag);
    } else {
      dev.log(formatted, name: tag, error: error, stackTrace: stackTrace);
    }
  }

  static void _printLong(String message, String tag) {
    final pattern = RegExp('.{1,$_maxLength}');
    for (final chunk in pattern.allMatches(message)) {
      dev.log(chunk.group(0)!, name: tag);
    }
  }
}
