import 'package:uefi_simulator/model/icon_config.dart';
import 'package:uefi_simulator/model/navigation_item.dart';

import '../model/navigation_entry.dart';

class StartupNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
      title: "Startup",
      icon: IconConfig.icons['Startup']!,
      entries: [
        NavigationEntry.branch(
          key: 'Primary Boot Sequence',
          description:
              'This sequence is used when the system is powered up normally. Use Up and Down arrows to select a device. <+> and <-> move the device up or down. <x> excludes/includes the device to boot.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Hard Disk Password'],
          children: [
            //Todo: Sequenz einfügen
          ],
        ),
        NavigationEntry.branch(
          key: 'Automatic Boot Sequence',
          description:
              'This sequence is used when the system is powered up normally. Use Up and Down arrows to select a device. <+> and <-> move the device up or down. <x> excludes/includes the device to boot.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Hard Disk Password'],
          children: [
            //Todo: Sequenz einfügen
          ],
        ),
        NavigationEntry.branch(
          key: 'Error Boot Sequence',
          description:
              'This sequence is used when the system is powered up normally. Use Up and Down arrows to select a device. <+> and <-> move the device up or down. <x> excludes/includes the device to boot.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Hard Disk Password'],
          children: [
            //Todo: Sequenz einfügen
          ],
        ),
        NavigationEntry.branch(
          key: 'Manufacturing Boot Sequence',
          description:
              'Use Up and Down arrows to select a device. <+> and <-> move the device up or down. <x> excludes/includes the device to boot.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Hard Disk Password'],
          children: [
            //Todo: Sequenz einfügen
          ],
        ),
        NavigationEntry(
            key: 'Boot Up Num-Lock Status',
            value: ['On', 'Off'],
            type: EntryType.selectable,
            description:
                'This field indicates the state of the NumLock feature of the keyboard after Startup. If NumLock is "On", the keys on the keypad will act as numeric keys. If NumLock is "Off", the keys on the keypad will act as cursor keys.'
        ),
        NavigationEntry(
            key: 'Fast Boot',
            value: ['Enabled', 'Disabled'],
            type: EntryType.selectable,
            description:
                'This feature could record the last successful startup state to short the hardware POST time at the next time boot. It is recommended to turn off "fast boot" if you often use CD/DVD or network to load your operatiing system Select "Enabled", System could start up computer faster. Select "Disabled" to switch back to normal boot.'
        ),
         NavigationEntry(
            key: 'Option Keys Display',
            value: ['Enabled', 'Disabled'],
            type: EntryType.selectable,
            description:
                'Controls the system software option key prompts (such as F1 key) when the system is turned on. Select "Enabled" to display the prompts. NOTE: Disabling the prompts will not affect the function of a specific key.'
        ),
         NavigationEntry(
            key: 'Option Keys Display Style',
            value: ['Normal', 'Legacy'],
            type: EntryType.selectable,
            description:
                'Controls the style of prompts displayed on the POST logo screen when the system is turned on. Choosing "Normal" will prompt for the Enter key and display a menu. Choosing "Legacy" will prompt for F1 and F12.'
        ),
      ],
    );
  }
}
