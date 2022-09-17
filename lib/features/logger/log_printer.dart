import 'dart:convert';

import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  final bool colorsEnabled;
  SimpleLogPrinter(this.className, {this.colorsEnabled = false});

// log output
/*
  [emoji] [ClassName] - [Message]
💡 LocationService - Request Location Update
*/

  @override
  List<String> log(LogEvent event) {
    final logColor = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final message = event.message;
    const splitter = LineSplitter();
    final splitMessage = splitter.convert('$message');
    splitMessage[0] = '$emoji $className - ${splitMessage[0]}';
    if (colorsEnabled) {
      return splitMessage.map((line) => logColor!(line)).toList();
    }

    // println(color('$emoji $className - $event.message'));

    return splitMessage;
  }
}

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}
