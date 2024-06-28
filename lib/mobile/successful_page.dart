import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessPage extends StatelessWidget {
  final String message;
  final void Function() onPressed;
  const SuccessPage(
      {super.key, required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30)
            .copyWith(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: SvgPicture.asset(
                'assets/images/check_circle.svg',
                color: Colors.white,
                width: 50,
              ),
            ),
            const SizedBox(height: 30),
            Text("Success!", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 50),
            TextButton(
                onPressed: onPressed,
                child: Text("Continue",
                    style: Theme.of(context).textTheme.labelLarge))
          ],
        ),
      ),
    );
  }
}
