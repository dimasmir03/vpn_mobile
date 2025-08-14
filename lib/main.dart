import 'package:flutter/material.dart';
import 'package:vpn_mobile/screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RavenVpnApp());
}

class RavenVpnApp extends StatelessWidget {
  const RavenVpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raven VPN',
      debugShowCheckedModeBanner: false,
      theme: ravenDarkTheme,
      home: const HomeScreen(),
    );
  }
}
