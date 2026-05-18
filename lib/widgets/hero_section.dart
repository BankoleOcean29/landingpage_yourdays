import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onWaitlistTap;

  const HeroSection({super.key, required this.onWaitlistTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _badgeFade;
  late Animation<Offset> _badgeSlide;
  late Animation<double> _headlineFade;
  late Animation<Offset> _headlineSlide;
  late Animation<double> _subtitleFade;
  late Animation<double> _ctaFade;
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _badgeFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _badgeSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _headlineFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.15, 0.55, curve: Curves.easeOut)),
    );
    _headlineSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.15, 0.55, curve: Curves.easeOut)),
    );
    _subtitleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _ctaFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 0.9, curve: Curves.easeOut)),
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.35).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _launchPlayStore() async {
    final uri = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.oceanfirm.yourdays');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDesktop = width >= 900;
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Container(
      constraints: BoxConstraints(minHeight: isDesktop ? height : 0),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1501139083538-0139583c060f?w=1600&q=80',
              fit: BoxFit.cover,
              color: const Color(0x99000000),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.bgHero,
              ),
            ),
          ),
          // Warm tint overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.bgHero.withOpacity(0.3),
                    AppColors.bgHero.withOpacity(0.5),
                    AppColors.terracotta.withOpacity(0.05),
                    AppColors.bgHero.withOpacity(0.85),
                    AppColors.bgHero,
                  ],
                  stops: const [0, 0.2, 0.5, 0.8, 1.0],
                ),
              ),
            ),
          ),
          // Content
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 48 : 24,
                  vertical: isDesktop ? 140 : 100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isDesktop
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    // Badge
                    FadeTransition(
                      opacity: reduceMotion
                          ? const AlwaysStoppedAnimation(1)
                          : _badgeFade,
                      child: SlideTransition(
                        position: reduceMotion
                            ? const AlwaysStoppedAnimation(Offset.zero)
                            : _badgeSlide,
                        child: _Badge(pulse: _pulse),
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Headline
                    FadeTransition(
                      opacity: reduceMotion
                          ? const AlwaysStoppedAnimation(1)
                          : _headlineFade,
                      child: SlideTransition(
                        position: reduceMotion
                            ? const AlwaysStoppedAnimation(Offset.zero)
                            : _headlineSlide,
                        child: RichText(
                          textAlign: isDesktop
                              ? TextAlign.center
                              : TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'See your life.\n',
                                style: AppTypography.heroHeadline(width),
                              ),
                              TextSpan(
                                text: 'One day at a time.',
                                style: AppTypography.heroHeadline(width)
                                    .copyWith(
                                  color: AppColors.terracottaLight,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Subtitle
                    FadeTransition(
                      opacity: reduceMotion
                          ? const AlwaysStoppedAnimation(1)
                          : _subtitleFade,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Text(
                          'Track your mood, journal your thoughts, and watch your year unfold in a mosaic of meaningful moments.',
                          style: AppTypography.sectionSubtitle(width),
                          textAlign: isDesktop
                              ? TextAlign.center
                              : TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    // CTA Buttons
                    FadeTransition(
                      opacity: reduceMotion
                          ? const AlwaysStoppedAnimation(1)
                          : _ctaFade,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: isDesktop
                            ? WrapAlignment.center
                            : WrapAlignment.start,
                        children: [
                          _PrimaryButton(
                            label: 'Get it on Google Play',
                            icon: Icons.play_arrow_rounded,
                            onTap: _launchPlayStore,
                          ),
                          _GhostButton(
                            label: 'iPhone? Join waitlist →',
                            onTap: widget.onWaitlistTap,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final Animation<double> pulse;

  const _Badge({required this.pulse});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: pulse,
                builder: (context, child) => Transform.scale(
                  scale: pulse.value,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.moodGreat,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Now available on Android',
                style: AppTypography.small().copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.terracottaDark : AppColors.terracotta,
          borderRadius: BorderRadius.circular(100),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.terracotta.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: widget.onTap,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: AppColors.textPrimary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    style: AppTypography.buttonLabel()
                        .copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _GhostButton({required this.label, required this.onTap});

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.terracotta.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _hovered
                ? AppColors.terracotta.withOpacity(0.7)
                : AppColors.terracotta.withOpacity(0.4),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: widget.onTap,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              child: Text(
                widget.label,
                style: AppTypography.buttonLabel().copyWith(
                  color: _hovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
