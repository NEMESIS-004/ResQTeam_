import 'package:flutter/material.dart';

class CustomAnimatedButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  const CustomAnimatedButton(
      {super.key, required this.onTap, required this.child});

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 400));
    _animation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: widget.onTap != null
          ? (_) {
              _animationController.forward();
            }
          : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _animationController.reverse();
            }
          : null,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Transform.scale(
            scale: _animation.value,
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    
    _animationController.dispose();
    super.dispose();
  }
}
