import 'package:logger/logger.dart';
export 'package:logger/logger.dart';

Logger getLogger(String className) {
  return Logger(
    printer: _MediaDripLogPrinter(className),
    level: null
  );
}

class _MediaDripLogPrinter extends LogPrinter {
  final String className;

  _MediaDripLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];

    return [color('$emoji $className - ${event.message}')];
  }
}