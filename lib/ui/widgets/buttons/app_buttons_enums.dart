part of 'app_elevated_button.dart';

enum AppButtonType {
  primary,
  primaryFixedDim,
  secondary,
  warning;

  Color backgroundColor(BuildContext context) {
    final colors = context.colors;

    return switch (this) {
      AppButtonType.primary => colors.primary,
      AppButtonType.secondary => colors.secondary,
      AppButtonType.primaryFixedDim => colors.primaryFixedDim,
      AppButtonType.warning => colors.error,
    };
  }

  Color foregroundColor(BuildContext context) {
    final colors = context.colors;

    return switch (this) {
      AppButtonType.primary => colors.onPrimary,
      AppButtonType.secondary => colors.onSecondary,
      AppButtonType.primaryFixedDim => colors.secondary,
      AppButtonType.warning => colors.onError,
    };
  }
}
