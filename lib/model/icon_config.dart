// Define a class to manage icons centrally
import 'package:flutter/material.dart';

class IconConfig {
  static const Map<String, IconData> icons = {
    'Main': Icons.home,
    'Devices': Icons.settings,
    'System Summary': Icons.memory,
    'CPU Speed': Icons.speed,
    'System Time (HH:MM:SS)': Icons.timer,
    'System Date (MM/DD/YYYY)': Icons.calendar_today,
    'Language': Icons.language,
    'Serial Port Setup': Icons.account_circle_rounded,
    'Parallel Port Setup': Icons.add_to_photos_rounded,
    'USB Setup': Icons.usb,
  };
}