import 'package:flutter/material.dart';
import 'multi_screen/master_detail_page.dart';
import 'multi_screen/orientation_demo.dart';

class MultiScreenPage extends StatelessWidget {
  const MultiScreenPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            MasterDetailPage(),
            OrientationDemo(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "多窗格",
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              text: "轉屏",
            ),
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
