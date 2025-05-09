import 'package:code_generator_app/ui/main/widgets/themed_text_field/themed_text_field.dart';
import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class ObscurableTextField extends StatelessWidget {
  const ObscurableTextField({
    super.key,
    required this.listenableEntityState,
    required this.controller,
    required this.onObscureTap,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.labelText,
    this.textInputAction = TextInputAction.next,
    required this.prefixIcon,
    required this.validator,
  });

  final ValueNotifier<EntityState<bool>> listenableEntityState;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback onObscureTap;
  final VoidCallback? onFieldSubmitted;
  final String? labelText;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder(
      listenableEntityState: listenableEntityState,
      builder: (_, isObscured) => isObscured == null
          ? const SizedBox.shrink()
          : ThemedTextField(
              labelText: labelText,
              prefixIcon: prefixIcon,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye_rounded,
                  color: isObscured ? null : AppColors.white,
                ),
                onPressed: () => onObscureTap(),
              ),
              controller: controller,
              focusNode: focusNode,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              isObscured: isObscured,
              validator: validator,
            ),
    );
  }
}
