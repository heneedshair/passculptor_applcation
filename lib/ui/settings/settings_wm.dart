import 'package:code_generator_app/ui/settings/settings_model.dart';
import 'package:code_generator_app/ui/settings/settings_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ISettingsScreenWidgetModel implements IWidgetModel {
  List<String> get encryptionAlgorithmList;

  void onEncryptionAlgorithmChanged(String? selectedValue);

  ValueNotifier<EntityState<String>> get encryptionAlgorithmListenable;
}

SettingsScreenWidgetModel defaultSettingsScreenWidgetModelFactory(
    BuildContext context) {
  return SettingsScreenWidgetModel(
    SettingsScreenModel(),
  );
}

class SettingsScreenWidgetModel
    extends WidgetModel<SettingsScreen, ISettingsScreenModel>
    implements ISettingsScreenWidgetModel {
  SettingsScreenWidgetModel(super.model);

  late final SharedPreferences _prefs;

  @override
  Future<void> initWidgetModel() async {
    _prefs = await SharedPreferences.getInstance();

    _initEntityStates();

    super.initWidgetModel();
  }

  static const _encryptionAlgorithmList = ['Встроенный', 'Hash-метод'];

  @override
  List<String> get encryptionAlgorithmList => _encryptionAlgorithmList;

  @override
  void onEncryptionAlgorithmChanged(String? selectedValue) {
    _prefs.setString(
      'encryptionAlgorithm',
      selectedValue!,
    );
    _encryptionAlgorithmEntity.content(selectedValue);
  }

  final _encryptionAlgorithmEntity = EntityStateNotifier<String>();

  @override
  ValueNotifier<EntityState<String>> get encryptionAlgorithmListenable =>
      _encryptionAlgorithmEntity;

  void _initEntityStates() {
    _encryptionAlgorithmEntity.loading();

    _encryptionAlgorithmEntity
        .content(_prefs.getString('encryptionAlgorithm') ?? 'Встроенный');
  }
}
