import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'dot_grid.dart';
import 'section_wrapper.dart';
import 'reveal_widget.dart';

class DotGridSection extends StatelessWidget {
  const DotGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return SectionWrapper(
      gradientColors: const [
        Color(0xFF1A1412),
        Color(0xFF2A1E18),
        Color(0xFF31231B),
        Color(0xFF2E201A),
        Color(0xFF1A1412),
      ],
      glows: [
        AmbientGlow(
          color: AppColors.terracotta.withOpacity(0.07),
          radius: 350,
          alignment: const Alignment(0.8, -0.6),
        ),
      ],
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 24,
              vertical: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RevealWidget(
                  key_id: 'dot-grid-label',
                  child: Text(
                    'TRY IT',
                    style: AppTypography.sectionLabel(),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'dot-grid-title',
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Your year at a glance',
                    style: AppTypography.sectionTitle(width),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'dot-grid-subtitle',
                  delay: const Duration(milliseconds: 200),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'Every dot is a day. Tap to cycle through moods. Your whole year, visible at once.',
                      style: AppTypography.sectionSubtitle(width),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                RevealWidget(
                  key_id: 'dot-grid-grid',
                  delay: const Duration(milliseconds: 300),
                  child: const DotGrid(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
