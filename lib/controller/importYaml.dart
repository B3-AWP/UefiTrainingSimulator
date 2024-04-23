import 'dart:html' as html;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uefi_simulator/controller/storage.dart';
import 'package:yaml/yaml.dart';

void importYAML(BuildContext context) {
  // Erstellt ein File Upload Element
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  uploadInput.accept = '.yaml';  // Akzeptiert nur YAML-Dateien
  uploadInput.click();  // Öffnet den Dateiauswahldialog

  uploadInput.onChange.listen((e) {
    // Holen Sie sich die ausgewählte Datei
    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files.first;
      final reader = html.FileReader();

      // Liest die Datei als Text
      reader.readAsText(file);
      reader.onLoadEnd.listen((e) {
        if (reader.result != null) {
          _processUploadedYAML(reader.result as String, context);
        }
      });
    }
  });
}

void _processUploadedYAML(String yamlString, BuildContext context) {
  var doc = loadYaml(yamlString);
  Map<String, dynamic> yamlMap = Map.from(doc);

  // Aktualisieren Sie die Einstellungen über den Provider
  print('Imported YAML: $yamlMap'); 
  var settingsModel = Provider.of<SettingsModel>(context, listen: false);
  // settingsModel.updateSettings(yamlMap);

}

void importUebung1(BuildContext context) {
   Map<String, dynamic> myMap = {
      "Language": "English",
      "Parallel Port Mode": "ECP-EPP",
    };
  // updateCurrentSetting("Language","English");
  // updateCurrentSetting("Parallel Port Mode","ECP-EPP");
  var settingsModel = Provider.of<SettingsModel>(context, listen: false);
  // settingsModel.updateSettings(myMap);
  
}