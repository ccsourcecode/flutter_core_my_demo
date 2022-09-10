import 'package:logger/logger.dart';

import 'logger_flutter.dart';

var logger = Logger(
  printer: PrettyPrinter(),
  output: ExampleLogOutput(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
  output: ExampleLogOutput(),
);

class ExampleLogOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);
    LogConsole.add(event);
  }
}

void log() {
  logger.d("Log message with 2 methods");

  loggerNoStack.i("Info message");

  loggerNoStack.w("Just a warning!");

  logger.e("Error! Something bad happened", "Test Error");

  loggerNoStack.v({"key": 5, "value": "something"});

  // Future.delayed(const Duration(seconds: 5), log);
}
