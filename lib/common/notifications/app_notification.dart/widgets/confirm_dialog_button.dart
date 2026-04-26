import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'confirm_dialog_button_type.dart';

class ConfirmDialogButton extends StatelessWidget {
  const ConfirmDialogButton.cancel({
    super.key,
    required this.onPressed,
    this.label = 'Отмена',
  }) : type = ConfirmDialogButtonType.cancel;

  const ConfirmDialogButton.confirm({
    super.key,
    required this.onPressed,
    this.label = 'Удалить',
  }) : type = ConfirmDialogButtonType.confirm;

  const ConfirmDialogButton({
    super.key,
    required this.type,
    required this.onPressed,
    required this.label,
  });

  final ConfirmDialogButtonType type;
  final VoidCallback? onPressed;
  final String label;

  static const double _height = 36;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: type.backgroundColor(context),
          foregroundColor: type.foregroundColor(context),
          shape: StadiumBorder(
            side: BorderSide(color: type.borderColor(context)),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
