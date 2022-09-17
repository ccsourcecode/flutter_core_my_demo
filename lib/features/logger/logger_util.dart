import 'package:logger/logger.dart';

import 'log_printer.dart';
import 'logger_flutter.dart';

// remove the method count printed above,
// when an exception has a stack trace I'd like to see up to 5 methods in that trace.
// I want the lines surrounding the logs to decrease,
// keep the colors for visual feedback.
// Emoji's are staying and enable the timestamp.
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  output: ExampleLogOutput(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
  output: ExampleLogOutput(),
);

// instead of  final logger = Logger(printer: SimpleLogPrinter('PostService'));
final log = getLogger('PostService');

class ExampleLogOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);
    LogConsole.add(event);
  }
}

void logDemo() {
  loggerNoStack.i("Info message");
  loggerNoStack.w("Just a warning!");
  loggerNoStack.v({"key": 5, "value": "something"});

  logger.v('You don\'t always want to see all of these');
  logger.d('Logs a debug message');
  logger.i('Public Function called');
  logger.w('This might become a problem');
  logger.e("Error! Something bad happened", "Test Error");
  logger.e('Something has happened');
  logger.wtf('Something has happened');

  // Future.delayed(const Duration(seconds: 5), log);
}
