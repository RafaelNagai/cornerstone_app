import 'package:flutter/material.dart';

class AnimatedFormField extends StatelessWidget {
  final Widget child;
  final int index;

  const AnimatedFormField({
    required this.child,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final parentAnimation = ModalRoute.of(context)?.animation;

    if (parentAnimation == null) return child;

    final curved = CurvedAnimation(
      parent: parentAnimation,
      curve: Interval(0.2 + index * 0.1, 0.8, curve: Curves.easeOut),
    );

    final slide = Tween<Offset>(
      begin: Offset(0.0, 0.4 + index * 0.1),
      end: Offset.zero,
    ).animate(curved);

    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: curved, // isso agora é Animation<double>, correto!
        child: child,
      ),
    );
  }
}
