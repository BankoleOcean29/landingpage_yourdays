import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'section_wrapper.dart';
import 'reveal_widget.dart';

class PrivacySection extends StatelessWidget {
  const PrivacySection({super.key});

  static const _points = [
    'Local-only storage — your data never leaves your device',
    'On-device encryption — protected by your device security',
    'No account required — no email, no sign-up',
    'Zero data collection — we know nothing about you',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return SectionWrapper(
      gradientColors: const [
        Color(0xFF161210),
        Color(0xFF2C201A),
        Color(0xFF352720),
        Color(0xFF352720),
        Color(0xFF2C201A),
        Color(0xFF1A1412),
      ],
      glows: [
        AmbientGlow(
          color: AppColors.terracotta.withOpacity(0.06),
          radius: 300,
          alignment: const Alignment(-0.7, -0.5),
        ),
        AmbientGlow(
          color: AppColors.amber.withOpacity(0.04),
          radius: 250,
          alignment: const Alignment(0.8, 0.7),
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
              children: [
                RevealWidget(
                  key_id: 'privacy-label',
                  child: Text(
                    'PRIVACY',
                    style: AppTypography.sectionLabel(),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'privacy-title',
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Your diary. Your device. Always.',
                    style: AppTypography.sectionTitle(width),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'privacy-subtitle',
                  delay: const Duration(milliseconds: 200),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Text(
                      'We built Your Days on a simple principle: what you write is none of our business.',
                      style: AppTypography.sectionSubtitle(width),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                RevealWidget(
                  key_id: 'privacy-card',
                  delay: const Duration(milliseconds: 300),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.bgCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.terracotta.withOpacity(0.12),
                          ),
                        ),
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: List.generate(_points.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      index < _points.length - 1 ? 20 : 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: AppColors.terracotta
                                          .withOpacity(0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: AppColors.terracotta,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      _points[index],
                                      style: AppTypography.body(width)
                                          .copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
