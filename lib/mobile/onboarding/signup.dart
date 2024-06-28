import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safepass/logic/api.dart';
import 'package:safepass/mobile/onboarding/login.dart';
import 'package:safepass/mobile/successful_page.dart';
import 'package:safepass/utils/colors.dart';
import 'package:safepass/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
            .copyWith(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign up",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: primaryColor, fontSize: 36),
            ),
            const SizedBox(height: 10),
            Text(
              "Let's get you started with SafePass",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 30),
            SizedBox(
                height: 50,
                child: CustomTextField(
                  textController: usernameController,
                  hintText: "someoneSpecial",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      'assets/images/frame.svg',
                      color: primaryColor,
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            SizedBox(
                height: 50,
                child: CustomTextField(
                  textController: passwordController,
                  isObscure: isObscure,
                  hintText: "This is your master password.",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      'assets/images/key.svg',
                      color: primaryColor,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: SvgPicture.asset(
                        isObscure
                            ? 'assets/images/eye.svg'
                            : 'assets/images/eye-slash.svg',
                        color: primaryColor,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            Text(
              "We'll keep your password safe on our end. Make sure you keep yours safe too",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  onPressed: () async {
                    createUser(usernameController.text, passwordController.text)
                        .then((_) => Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    SuccessPage(
                                        message:
                                            "You've successfully created your account.",
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      const LoginPage()));
                                        }))));
                  },
                  style: TextButton.styleFrom(backgroundColor: secondaryColor),
                  child: Text(
                    "Sign up",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
