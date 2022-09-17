import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StickyHeaderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BasicView(),
    );
  }
}

class BasicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
              height: 50.0,
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Header #$index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            // generate 5 grey containers as the children
            content: Column(
              children: List<int>.generate(5, (index) => index)
                  .map((item) => Container(
                        height: 50,
                        color: Colors.grey[(item + 1) * 100],
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class CustomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return StickyHeaderBuilder(
            builder: (context, stuckAmount) {
              print('$index - $stuckAmount');
              // The builder returns the "stuckAmount" which will start firing when the header reaches the sticking point.
              // The value goes from 1 to -1, 1 being at the bottom of the sticking point,
              // -1 being above the sticking point.
              // clamp the amount so it doesn't go into the negatives.
              stuckAmount = stuckAmount.clamp(0.0, 1.0);
              return Container(
                // set our height to the max size (100) and we subtract the relative shrink height (50) based on the stuck amount that's clamped
                // and inverted (subtracted from 1).
                // This will cause the shrinking effect as the value gets larger
                height: 100.0 - (50 * (1 - stuckAmount)),
                // change color from blue to red as the stuckAmount progresses
                color: Color.lerp(Colors.blue, Colors.red, stuckAmount),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Title #$index',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            content: Column(
              children: List<int>.generate(5, (index) => index)
                  .map((item) => Container(
                        height: 50,
                        color: Colors.grey[(item + 1) * 100],
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
