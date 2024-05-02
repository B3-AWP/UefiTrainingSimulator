// mainPage.dart
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uefi_simulator/controller/storage.dart';
import 'package:uefi_simulator/model/navigation_entry.dart';

class EntryWidget extends StatefulWidget {
  final NavigationEntry entry;
  final Future<void> Function(String key, String value) onSaveSelectedOption;
  final Future<String?> Function(String key) getSavedOption;

  EntryWidget({
      required this.entry,
      required this.onSaveSelectedOption,
      required this.getSavedOption
  });

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Eventuell hier Initialisierungslogik einfügen
  }

  @override
  Widget build(BuildContext context) {
    // Du verwendest den Provider, um den Wert zu holen, der möglicherweise aktualisiert wird.

    return FutureBuilder<String?>(
      future: widget.getSavedOption(widget.entry.key), // Hier rufst du den asynchronen Vorgang auf
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Wenn die Daten noch geladen werden, zeige einen Ladekreis
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Fehlerbehandlung, falls etwas schiefgeht
          return Text('Fehler: ${snapshot.error}');
        } else {
          // Wenn die Daten geladen sind, wird der Wert im DropdownButton angezeigt
          String? currentValue = snapshot.data;

          return widget.entry.isLeaf
              ? ListTile(
                  title: Text(widget.entry.key),
                  subtitle: Text(widget.entry.description),
                  leading: widget.entry.icon != null ? Icon(widget.entry.icon) : null,
                  trailing: widget.entry.type == EntryType.selectable
                      ? DropdownButton<String>(
                          value: currentValue ?? (widget.entry.value.isNotEmpty ? widget.entry.value.first : null),
                          items: widget.entry.value.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {

                            if (newValue != null) {
                              // Setzen des neuen Werts und Benachrichtigung des Providers
                              widget.onSaveSelectedOption(widget.entry.key, newValue).then((_) {
                                Provider.of<SettingsModel>(context, listen: false)
                                    .updateSetting(widget.entry.key, newValue);
                              });
                              setState(() {
                                currentValue = newValue;
                              });
                            }
                          },
                        )
                      : Text(currentValue ?? widget.entry.value ?? ""),
                )
              : ExpansionTile(
                  title: Text(widget.entry.key),
                  leading: widget.entry.icon != null ? Icon(widget.entry.icon) : null,
                  subtitle: Text(widget.entry.description),
                  children: widget.entry.children
                      .map((child) => EntryWidget(
                            entry: child,
                            onSaveSelectedOption: widget.onSaveSelectedOption,
                            getSavedOption: widget.getSavedOption,
                          ))
                      .toList(),
                );
        }
      },
    );
  }
}
