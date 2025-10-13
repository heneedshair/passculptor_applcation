import 'package:flutter/cupertino.dart';

typedef DirectFuncs = DirectoryFunctionsInherited;

class DirectoryFunctionsInherited extends InheritedWidget {
  final VoidCallback onClearAllTap;

  final Function({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) onDeleteWebsite;

  final Function({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) onWebsiteTap;

  final Function({
    required String enteredLogin,
    required String enteredKeyword,
  }) onLoginLongPress;

  final Function(String enteredKeyword) onKeywordLongPress;

  const DirectoryFunctionsInherited({
    super.key,
    required super.child,
    required this.onClearAllTap,
    required this.onDeleteWebsite,
    required this.onWebsiteTap,
    required this.onLoginLongPress,
    required this.onKeywordLongPress,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static DirectoryFunctionsInherited? read(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<DirectoryFunctionsInherited>()?.widget
        as DirectoryFunctionsInherited?;
  }
}
