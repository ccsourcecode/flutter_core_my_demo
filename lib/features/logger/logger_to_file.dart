import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MyLogger extends StatefulWidget {
  @override
  _MyLoggerState createState() => _MyLoggerState();
}

class _MyLoggerState extends State<MyLogger> {
  late File file;
  late Logger logger;

  @override
  void initState() {
    getDirectoryForLogRecord().whenComplete(
      () {
        FileOutput fileOutPut = FileOutput(file: file);
        ConsoleOutput consoleOutput = ConsoleOutput();
        List<LogOutput> multiOutput = [fileOutPut, consoleOutput];
        logger = Logger(
            filter: DevelopmentFilter(),
            // Use the default LogFilter (-> only log in debug mode)
            printer: PrettyPrinter(
                methodCount: 2,
                // number of method calls to be displayed
                errorMethodCount: 8,
                // number of method calls if stacktrace is provided
                lineLength: 120,
                // width of the output
                colors: true,
                // Colorful log messages
                printEmojis: false,
                // Print an emoji for each log message
                printTime: true // Should each log print contain a timestamp
                ),
            // Use the PrettyPrinter to format and print log
            output: MultiOutput(
                multiOutput) // Use the default LogOutput (-> send everything to console)
            );
      },
    );
    super.initState();
  }

  Future<void> getDirectoryForLogRecord() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/withMultiOutput.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            print("you pressed it");
            logger.v("Verbose log");

            logger.d("Debug log");

            logger.i("Info log");

            logger.w("Warning log");

            logger.e("Error log");

            logger.wtf("What a terrible failure log");
          },
          child: const Text(
            'TEST WITH BOTH',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

/// Writes the log output to a file.
class FileOutput extends LogOutput {
  final File file;
  final bool overrideExisting;
  final Encoding encoding;
  IOSink? _sink;

  // IOSink? _sink;

  FileOutput({
    required this.file,
    this.overrideExisting = false,
    this.encoding = utf8,
  });

  @override
  void init() {
    _sink = file.openWrite(
      mode: overrideExisting ? FileMode.writeOnly : FileMode.writeOnlyAppend,
      encoding: encoding,
    );
  }

  @override
  void output(OutputEvent event) {
    _sink!.writeAll(event.lines, '\n');
  }

  @override
  void destroy() async {
    await _sink!.flush();
    await _sink!.close();
  }
}
