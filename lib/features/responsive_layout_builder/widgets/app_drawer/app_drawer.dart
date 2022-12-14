import 'package:flutter/material.dart';
import '../../responsive/orientation_layout.dart';
import '../../responsive/screen_type_layout.dart';
import '../../widgets/app_drawer/app_drawer_mobile.dart';
import '../../widgets/drawer_option/drawer_option.dart';

import 'app_drawer_tablet.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      mobile: AppDrawerMobile(),
      tablet: OrientationLayout(
        portrait: AppDrawerTabletPortrait(),
        landscape: AppDrawerTabletLandscape(),
      ),
    );
  }

  static List<Widget> getDrawerOptions() {
    return [
      const DrawerOption(
        title: 'Images',
        iconData: Icons.image,
      ),
      const DrawerOption(
        title: 'Reports',
        iconData: Icons.photo_filter,
      ),
      const DrawerOption(
        title: 'Incidents',
        iconData: Icons.message,
      ),
      const DrawerOption(
        title: 'Settings',
        iconData: Icons.settings,
      ),
    ];
  }
}
