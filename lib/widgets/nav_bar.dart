import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;

  const NavBar({super.key, required this.scrollController});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = widget.scrollController.offset >= 40;
    if (isScrolled != _scrolled) {
      setState(() => _scrolled = isScrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _scrolled
            ? const Color(0x001A1412)
            : Colors.transparent,
        border: _scrolled
            ? Border(
                bottom: BorderSide(
                  color: AppColors.terracotta.withOpacity(0.08),
                  width: 1,
                ),
              )
            : null,
      ),
      child: _scrolled
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: const Color(0xD91A1412),
                  child: _buildContent(context),
                ),
              ),
            )
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
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
            ),
            _DownloadButton(),
          ],
        ),
      ),
    );
  }
}

class _DownloadButton extends StatefulWidget {
  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
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
              ? AppColors.terracottaDark
              : AppColors.terracotta,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.download_rounded,
                      color: AppColors.textPrimary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Download',
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
