import 'package:flutter/material.dart';



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

