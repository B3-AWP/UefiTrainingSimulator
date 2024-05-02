// Navigation item class with constructor
import 'package:flutter/material.dart';
import 'package:uefi_simulator/model/navigation_entry.dart';

class NavigationItem {
  final IconData icon;
  final String title;
  final List<NavigationEntry> entries;

  NavigationItem({required this.icon, required this.title, required this.entries});
}

