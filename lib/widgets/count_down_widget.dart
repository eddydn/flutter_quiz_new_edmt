import 'package:flutter/material.dart';

class CountDown extends AnimatedWidget {
  CountDown({super.key, required super.listenable, required this.animation});

  Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    var clockTimer = Duration(seconds: animation.value);
    var timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(fontSize: 40, color: Theme.of(context).primaryColor),
    );
  }
}
