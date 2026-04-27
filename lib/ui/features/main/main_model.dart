import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

abstract interface class IMainScreenModel extends ElementaryModel {
  Future<void> addWebsite(String login, String website, String key);

  bool containsSameKeyword(String enteredKeyword);

  bool get isLoginObscured;

  EntityValueListenable<bool> get isLoginObscuredListenable;

  Future<void> setLoginObscured(bool value);

  bool get isKeyObscured;

  EntityValueListenable<bool> get isKeyObscuredListenable;

  Future<void> setKeyObscured(bool value);

  bool get isPasswordObscured;

  EntityValueListenable<bool> get isPasswordObscuredListenable;

  Future<void> setPasswordObscured(bool value);

  bool get doSave;

  EntityValueListenable<bool> get doSaveListenable;

  Future<void> setDoSave(bool value);

  EncryptionType get encryptionAlgorithm;

  EntityValueListenable<EncryptionType> get encryptionTypeListenable;
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
  bool containsSameKeyword(String enteredKeyword) =>
      _repository.containsSameKeyword(enteredKeyword);

  @override
  bool get isLoginObscured => _repository.isLoginObscured;

  @override
  EntityValueListenable<bool> get isLoginObscuredListenable =>
      _repository.isLoginObscuredListenable;

  @override
  Future<void> setLoginObscured(bool value) =>
      _repository.setLoginObscured(value);

  @override
  bool get isKeyObscured => _repository.isKeyObscured;

  @override
  EntityValueListenable<bool> get isKeyObscuredListenable =>
      _repository.isKeyObscuredListenable;

  @override
  Future<void> setKeyObscured(bool value) => _repository.setKeyObscured(value);

  @override
  bool get isPasswordObscured => _repository.isPasswordObscured;

  @override
  EntityValueListenable<bool> get isPasswordObscuredListenable =>
      _repository.isPasswordObscuredListenable;

  @override
  Future<void> setPasswordObscured(bool value) =>
      _repository.setPasswordObscured(value);

  @override
  bool get doSave => _repository.doSave;

  @override
  EntityValueListenable<bool> get doSaveListenable =>
      _repository.doSaveListenable;

  @override
  Future<void> setDoSave(bool value) => _repository.setDoSave(value);

  @override
  EncryptionType get encryptionAlgorithm =>
      EncryptionType.fromString(_repository.encryptionAlgorithm);

  @override
  EntityValueListenable<EncryptionType> get encryptionTypeListenable =>
      _repository.encryptionTypeListenable;
}
