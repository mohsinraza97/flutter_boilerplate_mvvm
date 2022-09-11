import 'package:logger/logger.dart';

class LogUtils {
  const LogUtils._internal();

  static Logger? logger;

  static void init() {
    logger = Logger(
      printer: PrettyPrinter(printTime: true),
    );
  }

  static void debug(dynamic message) {
    logger?.d(message);
  }

  static void info(dynamic message) {
    logger?.i(message);
  }

  static void error(dynamic message) {
    logger?.e(message);
  }
}
