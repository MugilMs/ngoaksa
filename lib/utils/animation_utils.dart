import 'package:flutter/material.dart';
import '../widgets/bouncy_page_route.dart';

class AnimationUtils {
  // Navigation animations
  static void navigateWithSlideUp(BuildContext context, Widget page) {
    Navigator.push(
      context,
      SlideUpPageRoute(child: page),
    );
  }

  static void navigateWithFade(BuildContext context, Widget page) {
    Navigator.push(
      context,
      FadePageRoute(child: page),
    );
  }

  static void navigateWithScale(BuildContext context, Widget page) {
    Navigator.push(
      context,
      ScalePageRoute(child: page),
    );
  }

  static void navigateWithBounce(BuildContext context, Widget page) {
    Navigator.push(
      context,
      BouncyPageRoute(child: page),
    );
  }

  // Staggered list animations
  static Widget buildStaggeredList({
    required List<Widget> children,
    Duration delay = const Duration(milliseconds: 100),
    Duration duration = const Duration(milliseconds: 600),
  }) {
    return Column(
      children: children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        
        return AnimatedContainer(
          duration: duration,
          curve: Curves.easeOut,
          child: TweenAnimationBuilder<double>(
            duration: duration,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: child,
          ),
        );
      }).toList(),
    );
  }

  // Ripple effect animation
  static Widget buildRippleEffect({
    required Widget child,
    required VoidCallback onTap,
    Color? rippleColor,
    BorderRadius? borderRadius,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: rippleColor?.withOpacity(0.3),
        highlightColor: rippleColor?.withOpacity(0.1),
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }

  // Hero animation helper
  static Widget buildHeroWidget({
    required String tag,
    required Widget child,
  }) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }

  // Slide animation for cards
  static Widget buildSlideInCard({
    required Widget child,
    required int index,
    Duration delay = const Duration(milliseconds: 100),
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Scale animation for buttons
  static Widget buildScaleButton({
    required Widget child,
    required VoidCallback onPressed,
    Duration duration = const Duration(milliseconds: 150),
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 1.0, end: 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTapDown: (_) {
              // Trigger scale down animation
            },
            onTapUp: (_) {
              // Trigger scale up animation
              onPressed();
            },
            onTapCancel: () {
              // Reset scale
            },
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Loading animation
  static Widget buildLoadingAnimation({
    Color? color,
    double size = 40,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Colors.white,
        ),
      ),
    );
  }

  // Success animation
  static void showSuccessAnimation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    // Auto dismiss after animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }
}
