// Navigation model with predefined items
import 'package:uefi_simulator/model/navigation_item.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_devices.dart';
import 'package:uefi_simulator/navigationitems/navigationitem_home.dart';

class NavigationModel {
  List<NavigationItem> items = [
     MainNavigationItem.buildItem(),
    DevicesNavigationItem.buildItem(),
    // Add more NavigationItems here as needed
  ];
}
