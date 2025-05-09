import 'package:code_generator_app/common/notifications/app_notification.dart/dialogs/confirm_dialog.dart';
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
}
