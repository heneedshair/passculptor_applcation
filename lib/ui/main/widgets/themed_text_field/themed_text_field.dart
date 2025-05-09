import 'package:code_generator_app/data/inherited/text_fields_functions_inherited.dart';
import 'package:code_generator_app/ui/widgets/decorations/themed_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemedTextField extends StatelessWidget {
  const ThemedTextField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.isObscured = false,
  });

  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onFieldSubmitted;
  final bool isObscured;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: ThemedInputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      focusNode: focusNode,
      obscureText: isObscured,
      textInputAction: textInputAction,
      onTapOutside: (_) => FieldsFuncs.read(context)?.onTapOutsideField(),
      onFieldSubmitted: (_) =>
          onFieldSubmitted == null ? {} : onFieldSubmitted!(),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z]')),
      ],
    );
  }
}
