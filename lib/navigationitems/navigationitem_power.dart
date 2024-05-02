import 'package:uefi_simulator/model/icon_config.dart';
import 'package:uefi_simulator/model/navigation_item.dart';

import '../model/navigation_entry.dart';

class PowerNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
      title: "Power",
      icon: IconConfig.icons['Power']!,
      entries: [       
        NavigationEntry(
          key: 'After Power Loss',
          value: ['Power Off', 'Power On', 'Last State'],
          type: EntryType.selectable,
          description: 'This field controls whether the system will stay on after AC power is removed and then restored. Select "Power On" if you use a power strip to turn the  system on. Select "Power Off" if you want the system to remain  off after power restored. Select "Last State" to have the system return to the  previous state.'
        ),
        NavigationEntry(
          key: 'Enhanced Power Saving Mode',
          value: ['Disabled', 'Enabled'],
          type: EntryType.selectable,
          description: '<Enabled> The system will enter to Enhanced Power Saving Mode during power off. The total power consumption will be lower during power off. <Disabled> Disables function of Enhanced Power Save Mode. Note: When enabled Enhanced Power Saving Mode, only the Wake Up on Alarm function is supported. Other wake up functions are not supported. System will not enter to Enhanced Power Saving Mode if Intel ME is required to be active in Sx states and host is in AC mode.'
        ),
        NavigationEntry.branch(
          key: 'Intelligent Cooling',
          description: 'Lenovo unique system thermal management solution.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Intelligent Cooling'],
          children: [
            NavigationEntry(
              key: 'Performance Mode',
              value: [
                'Best Performance',
                'Best Experience',
                'Full Speed',
              ],
              description: '<Best Performance> The system will run at a better thermal level with normal acoustic performance. <Best Experience> The system will run at the best experience with balanced noise and better performance <Full Speed> All fans in the system will run at full speed.',
              type: EntryType.selectable,
            ),
          ],
        ),
        NavigationEntry.branch(
          key: 'Automatic Power On',
          description: 'Contains automatic power on features.',
          // type: EntryType.branch,
          icon: IconConfig.icons['Automatic Power On'],
          children: [
            NavigationEntry(
              key: 'Wake on LAN',
              value: [
                'Primary',
                'Automatic',
                'Disabled',
              ],
              description: 'Select whether to enable Wake on LAN, and/or which Startup Sequence to use after a Wake on LAN event. NOTE: This item controls the wake up event from onboard LAN and PCI LAN.',
              type: EntryType.selectable,
            ),
            NavigationEntry(
              key: 'Wake Up on Alarm',
              value: [
                'Single Event',
                'Daily Event',
                'Weekly Event',
                'User Defined',
                'Disabled',
              ],
              description: 'Select whether to enable Wake Up on Alarm, to turn on your system on a special day of the month, special day of the week or daily. NOTE: Values in these fields may be overwritten by the operating system.',
              type: EntryType.selectable,
            ),
            
          ],
        ),
      ],
    );
  }
}
