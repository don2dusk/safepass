import 'package:flutter/material.dart';
import 'package:safepass/utils/constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileApp;
  final Widget desktopApp;

  const ResponsiveLayout(
      {super.key, required this.mobileApp, required this.desktopApp});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileWidth) {
        return mobileApp;
      } else {
        return desktopApp;
      }
    });
  }
}
