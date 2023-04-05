import 'package:flutter/material.dart';

class AnimatedError extends StatefulWidget {
  const AnimatedError({super.key});

  @override
  State<AnimatedError> createState() => _AnimatedErrorState();
}

class _AnimatedErrorState extends State<AnimatedError> with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;
  late AnimationController checkController;
  late Animation<double> checkAnimation;

  @override
  void initState() {
    scaleController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    scaleAnimation = CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
    checkController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    checkAnimation = CurvedAnimation(parent: checkController, curve: Curves.linear);

    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });

    scaleController.forward();
    super.initState();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  double circleSize = 70;
  double iconSize = 54;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        height: circleSize,
        width: circleSize,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: SizeTransition(
            sizeFactor: checkAnimation,
            axis: Axis.horizontal,
            axisAlignment: -1,
            child: Center(
                child: Icon(Icons.close, color: Colors.white, size: iconSize)
            )
        ),
      ),
    );
  }
}