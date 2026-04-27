part of 'confirm_dialog_button.dart';

enum ConfirmDialogButtonType {
  cancel,
  confirm;

  Color backgroundColor(BuildContext context) {
    final colors = context.colors;

    return switch (this) {
      ConfirmDialogButtonType.cancel => Colors.transparent,
      ConfirmDialogButtonType.confirm => colors.error.withAlpha(35),
    };
  }

  Color foregroundColor(BuildContext context) {
    final colors = context.colors;

    return switch (this) {
      ConfirmDialogButtonType.cancel => colors.secondaryFixedDim,
      ConfirmDialogButtonType.confirm => colors.error,
    };
  }

  Color borderColor(BuildContext context) {
    final colors = context.colors;

    return switch (this) {
      ConfirmDialogButtonType.cancel => colors.primaryFixedDim.withAlpha(170),
      ConfirmDialogButtonType.confirm => colors.error.withAlpha(100),
    };
  }
}
