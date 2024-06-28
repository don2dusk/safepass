import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safepass/logic/api.dart';
import 'package:safepass/mobile/dashboard.dart';
import 'package:safepass/mobile/successful_page.dart';
import 'package:safepass/models/password_item.dart';
import 'package:safepass/utils/colors.dart';

import '../widgets/vertical_menu.dart';

class PasswordPreview extends StatefulWidget {
  final PasswordItem password;
  const PasswordPreview({super.key, required this.password});

  @override
  State<PasswordPreview> createState() => _PasswordPreviewState();
}

class _PasswordPreviewState extends State<PasswordPreview> {
  bool isObscure = true;
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
                    "Password Detail",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  )),
                  // IconButton(onPressed: () {}, icon: const VerticalMenu())
                  PopupMenuButton(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Colors.black, width: 0.6)),
                      icon: const VerticalMenu(),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                onTap: () {
                                  deletePassword(widget.password).then((_) =>
                                      Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => SuccessPage(
                                              message:
                                                  "Password Successfully Deleted",
                                              onPressed: () => Navigator.of(context)
                                                  .push(PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          const MobileDashboard()))))));
                                },
                                child: Text(
                                  "Delete Password",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ))
                          ])
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
                  Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: accentColor.withAlpha(135),
                      child: Center(
                          child: widget.password.favicon ??
                              (widget.password.category == "Websites"
                                  ? SvgPicture.asset(
                                      'assets/images/global.svg',
                                      width: 35,
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/slider-horizontal.svg',
                                      width: 35,
                                    ))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      widget.password.title ?? widget.password.site,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: accentColor.withAlpha(95)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Username/email",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: primaryColor)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/sms.svg',
                                color: primaryColor),
                            const SizedBox(width: 10),
                            Text(
                              widget.password.username,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text("Password",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: primaryColor)),
                        // const SizedBox(height: 5),
                        SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/key.svg',
                                  color: primaryColor),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  isObscure
                                      ? '*' * widget.password.password.length
                                      : widget.password.password,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              IconButton(
                                  onPressed: () => setState(() {
                                        isObscure = !isObscure;
                                      }),
                                  icon: isObscure
                                      ? SvgPicture.asset(
                                          'assets/images/eye.svg',
                                          color: primaryColor)
                                      : SvgPicture.asset(
                                          'assets/images/eye-slash.svg',
                                          color: primaryColor))
                            ],
                          ),
                        ),
                      ],
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
                  Text(
                    widget.password.site,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: widget.password.description != "" ? 20 : 0),
                  widget.password.description != ""
                      ? Text("Description",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: primaryColor))
                      : const SizedBox(),
                  SizedBox(height: widget.password.description != "" ? 10 : 0),
                  widget.password.description != ""
                      ? Text(
                          widget.password.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  Text("Category",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: primaryColor)),
                  const SizedBox(height: 10),
                  Text(
                    widget.password.category,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
