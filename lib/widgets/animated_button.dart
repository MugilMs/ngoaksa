import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final IconData? icon;

  const AnimatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.icon,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                width: widget.width,
                height: widget.height ?? 56,
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? AppColors.primaryGreen,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: (widget.backgroundColor ?? AppColors.primaryGreen)
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: widget.isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: widget.textColor ?? Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.icon != null) ...[
                              Icon(
                                widget.icon,
                                color: widget.textColor ?? Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              widget.text,
                              style: AppTextStyles.buttonLarge.copyWith(
                                color: widget.textColor ?? Colors.black,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
