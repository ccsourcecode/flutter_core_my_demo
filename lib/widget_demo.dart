import 'package:core_example/features/widget/dartz/dartz_app.dart';
import 'package:core_example/features/widget/google_sign_in/google_app.dart';
import 'package:core_example/features/widget/text/text_app.dart';
import 'package:core_example/features/widget/textfield/textfield_app.dart';
import 'package:flutter/material.dart';
import '../features/page2.dart';
import 'features/widget/button/button_app.dart';
import 'features/widget/center/center_app.dart';
import 'features/widget/column/column_app.dart';
import 'features/widget/container/contain_app.dart';
import 'features/widget/http/http_app.dart';
import 'features/widget/row/row_app.dart';
import 'features/widget/stack/stack_app.dart';
import 'features/widget/stateless_stateful/state_app.dart';

class WidgetDemoPage extends StatefulWidget {
  const WidgetDemoPage({super.key, required this.title});

  final String title;

  @override
  State<WidgetDemoPage> createState() => _WidgetDemoPageState();
}

class _WidgetDemoPageState extends State<WidgetDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text("Text field"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TextFiledAppPage(title: 'Text field')),
                ),
              ),
              TextButton(
                child: const Text("Text"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TextAppPage(title: 'Text')),
                ),
              ),
              TextButton(
                child: const Text("Stateless Stateful"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StateAppPage(
                            title: 'Stateless Stateful',
                          )),
                ),
              ),
              TextButton(
                child: const Text("Stack"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StackAppPage(title: 'Stack')),
                ),
              ),
              TextButton(
                child: const Text("Row"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RowAppPage(title: 'Row')),
                ),
              ),
              TextButton(
                child: const Text("Column"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ColumnAppPage(title: 'Column')),
                ),
              ),
              TextButton(
                child: const Text("Http"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HttpAppPage(title: 'Http')),
                ),
              ),
              TextButton(
                child: const Text("Container"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ContainerAppPage(title: 'Container')),
                ),
              ),
              TextButton(
                child: const Text("Center"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const CenterAppPage(title: 'Center')),
                ),
              ),
              TextButton(
                child: const Text("Button"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ButtonAppPage(title: 'Button')),
                ),
              ),
              TextButton(
                child: const Text("Dart"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DartzAppPage(
                            title: 'Dartz',
                          )),
                ),
              ),
              TextButton(
                child: const Text("Google sign in"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleAppPage()),
                ),
              ),
              TextButton(
                child: const Text("Domain driven design (Not yet"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('x');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
