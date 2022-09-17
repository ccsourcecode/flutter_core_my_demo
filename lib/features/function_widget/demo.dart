// Import packages for functional widget to work
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/material.dart';

// include the partial generated file
part 'demo.g.dart';

class FunctionWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeView('Home view Title'));
  }
}

@swidget
Widget homeView(String title) => Scaffold(
        body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        HeaderSection(title, 'FilledStacks'),
        const DecoratedContainer(),
      ]),
    ));

@swidget
Widget headerSection(String title, String name) => Column(children: [
      Text(title),
      Text('All posts from $name'),
    ]);

@swidget
Widget decoratedContainer() => Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.red,
          boxShadow: const [
            BoxShadow(color: Colors.red, blurRadius: 16.0),
          ]),
    );



/*


Each function generates a stateless widget making the function name the class name starting with an uppercase letter. So when referring to the widget you use the Uppercase name instead of the actual declared function name. For example

Then to run the generator, you will use the build_runner

flutter pub pub run build_runner watch


@widget
Widget myCustomWidget() => Container();

will be used as 

MyCustomWidget();

*/