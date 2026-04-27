import 'package:code_generator_app/data/models/keyword/keyword.dart';

abstract interface class IDiskDataRepository {
  Future<List<Keyword>> loadKeywords();

  Future<void> addWebsite({
    required String login,
    required String website,
    required String keyword,
  });

  bool containsSameKeyword(String keyword);

  Future<void> clearKeywords();

  Future<void> deleteWebsite({
    required String website,
    required String login,
    required String keyword,
  });

  Future<void> deleteLogin({
    required String login,
    required String keyword,
  });

  Future<void> deleteKeyword(String keyword);

  bool get isLoginObscured;

  Future<void> setLoginObscured(bool value);

  bool get isKeyObscured;

  Future<void> setKeyObscured(bool value);

  bool get isPasswordObscured;

  Future<void> setPasswordObscured(bool value);

  bool get doSave;

  Future<void> setDoSave(bool value);

  String? get encryptionAlgorithm;

  Future<void> setEncryptionAlgorithm(String value);
}
