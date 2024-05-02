import 'package:flutter/material.dart';

// Enumeration for different types of navigation entries
enum EntryType { branch, leaf, selectable, clickable }

class NavigationEntry {
  final String key;
  final dynamic value;
  final String description;
  final EntryType type;
  final IconData? icon;
  final List<NavigationEntry> children;
  final VoidCallback? onTap;

  NavigationEntry({
    required this.key,
    required this.value,
    this.description = '',
    required this.type,
    this.icon,
    this.children = const [],
    this.onTap,
  });

  bool get isLeaf =>
      type == EntryType.leaf ||
      type == EntryType.selectable ||
      type == EntryType.clickable;

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

  factory NavigationEntry.clickable({
    required String key,
    required VoidCallback onTap,
    String description = '',
    IconData? icon,
  }) {
    return NavigationEntry(
        key: key,
        value: null,
        type: EntryType.clickable,
        onTap: onTap,
        description: description,
        icon: icon);
  }
}
