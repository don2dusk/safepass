import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safepass/logic/api.dart';
import 'package:safepass/mobile/dashboard.dart';
import 'package:safepass/mobile/successful_page.dart';
import 'package:safepass/models/password_item.dart';
import 'package:safepass/utils/colors.dart';
import 'package:safepass/widgets/custom_dropdown.dart';
import 'package:safepass/widgets/custom_text_field.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({super.key});

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  bool isObscure = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController siteController = TextEditingController();

  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30)
            .copyWith(top: 70),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                          shape: const CircleBorder(
                              side:
                                  BorderSide(width: 0.6, color: Colors.black))),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                        size: 20,
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(
                    "Add Password",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: accentColor.withAlpha(135),
                        child: Center(
                            child: category != ""
                                ? (category == "Website"
                                    ? SvgPicture.asset(
                                        'assets/images/global.svg',
                                        width: 35,
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/slider-horizontal.svg',
                                        width: 35,
                                      ))
                                : const SizedBox()),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 50,
                          child: CustomTextField(
                              textController: titleController,
                              hintText: "Title"))
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text("Username/email",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: primaryColor)),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      textController: usernameController,
                      hintText: "user@example.com",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/images/sms.svg',
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text("Password",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: primaryColor)),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      hintText: "",
                      textController: passwordController,
                      isObscure: isObscure,
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
                          onTap: () => setState(() {
                            isObscure = !isObscure;
                          }),
                          child: SvgPicture.asset(
                            isObscure
                                ? 'assets/images/eye.svg'
                                : 'assets/images/eye-slash.svg',
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Text("Address",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: primaryColor)),
                  const SizedBox(height: 10),
                  SizedBox(
                      height: 50,
                      child: CustomTextField(
                          textController: siteController,
                          hintText: "www.example.com")),
                  const SizedBox(height: 20),
                  Text("Category",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: primaryColor)),
                  const SizedBox(height: 10),
                  CustomDropdown(
                      value: category.isNotEmpty ? category : null,
                      menuItems: <String>['App', 'Website']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(growable: false),
                      onChanged: (item) {
                        setState(() {
                          category = item;
                        });
                      }),
                  Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                addPassword(PasswordItem(
                                        site: siteController.text,
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        category: category))
                                    .then((_) => Navigator.of(context).push(PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            SuccessPage(
                                                message:
                                                    "You have successfully added a password, click on continue to proceed.",
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const MobileDashboard()))))));
                              },
                              child: Text("Save Password",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white))),
                        )),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
