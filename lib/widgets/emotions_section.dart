import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'emotion_pill.dart';
import 'section_wrapper.dart';
import 'reveal_widget.dart';

class EmotionsSection extends StatelessWidget {
  const EmotionsSection({super.key});

  static const _emotions = [
    (label: 'Grateful', color: AppColors.emotionGrateful),
    (label: 'Peaceful', color: AppColors.emotionPeaceful),
    (label: 'Energized', color: AppColors.emotionEnergized),
    (label: 'Connected', color: AppColors.emotionConnected),
    (label: 'Creative', color: AppColors.emotionCreative),
    (label: 'Heavy', color: AppColors.emotionHeavy),
    (label: 'Restless', color: AppColors.emotionRestless),
    (label: 'Numb', color: AppColors.emotionNumb),
    (label: 'Hopeful', color: AppColors.emotionHopeful),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return SectionWrapper(
      gradientColors: const [
        Color(0xFF161210),
        Color(0xFF221A15),
        Color(0xFF261D16),
        Color(0xFF221A15),
        Color(0xFF161210),
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
                  key_id: 'emotions-label',
                  child: Text(
                    'EMOTIONS',
                    style: AppTypography.sectionLabel(),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'emotions-title',
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Words for what you feel',
                    style: AppTypography.sectionTitle(width),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'emotions-subtitle',
                  delay: const Duration(milliseconds: 200),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      'Beyond happy or sad. Your Days gives you a rich vocabulary to name what you\'re going through.',
                      style: AppTypography.sectionSubtitle(width),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(_emotions.length, (index) {
                    return RevealWidget(
                      key_id: 'emotion-pill-$index',
                      delay: Duration(milliseconds: 300 + index * 50),
                      child: EmotionPill(
                        label: _emotions[index].label,
                        color: _emotions[index].color,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
