import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class MovableStackView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<MovableStackView> {
  List<Widget> movableItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              movableItems.add(const MoveableStackItem());
            });
          },
        ),
        body: Stack(
          children: movableItems,
        ));
  }
}

class MoveableStackItem extends StatefulWidget {
  const MoveableStackItem({Key? key}) : super(key: key);

  @override
  _MoveableStackItemState createState() => _MoveableStackItemState();
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  late Color color;

  @override
  void initState() {
    color = RandomColor().randomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: Container(
          width: 150,
          height: 150,
          color: color,
        ),
      ),
    );
  }
}
