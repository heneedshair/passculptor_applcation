import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ThemedTextField extends StatelessWidget {
  const ThemedTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.onObscureTap,
    this.focusNode,
  });

  final String labelText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final VoidCallback? onObscureTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: SizedBox.square(
          dimension: 55,
          child: prefixIcon,
        ),
        //? мб надо убирать, если нет возможности скрывать
        suffixIcon: SizedBox.square(
          dimension: 55,
          //? мб надо использовать не его
          child: IconButton(
            onPressed: onObscureTap,
            icon: suffixIcon ?? const SizedBox.shrink(),
          ),
        ),
      ),
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
