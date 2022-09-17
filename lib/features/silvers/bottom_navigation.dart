import 'package:flutter/material.dart';

import 'page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {Key? key, required this.page, required this.onSelectPage})
      : super(key: key);
  final Page_enum page;
  final ValueChanged<Page_enum> onSelectPage;

  Color _color(Page_enum page) =>
      this.page == page ? Colors.indigo : Colors.grey;

  static const Map<Page_enum, IconData> icons = {
    Page_enum.basic: Icons.view_headline,
    Page_enum.fetch: Icons.cloud_download,
    Page_enum.custom: Icons.directions_run,
    Page_enum.nested: Icons.table_chart,
  };

  static const Map<Page_enum, String> names = {
    Page_enum.basic: 'basic',
    Page_enum.fetch: 'networking',
    Page_enum.custom: 'custom',
    Page_enum.nested: 'nested',
  };

  BottomNavigationBarItem _buildItem(Page_enum page) {
    return BottomNavigationBarItem(
        icon: Icon(
          icons[page],
          color: _color(page),
        ),
        label: names[page]!);
  }

  @override
  Widget build(BuildContext context) {
    print("xxx2");
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: Page_enum.values.map(_buildItem).toList(),
      onTap: (index) => onSelectPage(Page_enum.values[index]),
    );
  }
}
