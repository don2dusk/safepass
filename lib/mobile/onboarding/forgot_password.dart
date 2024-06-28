import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safepass/logic/api.dart';
import 'package:safepass/mobile/onboarding/welcome.dart';
import 'package:safepass/utils/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/warning-2.svg',
                color: Colors.red, width: 100),
            const SizedBox(height: 10),
            Text("Danger Zone",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 36, color: Colors.red)),
            const SizedBox(height: 10),
            Text(
                "You're about to delete your account and all your saved passwords on this device in the process. \n\nDo you want to proceed?",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black)),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                  onPressed: () => deleteUser().then((_) =>
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const WelcomeScreen()))),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Sure, go ahead",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white))),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "No, take me back",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
