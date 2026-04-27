import 'package:flutter/cupertino.dart';

typedef DirectFuncs = DirectoryFunctionsInherited;

class DirectoryFunctionsInherited extends InheritedWidget {
  final Function({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) onWebsiteTap;

  const DirectoryFunctionsInherited({
    super.key,
    required super.child,
    required this.onWebsiteTap,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static DirectoryFunctionsInherited? read(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<DirectoryFunctionsInherited>()
        ?.widget as DirectoryFunctionsInherited?;
  }
}
