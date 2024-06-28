import 'package:flutter/widgets.dart';

class PasswordItem {
  final int? entryId;
  final Widget? favicon;
  final String? title;
  final String site;
  final String username;
  final String password;
  final String description;
  final String category;

  PasswordItem(
      {this.entryId,
      this.favicon,
      this.title,
      this.site = "",
      required this.username,
      required this.password,
      this.description = "",
      required this.category});
}
