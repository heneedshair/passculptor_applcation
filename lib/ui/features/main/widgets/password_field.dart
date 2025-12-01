import 'package:code_generator_app/ui/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.result,
    required this.onTap,
  });

  final ValueNotifier<String> result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: result,
      builder: (_, result, __) => AppElevatedButton.primaryfixedDim(
        label: result,
        width: double.maxFinite,
        onPressed: onTap,
      ),
    );
  }
}
