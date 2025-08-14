import 'package:flutter/material.dart';

class RavenButton extends StatefulWidget {
  final bool connected;
  final VoidCallback onTap;
  const RavenButton({super.key, required this.connected, required this.onTap});

  @override
  State<RavenButton> createState() => _RavenButtonState();
}

class _RavenButtonState extends State<RavenButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scale = CurvedAnimation(
      parent: _pulse,
      curve: Curves.easeInOut,
    ).drive(Tween(begin: 1.0, end: 1.05));
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOn = widget.connected;
    final icon = isOn ? Icons.close : Icons.play_arrow;

    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: 120,
          height: 120,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isOn
                    ? [Colors.redAccent, Colors.deepOrange, Colors.black]
                    : [
                        const Color(0xFF6A0DAD),
                        const Color(0xFF4B0082),
                        Colors.black,
                      ],
                stops: const [0.0, 0.5, 1.0],
              ).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: (isOn ? Colors.redAccent : const Color(0xFF6A0DAD))
                        .withOpacity(0.6),
                    blurRadius: 22,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: Icon(icon, size: 44, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
