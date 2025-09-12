import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_tracker/core/extension/context.extensions.dart';
import 'package:health_tracker/core/theme/app_colors.dart';
import 'package:overlay_support/overlay_support.dart';

enum SnackbarType { success, warning, error }

class AppSnackbar {
  static void error(String message) {
    showSimpleNotification(
      _AnimatedSnackbar(message: message, type: SnackbarType.error),
      background: Colors.transparent,
      elevation: 0,
      contentPadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      duration: const Duration(seconds: 5),
    );
  }

  static void warning(String message) {
    showSimpleNotification(
      _AnimatedSnackbar(message: message, type: SnackbarType.warning),
      background: Colors.transparent,
      elevation: 0,
      contentPadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      duration: const Duration(seconds: 5),
    );
  }

  static void success(String message) {
    showSimpleNotification(
      _AnimatedSnackbar(message: message, type: SnackbarType.success),
      background: Colors.transparent,
      elevation: 0,
      contentPadding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      duration: const Duration(seconds: 5),
    );
  }
}

class _AnimatedSnackbar extends StatefulWidget {
  final String message;
  final SnackbarType type;

  const _AnimatedSnackbar({required this.message, required this.type});

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      if (mounted) {
        OverlaySupportEntry.of(context)?.dismiss();
      }
    });
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case SnackbarType.success:
        return const Color(0xFF10B981);
      case SnackbarType.warning:
        return const Color(0xFFF59E0B);
      case SnackbarType.error:
        return const Color(0xFFEF4444);
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case SnackbarType.success:
        return Icons.check_circle;
      case SnackbarType.warning:
        return Icons.warning;
      case SnackbarType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withAlpha(40),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(_getIcon(), color: AppColors.textOnPrimary, size: 24),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: context.bodyMedium?.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: _dismiss,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.textOnPrimary.withAlpha(80),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.textOnPrimary,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
