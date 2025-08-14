import 'package:flutter/material.dart';

class ConnectionTimer extends StatelessWidget {
  final Duration duration;

  const ConnectionTimer({super.key, required this.duration});

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes % 60)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(duration),
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
