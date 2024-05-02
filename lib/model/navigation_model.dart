// Navigation model with predefined items
import 'package:uefi_simulator/model/navigation_item.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_advanced.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_devices.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_exit.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_home.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_power.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_security.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_startup.dart';

class NavigationModel {
  List<NavigationItem> items = [
    MainNavigationItem.buildItem(),
    DevicesNavigationItem.buildItem(),
    AdvancedNavigationItem.buildItem(),
    PowerNavigationItem.buildItem(),
    SecurityNavigationItem.buildItem(),
    StartupNavigationItem.buildItem(),
    ExitNavigationItem.buildItem(),
    // Add more NavigationItems here as needed
  ];
}
