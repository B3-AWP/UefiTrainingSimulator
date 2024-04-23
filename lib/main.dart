// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:uefi_simulator/EntryWidget.dart';
import 'package:uefi_simulator/controller/storage.dart';
import 'package:uefi_simulator/model/navigationModel.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // // Initialisiere die Einstellungen
  // initializeSettings();

  runApp(
    ChangeNotifierProvider<SettingsModel>(
      create: (context) => SettingsModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIOS Setup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BIOSPage(),
    );
  }
}

class BIOSPage extends StatefulWidget {
  const BIOSPage({super.key});

  @override
  _BIOSPageState createState() => _BIOSPageState();
}

class _BIOSPageState extends State<BIOSPage> {
  int _selectedPageIndex = 0;
  final NavigationModel navigationModel =
      NavigationModel(); // Make sure NavigationModel is correctly defined with entries.
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  void reload() {
    setState(() {});
  }

  // Future<void> saveSelectedOption(String key, String value) async {
  //   await storage.write(key: key, value: value);
  // }

  Future<void> saveSelectedOption(String key, String value) async {
    await storage.write(key: key, value: value);
    // Nach dem Speichern, erzwinge ein Neuladen des Widgets
    // reload();
  }

  Future<String?> getSelectedOption(String key) async {
    return await storage.read(key: key);
  }

  void setAlternativeSettings({required int exercise}) async {
    // Beispiel: Hier setzen wir alternative Werte
    Map<String, String> alternativeSettings;

    switch (exercise) {
      case 1:
        alternativeSettings = exercise1();
        break;
      case 2:
        alternativeSettings = exercise2();
        break;
      default:
        alternativeSettings = defaultOptions();
    }

    Provider.of<SettingsModel>(context, listen: false)
        .updateAllSettings(alternativeSettings);
    // Speichern der neuen Werte im sicheren Speicher

    alternativeSettings.forEach((key, value) async {
      await saveSelectedOption(key, value);
    });

    reload(); // Aktualisieren der UI, um die neuen Werte zu reflektieren
  }

  Map<String, String> defaultOptions() {
    var alternativeSettings = {
      'Language': 'English',
      // Fügen Sie hier weitere Einstellungen hinzu
    };
    return alternativeSettings;
  }

  Map<String, String> exercise1() {
    var alternativeSettings = {
      'Language': 'Frangais',
      'Serial Port 1 Address': '3E8/IRQ4',
      'Parallel Port Address': '3BC',
      'Parallel Port Mode': 'ECP',
      // Fügen Sie hier weitere Einstellungen hinzu
    };
    return alternativeSettings;
  }

  Map<String, String> exercise2() {
    var alternativeSettings = {
      'Parallel Port Address': '278',
      'Parallel Port Mode': 'EPP',
      // Fügen Sie hier weitere Einstellungen hinzu
    };
    return alternativeSettings;
  }

  void showExerciseDialog({required int exercise}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Übung 1"),
          content: Text(
              "Hier ist die Aufgabe, die Sie ausführen sollen. Klicken Sie auf 'Los geht's', um fortzufahren."),
          actions: <Widget>[
            TextButton(
              child: Text("Abbrechen"),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Schließt den Dialog ohne etwas zu tun
              },
            ),
            TextButton(
              child: Text("Los geht's"),
              onPressed: () {
                setAlternativeSettings(exercise: -1); // Ruft deine Funktion auf
                setAlternativeSettings(
                    exercise: exercise); // Ruft deine Funktion auf
                Navigator.of(context)
                    .pop(); // Schließt den Dialog nach der Ausführung
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Vergrößerte AppBar-Höhe
        child: AppBar(
          toolbarHeight: 80,
          title: Text('Lenovo V55t-15ARE (11KF,11KG,11KH,11KJ)'),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                showExerciseDialog(
                    exercise: 1); // Deine Methode zum Anzeigen des Dialogs
              },
              icon: Icon(
                Icons.numbers, // Das Icon für den Button
                size: 20, // Die Icon-Größe
              ),
              label: Text(
                "Übung 1", // Der Text für den Button
                style: TextStyle(fontSize: 16), // Die Textgröße
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10), // Innenabstand des Buttons
                // Weitere Stil-Einstellungen können hier hinzugefügt werden
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showExerciseDialog(
                    exercise: 2); // Deine Methode zum Anzeigen des Dialogs
              },
              icon: Icon(
                Icons.numbers, // Das Icon für den Button
                size: 20, // Die Icon-Größe
              ),
              label: Text(
                "Übung 2", // Der Text für den Button
                style: TextStyle(fontSize: 16), // Die Textgröße
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10), // Innenabstand des Buttons
                // Weitere Stil-Einstellungen können hier hinzugefügt werden
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showExerciseDialog(
                    exercise: -1); // Deine Methode zum Anzeigen des Dialogs
              },
              icon: Icon(
                Icons.numbers, // Das Icon für den Button
                size: 20, // Die Icon-Größe
              ),
              label: Text(
                "Zurücksetzen", // Der Text für den Button
                style: TextStyle(fontSize: 16), // Die Textgröße
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10), // Innenabstand des Buttons
                // Weitere Stil-Einstellungen können hier hinzugefügt werden
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: navigationModel.items
                .map((item) => NavigationRailDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.icon),
                      label: Text(item.title),
                    ))
                .toList(),
          ),
          VerticalDivider(thickness: 10, width: 1),
          Expanded(
            child: ListView(
              children: navigationModel.items[_selectedPageIndex].entries
                  .map((entry) => EntryWidget(
                      entry: entry,
                      onSaveSelectedOption: saveSelectedOption,
                      getSavedOption: getSelectedOption))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
