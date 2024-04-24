import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// Initialisiert ein globales Dictionary `currentSettings`, das Standardwerte für verschiedene Einstellungen speichert.


class SettingsModel extends ChangeNotifier {
  final Map<String, String> _settings = {};

  void updateSetting(String key, String value) {
    _settings[key] = value;
    // notifyListeners();  // Benachrichtigt alle lauschenden Widgets über die Änderung
  }

  // Neue Methode, um alle Einstellungen zu aktualisieren
  void updateAllSettings(Map<String, String> newSettings) {
    _settings.addAll(newSettings);
    notifyListeners();
  }

  String getSetting(String key) => _settings[key] ?? '';

}