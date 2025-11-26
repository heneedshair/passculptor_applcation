import 'package:code_generator_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextLargeTitleWidget extends StatelessWidget {
  const TextLargeTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'Pas',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
              text: 'Sculptor',
              style: TextStyle(color: AppColors.lightPrimaryColor)),
        ],
      ),
    );
  }
}
