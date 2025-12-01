import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/common/objects/code_generator/code_generator_types.dart';
import 'package:code_generator_app/ui/features/main/widgets/check_position_wirdget.dart';
import 'package:code_generator_app/ui/features/settings/settings_wm.dart';
import 'package:code_generator_app/ui/features/settings/widgets/algorithm_dropdown_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends ElementaryWidget<ISettingsScreenWidgetModel> {
  final EncryptionType initialEncryptionType;

  const SettingsScreen({
    super.key,
    required this.initialEncryptionType,
  }) : super(defaultSettingsScreenWidgetModelFactory);

  @override
  Widget build(ISettingsScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: const Text(
          'Настройки',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: wm.onBackTap,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: RichText(
                text: TextSpan(
                  text: 'Алгоритм ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: 'создания',
                      style: TextStyle(color: wm.colors.primary),
                    ),
                    const TextSpan(text: ' пароля:'),
                  ],
                ),
              ),
            ),
            AlgorithmDropdownWidget(
              encryptionAlgorithmList: wm.encryptionAlgorithmList,
              onEncryptionAlgorithmChanged: wm.onEncryptionAlgorithmChanged,
              encryptionAlgorithmListenable: wm.encryptionTypeListenable,
            ),
            const SizedBox(height: 18),
            Divider(color: wm.colors.secondaryFixedDim),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Text(
                'Функциональные параметры:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 18),
            CheckPositionWirdget(
              label: 'Копировать пароль автоматически',
              onSaveCheckTap: () {},
              doSave: true,
            ),
            const SizedBox(height: 18),
            Divider(color: wm.colors.secondaryFixedDim),
            const SizedBox(height: 18),
            Center(
              child: Text(
                'В будущем появится больше настроек...',
                style: TextStyle(
                  color: wm.colors.secondaryFixedDim,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
