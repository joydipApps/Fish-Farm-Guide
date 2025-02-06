// custom_music_visualizer.dart

import 'package:flutter/material.dart';

class CustomMusicVisualizer extends StatelessWidget {
  final int _waveCount;
  final List<Color> _colors;
  final List<int> _durations;

  CustomMusicVisualizer({
    super.key,
    List<Color>? colors,
    List<int>? durations,
    int? waveCount,
  })  : _colors =
            colors ?? [Colors.red, Colors.green, Colors.blue, Colors.yellow],
        _durations = durations ?? [900, 700, 600, 800],
        _waveCount = waveCount ?? 30;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        _waveCount,
        (index) => WaveComponent(
          duration: _durations[index % _durations.length],
          color: _colors[index % _colors.length],
        ),
      ),
    );
  }
}

class WaveComponent extends StatefulWidget {
  final int duration;
  final Color color;

  const WaveComponent({
    super.key,
    required this.duration,
    required this.color,
  });

  @override
  _WaveComponentState createState() => _WaveComponentState();
}

class _WaveComponentState extends State<WaveComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 50).animate(_animationController)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: _animation.value,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
