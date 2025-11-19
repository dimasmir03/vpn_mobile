// body: Center(
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       // StatusPanel(status: status),
//       // const SizedBox(height: 24),
//       RavenButton(connected: connected, onTap: toggle),
//     ],
//   ),
// ),

import 'package:flutter/material.dart';
import 'package:flutter_v2ray/model/v2ray_status.dart';
import 'package:vpn_mobile/service/vpn_service.dart';
import 'package:vpn_mobile/widgets/connect_button.dart';
import 'package:vpn_mobile/widgets/vpn_status_widget.dart';

class VpnPage extends StatefulWidget {
  const VpnPage({super.key});

  @override
  State<VpnPage> createState() => VpnPageState();
}

class VpnPageState extends State<VpnPage> {
  final vpn = VpnService.instance;

  V2RayStatus status = V2RayStatus(); // duration/uploadSpeed/downloadSpeed/upload/download/state

  bool get connected => status.state.toUpperCase() == 'CONNECTED';

  @override
  void initState() {
    super.initState();
    vpn.attach((s) {
      if (mounted) {
        setState(() => status = s);
      }
    });
  }

  @override
  void dispose() {
    vpn.detach();
    super.dispose();
  }

  Future<void> toggle() async {
    if (connected) {
      await vpn.disconnect();
    } else {
      // Подставь конфиг из API/файла/строки вместо ravenSampleConfig.
      final ravenSampleConfig =
          "vless://d9020b88-cc39-2988-0254-25940368f6f9@raven.net.ru:443?type=tcp&security=reality&pbk=sompOjrok5Nr0zdcLcgFKdE98YJFb0GthGkRUyaleXs&fp=chrome&sni=yahoo.com&sid=fd6546ec484b44&spx=%2F&flow=xtls-rprx-vision#Corvin-Dfghhjk670348974";
      await vpn.connect(config: ravenSampleConfig, remark: 'Raven VPN');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [VPNStatusText(status: status)]),
      body: Center(
        child: RavenButton(connected: connected, onTap: toggle),
      ),
    );
  }
}
