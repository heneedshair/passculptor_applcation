import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static final ThemeData dark = _getThemeData(const AppColors.dark(), Brightness.dark);

  static ThemeData _getThemeData(AppColors colors, Brightness brightness) => ThemeData(
        colorScheme: ColorScheme(
          brightness: brightness,

          /// PRIMARY COLORS
          primary: colors.primary,
          onPrimary: colors.onPrimary,

          primaryContainer: colors.primaryContainer,
          onPrimaryContainer: colors.onPrimaryContainer,

          primaryFixedDim: colors.primaryFixedDim,

          /// SECONDARY COLORS
          secondary: colors.secondary,
          onSecondary: colors.onSecondary,
          secondaryFixedDim: colors.secondaryFixedDim,

          error: colors.error,
          onError: colors.onError,

          surface: colors.surface,
          onSurface: colors.onSurface,
        ),

        /// SCAFFOLD & APP BAR
        scaffoldBackgroundColor: colors.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onSurface,
          surfaceTintColor: colors.primaryFixedDim,
        ),

        /// TEXT
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: colors.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),

        /// INPUT DECORATION
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: colors.onPrimaryContainer,
          ),
          floatingLabelStyle: TextStyle(
            color: colors.primary,
          ),
          prefixIconColor: colors.onPrimaryContainer,
          suffixIconColor: colors.onPrimaryContainer,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: colors.primaryContainer,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1000),
            borderSide: BorderSide.none,
          ),
        ),

        /// ELEVATED BUTTON
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            //TODO Изменить цвет нажатия
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.disabled)) {
                return colors.primary.withAlpha(50);
              }
              return colors.primary;
            }),
            foregroundColor: WidgetStatePropertyAll(colors.surface),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        /// TEXT BUTTON
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(colors.secondaryFixedDim),
          ),
        ),

        /// SNACK BAR
        snackBarTheme: SnackBarThemeData(
          backgroundColor: colors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          contentTextStyle: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: colors.surface,
          ),
        ),

        /// DRAWER
        drawerTheme: DrawerThemeData(
          backgroundColor: colors.surface,
        ),

        /// PROGRESS INDICATOR
        progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: colors.primaryContainer,
          color: colors.primaryFixedDim,
        ),

        /// EXPANSION TILE
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: colors.surface,
          collapsedBackgroundColor: colors.surface,
          iconColor: colors.primaryFixedDim,
          collapsedIconColor: colors.secondary,
        ),
        dividerColor: colors.surface,

        /// LIST TILE
        listTileTheme: ListTileThemeData(
          iconColor: colors.secondaryFixedDim,
        ),

        /// DIALOG
        dialogTheme: DialogThemeData(
          backgroundColor: colors.primaryContainer,
        ),
      );
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => theme.colorScheme;
}
