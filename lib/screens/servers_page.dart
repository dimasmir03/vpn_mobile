import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
import 'package:http/http.dart' as http;

class ServersPage extends StatefulWidget {
  const ServersPage({super.key});

  @override
  State<ServersPage> createState() => ServersPageState();
}

class ServersPageState extends State<ServersPage> {
  List<Map<String, dynamic>> servers = [];
  int selectedServer = 0;
  int countServers = 0;

  @override
  void initState() {
    super.initState();
    fetchServers();
  }

  Future<void> fetchServers() async {
    // servers = [
    //   {"code": "ch", "label": "Switzerland"},
    //   {"code": "de", "label": "Germany"},
    //   {"code": "us", "label": "United States"},
    //   {"code": "uk", "label": "United Kingdom"},

    //   {"code": "ru", "label": "Russia"},
    // ];
    try {
      final url = Uri.parse("https://api.raven.net.ru/api/mb/servers");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          servers = data.map((item) {
            return {"code": item["code"], "label": item["label"]};
          }).toList();
        });
      } else {
        throw Exception("Bad status: ${response.statusCode}");
      }
    } catch (e) {
      // setState(() => loading = false);
      debugPrint("Error loading servers: $e");
    }
  }

  Widget buildServerItem({
    required int index,
    required String code, // ch
    required String label, // Switzerland
  }) {
    return ListTile(
      leading: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CountryIcons.getSvgFlag(code),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                color: Colors.black54,
                child: Text(
                  code.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),

      selected: selectedServer == index,
      selectedTileColor: Colors.grey.shade300,

      onTap: () {
        setState(() {
          selectedServer = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(countServers.toString())),
      body: ListView.builder(
        itemCount: servers.length,
        itemBuilder: (context, index) {
          final server = servers[index];
          return buildServerItem(index: index, code: server["code"], label: server["label"]);
        },
      ),
    );
  }
}
