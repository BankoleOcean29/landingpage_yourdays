import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../services/email_service.dart';
import 'section_wrapper.dart';
import 'reveal_widget.dart';

class WaitlistSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const WaitlistSection({super.key, required this.sectionKey});

  @override
  State<WaitlistSection> createState() => _WaitlistSectionState();
}

class _WaitlistSectionState extends State<WaitlistSection>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;
  bool _isInvalid = false;
  late AnimationController _successController;
  late Animation<double> _formFade;
  late Animation<double> _successFade;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _formFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _successController, curve: Curves.easeOut),
    );
    _successFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _successController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _successController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    if (!_isValidEmail(email)) {
      setState(() => _isInvalid = true);
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) setState(() => _isInvalid = false);
      });
      return;
    }

    setState(() => _isLoading = true);

    final success = await EmailService.saveEmail(email);

    if (mounted) {
      if (success) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
        });
        _successController.forward();
      } else {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return SectionWrapper(
      key: widget.sectionKey,
      gradientColors: const [
        Color(0xFF1A1412),
        Color(0xFF231C18),
        Color(0xFF231C18),
        Color(0xFF1A1412),
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
                  key_id: 'waitlist-label',
                  child: Text(
                    'EARLY ACCESS',
                    style: AppTypography.sectionLabel(),
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'waitlist-title',
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'iPhone is coming. Be first.',
                    style: AppTypography.sectionTitle(width),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                RevealWidget(
                  key_id: 'waitlist-subtitle',
                  delay: const Duration(milliseconds: 200),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Text(
                      'Leave your email and we\'ll reach out the moment the iOS version is ready.',
                      style: AppTypography.sectionSubtitle(width),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                RevealWidget(
                  key_id: 'waitlist-card',
                  delay: const Duration(milliseconds: 300),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 580),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.bgCard, AppColors.bgElevated],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.terracotta.withOpacity(0.15),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              // Top accent line
                              Container(
                                height: 4,
                                color: AppColors.terracotta,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(32),
                                child: _isSuccess
                                    ? _buildSuccess()
                                    : _buildForm(isDesktop),
                              ),
                            ],
                          ),
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

  Widget _buildForm(bool isDesktop) {
    return FadeTransition(
      opacity: _formFade,
      child: Column(
        children: [
          isDesktop
              ? Row(
                  children: [
                    Expanded(child: _buildInput()),
                    const SizedBox(width: 12),
                    _buildButton(),
                  ],
                )
              : Column(
                  children: [
                    _buildInput(),
                    const SizedBox(height: 12),
                    SizedBox(width: double.infinity, child: _buildButton()),
                  ],
                ),
          const SizedBox(height: 14),
          Text(
            'No spam. Just one email when it\'s ready.',
            style: AppTypography.small(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: _isInvalid
              ? AppColors.moodRough
              : AppColors.terracotta.withOpacity(0.2),
          width: 1.5,
        ),
        color: AppColors.bgDeep.withOpacity(0.5),
      ),
      child: TextField(
        controller: _emailController,
        enabled: !_isLoading,
        keyboardType: TextInputType.emailAddress,
        style: AppTypography.body(800).copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'your@email.com',
          hintStyle: AppTypography.body(800)
              .copyWith(color: AppColors.textMuted),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
        onSubmitted: (_) => _submit(),
      ),
    );
  }

  Widget _buildButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isLoading
            ? AppColors.terracottaDark
            : AppColors.terracotta,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: _isLoading ? null : _submit,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.textPrimary,
                    ),
                  )
                : Text(
                    'Notify me',
                    style: AppTypography.buttonLabel()
                        .copyWith(color: AppColors.textPrimary),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return FadeTransition(
      opacity: _successFade,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.moodGreat.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.moodGreat,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'You\'re on the list ✓',
            style: AppTypography.sectionSubtitle(800).copyWith(
              color: AppColors.moodGreat,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'ll reach out the moment iOS is ready.',
            style: AppTypography.small(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
