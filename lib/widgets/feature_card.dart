import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class FeatureCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String description;
  final Color accentColor;

  const FeatureCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: widget.accentColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? widget.accentColor.withOpacity(0.35)
                : widget.accentColor.withOpacity(0.15),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 14),
            Text(
              widget.title,
              style: AppTypography.sectionSubtitle(width).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: AppTypography.body(width),
            ),
          ],
        ),
      ),
    );
  }
}
