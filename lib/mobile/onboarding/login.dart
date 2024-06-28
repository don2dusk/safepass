import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:safepass/logic/api.dart';
import 'package:safepass/mobile/dashboard.dart';
import 'package:safepass/mobile/onboarding/forgot_password.dart';
import 'package:safepass/utils/colors.dart';
import 'package:safepass/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "defaultName";
  bool isObscure = true;
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayUsername().then((e) => setState(() {
          username = e;
        }));
  }

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
              "Login",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: primaryColor, fontSize: 36),
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome, $username!",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 50,
                child: CustomTextField(
                  textController: passwordController,
                  isObscure: isObscure,
                  hintText: "Your master password goes here...",
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
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ForgotPassword())),
                child: Text("Forgot Password?",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red)),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  onPressed: () async {
                    loginUser(username, passwordController.text).then((val) {
                      if (val) {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const MobileDashboard()));
                      } else {
                        Get.snackbar("Error", "Incorrect master password!",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    });
                  },
                  style: TextButton.styleFrom(backgroundColor: secondaryColor),
                  child: Text(
                    "Login",
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
