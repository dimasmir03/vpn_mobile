import 'package:flutter_v2ray/flutter_v2ray.dart';

class VpnService {
  VpnService._() {
    _vpn = FlutterV2ray(onStatusChanged: _handleStatus);
  }
  static final VpnService instance = VpnService._();

  late final FlutterV2ray _vpn;

  late V2RayURL _config;

  V2RayStatus _status =
      V2RayStatus(); // duration/uploadSpeed/downloadSpeed/upload/download/state
  V2RayStatus get status => _status;

  void Function(V2RayStatus)? _listener;
  bool _initialized = false;

  void attach(void Function(V2RayStatus) listener) => _listener = listener;
  void detach() => _listener = null;

  void _handleStatus(V2RayStatus s) {
    _status = s;
    _listener?.call(s);
  }

  Future<void> _ensureInit() async {
    if (_initialized) return;
    await _vpn.initializeV2Ray(
      notificationIconResourceType: 'mipmap',
      notificationIconResourceName: 'ic_launcher',
    );
    _initialized = true;
  }

  Future<bool> connect({
    required String config,
    String remark = 'Raven VPN',
    bool proxyOnly = false,
  }) async {
    _config = FlutterV2ray.parseFromURL(config);

    await _ensureInit();
    final granted = await _vpn.requestPermission();
    if (!granted) return false;
    await _vpn.startV2Ray(
      remark: _config.remark,
      config: _config.getFullConfiguration(),
      proxyOnly: proxyOnly,
      notificationDisconnectButtonName: "DISCONNECT",
    );
    return true;
  }

  Future<void> disconnect() async {
    await _vpn.stopV2Ray();
  }
}
