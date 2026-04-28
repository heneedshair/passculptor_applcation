import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';

abstract interface class IMainScreenModel extends ElementaryModel {
  Future<void> addWebsite(String login, String website, String key);

  bool containsSameKeyword(String enteredKeyword);

  ValueListenable<bool> get isLoginObscuredListenable;

  Future<void> setLoginObscured(bool value);

  ValueListenable<bool> get isKeyObscuredListenable;

  Future<void> setKeyObscured(bool value);

  ValueListenable<bool> get isPasswordObscuredListenable;

  Future<void> setPasswordObscured(bool value);

  ValueListenable<bool> get doSaveListenable;

  Future<void> setDoSave(bool value);

  ValueListenable<bool> get doCopyPasswordListenable;

  ValueListenable<EncryptionType> get encryptionTypeListenable;
}

class MainScreenModel extends IMainScreenModel {
  MainScreenModel(this._repository);

  final IDiskDataRepository _repository;

  @override
  Future<void> addWebsite(
    String enteredLogin,
    String enteredWebsite,
    String enteredKeyword,
  ) async =>
      await _repository.addWebsite(
        login: enteredLogin,
        website: enteredWebsite,
        keyword: enteredKeyword,
      );

  @override
  bool containsSameKeyword(String enteredKeyword) => _repository.containsSameKeyword(enteredKeyword);

  @override
  ValueListenable<bool> get isLoginObscuredListenable => _repository.isLoginObscuredListenable;

  @override
  Future<void> setLoginObscured(bool value) => _repository.setLoginObscured(value);

  @override
  ValueListenable<bool> get isKeyObscuredListenable => _repository.isKeyObscuredListenable;

  @override
  Future<void> setKeyObscured(bool value) => _repository.setKeyObscured(value);

  @override
  ValueListenable<bool> get isPasswordObscuredListenable => _repository.isPasswordObscuredListenable;

  @override
  Future<void> setPasswordObscured(bool value) => _repository.setPasswordObscured(value);

  @override
  ValueListenable<bool> get doSaveListenable => _repository.doSaveListenable;

  @override
  Future<void> setDoSave(bool value) => _repository.setDoSave(value);

  @override
  ValueListenable<bool> get doCopyPasswordListenable => _repository.doCopyPasswordListenable;

  @override
  ValueListenable<EncryptionType> get encryptionTypeListenable => _repository.encryptionTypeListenable;
}
