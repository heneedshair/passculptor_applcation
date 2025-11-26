import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/common/objects/code_generator/code_generator_types.dart';
import 'package:code_generator_app/ui/features/settings/settings_model.dart';
import 'package:code_generator_app/ui/features/settings/settings_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ISettingsScreenWidgetModel implements IWidgetModel {
  List<String> get encryptionAlgorithmList;

  void onEncryptionAlgorithmChanged(String? selectedValue);

  ValueNotifier<EntityState<EncryptionType>> get encryptionTypeListenable;

  void onBackTap();
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

    _encryptionTypeEntity.content(widget.initialEncryptionType);

    super.initWidgetModel();
  }

  @override
  List<String> get encryptionAlgorithmList =>
      EncryptionType.values.map((value) => value.name).toList();

  @override
  void onEncryptionAlgorithmChanged(String? selectedValue) {
    _prefs.setString(
      'encryptionAlgorithm',
      selectedValue!,
    );

    _encryptionTypeEntity.content(EncryptionType.create(selectedValue));
  }

  final _encryptionTypeEntity = EntityStateNotifier<EncryptionType>();

  @override
  ValueNotifier<EntityState<EncryptionType>> get encryptionTypeListenable =>
      _encryptionTypeEntity;

  @override
  void onBackTap() => AutoRouter.of(context).maybePop();
}
