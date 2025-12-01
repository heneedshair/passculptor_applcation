import 'package:code_generator_app/data/models/password/password.dart';
import 'package:code_generator_app/ui/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.result,
    required this.onTap,
  });

  final ValueNotifier<Password> result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: result,
      builder: (_, password, __) => AppElevatedButton.primaryfixedDim(
        label: password.label,
        width: double.maxFinite,
        onPressed: onTap,
      ),
    );
  }
}
