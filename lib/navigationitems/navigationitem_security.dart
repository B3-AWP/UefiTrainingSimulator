import 'package:uefi_simulator/model/icon_config.dart';
import 'package:uefi_simulator/model/navigation_item.dart';

import '../model/navigation_entry.dart';

class SecurityNavigationItem {
  static NavigationItem buildItem() {
    return NavigationItem(
        title: "Security",
        icon: IconConfig.icons['Security']!,
        entries: [
          NavigationEntry(
            key: 'Supervisor Password',
            value: 'Not Installed',
            type: EntryType.leaf,
          ),
          NavigationEntry(
            key: 'Power-On Password',
            value: 'Not Installed',
            type: EntryType.leaf,
          ),
          NavigationEntry(
              key: 'Secure Roll Back Prevention',
              value: ['Yes', 'No'],
              type: EntryType.selectable,
              description:
                  '[Yes] - Flash BIOS to a previous or current version is not allowed. This is the default setting. [No] - Flash BIOS to a previous or current version is allowed.'),
          NavigationEntry(
              key: 'Require SVP when Flashing',
              value: ['Yes', 'No'],
              type: EntryType.selectable,
              description:
                  'If "No" is selected, the supervisor password will not be required when updating the system software.'),
          NavigationEntry(
              key: 'Windows UEFI Firmware Update',
              value: ['Enabled', 'Disabled'],
              type: EntryType.selectable,
              description:
                  'This option enables or disables windows UEFI firmware update feature. <Enabled> Allow windows UEFI firmware update. <Disabled> BIOS will skip windows UEFI firmware update.'),
          NavigationEntry(
              key: 'BIOS Password At System Boot',
              value: ['Yes', 'No'],
              type: EntryType.selectable,
              description:
                  '<Yes> The system prompts for passwords when the system starts from the full off or hibernate state. <No>Passwords are not prompted and continue to boot the OS. To prevent unauthorized access to the system, recommend to set user authentication  on the OS.'),
          NavigationEntry(
              key: 'BIOS Password At Reboot',
              value: ['Yes', 'No'],
              type: EntryType.selectable,
              description:
                  'If "No" is selected, the Power-On Password will not be required when system restarts.'),
          NavigationEntry(
              key: 'POP Changeable by User',
              value: ['Yes', 'No'],
              type: EntryType.selectable,
              description:
                  'If "No" is selected, the Power-On Password can only be changed by the supervisor password.'),
          NavigationEntry(
              key: 'BIOS Password At Boot Device List',
              value: ['Yes', 'No'],
              type: EntryType.selectable,
              description:
                  'If Yes and an Supervisor Password is set, the  user will be prompted for a password when F12 is pressed during POST.'),
          NavigationEntry(
              key: 'Smart USB Protection',
              value: ['Disabled', 'Read Only', 'No Access'],
              type: EntryType.selectable,
              description:
                  'Smart USB Protection could block copying data from the computer to the USB storage device in windows. Read Only mode: the user can copy data from USB storage device to the Computer but cannot copy data from the computer to USB storage device. No Access mode: the user cannot use USB storage device in windows'),
          NavigationEntry.branch(
            key: 'Hard Disk Password',
            description: 'Configure hard disk password',
            // type: EntryType.branch,
            icon: IconConfig.icons['Hard Disk Password'],
            children: [
              NavigationEntry(
                key: 'M.2 Drive 1 Password',
                value: 'Enter',
                description:
                    'Hard Disk Password prevents unauthorized users from accessing the data on the Hard Disk. In addition to the User Password,an optional Master Password can be used to recover the disk if the User Password is lost. NOTE: If several disks are present, suggest to set all Hard Disk Passwords to the same.',
                type: EntryType.leaf,
              ),
              NavigationEntry(
                key: 'SATA Drive 1 Password',
                value: 'Enter',
                description:
                    'Hard Disk Password prevents unauthorized users from accessing the data on the Hard Disk. In addition to the User Password,an optional Master Password can be used to recover the disk if the User Password is lost.NOTE: If several disks are present, suggest to set all Hard Disk Passwords to the same.',
                type: EntryType.leaf,
              ),
              NavigationEntry(
                key: 'SATA Drive 2 Password',
                value: 'Enter',
                description:
                    'Hard Disk Password prevents unauthorized users from accessing the data on the Hard Disk. In addition to the User Password,an optional Master Password can be used to recover the disk if the User Password is lost.NOTE: If several disks are present, suggest to set all Hard Disk Passwords to the same.',
                type: EntryType.leaf,
              ),
              NavigationEntry.branch(
                key: 'Security Erase HDD Data',
                description:
                    'Select this option to security erase HDD data. The items are only available when corresponding hard disk password is present.',
                // type: EntryType.branch,
                icon: IconConfig.icons['Security Erase HDD Data'],
                children: [
                  NavigationEntry(
                    key: 'Erase M.2 Drive 1 Data',
                    value: 'Enter',
                    description:
                        'Select this option to security erase HDD data.',
                    type: EntryType.leaf,
                  ),
                  NavigationEntry(
                    key: 'Erase SATA Drive 1 Data',
                    value: 'Enter',
                    description:
                        'Select this option to security erase HDD data.',
                    type: EntryType.leaf,
                  ),
                  NavigationEntry(
                    key: 'Erase SATA Drive 2 Data',
                    value: 'Enter',
                    description:
                        'Select this option to security erase HDD data.',
                    type: EntryType.leaf,
                  ),
                ],
              ),
            ],
          ),
          NavigationEntry.branch(
            key: 'TCG Feature Setup',
            description: 'Contains TCG security features',
            // type: EntryType.branch,
            icon: IconConfig.icons['TCG Feature Setup'],
            children: [
              NavigationEntry(
                key: 'TCG Security Device State',
                value: 'Firmware TPM 2.0',
                type: EntryType.leaf,
              ),
              NavigationEntry(
                key: 'Security Chip 2.0',
                value: ['Enter', 'Disabled'],
                description:
                    '<Enabled> When item enabled that TCG security/nfeature is full function. <Disabled> When item disabled TCG security feature is  no functional. NOTE: If set to "Disabled", the TxT will be set to "Disabled" automatically.',
                type: EntryType.selectable,
              ),
              NavigationEntry(
                key: 'Clear TCG Security Feature',
                value: ['No', 'Yes'],
                description:
                    'Select whether to clear TCG Security Feature. Warning: Any data in TPM will be cleared.',
                type: EntryType.selectable,
              ),
              NavigationEntry(
                key: 'Physical Presence for Clear',
                value: ['Enabled', 'Disabled'],
                description:
                    'This option enables or disables confirmation of a user\'s physical presence when clearing the security chip. <Enabled> Display user confirmation screen when clearing. <Disabled> No user confirmation screen when clearing.',
                type: EntryType.selectable,
              ),
            ],
          ),
          NavigationEntry.branch(
            key: 'System Event Log',
            description: 'View or clear the system event log.',
            // type: EntryType.branch,
            icon: IconConfig.icons['System Event Log'],
            children: [
              NavigationEntry.branch(
                key: 'View System Event Log',
                description: 'View or clear the system event log.',
                // type: EntryType.branch,
                icon: IconConfig.icons['System Event Log'],
                children: [
                  //Todo: hier müssten Logs zu sehen sein.
                ],
              ),
              NavigationEntry(
                key: 'Clear System Event Log',
                value: 'Enter',
                description: 'Clear the system event log',
                type: EntryType.leaf,
              ),
            ],
          ),
          NavigationEntry.branch(
              key: 'Secure Boot',
              description:
                  'Secure Boot flow control. Secure Boot is possible only if System runs in User Mode',
              // type: EntryType.branch,
              icon: IconConfig.icons['Secure Boot'],
              children: [
                NavigationEntry(
                  key: 'System Boot',
                  value: 'User Mode',
                  type: EntryType.leaf,
                ),
                NavigationEntry(
                    key: 'Secure Boot',
                    value: ['Enabled', 'Disabled'],
                    type: EntryType.selectable,
                    description:
                        '<Enabled> Enables Secure Boot,BIOS will prevent un-authorised OS be loaded.<Disabled> Disables Secure Boot.'),
                NavigationEntry(
                  key: 'Restore Factory Keys',
                  value: 'Enter',
                  description:
                      'Restore Factory Keys will put secure boot into factory defaults.',
                  type: EntryType.leaf,
                ),
                NavigationEntry(
                  key: 'Reset Platform to Setup Mode',
                  value: 'Enter',
                  description:
                      'Reset to setup mode will move secure boot to setup mode.',
                  type: EntryType.leaf,
                ),
                NavigationEntry(
                  key: 'Enter Audit Mode',
                  value: 'Enter',
                  description:
                      'Enter Audit Mode workflow. Transitions from User to Audit Mode will result in erasing of PK variable',
                  type: EntryType.leaf,
                ),
                NavigationEntry(
                  key: 'Enter Deployed Mode',
                  value: 'Enter',
                  description: 'Transition between Deployment and User Modes',
                  type: EntryType.leaf,
                ),
                NavigationEntry.branch(
                  key: 'Key Management',
                  description:
                      'Enables users to modify Secure Boot Policy variables.',
                  // type: EntryType.branch,
                  icon: IconConfig.icons['Key Management'],
                  children: [
                    //Todo: Text Simultor not supported
                  ],
                ),
              ]),
          NavigationEntry(
            key: 'Device Guard',
            value: ['Disabled', 'Enabled'],
            description:
                'Device Guard enables PCs to be protected against malware by introducing a collective set of restrictions on a device across several technologies. <Enabled> CPU Virtualization Technology be enabled, IOMMU, Such as Intel VT-d, AMD-Vi be enabled, Secure boot be enabled, TPM be enabled Ethernet, USB, CD, and other boot methods be disabled,only SATA device is allowed.<Disabled>Ethernet, USB, CD, and other boot methods be enabled.',
            type: EntryType.selectable,
          ),
          NavigationEntry(
            key: 'Cover Tamper Detected',
            value: ['Disabled', 'Enabled'],
            description:
                'Chassis Intrusion Detection is a utility that can tell whether someone has opened the case (intruded into the chassis).NOTE:If chassis tamper occurs, you can only enter setup to clear this error.',
            type: EntryType.selectable,
          ),
          NavigationEntry(
            key: 'Configuration Change Detection',
            value: ['Disabled', 'Enabled'],
            description:
                'If it is enabled, when a device is installed or remove, the system will notify the user during POST. This notice can only be cleared by entering BIOS setup, saving and then exiting',
            type: EntryType.selectable,
          ),
          NavigationEntry(
            key: 'Password Count Exceeded Error',
            value: ['Disabled', 'Enabled'],
            description:
                'Select Enabled to show the POST 0199 error and prompt for password. Select Disabled to hide the POST 0199 error and proceed without any user action required.',
            type: EntryType.selectable,
          ),
        ]);
  }
}
