import 'package:flutter/material.dart';

// Festlegung der Hauptstruktur (Kateogiren) auf der linken Seite
class NavigationItem {
  IconData icon;
  String title;
  List<NavigationEntry> entries;

  NavigationItem(
      {required this.icon, required this.title, required this.entries});
}

// MÖgliche Einträge eines NavigationEntry
enum EntryType { branch, leaf, selectable }

// Ein Eintrag in der Kategorie
class NavigationEntry {
  String key;
  dynamic value; // Can be String or List<String> depending on the entry type
  String description;
  EntryType type;
  IconData? icon; // Optional icon for the entry
  List<NavigationEntry> children;

  NavigationEntry({
    required this.key,
    required this.value,
    required this.description,
    required this.type,
    this.icon,
    this.children = const [],
  });

  bool get isLeaf {
    return type == EntryType.leaf || type == EntryType.selectable;
  }
}

//Bau der NavigationEntry
class NavigationEntryBuilder {
  String? key;
  dynamic value;
  String? description;
  EntryType? type;
  IconData? icon; // Property to hold the icon
  List<NavigationEntry> children = [];

  NavigationEntryBuilder();

  NavigationEntryBuilder branch(
      {required String key, String? description, IconData? icon}) {
    this.key = key;
    this.description = description;
    this.icon = icon;
    type = EntryType.branch;
    return this;
  }

  NavigationEntryBuilder leaf(
      {required String key,
      required dynamic value,
      String? description,
      IconData? icon}) {
    this.key = key;
    this.value = value;
    this.description = description;
    this.icon = icon;
    type = EntryType.leaf;
    return this;
  }

  NavigationEntryBuilder selectable(
      {required String key,
      required List<String> options,
      String? description,
      IconData? icon,
      String? defaultValue}) {
    this.key = key;
    value = options;
    this.description = description;
    this.icon = icon;
    type = EntryType.selectable;
    return this;
  }

  NavigationEntryBuilder addChild(NavigationEntry child) {
    children.add(child);
    return this;
  }

  NavigationEntry build() {
    assert(key != null, 'Key must be provided.');
    // assert(description != null, 'Description must be provided.');
    assert(type != null, 'Type must be set.');
    return NavigationEntry(
      key: key!,
      value: value,
      description: description ??
          '', // Provide a default empty string if description is null
      type: type!,
      icon: icon,
      children: children,
    );
  }
}


//Aufbau der Standardwerte
class NavigationModel {
  List<NavigationItem> items = [
    NavigationItem(
      icon: Icons.home,
      title: "Main",
      entries: [
        NavigationEntryBuilder()
            .branch(key: 'System Summary', icon: Icons.memory)
            .addChild(
              NavigationEntryBuilder()
                  .leaf(
                      key: 'CPU Type',
                      value: "CPU Brand String",
                      description: "aasdf")
                  .build(),
            )
            .addChild(
              NavigationEntryBuilder()
                  .leaf(key: 'CPU Speed', value: "xx0GHZ", icon: Icons.speed)
                  .build(),
            )
            .build(),
        NavigationEntryBuilder()
            .branch(key: 'System Time & Date')
            .addChild(
              NavigationEntryBuilder()
                  .leaf(
                      key: 'System Time (HH:MM::SS)',
                      value: "21:23:17",
                      icon: Icons.timer)
                  .build(),
            )
            .addChild(
              NavigationEntryBuilder()
                  .leaf(
                      key: 'System Date (MM/DD/YYYY)',
                      value: "Apr 21. 2024",
                      icon: Icons.calendar_today)
                  .build(),
            )
            .build(),
        NavigationEntryBuilder()
            .leaf(key: 'Machine Type and Model', value: '11KF')
            .build(),
        NavigationEntryBuilder()
            .selectable(
                key: 'Language',
                options: ['English', 'Frangais', '中文'],
                icon: Icons.language)
            .build(),
      ],
    ),
    NavigationItem(
      icon: Icons.settings,
      title: "Devices",
      entries: [
        NavigationEntryBuilder()
            .branch(
                key: 'Serial Port Setup',
                description:
                    'Select this option to configure your system\'s serial port.',
                icon: Icons.account_circle_rounded)
            .addChild(
              NavigationEntryBuilder()
                  .selectable(
                      key: 'Serial Port 1 Address',
                      options: [
                        'Disabled',
                        '2F8/IRQ3',
                        '3F8/IRQ4',
                        '3E8/IRQ4',
                        '2E8/IRQ3'
                      ],
                      description:
                          'Select settings for the Serial Port 1.If set to "Disabled",the Serial Port will not be seen by the OS.')
                  .build(),
            )
            .build(),
        NavigationEntryBuilder()
            .branch(
                key: 'Parallel Port Setup',
                description:
                    'Select this option to configure your system\'s parallel port.',
                icon: Icons.add_to_photos_rounded)
            .addChild(
              NavigationEntryBuilder()
                  .selectable(
                      key: 'Parallel Port Address',
                      options: ['Disabled', '378', '278', '3BC'],
                      description:
                          'Select settings for the Serial Port. If set to"Disabled",the Parallel Port will not be seen by the OS..')
                  .build(),
            )
            .addChild(
              NavigationEntryBuilder()
                  .selectable(
                      key: 'Parallel Port Mode',
                      options: ['ECP-EPP', 'ECP', 'EPP'],
                      description:
                          'Change the Parallel Port Mode. EPP (Enhanced Parallel Port) and ECP (Extended Capabilities Port) are two modes to transmit data by Parallel Port. EPP is more commonly used than ECP.')
                  .build(),
            )
            .build(),
      ],
    ),
    // ... Repeat for other NavigationItems
  ];
}

