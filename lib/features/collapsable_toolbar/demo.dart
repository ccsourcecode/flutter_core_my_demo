import 'package:flutter/material.dart';

class CollapsableApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
        // To use Slivers in a Scrollable view we have to use the CustomScrollView widget.
        // Pinned true tells the the CustomScrollView to keep the AppBarVisible even when collapsed and not scroll it out of view
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('FilledStacks'),
                background: Image.asset(
                  'icon.png', // <===   Add your own image to assets or use a .network image instead.
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: List<int>.generate(6, (index) => index)
                    .map((index) => Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: Text('$index item'),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
