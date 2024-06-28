import 'dart:math';

String generatePassword(
    {required bool useDigit,
    required bool useUpperCase,
    required bool useSpecialCharacters,
    required int length}) {
  const String lowerCase = 'abcdefghijklmnopqrstuvwxyz';
  const String upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String digits = '0123456789';
  const String specialCharacters = '!@#\$%^&*()-_=+[]{}|;:,.<>?/~`';

  String allowedChars = lowerCase;

  if (useUpperCase) {
    allowedChars += upperCase;
  }
  if (useDigit) {
    allowedChars += digits;
  }
  if (useSpecialCharacters) {
    allowedChars += specialCharacters;
  }

  if (allowedChars.isEmpty) {
    throw Exception('No character sets selected');
  }

  final Random random = Random.secure();
  final List<int> passwordChars = List.generate(length,
      (index) => allowedChars.codeUnitAt(random.nextInt(allowedChars.length)));

  return String.fromCharCodes(passwordChars);
}
