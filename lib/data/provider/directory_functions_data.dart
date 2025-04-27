import 'package:flutter/cupertino.dart';

class DirectoryFunctionsData {
  final VoidCallback onClearAllTap;
  final Function({
    required String enteredWebsite,
    required String enteredLogin,
    required String enteredKeyword,
  }) onDeleteWebsite;

  DirectoryFunctionsData({
    required this.onClearAllTap,
    required this.onDeleteWebsite,
  });
}
