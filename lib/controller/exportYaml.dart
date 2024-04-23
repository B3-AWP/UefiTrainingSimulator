import 'dart:html' as html;

String convertSettingsToYaml(Map<String, dynamic> settings) {
  // Konvertiert die Map in einen YAML-kompatiblen String
  String yamlString = "";
  settings.forEach((key, value) {
    yamlString += "$key: $value\n";
  });
  return yamlString;
}

void exportYaml(Map<String, dynamic> currentSettings) {
  String yamlContent = convertSettingsToYaml(currentSettings);
  final blob = html.Blob([yamlContent]);  // Erstellt einen Blob aus dem YAML-String
  final url = html.Url.createObjectUrlFromBlob(blob);  // Erstellt eine URL für den Blob
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'settings.yaml')  // Setzt den Dateinamen
    ..click();  // Startet den Download
  html.Url.revokeObjectUrl(url);  // Bereinigt die URL nach dem Download
}
