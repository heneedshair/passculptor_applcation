import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TextLargeTitleWidget extends StatelessWidget {
  const TextLargeTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Pas',
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: 'Sculptor',
            style: TextStyle(color: context.colors.primary),
          ),
        ],
      ),
    );
  }
}
