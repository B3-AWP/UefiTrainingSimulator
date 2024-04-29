import 'package:flutter/material.dart';

// Define a class to manage icons centrally
class IconConfig {
  static const Map<String, IconData> icons = {
    'home': Icons.home,
    'settings': Icons.settings,
    'memory': Icons.memory,
    'speed': Icons.speed,
    'timer': Icons.timer,
    'calendar_today': Icons.calendar_today,
    'language': Icons.language,
    'account_circle_rounded': Icons.account_circle_rounded,
    'add_to_photos_rounded': Icons.add_to_photos_rounded,
  };
}

// Enumeration for different types of navigation entries
enum EntryType { branch, leaf, selectable }

class NavigationEntry {
  final String key;
  final dynamic value;
  final String description;
  final EntryType type;
  final IconData? icon;
  final List<NavigationEntry> children;

  NavigationEntry({
    required this.key,
    required this.value,
    this.description = '',
    required this.type,
    this.icon,
    this.children = const [],
  });

   bool get isLeaf => type == EntryType.leaf || type == EntryType.selectable;

  // Factory-Methode für Branch-Typen ohne `value`
  factory NavigationEntry.branch({
    required String key,
    String description = '',
    IconData? icon,
    List<NavigationEntry> children = const [],
  }) {
    return NavigationEntry(
      key: key,
      value: null, // Kein Wert für Branches
      description: description,
      type: EntryType.branch,
      icon: icon,
      children: children,
    );
  }
}


// Navigation item class with constructor
class NavigationItem {
  final IconData icon;
  final String title;
  final List<NavigationEntry> entries;

  NavigationItem({required this.icon, required this.title, required this.entries});
}

// Navigation model with predefined items
class NavigationModel {
  List<NavigationItem> items = [
    NavigationItem(
      icon: IconConfig.icons['home']!,
      title: "Main",
      entries: [
        NavigationEntry.branch(
          key: 'System Summary',
          // type: EntryType.branch,
          icon: IconConfig.icons['memory'],
          children: [
            NavigationEntry(
              key: 'CPU Type',
              value: "CPU Brand String",
              description: "Processor brand and model",
              type: EntryType.leaf,
            ),
            NavigationEntry(
              key: 'CPU Speed',
              value: "xx0GHZ",
              description: "Current processor speed",
              type: EntryType.leaf,
              icon: IconConfig.icons['speed'],
            ),
          ],
        ),
        NavigationEntry.branch(
          key: 'System Time & Date',
          // type: EntryType.branch,
          children: [
            NavigationEntry(
              key: 'System Time (HH:MM:SS)',
              value: "21:23:17",
              type: EntryType.leaf,
              icon: IconConfig.icons['timer'],
            ),
            NavigationEntry(
              key: 'System Date (MM/DD/YYYY)',
              value: "Apr 21, 2024",
              type: EntryType.leaf,
              icon: IconConfig.icons['calendar_today'],
            ),
          ],
        ),
        NavigationEntry(
          key: 'Machine Type and Model',
          value: '11KF',
          type: EntryType.leaf,
        ),
        NavigationEntry(
          key: 'Language',
          value: ['English', 'Français', '中文'],
          type: EntryType.selectable,
          icon: IconConfig.icons['language'],
        ),
      ],
    ),
    NavigationItem(
      icon: IconConfig.icons['settings']!,
      title: "Devices",
      entries: [
        NavigationEntry.branch(
          key: 'Serial Port Setup',
          description: 'Configure your system\'s serial port settings.',
          // type: EntryType.branch,
          icon: IconConfig.icons['account_circle_rounded'],
          children: [
            NavigationEntry(
              key: 'Serial Port 1 Address',
              value: ['Disabled', '2F8/IRQ3', '3F8/IRQ4', '3E8/IRQ4', '2E8/IRQ3'],
              description: 'Select settings for Serial Port 1.',
              type: EntryType.selectable,
            ),
          ],
        ),
        NavigationEntry.branch(
          key: 'Parallel Port Setup',
          description: 'Configure your system\'s parallel port settings.',
          // type: EntryType.branch,
          icon: IconConfig.icons['add_to_photos_rounded'],
          children: [
            NavigationEntry(
              key: 'Parallel Port Address',
              value: ['Disabled', '378', '278', '3BC'],
              description: 'Select settings for the Parallel Port.',
              type: EntryType.selectable,
            ),
            NavigationEntry(
              key: 'Parallel Port Mode',
              value: ['ECP-EPP', 'ECP', 'EPP'],
              description: 'Select the mode for Parallel Port.',
              type: EntryType.selectable,
            ),
          ],
        ),
      ],
    ),
    // Add more NavigationItems here as needed
  ];
}
