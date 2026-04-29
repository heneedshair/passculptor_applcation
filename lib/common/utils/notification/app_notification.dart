import 'package:code_generator_app/common/utils/notification/dialogs/app_info_dialog/app_info_dialog.dart';
import 'package:code_generator_app/common/utils/notification/dialogs/app_info_dialog/widgets/info_section.dart';
import 'package:code_generator_app/common/utils/notification/dialogs/confirm_dialog/confirm_dialog.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

abstract class AppNotification {
  static Future<void> showConfirmDialog({
    required BuildContext context,
    required VoidCallback onConfirmTap,
    String content = 'Вы уверены, что хотите удалить этот элемент?',
  }) async {
    showDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        content: content,
        onConfirmTap: () => onConfirmTap(),
      ),
    );
  }

  static Future<void> showInfoDialog({
    required BuildContext context,
    required String title,
    required List<AppInfoSection> childrens,
    String? description,
    IconData icon = Icons.info_outline_rounded,
    String closeLabel = 'Понятно',
  }) async {
    await showDialog(
      context: context,
      builder: (_) => AppInfoDialog(
        title: title,
        description: description,
        childrens: childrens,
        icon: icon,
        closeLabel: closeLabel,
      ),
    );
  }

  static Future<void> showPreparedInfoDialog({
    required BuildContext context,
    required AppInfoDialog appInfoDialog,
  }) async =>
      await showDialog(context: context, builder: (_) => appInfoDialog);

  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isSuccsess = true,
    String unsuccessMessage = 'Что-то пошло не так...',
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Text(
          isSuccsess ? message : unsuccessMessage,
          style: TextStyle(
            color: isSuccsess ? context.colors.onPrimary : context.colors.surface,
          ),
        ),
        backgroundColor: isSuccsess ? context.colors.primary : context.colors.error,
      ),
    );
  }
}
