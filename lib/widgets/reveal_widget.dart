import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RevealWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final String? key_id;

  const RevealWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.key_id,
  });

  @override
  State<RevealWidget> createState() => _RevealWidgetState();
}

class _RevealWidgetState extends State<RevealWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_revealed && info.visibleFraction >= 0.15) {
      _revealed = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (reduceMotion) return widget.child;

    return VisibilityDetector(
      key: Key(widget.key_id ?? widget.child.hashCode.toString()),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      ),
    );
  }
}
