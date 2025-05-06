import 'package:flutter/cupertino.dart';

class DirectoryFunctionsData {
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

  DirectoryFunctionsData({
    required this.onClearAllTap,
    required this.onDeleteWebsite,
    required this.onWebsiteTap,
    required this.onLoginLongPress,
  });
}
