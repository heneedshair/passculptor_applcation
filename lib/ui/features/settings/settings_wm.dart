import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/data/repositories/i_disk_data_repository.dart';
import 'package:code_generator_app/ui/features/settings/settings_model.dart';
import 'package:code_generator_app/ui/features/settings/settings_screen.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract interface class ISettingsScreenWidgetModel implements IWidgetModel {
  List<String> get encryptionAlgorithmList;

  void onEncryptionAlgorithmChanged(String? selectedValue);

  ValueListenable<EncryptionType> get encryptionTypeListenable;

  void onBackTap();

  ColorScheme get colors;
}

SettingsScreenWidgetModel defaultSettingsScreenWidgetModelFactory(BuildContext context) {
  return SettingsScreenWidgetModel(
    SettingsScreenModel(context.read<IDiskDataRepository>()),
  );
}

class SettingsScreenWidgetModel extends WidgetModel<SettingsScreen, ISettingsScreenModel>
    implements ISettingsScreenWidgetModel {
  SettingsScreenWidgetModel(super.model);

  @override
  List<String> get encryptionAlgorithmList => EncryptionType.values.map((value) => value.name).toList();

  @override
  Future<void> onEncryptionAlgorithmChanged(String? selectedValue) async {
    if (selectedValue == null) return;

    await model.setEncryptionAlgorithm(selectedValue);
  }

  @override
  ValueListenable<EncryptionType> get encryptionTypeListenable => model.encryptionTypeListenable;

  @override
  void onBackTap() => AutoRouter.of(context).maybePop();

  @override
  ColorScheme get colors => context.colors;
}
