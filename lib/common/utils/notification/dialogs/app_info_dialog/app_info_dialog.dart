import 'package:code_generator_app/common/extensions/build_context.dart';
import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppInfoDialog extends StatelessWidget {
  const AppInfoDialog({
    super.key,
    required this.title,
    required this.childrens,
    this.description,
    this.icon = Icons.info_outline_rounded,
    this.closeLabel = 'Понятно',
  });

  final String title;
  final String? description;
  final IconData icon;
  final String closeLabel;
  final List<Widget> childrens;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 460,
          maxHeight: context.height * 0.83,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.primaryContainer,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: context.colors.primaryFixedDim.withAlpha(180)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DialogHeader(
                  title: title,
                  icon: icon,
                ),
                if (description != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    description!,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.45,
                      color: context.colors.onSurface.withAlpha(220),
                    ),
                  ),
                ],
                if (childrens.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        children: [...childrens],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      backgroundColor: context.colors.primary,
                      foregroundColor: context.colors.onPrimary,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: Text(closeLabel),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: context.colors.primaryFixedDim.withAlpha(150),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 24,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 1.2,
                color: context.colors.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
