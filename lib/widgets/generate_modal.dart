import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:safepass/logic/password_generator.dart';

import '../utils/colors.dart';

class GenerateModal extends StatefulWidget {
  const GenerateModal({
    super.key,
  });

  @override
  State<GenerateModal> createState() => _GenerateModalState();
}

class _GenerateModalState extends State<GenerateModal> {
  double characterValue = 0;
  bool useDigits = false;
  bool useCapital = false;
  bool useSpecial = false;
  int passwordLength = 6;
  @override
  Widget build(BuildContext context) {
    String generatedPassword = generatePassword(
        useDigit: useDigits,
        useUpperCase: useCapital,
        useSpecialCharacters: useSpecial,
        length: passwordLength);
    return Container(
      width: double.infinity,
      height: 550,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Create", style: Theme.of(context).textTheme.headlineLarge),
          Text("a solid password",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: altColor)),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Password Length",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                passwordLength.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          Slider.adaptive(
            value: (passwordLength / 32),
            onChanged: (value) {
              setState(() {
                characterValue = value;
                passwordLength = (value * 32).toInt();
              });
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Use digits",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Switch.adaptive(
                  activeColor: primaryColor,
                  value: useDigits,
                  onChanged: (val) {
                    setState(() {
                      useDigits = val;
                    });
                  })
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Use capital letters",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Switch.adaptive(
                  activeColor: primaryColor,
                  value: useCapital,
                  onChanged: (val) {
                    setState(() {
                      useCapital = val;
                    });
                  })
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Use special characters",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Switch.adaptive(
                  activeColor: primaryColor,
                  value: useSpecial,
                  onChanged: (val) {
                    setState(() {
                      useSpecial = val;
                    });
                  })
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 70,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        generatedPassword,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: generatedPassword))
                              .then((e) => Get.snackbar(
                                    "",
                                    "Password Copied Successfully",
                                    backgroundColor: Colors.green,
                                    snackPosition: SnackPosition.TOP,
                                    snackStyle: SnackStyle.FLOATING,
                                  ));
                        },
                        padding: const EdgeInsets.all(5),
                        icon: SvgPicture.asset(
                          'assets/images/copy copy.svg',
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
