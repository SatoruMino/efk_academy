import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.enabled = true,
    this.inProgress = false,
    required this.text,
    required this.style,
    required this.onTap,
  });

  final bool enabled;
  final bool inProgress;
  final String text;
  final CustomButtonStyle style;
  final VoidCallback onTap;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.95)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    if (!widget.inProgress) {
      widget.onTap;
    }
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.enabled) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.enabled) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.enabled) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.enabled
        ? widget.style.backgroundColor
        : Theme.of(context).disabledColor;
    final borderColor =
        widget.enabled ? widget.style.borderColor : Colors.transparent;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (_, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: InkWell(
        onTap: _onTap,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Ink(
          height: 50.h,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: widget.inProgress
                ? LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                    colors: [widget.style.progressColor],
                  )
                : Text(
                    widget.text,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: widget.style.textColor),
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color progressColor;
  final Color textColor;

  const CustomButtonStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.progressColor,
    required this.textColor,
  });

  factory CustomButtonStyle.primary(BuildContext context) {
    final theme = Theme.of(context);
    return CustomButtonStyle(
      backgroundColor: theme.primaryColor,
      borderColor: theme.primaryColor,
      progressColor: theme.scaffoldBackgroundColor,
      textColor: theme.scaffoldBackgroundColor,
    );
  }

  factory CustomButtonStyle.secondary(BuildContext context) {
    final theme = Theme.of(context);
    return CustomButtonStyle(
      backgroundColor: theme.scaffoldBackgroundColor,
      borderColor: theme.colorScheme.onSurface,
      progressColor: theme.colorScheme.onSurface,
      textColor: theme.colorScheme.onSurface,
    );
  }
}
