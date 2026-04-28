import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppInfoDialogSection {
  const AppInfoDialogSection({
    required this.subtitle,
    required this.text,
    this.icon,
  });

  final String subtitle;
  final String text;
  final IconData? icon;
}

class AppInfoDialog extends StatelessWidget {
  const AppInfoDialog({
    super.key,
    required this.title,
    required this.sections,
    this.description,
    this.icon = Icons.info_outline_rounded,
    this.closeLabel = 'Понятно',
  });

  final String title;
  final String? description;
  final List<AppInfoDialogSection> sections;
  final IconData icon;
  final String closeLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 460,
          maxHeight: MediaQuery.sizeOf(context).height * 0.8,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.primaryContainer,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(
              color: context.colors.primaryFixedDim.withAlpha(180),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(80),
                blurRadius: 28,
                offset: const Offset(0, 18),
              ),
            ],
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
                if (sections.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int index = 0; index < sections.length; index++) ...[
                            _InfoSection(section: sections[index]),
                            if (index != sections.length - 1) const SizedBox(height: 10),
                          ],
                        ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
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

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.section,
  });

  final AppInfoDialogSection section;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface.withAlpha(120),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: context.colors.primaryFixedDim.withAlpha(120),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section.icon != null) ...[
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: context.colors.primaryFixedDim.withAlpha(120),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  section.icon,
                  size: 18,
                  color: context.colors.primary,
                ),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: context.colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    section.text,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: context.colors.onSurface.withAlpha(210),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
