import 'package:efk_academy/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.enabled = true,
    required this.text,
    this.inProgress = false,
    this.onTap,
  });

  final String text;
  final bool enabled;
  final bool inProgress;
  final VoidCallback? onTap;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95)
        .chain(CurveTween(curve: Curves.easeInOutBack))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  onTapDown(TapDownDetails detail) {
    _animationController.forward();
  }

  onTapUp(TapUpDetails detail) {
    _animationController.reverse();
  }

  onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = widget.enabled ? theme.primaryColor : theme.disabledColor;
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (_, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: InkWell(
        onTap: widget.enabled ? widget.onTap : null,
        onTapDown: widget.enabled ? onTapDown : null,
        onTapUp: widget.enabled ? onTapUp : null,
        onTapCancel: widget.enabled ? onTapCancel : null,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Ink(
          height: 50.h,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: color,
          ),
          child: Center(
            child: widget.inProgress
                ? LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                    colors: [theme.scaffoldBackgroundColor],
                  )
                : Text(
                    widget.text,
                    style: labelStyle.copyWith(
                      color: theme.scaffoldBackgroundColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
