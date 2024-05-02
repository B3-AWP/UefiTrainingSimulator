import 'package:uefi_simulator/model/icon_config.dart';
import 'package:uefi_simulator/model/navigation_item.dart';

import '../model/navigation_entry.dart';

class AdvancedNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
      title: "Advanced",
      icon: IconConfig.icons['Advanced']!,
      entries: [
        NavigationEntry.branch(
          key: 'CPU Setup',
          description: 'Contains CPU features.',
          // type: EntryType.branch,
          icon: IconConfig.icons['System Summary'],
          children: [
            NavigationEntry(
                key: 'AMD Secure Virtual Machine',
                value: ['Enabled', 'Disabled'],
                type: EntryType.selectable,
                icon: IconConfig.icons['AMD Secure Virtual Machine'],
                description:
                    'AMD Virtualization technology is a set of unique on-chip features that enables AMD PRO-based clients to run multiple operating systems and applications on a single machine. Select whether to enable or disable AMD Virtualization technology.'),
            NavigationEntry(
                key: 'IOMMU',
                value: ['Enabled', 'Disabled'],
                type: EntryType.selectable,
                icon: IconConfig.icons['IOMMU'],
                description: 'AMD input/output memory management unit'),
            NavigationEntry(
                key: 'CPB Mode',
                value: ['Enabled', 'Disabled'],
                type: EntryType.selectable,
                icon: IconConfig.icons['CPB Mode'],
                description:
                    'Core Performance Boost allows the processor to dynamically control and adjust its operating frequency to increase performance when needed and maintain lower power and thermal characteristics during normal operation.'),
            NavigationEntry(
                key: 'C State Support',
                value: ['Enabled', 'Disabled'],
                type: EntryType.selectable,
                icon: IconConfig.icons['C State Support'],
                description:
                    'Select whether to enable or disable the CPU power management state to minimize idle power consumption of the processor.'),
            NavigationEntry(
                key: 'CPU ID',
                value: 'xxxxxx',
                type: EntryType.leaf,
                description: 'Displays the Processor ID.'),
            NavigationEntry(
                key: 'Microcode Revision',
                value: 'BE',
                type: EntryType.leaf,
                description: 'CPU Microcode Revision'),
            NavigationEntry(
                key: 'Chipset', value: 'xxxxxx', type: EntryType.leaf),
          ],
        ),
        NavigationEntry(
          key: 'Dust Shield Alert',
          value: ['Enabled', 'Disabled'],
          type: EntryType.selectable,
          icon: IconConfig.icons['Dust Shield Alert'],
        ),
        // Weitere Einträge hinzufügen...
      ],
    );
  }
}
