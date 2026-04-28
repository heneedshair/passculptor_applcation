import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';

abstract interface class ISettingsScreenModel extends ElementaryModel {
  Future<void> setEncryptionAlgorithm(String value);

  ValueListenable<EncryptionType> get encryptionTypeListenable;

  ValueListenable<bool> get doCopyPasswordListenable;

  Future<void> setDoCopyPassword(bool value);

  ValueListenable<bool> get doSaveListenable;

  Future<void> setDoSave(bool value);
}

class SettingsScreenModel extends ISettingsScreenModel {
  SettingsScreenModel(this._repository);

  final IDiskDataRepository _repository;

  @override
  Future<void> setEncryptionAlgorithm(String value) => _repository.setEncryptionAlgorithm(value);

  @override
  ValueListenable<EncryptionType> get encryptionTypeListenable => _repository.encryptionTypeListenable;

  @override
  ValueListenable<bool> get doCopyPasswordListenable => _repository.doCopyPasswordListenable;

  @override
  Future<void> setDoCopyPassword(bool value) => _repository.setDoCopyPassword(value);

  @override
  ValueListenable<bool> get doSaveListenable => _repository.doSaveListenable;

  @override
  Future<void> setDoSave(bool value) => _repository.setDoSave(value);
}
