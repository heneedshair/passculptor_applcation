// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:code_generator_app/common/extensions/build_context.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

extension ElementaryExtensions on WidgetModel {
  double get height => context.height;

  double get width => context.width;

  ThemeData get gradients => context.theme;

  ColorScheme get colors => context.colors;
}
