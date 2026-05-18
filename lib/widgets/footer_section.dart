import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  static const _socials = [
    (label: 'X', url: 'https://x.com/'),
    (label: 'YouTube', url: 'https://youtube.com/'),
    (label: 'LinkedIn', url: 'https://linkedin.com/'),
    (label: 'Instagram', url: 'https://instagram.com/'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgDeep,
        border: Border(
          top: BorderSide(
            color: AppColors.terracotta.withOpacity(0.08),
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 24,
              vertical: 40,
            ),
            child: isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBrand(),
                      _buildCenter(),
                      _buildSocials(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildBrand(),
                      const SizedBox(height: 16),
                      _buildCenter(),
                      const SizedBox(height: 16),
                      _buildSocials(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Your ',
            style: AppTypography.navBrand(),
          ),
          TextSpan(
            text: 'Days',
            style: AppTypography.navBrand().copyWith(
              color: AppColors.terracotta,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenter() {
    return Text(
      'Built with care in Lagos by Bankole.',
      style: AppTypography.small(),
    );
  }

  Widget _buildSocials() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _socials.map((s) {
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: _SocialLink(label: s.label, url: s.url),
        );
      }).toList(),
    );
  }
}

class _SocialLink extends StatefulWidget {
  final String label;
  final String url;

  const _SocialLink({required this.label, required this.url});

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTypography.small().copyWith(
            color: _hovered ? AppColors.terracotta : AppColors.textMuted,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
