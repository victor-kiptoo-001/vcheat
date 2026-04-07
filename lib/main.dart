import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';

void main() => runApp(const VCheatApp());

class VCheatApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("V-Cheat SDK 35 Fix")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => SystemAlertWindow.requestPermissions(),
                child: const Text("1. Grant Overlay Permission"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => FlutterAccessibilityService.requestAccessibilityPermission(),
                child: const Text("2. Enable Accessibility Service"),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                   SystemAlertWindow.showSystemWindow(
                    height: 100,
                    width: 200,
                    gravity: SystemWindowGravity.TOP,
                    prefMode: SystemWindowPrefMode.OVERLAY,
                  );
                },
                child: const Text("3. START CHEAT BUBBLE", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}