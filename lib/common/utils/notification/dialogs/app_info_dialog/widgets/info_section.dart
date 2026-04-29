import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({
    super.key,
    required this.subtitle,
    required this.text,
    this.icon,
  });

  final String subtitle;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface.withAlpha(120),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: context.colors.primaryFixedDim.withAlpha(120)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Row(
                children: [
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: context.colors.primaryFixedDim.withAlpha(120),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 18,
                      color: context.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: context.colors.onSurface,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 42, right: 5),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: context.colors.onSurface.withAlpha(210),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
