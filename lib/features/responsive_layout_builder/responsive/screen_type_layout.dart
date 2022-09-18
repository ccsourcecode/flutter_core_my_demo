import 'package:flutter/material.dart';
import '../enums/device_screen_type.dart';
import '../responsive/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget? desktop;
  const ScreenTypeLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
          return tablet;
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
          return desktop!;
        }

        return mobile;
      },
    );
  }
}
