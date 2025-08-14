import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

class StatusPanel extends StatelessWidget {
  final V2RayStatus status;
  const StatusPanel({super.key, required this.status});

  String _fmtBytes(int v) {
    const u = ['B', 'KB', 'MB', 'GB', 'TB'];
    double n = v.toDouble();
    int i = 0;
    while (n >= 1024 && i < u.length - 1) {
      n /= 1024;
      i++;
    }
    return '${n.toStringAsFixed(n < 10 && i > 0 ? 1 : 0)} ${u[i]}';
    // пример: 932 KB, 1.2 MB
  }

  String _fmtSpeed(int bps) => '${_fmtBytes(bps)}/s';

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          status.state.toUpperCase() == 'CONNECTED'
              ? 'Подключено'
              : status.state.toUpperCase() == 'CONNECTING'
              ? 'Подключение...'
              : status.state.toUpperCase() == 'DISCONNECTING'
              ? 'Отключение...'
              : 'Отключено',
          style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.schedule, size: 18),
            const SizedBox(width: 8),
            Text(
              status.duration,
              style: text.titleLarge?.copyWith(letterSpacing: 0.5),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Metric(
                label: 'Загрузка ↓',
                value: _fmtSpeed(status.downloadSpeed),
                sub: _fmtBytes(status.download),
                icon: Icons.download,
              ),
              const SizedBox(width: 24),
              _Metric(
                label: 'Отдача ↑',
                value: _fmtSpeed(status.uploadSpeed),
                sub: _fmtBytes(status.upload),
                icon: Icons.upload,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final IconData icon;

  const _Metric({
    required this.label,
    required this.value,
    required this.sub,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: text.bodySmall),
            Text(
              value,
              style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(sub, style: text.bodySmall?.copyWith(color: Colors.white60)),
          ],
        ),
      ],
    );
  }
}
