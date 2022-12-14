import 'package:flutter/material.dart';
import '../../responsive/orientation_layout.dart';
import '../../responsive/screen_type_layout.dart';

import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: HomeMobilePortrait(),
        landscape: const HomeMobileLandscape(),
      ),
      tablet: const HomeViewTablet(),
    );
  }
}
