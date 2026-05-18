import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class DotGrid extends StatefulWidget {
  const DotGrid({super.key});

  @override
  State<DotGrid> createState() => _DotGridState();
}

class _DotGridState extends State<DotGrid> {
  static const int _totalDays = 365;
  late List<int?> _moods;

  static const _moodColors = [
    AppColors.moodGreat,
    AppColors.moodGood,
    AppColors.moodOkay,
    AppColors.moodLow,
    AppColors.moodRough,
  ];

  static const _moodLabels = ['Great', 'Good', 'Okay', 'Low', 'Rough'];

  @override
  void initState() {
    super.initState();
    _moods = List<int?>.filled(_totalDays, null);
    _prefillPastDays();
  }

  void _prefillPastDays() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final dayOfYear = now.difference(startOfYear).inDays;
    final rng = Random(now.year * 1000);

    for (int i = 0; i < dayOfYear && i < _totalDays; i++) {
      _moods[i] = rng.nextInt(5);
    }
  }

  void _onTapDot(int index) {
    setState(() {
      final current = _moods[index];
      if (current == null) {
        _moods[index] = 0;
      } else if (current < 4) {
        _moods[index] = current + 1;
      } else {
        _moods[index] = null;
      }
    });
  }

  int get _filledCount => _moods.where((m) => m != null).length;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;
    final dotSize = isDesktop ? 12.0 : 9.0;
    final spacing = 3.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(_totalDays, (index) {
            final mood = _moods[index];
            return GestureDetector(
              onTap: () => _onTapDot(index),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: mood != null
                        ? _moodColors[mood]
                        : AppColors.bgElevated,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              '$_filledCount / $_totalDays days filled',
              style: AppTypography.small(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Legend
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: List.generate(5, (i) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _moodColors[i],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 5),
                Text(_moodLabels[i], style: AppTypography.small()),
              ],
            );
          }),
        ),
      ],
    );
  }
}
