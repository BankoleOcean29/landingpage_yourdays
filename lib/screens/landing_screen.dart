import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/dot_grid_section.dart';
import '../widgets/features_section.dart';
import '../widgets/emotions_section.dart';
import '../widgets/privacy_section.dart';
import '../widgets/waitlist_section.dart';
import '../widgets/footer_section.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _scrollController = ScrollController();
  final _waitlistKey = GlobalKey();

  void _scrollToWaitlist() {
    final context = _waitlistKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroSection(onWaitlistTap: _scrollToWaitlist),
                const DotGridSection(),
                const FeaturesSection(),
                const EmotionsSection(),
                const PrivacySection(),
                WaitlistSection(sectionKey: _waitlistKey),
                const FooterSection(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }
}
