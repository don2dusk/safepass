import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuItem> menuItems;
  final void Function(dynamic)? onChanged;
  final value;
  const CustomDropdown(
      {super.key,
      required this.menuItems,
      required this.onChanged,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(width: 0.6, color: const Color(0xFF757575)),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButton(
          value: value,
          items: menuItems,
          isExpanded: true,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          elevation: 0,
          dropdownColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
      ),
    );
  }
}
