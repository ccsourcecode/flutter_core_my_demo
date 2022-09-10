import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            ParallelWidget(),
            ScrollNotificationWidget(),
            ScrollControllerWidget(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "視差",
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              text: "Notification",
            ),
            Tab(
              icon: Icon(Icons.perm_identity),
              text: "Controller",
            )
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

class ParallelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        //SliverAppBar 作為頭圖控件
        title: const Text('CustomScrollView Demo'), // 標題
        floating: true, // 設置懸浮樣式
        flexibleSpace: Image.network(
            "https://media-cdn.tripadvisor.com/media/photo-s/13/98/8f/c2/great-wall-hiking-tours.jpg",
            fit: BoxFit.cover), // 設置懸浮頭圖背景
        expandedHeight: 280, // 頭圖控件高度
      ),
      SliverList(
        //SliverList 作為列表控件
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('Item #$index')), // 列表項創建方法
          childCount: 100, // 列表元素個數
        ),
      ),
    ]);
  }
}

class ScrollNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scroll Notification Demo',
        home: Scaffold(
            appBar: AppBar(title: const Text('ScrollController Demo')),
            body: NotificationListener<ScrollNotification>(
              // 添加 NotificationListener 作為父容器
              onNotification: (scrollNotification) {
                // 註冊通知回調
                if (scrollNotification is ScrollStartNotification) {
                  // 滾動開始
                  print('Scroll Start');
                } else if (scrollNotification is ScrollUpdateNotification) {
                  // 滾動位置更新
                  print('Scroll Update');
                } else if (scrollNotification is ScrollEndNotification) {
                  // 滾動結束
                  print('Scroll End');
                }
                return true;
              },
              child: ListView.builder(
                itemCount: 30, // 列表元素個數
                itemBuilder: (context, index) =>
                    ListTile(title: Text("Index : $index")), // 列表項創建方法
              ),
            )));
  }
}

class ScrollControllerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScrollControllerState();
}

class _ScrollControllerState extends State<ScrollControllerWidget> {
  late ScrollController _controller; //ListView 控制器
  bool isToTop = false; // 標示目前是否需要啟用 "Top" 按鈕
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      // 為控制器註冊滾動監聽方法
      if (_controller.offset > 1000) {
        // 如果 ListView 已經向下滾動了 1000，則啟用 Top 按鈕
        setState(() {
          isToTop = true;
        });
      } else if (_controller.offset < 300) {
        // 如果 ListView 向下滾動距離不足 300，則禁用 Top 按鈕
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scroll Controller Widget")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: TextButton(
              onPressed: (isToTop
                  ? () {
                      if (isToTop) {
                        _controller.animateTo(.0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease); // 做一個滾動到頂部的動畫
                      }
                    }
                  : null),
              child: const Text("Top"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller, // 初始化傳入控制器
              itemCount: 100, // 列表元素總數
              itemBuilder: (context, index) =>
                  ListTile(title: Text("Index : $index")), // 列表項構造方法
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // 銷燬控制器
    super.dispose();
  }
}
