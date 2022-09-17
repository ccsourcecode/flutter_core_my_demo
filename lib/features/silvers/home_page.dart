import 'package:flutter/material.dart';
import './bottom_navigation.dart';
import './page.dart';
import './pages/fitness_tracker/activities/activities_page.dart';
import './pages/networking/networking_page.dart';
import './pages/slivers_basic_page.dart';
import 'pages/nested_scroll_view_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Page_enum _page = Page_enum.basic;

  void _selectPage(Page_enum page) => setState(() => _page = page);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        page: _page,
        onSelectPage: _selectPage,
      ),
    );
  }

  Widget _buildBody() {
    print("xxx1");
    print("xxx12 {$Page_enum.basic.index}");
    print(Page_enum.basic.index);
    print("xxx13 {$_page}");
    print(_page);
    return <int, WidgetBuilder>{
      Page_enum.basic.index: (_) => SliversBasicPage(),
      Page_enum.fetch.index: (_) => NetworkingPage(),
      Page_enum.custom.index: (_) => ActivitiesPage.withSampleData(),
      Page_enum.nested.index: (_) => NestedScrollViewPage(),
    }[_page.index]!(context);
  }
}
