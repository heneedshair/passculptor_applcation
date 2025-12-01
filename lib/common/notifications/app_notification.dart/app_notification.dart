import 'package:code_generator_app/common/notifications/app_notification.dart/dialogs/confirm_dialog.dart';
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
