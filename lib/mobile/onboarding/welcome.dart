import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safepass/mobile/onboarding/signup.dart';
import 'package:safepass/mobile/onboarding/sync_receive.dart';
import 'package:safepass/utils/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30)
            .copyWith(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset('assets/images/lock.svg',
                    width: 60, color: primaryColor),
              ),
            ),
            Text("Keep your Passwords",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: primaryColor, fontSize: 24)),
            const SizedBox(height: 10),
            Text("Safe and Secure with SafePass.",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.bold)),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 75,
                width: 75,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const SignupPage()));
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: secondaryColor,
                    ),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const ReceiveSync())),
                  child: Text(
                    "Sync passwords from another device instead?",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        color: primaryColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
