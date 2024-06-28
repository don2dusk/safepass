import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safepass/logic/api.dart';
import 'package:safepass/logic/encrypt_logic.dart';
import 'package:safepass/mobile/onboarding/login.dart';
import 'package:safepass/mobile/onboarding/signup.dart';
import 'package:safepass/mobile/onboarding/welcome.dart';
import 'package:safepass/utils/colors.dart';
import 'package:safepass/desktop/dashboard.dart';
import 'package:safepass/mobile/dashboard.dart';
import 'package:safepass/utils/constants.dart';
import 'package:safepass/utils/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool user = await userExists();
  runApp(MyApp(
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  final bool user;
  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
            brightness: Brightness.light,
            surface: backgroundColor,
            primary: primaryColor,
            secondary: secondaryColor,
            tertiary: tertiaryColor,
          ),
          cardTheme: CardTheme(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
          appBarTheme: const AppBarTheme(
              backgroundColor: backgroundColor,
              scrolledUnderElevation: 0,
              elevation: 0,
              toolbarHeight: 70),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
              buttonColor: backgroundColor,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          textTheme: TextTheme(
              headlineLarge: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: size.width <= mobileWidth ? 32 : 48,
                  fontWeight: FontWeight.bold),
              headlineMedium: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: size.width <= mobileWidth ? 28 : 42,
                  fontWeight: FontWeight.w600),
              titleLarge: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: size.width <= mobileWidth ? 24 : 36,
                  fontWeight: FontWeight.bold),
              titleMedium: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: size.width <= mobileWidth ? 20 : 32,
                  fontWeight: FontWeight.w600),
              titleSmall: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: size.width <= mobileWidth ? 18 : 28,
                  fontWeight: FontWeight.w600),
              bodyLarge: GoogleFonts.inter(
                  fontSize: size.width <= mobileWidth ? 18 : 24,
                  fontWeight: FontWeight.w500),
              bodyMedium: GoogleFonts.inter(
                  fontSize: size.width <= mobileWidth ? 16 : 20,
                  fontWeight: FontWeight.normal),
              bodySmall: GoogleFonts.inter(
                  fontSize: size.width <= mobileWidth ? 14 : 18,
                  fontWeight: FontWeight.w400),
              labelMedium: GoogleFonts.inter(
                  fontSize: size.width <= mobileWidth ? 12 : 16,
                  fontWeight: FontWeight.w300))),
      home: ResponsiveLayout(
          mobileApp: user ? const LoginPage() : const WelcomeScreen(),
          desktopApp: const DesktopDashboard()),
    );
  }
}
