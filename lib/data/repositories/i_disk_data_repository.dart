import 'package:code_generator_app/data/models/keyword/keyword.dart';
import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:flutter/foundation.dart';

abstract interface class IDiskDataRepository {
  ValueListenable<List<Keyword>> get keywordsListenable;

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

  ValueListenable<bool> get isLoginObscuredListenable;

  Future<void> setLoginObscured(bool value);

  ValueListenable<bool> get isKeyObscuredListenable;

  Future<void> setKeyObscured(bool value);

  ValueListenable<bool> get isPasswordObscuredListenable;

  Future<void> setPasswordObscured(bool value);

  ValueListenable<bool> get doSaveListenable;

  Future<void> setDoSave(bool value);

  ValueListenable<bool> get doCopyPasswordListenable;

  Future<void> setDoCopyPassword(bool value);

  ValueListenable<EncryptionType> get encryptionTypeListenable;

  Future<void> setEncryptionAlgorithm(String value);
}
