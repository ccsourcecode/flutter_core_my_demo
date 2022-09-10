import 'package:flutter/material.dart';
import 'animation/normal_animate_widget.dart';
import 'animation/builder_animate_widget.dart';
import 'animation/widget_animate_widget.dart';
import 'animation/hero_transition.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            NormalAnimateWidget(),
            BuilderAnimateWidget(),
            WidgetAnimateWidget(),
            Page1()
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "普通動畫",
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              text: "Builder動畫",
            ),
            Tab(
              icon: Icon(Icons.perm_identity),
              text: "Widget動畫",
            ),
            Tab(icon: Icon(Icons.message), text: 'Hero 動畫')
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}
