import 'package:flutter/material.dart';

abstract class AppColorsOld {
  static const backgroundColor = Color.fromRGBO(8, 12, 37, 1);
  static const appBarColor = Color.fromRGBO(22, 30, 53, 1);
  static const primaryColor = Color.fromRGBO(41, 54, 89, 1);
  // static const lightPrimaryColor = Color.fromRGBO(48, 113, 231, 1);
  static const lightPrimaryColor = Color.fromRGBO(48, 161, 231, 1);

  static const grayColor = Color.fromARGB(255, 134, 134, 134);
  static const white = Color.fromRGBO(229, 229, 229, 1);
}

class AppColors {
  // PRIMARY COLORS

  final Color primary;
  final Color onPrimary;

  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color primaryFixedDim;

  // SECONDARY COLORS

  final Color secondary;
  final Color onSecondary;

  final Color secondaryFixedDim;

  // SURFACE COLORS

  final Color surface;
  final Color onSurface;

  // ERROR COLORS

  final Color error;
  final Color onError;

  const AppColors.dark({
    /// PRIMARY COLORS
    this.primary = const Color.fromRGBO(48, 161, 231, 1),
    // this.onPrimary = const Color.fromRGBO(8, 12, 37, 1),
    this.primaryContainer = const Color.fromRGBO(22, 30, 53, 1),
    this.primaryFixedDim = const Color.fromRGBO(41, 54, 89, 1),

    /// SECONDARY COLORS
    this.secondary = const Color.fromRGBO(229, 229, 229, 1),
    this.secondaryFixedDim = const Color.fromARGB(255, 134, 134, 134),

    /// SURFACE COLORS
    this.surface = const Color.fromRGBO(8, 12, 37, 1),

    /// ERROR COLORS
    this.error = Colors.redAccent,
  })  :

        /// PRIMARY COLORS
        onPrimary = surface,
        onPrimaryContainer = secondaryFixedDim,

        /// SECONDARY COLORS
        onSecondary = surface,

        /// SURFACE COLORS
        onSurface = secondary,

        /// ERROR COLORS
        onError = secondary;
}
