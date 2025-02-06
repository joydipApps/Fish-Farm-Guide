import 'dart:async';
import 'package:flutter/material.dart';

class BlinkingIcon extends StatefulWidget {
  final IconData icon;
  final double size;
  final bool blinking;
  final Color blinkingColor;
  final Color nonBlinkingColor;

  const BlinkingIcon({
    super.key,
    required this.icon,
    required this.size,
    this.blinking = true,
    required this.blinkingColor,
    required this.nonBlinkingColor,
  });

  @override
  _BlinkingIconState createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon> {
  late bool _isBlinking;
  late Timer _blinkTimer;

  @override
  void initState() {
    super.initState();
    _isBlinking = widget.blinking;

    // Start the blinking effect only if blinking is enabled
    if (widget.blinking) {
      _startBlinking();
    }
  }

  void _startBlinking() {
    // Toggle color every 500 milliseconds
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _isBlinking = !_isBlinking;
      });
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed
    _blinkTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blinkingColor = _isBlinking
        ? widget.blinkingColor.withOpacity(0.5)
        : widget.blinkingColor;

    final color = widget.blinking ? blinkingColor : widget.nonBlinkingColor;

    return Icon(
      widget.icon,
      size: widget.size,
      color: color,
    );
  }
}
