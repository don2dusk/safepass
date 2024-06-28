import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safepass/mobile/add_password.dart';
import 'package:safepass/utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  final void Function() homeOnPressed;
  final void Function() syncOnPressed;
  const CustomNavBar(
      {super.key, required this.homeOnPressed, required this.syncOnPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset('assets/images/Vector.svg', fit: BoxFit.fill),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                          onPressed: homeOnPressed,
                          icon: SvgPicture.asset(
                            'assets/images/home.svg',
                            color: accentColor,
                            fit: BoxFit.fill,
                            width: 25,
                          )),
                    ),
                    // const SizedBox(width: 15),
                    IconButton(
                        onPressed: () => Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const AddPassword())),
                        padding: const EdgeInsets.all(15),
                        icon: SvgPicture.asset(
                          'assets/images/add.svg',
                          width: 35,
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: accentColor,
                        )),
                    // const SizedBox(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                          onPressed: syncOnPressed,
                          icon: SvgPicture.asset(
                            'assets/images/convertshape.svg',
                            color: accentColor,
                            width: 25,
                          )),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
