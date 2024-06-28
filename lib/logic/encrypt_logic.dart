import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:argon2/argon2.dart';

class OnBoarding {
  const OnBoarding();
  // Generates salt to store in DB during user onboarding ONLY
  String generateSalt([int length = 16]) {
    final random = Random.secure();
    final saltBytes = List<int>.generate(length, (_) => random.nextInt(256));
    return base64Url.encode(saltBytes);
  }

  /// Hashes a password using Argon2i
  Future<String> hashPassword(String password, String salt) async {
    final saltBytes = base64Url.decode(salt);

    var parameters = Argon2Parameters(
      Argon2Parameters.ARGON2_i,
      saltBytes,
      version: Argon2Parameters.ARGON2_VERSION_10,
      iterations: 2,
      memoryPowerOf2: 16,
    );

    var argon2 = Argon2BytesGenerator();

    argon2.init(parameters);

    var passwordBytes = parameters.converter.convert(password);

    var result = Uint8List(32);
    argon2.generateBytes(passwordBytes, result, 0, result.length);

    var resultHex = result.toHexString();
    return resultHex;
  }
}
