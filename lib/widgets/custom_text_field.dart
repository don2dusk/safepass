import 'package:flutter/material.dart';
import 'package:safepass/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool isObscure;
  const CustomTextField(
      {super.key,
      this.textController,
      this.isObscure = false,
      this.prefixIcon,
      this.suffixIcon,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: TextField(
          obscureText: isObscure,
          controller: textController,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: const Color(0xFF757575)),
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 0.6, color: secondaryColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 0.6, color: Color(0xFF757575)))),
        ),
      ),
    );
  }
}
