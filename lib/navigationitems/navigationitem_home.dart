import 'package:uefi_simulator/model/icon_config.dart';
import 'package:uefi_simulator/model/navigation_item.dart';

import '../model/navigation_entry.dart';

class MainNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
      title: "Main",
      icon: IconConfig.icons['Main']!,
      entries: [
        NavigationEntry.branch(
          key: 'System Summary',
          // type: EntryType.branch,
          icon: IconConfig.icons['System Summary'],
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
              icon: IconConfig.icons['CPU Speed'],
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
              icon: IconConfig.icons['System Time (HH:MM:SS)'],
            ),
            NavigationEntry(
              key: 'System Date (MM/DD/YYYY)',
              value: "Apr 21, 2024",
              type: EntryType.leaf,
              icon: IconConfig.icons['System Date (MM/DD/YYYY)'],
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
          icon: IconConfig.icons['Language'],
        ),
        // Weitere Einträge hinzufügen...
      ],
    );
  }
}
