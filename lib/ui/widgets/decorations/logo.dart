import 'package:code_generator_app/ui/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({
    super.key,
    required this.animationTrigger,
  });

  final ValueListenable<int> animationTrigger;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 550),
  );

  @override
  void initState() {
    super.initState();

    widget.animationTrigger.addListener(_onAnimationTriggerChanged);
  }

  @override
  void dispose() {
    widget.animationTrigger.removeListener(_onAnimationTriggerChanged);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onAnimationTriggerChanged() async {
    _controller.value = 1;
    _controller.animateTo(0, curve: Curves.easeInOutSine);
  }

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
        Padding(
          padding: const EdgeInsets.only(left: 73, top: 83),
          child: RotationTransition(
            turns: _controller,
            child: const Icon(
              Icons.restart_alt_rounded,
              color: Colors.white,
              size: 60,
            ),
          ),
        ),
      ],
    );
  }
}
