import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlippableCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FlippableCard({super.key, required this.front, required this.back});

  @override
  _FlippableCardState createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    startAutoFlip();
  }

  void startAutoFlip() {
    Timer(const Duration(seconds: 2), () {
      if (!_isFlipped) {
        if (mounted) {
          _controller.forward();
        }

        _isFlipped = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final value = _animation.value;
          final frontScale = 1 - value;
          final backScale = value;

          return Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(math.pi * value),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: frontScale,
                  child: widget.front,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(math.pi * (1 - value)),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: backScale,
                  child: widget.back,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
