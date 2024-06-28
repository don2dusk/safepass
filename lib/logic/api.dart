import 'package:flutter_svg/svg.dart';
import 'package:safepass/database/database_helper.dart';
import 'package:safepass/models/password_item.dart';

Future<bool> userExists() async {
  final db = await DatabaseHelper().database;
  final query = await db.query('user');

  if (query.length != 1) {
    return false;
  } else {
    return true;
  }
}

Future<String> displayUsername() async {
  final db = await DatabaseHelper().database;
  final query = await db.query('user');

  return query.first['username'] as String;
}

Future<void> createUser(String username, String password) async {
  final db = await DatabaseHelper().database;
  await db
      .insert('user', {'username': username, 'masterPasswordHash': password});
}

Future<bool> loginUser(String username, String password) async {
  final db = await DatabaseHelper().database;
  final query = await db.query('user');
  String queriedPassword = query.first['masterPasswordHash'] as String;
  int userId = query.first['userId'] as int;
  if (password == queriedPassword) {
    retrievePasswords();
    return true;
  } else {
    return false;
  }
}

Future<List<PasswordItem>> retrievePasswords() async {
  final db = await DatabaseHelper().database;
  final query = await db.query('user');
  int userId = query.first['userId'] as int;
  final List<Map<String, Object?>> passwords =
      await db.query('passwordEntry', where: 'userId = ?', whereArgs: [userId]);

  return [
    for (final {
          'entryId': entryId as int,
          'website': website as String,
          'username': username as String,
          'password': password as String,
          'category': category as String,
          'description': description as String?,
        } in passwords)
      PasswordItem(
          entryId: entryId,
          favicon: category == "Website"
              ? SvgPicture.asset('assets/images/global.svg')
              : SvgPicture.asset('assets/images/slider-horizontal.svg'),
          site: website,
          username: username,
          password: password,
          category: category,
          description: description ?? "")
  ];
}

Future<void> addPassword(PasswordItem password) async {
  final db = await DatabaseHelper().database;
  final query = await db.query('user');
  int userId = query.first['userId'] as int;
  await db.insert('passwordEntry', {
    'userId': userId,
    'favicon': '',
    'title': password.title,
    'website': password.site,
    'username': password.username,
    'password': password.password,
    'category': password.category,
    'description': password.description,
    'createdDate': DateTime.now().toString(),
    'modifiedDate': DateTime.now().toString(),
  }).then((e) => print(e));
}

Future<void> deletePassword(PasswordItem password) async {
  final db = await DatabaseHelper().database;
  await db.delete('passwordEntry',
      where: 'entryId = ?', whereArgs: [password.entryId]);
}

Future<void> deleteUser() async {
  final db = await DatabaseHelper().database;
  await db.delete('passwordEntry');
  await db.delete('user');
}
