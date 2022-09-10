import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/consumer_demo.dart';
import 'provider/provider_demo.dart';
import 'provider/counter_model.dart';

class ProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            ConsumerTabPage1(),
            ProviderTabPage1(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Consumer",
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              text: "Provider",
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
