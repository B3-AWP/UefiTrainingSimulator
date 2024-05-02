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
            
            NavigationEntry(key: 'CPU Type', value: 'CPU Brand String', type: EntryType.leaf),
            NavigationEntry(key: 'CPU Speed', value: 'xx0GHz', type: EntryType.leaf),
            NavigationEntry(key: 'CPU Core Count', value: 'x', type: EntryType.leaf),
            NavigationEntry(key: 'Installed Memory', value: 'xxxx MB', type: EntryType.leaf),
            NavigationEntry(key: 'Memory Bus Speed', value: 'xx MHz', type: EntryType.leaf),
            NavigationEntry(key: 'Active Video', value: 'IGD/PEG/PCI', type: EntryType.leaf),
            NavigationEntry(key: 'Onboard Audio', value: 'Enabled', type: EntryType.leaf),
            NavigationEntry(key: 'Onboard Ethernet', value: 'Enabled', type: EntryType.leaf),
            NavigationEntry(key: 'System Fan', value: 'Operating', type: EntryType.leaf),
            NavigationEntry(key: 'Aux Fan', value: 'Operating', type: EntryType.leaf),
            NavigationEntry(key: 'M.2 Drive 1', value: 'None', type: EntryType.leaf),
            NavigationEntry(key: 'SATA Drive 1', value: 'None', type: EntryType.leaf),
            NavigationEntry(key: 'SATA Drive 2', value: 'None', type: EntryType.leaf),
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
        NavigationEntry(key: 'Machine Type and Model', value: '11KF', type: EntryType.leaf),
        NavigationEntry(key: 'System Brand ID', value: 'Lenovo V55t-15ARE', type: EntryType.leaf),
        NavigationEntry(key: 'System Serial Number', value: 'INVALID', type: EntryType.leaf),
        NavigationEntry(key: 'Asset Tag', value: '', type: EntryType.leaf),
        NavigationEntry(key: 'System UUID', value: 'abcdefg-1234-1234-1234-abcdefghijklmn', type: EntryType.leaf),
        NavigationEntry(key: 'Ethernet MAC Address', value: 'xx:xx:xx:xx:xx:xx', type: EntryType.leaf),
        NavigationEntry(key: 'Embedded Controller Version', value: 'O52CT', type: EntryType.leaf),
        NavigationEntry(key: 'BIOS Revision Level', value: 'O52KT', type: EntryType.leaf),
        NavigationEntry(key: 'Boot Block Revision Level', value: '0.04', type: EntryType.leaf),
        NavigationEntry(key: 'BIOS Date (MM/DD/YYYY)', value: '07/21/2018', type: EntryType.leaf),
        NavigationEntry(key: 'Preinstalled OS License', value: 'Not Defined', type: EntryType.leaf),
        NavigationEntry(key: 'OA3 License Key ID', value: 'NO DPK', type: EntryType.leaf),
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
