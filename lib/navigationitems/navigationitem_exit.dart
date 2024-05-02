import 'package:uefi_simulator/model/icon_config.dart';
import 'package:uefi_simulator/model/navigation_item.dart';

import '../model/navigation_entry.dart';

class ExitNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
      title: "Exit",
      icon: IconConfig.icons['Exit']!,
      entries: [
        NavigationEntry(
            key: 'Save Changes and Exit',
            value: '',
            type: EntryType.leaf,
            description:
                'Exit system Setup after saving the changes.'
        ),
        NavigationEntry(
            key: 'Discard Changes and Exit',
            value: '',
            type: EntryType.leaf,
            description:
                'Exit system Setup without saving any changes.'
        ),
        NavigationEntry(
            key: 'Load Optimal Defaults',
            value: '',
            type: EntryType.leaf,
            description:
                'Restore/Load Default values for all the setup options.'
        ),
       
      ],
    );
  }
}
