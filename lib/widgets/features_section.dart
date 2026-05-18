import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'feature_card.dart';
import 'reveal_widget.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _features = [
    (
      emoji: '🌙',
      title: 'Evening Check-In',
      description:
          'A gentle nightly prompt to capture how your day really felt — in seconds, not paragraphs.',
      accent: AppColors.terracotta,
    ),
    (
      emoji: '📓',
      title: 'Daily Journal',
      description:
          'Write freely. Your thoughts stay private, encrypted, and entirely yours.',
      accent: AppColors.amber,
    ),
    (
      emoji: '📅',
      title: 'Year in Dots',
      description:
          'Watch 365 days transform into a living mosaic of your moods and milestones.',
      accent: AppColors.moodGood,
    ),
    (
      emoji: '🌐',
      title: 'Life Grid',
      description:
          'See your entire life in weeks. A humbling, beautiful perspective on time.',
      accent: AppColors.terracotta,
    ),
    (
      emoji: '📊',
      title: 'Weekly Review',
      description:
          'Spot patterns across your mood history with a clear, calm weekly summary.',
      accent: AppColors.amber,
    ),
    (
      emoji: '✨',
      title: 'Weekly Word',
      description:
          'One word that captures your week. Simple, powerful, and surprisingly revealing.',
      accent: AppColors.moodGood,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;
    final isTablet = width >= 600;

    int crossAxisCount = 1;
    if (isDesktop) {
      crossAxisCount = 3;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Container(
      color: const Color(0xFF161210),
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
                  key_id: 'features-label',
                  child: Text(
                    'FEATURES',
                    style: AppTypography.sectionLabel(),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'features-title',
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Everything you need to know yourself',
                    style: AppTypography.sectionTitle(width),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'features-subtitle',
                  delay: const Duration(milliseconds: 200),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'Simple tools that work quietly in the background of your daily life.',
                      style: AppTypography.sectionSubtitle(width),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                _buildGrid(context, crossAxisCount),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, int columns) {
    final rows = <Widget>[];
    for (int i = 0; i < _features.length; i += columns) {
      final rowItems = <Widget>[];
      for (int j = i; j < i + columns && j < _features.length; j++) {
        final feature = _features[j];
        rowItems.add(
          Expanded(
            child: RevealWidget(
              key_id: 'feature-card-$j',
              delay: Duration(milliseconds: j * 100),
              child: FeatureCard(
                emoji: feature.emoji,
                title: feature.title,
                description: feature.description,
                accentColor: feature.accent,
              ),
            ),
          ),
        );
        if (j < i + columns - 1 && j < _features.length - 1) {
          rowItems.add(const SizedBox(width: 16));
        }
      }
      // Pad incomplete rows
      final itemsInRow = rowItems.length ~/ 2 + rowItems.length % 2;
      if (itemsInRow < columns) {
        for (int k = itemsInRow; k < columns; k++) {
          rowItems.add(const Expanded(child: SizedBox()));
          if (k < columns - 1) {
            rowItems.add(const SizedBox(width: 16));
          }
        }
      }
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowItems,
      ));
      if (i + columns < _features.length) {
        rows.add(const SizedBox(height: 16));
      }
    }
    return Column(children: rows);
  }
}
