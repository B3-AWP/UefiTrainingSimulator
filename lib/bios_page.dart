// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uefi_simulator/controller/storage_service.dart';
import 'package:uefi_simulator/entry_widget.dart';
import 'package:uefi_simulator/controller/export_csv.dart';
import 'package:uefi_simulator/controller/storage.dart';
import 'package:uefi_simulator/model/navigation_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BIOSPage extends StatefulWidget {
  const BIOSPage({super.key});

  @override
  _BIOSPageState createState() => _BIOSPageState();
}

class _BIOSPageState extends State<BIOSPage>
    with SingleTickerProviderStateMixin {
  int _currentExercise = 0;
  final Map<String, String> initialSettings = {};
  late final NavigationModel navigationModel;
  late final TabController _tabController;
  late final StorageService storageService;

  final TextStyle headlineStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue, // Ändern Sie die Farbe nach Bedarf
  );

  @override
  void initState() {
    super.initState();
    navigationModel = NavigationModel();
    storageService = Provider.of<StorageService>(context, listen: false);
    _tabController =
        TabController(length: navigationModel.items.length, vsync: this);
  }

  void reload() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> saveInitialState() async {
    final storageService = Provider.of<StorageService>(context, listen: false);

    for (var key in initialSettings.keys) {
      String? value = await storageService.getOption(key);
      if (value != null) {
        setState(() {
          initialSettings[key] = value;
        });
      }
    }
  }

  void extractDefaultValues(List<NavigationEntry> entries) {
    for (var entry in entries) {
      if (entry.type == EntryType.selectable && entry.value.isNotEmpty) {
        initialSettings[entry.key] = entry.value.first;
      }
      // Rekursive Suche, falls der Eintrag Kinder hat
      if (entry.children.isNotEmpty) {
        extractDefaultValues(entry.children);
      }
    }
  }

  void setinitialSettings({required int exercise}) async {
    Map<String, String> customSettings = {};
    final storageService = Provider.of<StorageService>(context, listen: false);

    setState(() {
      if (exercise > 0) {
        _currentExercise = exercise; // Setze den aktuellen Übungszustand
      } else {
        _currentExercise = 0;
      }
    });
    // Hole die aktuellen ersten Werte der Einstellungen.

    // Starte die rekursive Extraktion für jeden NavigationItem
    for (var item in navigationModel.items) {
      // 1. Schritt: Auf Basis des Navigationsmodell werden die Werte gesetzt
      // Funktion zum rekursiven Durchlaufen aller Einträge und deren Kinder
      extractDefaultValues(item.entries);
    }

    // 2. Schritt: Werte werden mit Custom-Default-Options überschrieben
    initialSettings.clear();
    initialSettings.addAll(DefaultValues.initialSettings());
    print("Initial $initialSettings");
    // 2. Schritt: Werte werden mit Übungsaufgaben überschrieben

    switch (exercise) {
      case 1:
        DefaultValues.exercise1().forEach((key, value) {
          // Überprüfe, ob der "start"-Schlüssel vorhanden ist und füge ihn zu customSettings hinzu
          if (value.containsKey('start')) {
            customSettings[key] = value['start']!;
          }
        });
        initialSettings.addAll(customSettings);
        break;
      case 2:
        DefaultValues.exercise2().forEach((key, value) {
          // Überprüfe, ob der "start"-Schlüssel vorhanden ist und füge ihn zu customSettings hinzu
          if (value.containsKey('start')) {
            customSettings[key] = value['start']!;
          }
        });
        initialSettings.addAll(customSettings);
        break;
    }

    print("Übungs-Settings: $initialSettings");

    // Aktualisiert die Einstellungen mit neuen Werten.
    Provider.of<SettingsModel>(context, listen: false)
        .updateAllSettings(initialSettings);

    // Speichern der neuen Werte im sicheren Speicher
    saveInitialState();
    initialSettings.forEach((key, value) async {
      await storageService.saveOption(key, value);
    });

    reload(); // Aktualisieren der UI, um die neuen Werte zu reflektieren
  }

  void checkGoalValues(Map<String, String> initialSettings,
      Map<String, Map<String, String>> goals) async {
    final storageService = Provider.of<StorageService>(context, listen: false);

    int numberOfDifferences = 0;
    List<DataRow> rows = [];
    for (var key in goals.keys) {
      String? currentValue = await storageService.getOption(key);
      if (currentValue != null && goals[key]!.containsKey('goal')) {
        if (goals[key]!['goal'] != currentValue) {
          numberOfDifferences++;
          rows.add(DataRow(cells: [
            DataCell(Text(key)),
            DataCell(Text(currentValue)),
            DataCell(Text(goals[key]!['goal'] ??
                'Für Lösung unnötig!')), // Zielwert anzeigen
          ]));
        }
      }
    }

    if (rows.isEmpty) {
      // Wenn keine Änderungen vorliegen, füge eine Benachrichtigungszeile hinzu.
      rows.add(DataRow(cells: const [
        DataCell(Text('Keine Fehler erkannt. Super!')),
        DataCell(Text('')),
        DataCell(Text(''))
      ]));
    } else if (numberOfDifferences > 0) {
      rows.add(DataRow(cells: [
        DataCell(Text('$numberOfDifferences Fehler nicht gefunden!')),
        DataCell(Text('')),
        DataCell(Text(''))
      ]));
    }

    showDialog(
      context: context,
      builder: (context) {
        if (!mounted)
          return SizedBox.shrink(); // Check if the widget is still mounted
        return AlertDialog(
          title: Text('Änderungen'),
          content: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Eintrag')),
                DataColumn(label: Text('Ist')),
                DataColumn(label: Text('Soll')),
              ],
              rows: rows,
            ),
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close),
              label: Text("Schließen"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                exportToCSV(rows);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save_alt),
              label: Text("Exportieren"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        );
      },
    );
  }

  void checkChangedSettings() async {
    print("Alle Settings vor Änderung: $initialSettings");
    final storageService = Provider.of<StorageService>(context, listen: false);

    List<DataRow> rows = [];
    for (var key in initialSettings.keys) {
      String? currentValue = await storageService.getOption(key);
      if (currentValue != null && currentValue != initialSettings[key]) {
        rows.add(DataRow(cells: [
          DataCell(Text(key)),
          DataCell(Text(initialSettings[key] ?? '')),
          DataCell(Text(currentValue))
        ]));
      }
    }

    if (rows.isEmpty) {
      // Wenn keine Änderungen vorliegen, füge eine Benachrichtigungszeile hinzu.
      rows.add(DataRow(cells: const [
        DataCell(Text('Keine Änderungen erkannt')),
        DataCell(Text('')),
        DataCell(Text(''))
      ]));
    }

    showDialog(
      context: context,
      builder: (context) {
        if (!mounted)
          return SizedBox.shrink(); // Check if the widget is still mounted
        return AlertDialog(
          title: Text('Änderungen'),
          content: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Eintrag')),
                DataColumn(label: Text('Von')),
                DataColumn(label: Text('Auf')),
              ],
              rows: rows,
            ),
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close),
              label: Text("Schließen"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                exportToCSV(rows);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save_alt),
              label: Text("Exportieren"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ],
        );
      },
    );
  }

  void showExerciseDialog({required int exercise}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: exercise > 0 ? Text("Übung $exercise") : Text("Zurücksetzen"),
          content: exercise > 0
              ? Text(
                  "Hier ist die Aufgabe, die Sie ausführen sollen. Klicken Sie auf 'Los geht's', um fortzufahren.")
              : Text(
                  "Bestätigen Sie, dass Sie wirklich sämtliche Werte zurückzusetzen wollen. \nAktion kann nicht rückgängig gemacht werden."),
          actions: <Widget>[
            TextButton(
              child: Text("Abbrechen"),
              onPressed: () => Navigator.of(context)
                  .pop(), // Schließt den Dialog ohne etwas zu tun
            ),
            TextButton(
              child: Text("Los geht's"),
              onPressed: () {
                // Schließt den Übungsdialog
                Navigator.of(context).pop();
                // Zeigt den Lade-Dialog
                showLoadingDialog();
                setinitialSettings(exercise: exercise);
                // Führt nach einer Verzögerung die setinitialSettings-Funktion aus
                Future.delayed(Duration(seconds: 2), () {
                  if (mounted) {}
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showHelp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$packageName", style: headlineStyle),
              Image.asset(
                'lib/assets/images/B3_logo.png',
                width: 100.0,
              ),
            ],
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Version: $version"),
              Text(""),
              Text("Kontakt", style: headlineStyle),
              Text("- https://github.com/B3-AWP/UefiTrainingSimulator"),
              Text("- software@info-rommel.de"),
              Text(""),
              Text("Datenschutz:", style: headlineStyle),
              Text(
                  "Es werden keine personenbezogenen Daten erfasst, ausgewertet oder weitergegeben.:"),
              Text("GNU General Public License (GPL)"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Schließen"),
              onPressed: () => Navigator.of(context)
                  .pop(), // Schließt den Dialog ohne etwas zu tun
            ),
          ],
        );
      },
    );
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Ladedialog nicht durch User schließen
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Übung wird vorbereitet"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("Bitte warten..."),
            ],
          ),
        );
      },
    );
    // Starte einen Timer, der nach 2 Sekunden den Dialog schließt
    Timer(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pop(); // Schließt den Ladedialog
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lenovo V55t-15ARE (11KF,11KG,11KH,11KJ)'),
        actions: _buildAppBarActions(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: TabBar(
            controller: _tabController,
            tabs: navigationModel.items
                .map((item) => Tab(
                      icon: Icon(item.icon),
                      text: item.title,
                    ))
                .toList(),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
            navigationModel.items.map((item) => _buildTabPage(item)).toList(),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      _buildExerciseButton(
          Icons.numbers, "Übung 1", () => showExerciseDialog(exercise: 1)),
      _buildExerciseButton(
          Icons.numbers, "Übung 2", () => showExerciseDialog(exercise: 2)),
      _buildExerciseButton(Icons.refresh, "Zurücksetzen",
          () => showExerciseDialog(exercise: -1)),
      if (_currentExercise > 0) ...[
        _buildExerciseButton(
            Icons.history, "Änderungen", () => checkChangedSettings()),
        _buildExerciseButton(
            Icons.check,
            "Prüfung",
            () =>
                _checkGoalValues(DefaultValues.initialSettings(), _currentExercise)),
      ],
      _buildExerciseButton(Icons.help_outline, "Info", showHelp),
    ];
  }

  Widget _buildExerciseButton(
      IconData icon, String text, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text, style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
    );
  }

  void _checkGoalValues(Map<String, String> initialSettings, int exercise) {
    Map<String, Map<String, String>> goals = {};
    switch (exercise) {
      case 1:
        goals = DefaultValues.exercise1();
        break;
      case 2:
        goals = DefaultValues.exercise2();
        break;
    }

    checkGoalValues(initialSettings, goals);
  }

  Widget _buildTabPage(NavigationItem item) {
    return ListView(
      children: item.entries
          .map((entry) => EntryWidget(
                entry: entry,
                onSaveSelectedOption: storageService.saveOption,
                getSavedOption: storageService.getOption,
              ))
          .toList(),
    );
  }
}

class DefaultValues {
  // Eine Methode, um Standard-Einstellungen zu definieren
  static Map<String, String> initialSettings() {
    return {
      'Language': 'English',
      // Fügen Sie hier weitere Standardwerte hinzu
    };
  }

  // Eine Methode, um die Übung 1 zu definieren
  static Map<String, Map<String, String>> exercise1() {
    return {
      'Language': {'start': 'Français', 'goal': 'English'},
      'Serial Port 1 Address': {'goal': '3E8/IRQ4'},
      'Parallel Port Address': {'start': '3BC'},
      'Parallel Port Mode': {'goal': 'ECP'},
      // Fügen Sie hier weitere Einstellungen hinzu
    };
  }

  // Eine Methode, um die Übung 2 zu definieren
  static Map<String, Map<String, String>> exercise2() {
    return {
      'Serial Port 1 Address': {'goal': '3E8/IRQ4'},
      'Parallel Port Address': {'start': '278'},
      'Parallel Port Mode': {'start': 'EPP'},
      // Weitere Einstellungen hier
    };
  }
}
