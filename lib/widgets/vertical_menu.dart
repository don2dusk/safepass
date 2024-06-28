import 'package:flutter/material.dart';

class VerticalMenu extends StatelessWidget {
  const VerticalMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.black,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.black,
        ),
        CircleAvatar(
          radius: 2,
          backgroundColor: Colors.black,
        )
      ],
    );
  }
}
