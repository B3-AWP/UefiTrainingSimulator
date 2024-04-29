import 'package:flutter/material.dart';
import 'package:uefi_simulator/model/navigation_model.dart';


class DevicesNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
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
    );
  }
}
