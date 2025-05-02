import 'package:auto_route/auto_route.dart';
import 'package:code_generator_app/ui/settings/settings_wm.dart';
import 'package:code_generator_app/ui/settings/widgets/algorithm_dropdown_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends ElementaryWidget<ISettingsScreenWidgetModel> {
  const SettingsScreen({super.key})
      : super(defaultSettingsScreenWidgetModelFactory);

  @override
  Widget build(ISettingsScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Алгоритм создания пароля:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            AlgorithmDropdownWidget(
              encryptionAlgorithmList: wm.encryptionAlgorithmList,
              onEncryptionAlgorithmChanged: wm.onEncryptionAlgorithmChanged,
              encryptionAlgorithmListenable: wm.encryptionAlgorithmListenable,
            ),
          ],
        ),
      ),
    );
  }
}
