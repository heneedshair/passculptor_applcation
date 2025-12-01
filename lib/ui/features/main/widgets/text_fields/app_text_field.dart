import 'package:code_generator_app/data/inherited/text_fields_functions_inherited.dart';
import 'package:code_generator_app/ui/widgets/decorations/themed_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.isObscured = false,
    required this.validator,
    this.onChanged,
  });

  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onFieldSubmitted;
  final bool isObscured;
  final Function(String? value) validator;
  final ValueChanged<String>? onChanged;

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
      onTapOutside: (_) => _onTapOutside(context),
      onFieldSubmitted: (_) => onFieldSubmitted == null ? null : onFieldSubmitted!(),
      onChanged: (value) => _onChanged(context, value: value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z]')),
      ],
      validator: (value) => validator(value),
      //TODO добавить errorText при вводе некорректных символов
    );
  }

  void _onTapOutside(BuildContext context) => FocusManager.instance.primaryFocus?.unfocus();
  
  void _onChanged(BuildContext context, {required String value}) {
    FieldsFuncs.read(context)?.onAnyTexFieldChanged();
    
    onChanged?.call(value);
  }
}
