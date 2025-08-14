import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

class VpnStatusProvider extends ChangeNotifier {
  Duration duration = Duration.zero;
  int speedDown = 0;
  int speedUp = 0;
  int trafficDown = 0;
  int trafficUp = 0;

  void updateStatus(V2RayStatus status) {
    duration = status.duration as Duration;
    speedDown = status.downloadSpeed;
    speedUp = status.uploadSpeed;
    trafficDown = status.download;
    trafficUp = status.upload;
    notifyListeners();
  }
}
