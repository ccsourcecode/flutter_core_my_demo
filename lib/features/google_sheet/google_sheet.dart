import 'package:flutter/material.dart';
import '././screens/home/home_page.dart';
import './config/secret.dart';
import 'providers/google_sheets_provider.dart';

const String routeAdd = '/add';
const String routeHome = '/';

/// Wrapper for stateful functionality to provide onInit calls in stateless widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  final sheetId = "1uPTi7OYXMPZQcIjNrauM79Avq2_lJLcvYv3Mkhaa6i0";
  final worksheetTitle = "Test1";
  final provider = GoogleSheetsProvider((credentials));

  @override
  void initState() {
    widget.onInit();
    super.initState();
    asyncMethod();
    print("start5");
  }

  void asyncMethod() async {
    /// Initialize provider
    await provider.initializeForWorksheet(sheetId, worksheetTitle);
    print("start4");
  }

  @override
  Widget build(BuildContext context) {
    print("start6");

    return HomePage(provider: provider);
  }
}

class GoogleSheetsApp extends StatelessWidget {
  const GoogleSheetsApp({
    Key? key,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        _getThingsOnStartup().then((value) {
          print('Async done');
        });
      },
      child: Container(),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
