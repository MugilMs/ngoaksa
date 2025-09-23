import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key,
    required this.child,
    required this.isLoading,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.isLoading) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ShimmerLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor ?? AppColors.inputBackground,
                widget.highlightColor ?? AppColors.dividerColor,
                widget.baseColor ?? AppColors.inputBackground,
              ],
              stops: [
                0.0,
                0.5,
                1.0,
              ],
              transform: GradientRotation(_animation.value * 0.5),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}

class ShimmerOpportunityCard extends StatelessWidget {
  const ShimmerOpportunityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerBox(width: 60, height: 60, borderRadius: BorderRadius.circular(12)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: double.infinity, height: 16, borderRadius: BorderRadius.circular(4)),
                    const SizedBox(height: 8),
                    ShimmerBox(width: 120, height: 14, borderRadius: BorderRadius.circular(4)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ShimmerBox(width: double.infinity, height: 14, borderRadius: BorderRadius.circular(4)),
          const SizedBox(height: 8),
          ShimmerBox(width: 200, height: 14, borderRadius: BorderRadius.circular(4)),
          const SizedBox(height: 16),
          Row(
            children: [
              ShimmerBox(width: 80, height: 32, borderRadius: BorderRadius.circular(16)),
              const Spacer(),
              ShimmerBox(width: 100, height: 40, borderRadius: BorderRadius.circular(20)),
            ],
          ),
        ],
      ),
    );
  }
}
