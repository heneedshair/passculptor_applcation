import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:elementary/elementary.dart';

abstract interface class ISettingsScreenModel extends ElementaryModel {
  Future<void> setEncryptionAlgorithm(String value);

  EncryptionType get encryptionType;
}

class SettingsScreenModel extends ISettingsScreenModel {
  SettingsScreenModel(this._repository);

  final IDiskDataRepository _repository;

  @override
  Future<void> setEncryptionAlgorithm(String value) => _repository.setEncryptionAlgorithm(value);

  @override
  EncryptionType get encryptionType => EncryptionType.fromString(_repository.encryptionAlgorithm);
}
