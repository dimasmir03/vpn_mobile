import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:vpn_mobile/widgets/connect_button.dart';
import 'package:vpn_mobile/widgets/vpn_status_widget.dart';
import '../service/vpn_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _vpn = VpnService.instance;
  V2RayStatus _status =
      V2RayStatus(); // имеет duration/uploadSpeed/downloadSpeed/upload/download/state

  bool get _connected => _status.state.toUpperCase() == 'CONNECTED';

  @override
  void initState() {
    super.initState();
    _vpn.attach((s) {
      if (mounted) {
        setState(() => _status = s);
      }
    });
  }

  @override
  void dispose() {
    _vpn.detach();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_connected) {
      await _vpn.disconnect();
    } else {
      // Подставь свой конфиг из API/файла/строки вместо ravenSampleConfig.
      final ravenSampleConfig =
          "vless://d9020b88-cc39-2988-0254-25940368f6f9@raven.net.ru:443?type=tcp&security=reality&pbk=sompOjrok5Nr0zdcLcgFKdE98YJFb0GthGkRUyaleXs&fp=chrome&sni=yahoo.com&sid=fd6546ec484b44&spx=%2F&flow=xtls-rprx-vision#Corvin-Dfghhjk670348974";
      await _vpn.connect(config: ravenSampleConfig, remark: 'Raven VPN');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raven VPN')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusPanel(status: _status),
            const SizedBox(height: 24),
            RavenButton(connected: _connected, onTap: _toggle),
          ],
        ),
      ),
    );
  }
}
