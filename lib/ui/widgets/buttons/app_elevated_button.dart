import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'app_buttons_enums.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final Widget? child;

  final String? label;

  final AppButtonStyle type;

  final double? height;

  final double? width;

  final OutlinedBorder? shape;

  final double? iconSize;

  final TextStyle? textStyle;

  /// Default height of button
  static const double defaultHeight = 54;

  const AppElevatedButton.primary({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.label,
    this.child,
    this.height = defaultHeight,
    this.width,
    this.shape,
    this.iconSize,
    this.textStyle,
  })  : type = AppButtonStyle.primary,
        assert(label != null || child != null, '[label] or [child] must not be null');

  const AppElevatedButton.primaryfixedDim({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.label,
    this.child,
    this.height = defaultHeight,
    this.width,
    this.shape,
    this.iconSize,
    this.textStyle,
  })  : type = AppButtonStyle.primaryFixedDim,
        assert(label != null || child != null, '[label] or [child] must not be null');

  const AppElevatedButton.secondary({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.label,
    this.child,
    this.height = defaultHeight,
    this.width,
    this.shape,
    this.iconSize,
    this.textStyle,
  })  : type = AppButtonStyle.secondary,
        assert(label != null || child != null, '[label] or [child] must not be null');

  const AppElevatedButton.warning({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.label,
    this.child,
    this.height = defaultHeight,
    this.width,
    this.shape,
    this.iconSize,
    this.textStyle,
  })  : type = AppButtonStyle.warning,
        assert(label != null || child != null, '[label] or [child] must not be null');

  /// Use this constructor if you want to pass a button type parameter
  const AppElevatedButton({
    super.key,
    required this.type,
    this.onPressed,
    this.onLongPress,
    this.label,
    this.child,
    this.height = defaultHeight,
    this.width,
    this.shape,
    this.iconSize,
    this.textStyle,
  }) : assert(label != null || child != null, '[label] or [child] must not be null');

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: styleFrom(
            backgroundColor: type.backgroundColor(context),
            foregroundColor: type.foregroundColor(context),
            shape: shape,
            iconSize: iconSize,
            textStyle: textStyle,
          ),
          child: child ?? Text(label!, textAlign: TextAlign.center),
        ),
      );

  /// Default style for [AppElevatedButton]
  static ButtonStyle styleFrom({
    required Color backgroundColor,
    required Color foregroundColor,
    TextStyle? textStyle,
    OutlinedBorder? shape,
    double? iconSize,
  }) =>
      ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: textStyle,
        shape: shape ?? const StadiumBorder(),
        iconSize: iconSize ?? 24,
      );
}
