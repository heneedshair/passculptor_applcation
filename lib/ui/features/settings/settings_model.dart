import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';

abstract interface class ISettingsScreenModel extends ElementaryModel {
  Future<void> setEncryptionAlgorithm(String value);

  EncryptionType get encryptionType;

  ValueListenable<EncryptionType> get encryptionTypeListenable;

  bool get doCopyPassword;

  ValueListenable<bool> get doCopyPasswordListenable;

  Future<void> setDoCopyPassword(bool value);

  bool get doSave;

  ValueListenable<bool> get doSaveListenable;

  Future<void> setDoSave(bool value);
}

class SettingsScreenModel extends ISettingsScreenModel {
  SettingsScreenModel(this._repository);

  final IDiskDataRepository _repository;

  @override
  Future<void> setEncryptionAlgorithm(String value) => _repository.setEncryptionAlgorithm(value);

  @override
  EncryptionType get encryptionType => EncryptionType.fromString(_repository.encryptionAlgorithm);

  @override
  ValueListenable<EncryptionType> get encryptionTypeListenable => _repository.encryptionTypeListenable;

  @override
  bool get doCopyPassword => _repository.doCopyPassword;

  @override
  ValueListenable<bool> get doCopyPasswordListenable => _repository.doCopyPasswordListenable;

  @override
  Future<void> setDoCopyPassword(bool value) => _repository.setDoCopyPassword(value);

  @override
  bool get doSave => _repository.doSave;

  @override
  ValueListenable<bool> get doSaveListenable => _repository.doSaveListenable;

  @override
  Future<void> setDoSave(bool value) => _repository.setDoSave(value);
}
