
import 'package:logger/logger.dart';

final logger = Logger(
  printer: CustomerPrinter(),
  level: Level.verbose,
);

class CustomerPrinter extends LogPrinter {

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final message = event.message;

    return [color!('$emoji: $message')];
  }
}