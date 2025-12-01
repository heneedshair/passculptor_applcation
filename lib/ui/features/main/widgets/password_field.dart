import 'package:code_generator_app/data/models/password/password.dart';
import 'package:code_generator_app/ui/widgets/buttons/app_elevated_button.dart';
import 'package:elementary_helper/elementary_helper.dart';
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
  final EntityValueListenable<bool> isObscured;
  final VoidCallback onTap;
  final VoidCallback onObscureTap;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: isObscured,
      builder: (_, isObscured) => isObscured == null
          ? const SizedBox.shrink()
          : ValueListenableBuilder(
              valueListenable: password,
              builder: (_, password, __) => AppElevatedButton.primaryfixedDim(
                padding: EdgeInsets.zero,
                onPressed: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.square(
                      dimension: AppElevatedButton.defaultHeight,
                      child: Icon(Icons.lock_rounded),
                    ),
                    Text(_buttonLabel),
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
    /// [isObscured.value.data] can't be null here, because of the check in the builder
    if (password.value.value == null || !isObscured.value.data!) {
      return password.value.label;
    } else {
      return 'Копировать пароль (скрыт)';
    }
  }
}
