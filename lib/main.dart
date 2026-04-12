import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for Clipboard
import 'package:system_alert_window/system_alert_window.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VCheatApp(),
    ));

// --- MAIN APP UI ---
class VCheatApp extends StatelessWidget {
  const VCheatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("V-Cheat Control Center"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Setup Requirements:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.layers),
              onPressed: () => SystemAlertWindow.requestPermissions(),
              label: const Text("1. Grant Overlay Permission"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.accessibility),
              onPressed: () => FlutterAccessibilityService.requestAccessibilityPermission(),
              label: const Text("2. Enable Accessibility Service"),
            ),
            const Divider(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () async {
                await SystemAlertWindow.showSystemWindow(
                  height: 400, // Taller to fit the search list
                  width: 300,
                  gravity: SystemWindowGravity.TOP,
                  prefMode: SystemWindowPrefMode.OVERLAY,
                );
              },
              child: const Text(
                "OPEN CHEAT CONTROLLER",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- THE SEARCHABLE OVERLAY UI ---
@pragma("vm:entry-point")
void overlayMain() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CheatOverlayContent(),
  ));
}

class CheatOverlayContent extends StatefulWidget {
  const CheatOverlayContent({super.key});

  @override
  State<CheatOverlayContent> createState() => _CheatOverlayContentState();
}

class _CheatOverlayContentState extends State<CheatOverlayContent> {
  // FULL DATA FROM YOUR SCREENSHOT
  final Map<String, String> viceCityCheats = {
  // Tommy Experience
  "Full Armor": "PRECIOUSPROTECTION",
  "Full Health": "ASPIRINE",
  "Thug Weapons": "THUGSTOOLS",
  "Professional Weapons": "PROFESSIONALTOOLS",
  "Nutter Weapons": "NUTTERTOOLS",
  "Raise Wanted Level": "YOUWONTTAKEMEALIVE",
  "Remove Wanted Level": "LEAVEMEALONE",
  "Tommy goes faster": "ONSPEED",
  "Tommy goes slower": "BOOOOOORING",
  "Blow up vehicles": "BIGBANG",
  

  
  // Vehicles
  "Spawn Tank": "PANZER",
  "Spawn Limo": "ROCKANDROLLCAR",
  "Spawn Hearse": "THELASTRIDE",
  "Spawn Trashmaster": "RUBBISHCAR",
  "Spawn Sabre Turbo": "GETTHEREFAST",
  
  // Environment
  "Clear Weather": "APLEASANTDAY",
  "Cloudy Weather": "ABITDRIEG",
  "Rainy Weather": "CATSANDDOGS",
  "Foggy Weather": "CANTSEEATHING",
};

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filters the list as you type
    final filteredKeys = viceCityCheats.keys
        .where((key) => key.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.blueGrey[900],
            child: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Search cheat...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white54),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredKeys.length,
              itemBuilder: (context, index) {
                final name = filteredKeys[index];
                final code = viceCityCheats[name]!;
                return ListTile(
                  dense: true,
                  title: Text(name, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(code, style: const TextStyle(color: Colors.blueAccent)),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    // Optional: Add a small toast or vibration here if you want
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () => SystemAlertWindow.closeSystemWindow(),
            child: const Text("CLOSE", style: TextStyle(color: Colors.red)),
          )
        ],
      ),
    );
  }
}