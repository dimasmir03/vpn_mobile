import 'package:flutter/material.dart';

class RavenButton extends StatefulWidget {
  final bool connected;
  final VoidCallback onTap;
  const RavenButton({super.key, required this.connected, required this.onTap});

  @override
  State<RavenButton> createState() => RavenButtonState();
}

class RavenButtonState extends State<RavenButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController pulse;
  late final Animation<double> scale;

  @override
  void initState() {
    super.initState();

    pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    scale = Tween(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = widget.connected;
    final Color glowColor = isConnected
        ? Colors.redAccent
        : const Color(0xFF8A2BE2);
    final String text = isConnected ? "DISCONNECT" : "CONNECT";

    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: scale,
        child: Container(
          width: 180,
          height: 180,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Внешнее мягкое свечение
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: glowColor.withOpacity(0.5),
                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),

              // Внешний контур
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: glowColor.withAlpha((255 * 0.6) as int),
                    width: 4,
                  ),
                ),
              ),

              // Внутренний контур
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: glowColor, width: 3),
                ),
              ),

              // Центральная кнопка с фоном
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black, // ← фон внутри круга
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
