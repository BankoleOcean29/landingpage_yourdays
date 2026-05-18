import 'package:flutter/material.dart';

class AmbientGlow {
  final Color color;
  final double radius;
  final AlignmentGeometry alignment;

  const AmbientGlow({
    required this.color,
    required this.radius,
    required this.alignment,
  });
}

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final List<AmbientGlow> glows;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.gradientColors,
    this.glows = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Stack(
        children: [
          for (final glow in glows)
            Positioned.fill(
              child: Align(
                alignment: glow.alignment,
                child: Container(
                  width: glow.radius * 2,
                  height: glow.radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [glow.color, Colors.transparent],
                    ),
                  ),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}
