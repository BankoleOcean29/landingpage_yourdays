import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class EmotionPill extends StatefulWidget {
  final String label;
  final Color color;

  const EmotionPill({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  State<EmotionPill> createState() => _EmotionPillState();
}

class _EmotionPillState extends State<EmotionPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.terracotta.withOpacity(0.05),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppColors.terracotta.withOpacity(_hovered ? 0.35 : 0.18),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(widget.label, style: AppTypography.small().copyWith(
              color: AppColors.textSecondary,
            )),
          ],
        ),
      ),
    );
  }
}
