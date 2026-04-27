import 'package:code_generator_app/data/models/password/password.dart';
import 'package:code_generator_app/ui/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.password,
    required this.onTap,
    required this.onObscureTap,
    required this.isObscured,
  });

  final ValueNotifier<Password> password;
  final ValueListenable<bool> isObscured;
  final VoidCallback onTap;
  final VoidCallback onObscureTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isObscured,
      builder: (_, isObscured, __) => ValueListenableBuilder(
        valueListenable: password,
        builder: (_, passwordValue, __) => AppElevatedButton.primaryfixedDim(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.square(
                dimension: AppElevatedButton.defaultHeight,
                child: Icon(Icons.lock_rounded),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Text(
                    _buttonLabel,
                    key: ValueKey(_buttonLabel),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox.square(
                dimension: AppElevatedButton.defaultHeight,
                child: Tooltip(
                  message: isObscured ? 'Показать пароль' : 'Скрыть пароль',
                  child: IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    ),
                    onPressed: onObscureTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _buttonLabel {
    if (password.value.value == null || !isObscured.value) {
      return password.value.label;
    } else {
      return 'Копировать пароль (скрыт)';
    }
  }
}
