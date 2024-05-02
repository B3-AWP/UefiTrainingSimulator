import 'package:uefi_simulator/model/icon_config.dart';
import 'package:uefi_simulator/model/navigation_entry.dart';
import 'package:uefi_simulator/model/navigation_item.dart';

class DevicesNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
      icon: IconConfig.icons['Devices']!,
      title: "Devices",
      entries: [
        NavigationEntry.branch(
          key: 'Serial Port Setup',
          description: 'Configure your system\'s serial port settings.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Serial Port Setup'],
          children: [
            NavigationEntry(
              key: 'Serial Port 1 Address',
              value: [
                'Disabled',
                '2F8/IRQ3',
                '3F8/IRQ4',
                '3E8/IRQ4',
                '2E8/IRQ3'
              ],
              description: 'Select settings for Serial Port 1.',
              type: EntryType.selectable,
            ),
          ],
        ),
        NavigationEntry.branch(
          key: 'Parallel Port Setup',
          description: 'Configure your system\'s parallel port settings.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Parallel Port Setup'],
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
        NavigationEntry.branch(
          key: 'USB Setup',
          description: 'Select this option to configure your systems USB port.',
          // type: EntryType.branch,
          icon: IconConfig.icons['USB Setup'],
          children: [
            NavigationEntry(
              key: 'USB Port Access',
              value: ['Enabled', 'Disabled'],
              description:
                  'Select whether to enable or disable USB (Universal Serial Bus) functions. If the functions are disabled,no USB device can be used.',
              type: EntryType.selectable,
            ),
            NavigationEntry(
              key: 'USB Enumeration Delay',
              value: ['Enabled', 'Disabled'],
              description:
                  'If it is enabled, extra delay will be added when host performs USB enumeration. This may improve the compatibility of USB device detection but increase POST time.',
              type: EntryType.selectable,
            ),
            NavigationEntry(
              key: 'Front USB Ports',
              value: ['Enabled', 'Disabled'],
              description:
                  'Select whether to enable or disable the Side USB ports.',
              type: EntryType.selectable,
            ),
            NavigationEntry(
              key: 'Rear USB Ports',
              value: ['Enabled', 'Disabled'],
              description:
                  'Select whether to enable or disable the rear USB port.',
              type: EntryType.selectable,
            ),
          ],
        ),
      ],
    );
  }
}
