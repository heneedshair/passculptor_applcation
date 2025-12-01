part of 'app_elevated_button.dart';

enum AppButtonStyle {
  primary,
  primaryFixedDim,
  secondary,
  warning;

  Color backgroundColor(BuildContext context) {
    final colors = context.colors;

    return switch (this) {
      AppButtonStyle.primary => colors.primary,
      AppButtonStyle.secondary => colors.secondary,
      AppButtonStyle.primaryFixedDim => colors.primaryFixedDim,
      AppButtonStyle.warning => colors.error,
    };
  }

  Color foregroundColor(BuildContext context) {
    final colors = context.colors;

    return switch (this) {
      AppButtonStyle.primary => colors.onPrimary,
      AppButtonStyle.secondary => colors.onSecondary,
      AppButtonStyle.primaryFixedDim => colors.secondary,
      AppButtonStyle.warning => colors.onError,
    };
  }
}
