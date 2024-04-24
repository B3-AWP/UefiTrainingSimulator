import 'dart:convert';
import 'dart:html';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

void exportToCSV(List<DataRow> rows) {
  // Erzeuge eine Liste von Listen, um die Daten der DataRow zu speichern
  List<List<dynamic>> csvData = [];

  // Füge die Kopfzeile hinzu
  csvData.add(['Eintrag', 'Von', 'Auf']);

  // Füge die Datenzeilen hinzu
  for (var row in rows) {
    List<dynamic> rowData = [];
    for (var cell in row.cells) {
      rowData.add(cell.child.toString().replaceAll('Text("', '').replaceAll('")', '')); // Extrahiere den Text aus dem DataRow-Widget
    }
    csvData.add(rowData);
  }

  // Konvertiere die Daten in einen CSV-String
  String csvString = const ListToCsvConverter(fieldDelimiter: ';').convert(csvData);

  // Erzeuge einen Blob mit dem CSV-String
  var blob = Blob([csvString], 'text/csv');

  // Erzeuge einen Datei-URL aus dem Blob
  var url = Url.createObjectUrlFromBlob(blob);

  // Erzeuge ein Link-Element zum Herunterladen der Datei
  var anchor = AnchorElement(href: url)
    ..setAttribute("download", "settings.csv")
    ..text = "Download CSV";

  // Füge das Link-Element zum Dokument hinzu
  document.body!.append(anchor);

  // Klicke auf das Link-Element, um den Download zu starten
  anchor.click();

  // Entferne das Link-Element vom Dokument
  anchor.remove();
}
