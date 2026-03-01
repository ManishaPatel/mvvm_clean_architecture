import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class Log {
  static final Logger _logger = Logger('Demo');

  static void info(String message) {
    _logger.info(message);
  }

  static void warning(String message) {
    _logger.warning(message);
  }

  static void severe(String message) {
    _logger.severe(message);
  }
}

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}