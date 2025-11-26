import 'package:code_generator_app/ui/theme/app_theme.dart';
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
      builder: (_, result, __) => Material(
        color: context.colors.primaryFixedDim,
        shape: const StadiumBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
