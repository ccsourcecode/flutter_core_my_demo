import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshApp extends StatelessWidget {
  const PullToRefreshApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}

class Home extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        // header: defaultHeader,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: [
            RefreshBackground(), // <== Add AppBack background
            SliverList(delegate: SliverChildListDelegate(buildList()))
          ],
        ),
      ),
    );
  }
}

List<Widget> buildList() {
  return List.generate(
      15,
      (index) => Container(
            height: 100,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ));
}

class RefreshBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
        "assets/ronnie-mayo-361348-unsplash.jpg'",
        fit: BoxFit.cover,
      )),
    );
  }
}
