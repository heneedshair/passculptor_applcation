import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary/elementary.dart';

abstract interface class IMainScreenModel extends ElementaryModel {
  Future<void> addWebsite(String login, String website, String key);

  bool containsSameKeyword(String enteredKeyword);

  bool get isLoginObscured;

  Future<void> setLoginObscured(bool value);

  bool get isKeyObscured;

  Future<void> setKeyObscured(bool value);

  bool get isPasswordObscured;

  Future<void> setPasswordObscured(bool value);

  bool get doSave;

  Future<void> setDoSave(bool value);

  String? get encryptionAlgorithm;
}

class MainScreenModel extends IMainScreenModel {
  MainScreenModel(this._repository);

  final IDiskDataRepository _repository;

  @override
  Future<void> addWebsite(
    String enteredLogin,
    String enteredWebsite,
    String enteredKeyword,
  ) async {
    await _repository.addWebsite(
      login: enteredLogin,
      website: enteredWebsite,
      keyword: enteredKeyword,
    );
  }

  @override
  bool containsSameKeyword(String enteredKeyword) => _repository.containsSameKeyword(enteredKeyword);

  @override
  bool get isLoginObscured => _repository.isLoginObscured;

  @override
  Future<void> setLoginObscured(bool value) => _repository.setLoginObscured(value);

  @override
  bool get isKeyObscured => _repository.isKeyObscured;

  @override
  Future<void> setKeyObscured(bool value) => _repository.setKeyObscured(value);

  @override
  bool get isPasswordObscured => _repository.isPasswordObscured;

  @override
  Future<void> setPasswordObscured(bool value) => _repository.setPasswordObscured(value);

  @override
  bool get doSave => _repository.doSave;

  @override
  Future<void> setDoSave(bool value) => _repository.setDoSave(value);

  @override
  String? get encryptionAlgorithm => _repository.encryptionAlgorithm;
}
