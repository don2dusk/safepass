import 'package:flutter/material.dart';
import 'package:safepass/utils/colors.dart';
import 'package:safepass/desktop/dashboard.dart';
import 'package:safepass/mobile/dashboard.dart';
import 'package:safepass/utils/responsive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
            brightness: Brightness.light,
            background: backgroundColor,
            primary: primaryColor,
            secondary: buttonColor,
            tertiary: tertiaryColor,
          ),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
              buttonColor: backgroundColor,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          textTheme: TextTheme()),
      home: const ResponsiveLayout(
          mobileApp: MobileDashboard(), desktopApp: DesktopDashboard()),
    );
  }
}
