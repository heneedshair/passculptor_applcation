import 'package:flutter/material.dart';

typedef FieldsFuncs = TextFieldsFunctionsInherited;

class TextFieldsFunctionsInherited extends InheritedWidget {
  final VoidCallback onAnyTexFieldChanged;

  const TextFieldsFunctionsInherited({
    super.key,
    required super.child,
    required this.onAnyTexFieldChanged,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static TextFieldsFunctionsInherited? read(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<TextFieldsFunctionsInherited>()?.widget
        as TextFieldsFunctionsInherited?;
  }
}
