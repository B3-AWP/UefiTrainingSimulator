import 'package:flutter/material.dart';

import '../navigationitems/navigationitem_devices.dart';
import '../navigationitems/navigationitem_home.dart';

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
     MainNavigationItem.buildItem(),
    DevicesNavigationItem.buildItem(),
    // Add more NavigationItems here as needed
  ];
}
