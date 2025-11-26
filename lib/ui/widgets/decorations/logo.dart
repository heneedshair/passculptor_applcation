import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Icon(
          Icons.lock,
          color: context.colors.primary,
          size: 130,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 73, top: 83),
          child: Icon(
            Icons.restart_alt_rounded,
            color: Colors.white,
            size: 60,
          ),
        ),
      ],
    );
  }
}
