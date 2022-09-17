import 'package:flutter/material.dart';

class ReorderWidgetApp extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<ReorderWidgetApp> {
  List<int> widgetIds = [0, 1, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // use the widgetId's and the map function to produce a list of children for the Stack
      body: Stack(
        children: widgetIds.reversed
            .map((id) => StackItem(
                  id: id,
                  isTop: id == widgetIds.first,
                ))
            .toList(),
      ),
      // re-order the widgets
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widgetIds = [widgetIds.last, ...widgetIds.getRange(0, 2)];
          });
        },
      ),
    );
  }
}

class StackItem extends StatelessWidget {
  final int id;
  final bool isTop;

  const StackItem({super.key, required this.id, required this.isTop});

// make the root of the widget a Positioned widget.
// set the left and top to a third of the screen size * id value
// use the id to generate a colour with some random values.
// pass in a boolean that tells us if the item is currently at the top.
// If it is we give it a drop shadow to stand out a bit more.
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: id * (MediaQuery.of(context).size.width / 3),
      top: id * (MediaQuery.of(context).size.height / 3),
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, id * 40, id * (id * 10), 150 + (id * 3)),
            boxShadow: [
              if (isTop)
                const BoxShadow(
                    color: Color.fromARGB(125, 0, 0, 0), blurRadius: 16)
            ]),
      ),
    );
  }
}
