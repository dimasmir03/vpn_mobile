import 'package:flutter/material.dart';

import 'vpn_page.dart';
import 'servers_page.dart';
import 'settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [ServersPage(), VpnPage(), SettingsPage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RAVEN')),

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.language), label: 'Servers'),
          BottomNavigationBarItem(icon: const Icon(Icons.verified_user), label: 'VPN'),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: _selectPage,
      ),
    );
  }
}
