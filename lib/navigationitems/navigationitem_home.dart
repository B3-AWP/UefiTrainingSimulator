import 'package:flutter/material.dart';
import '../model/navigation_model.dart';

class MainNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
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
        // Weitere Einträge hinzufügen...
      ],
    );
  }
}
