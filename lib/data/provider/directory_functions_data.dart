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

  DirectoryFunctionsData({
    required this.onClearAllTap,
    required this.onDeleteWebsite,
    required this.onWebsiteTap,
  });
}
