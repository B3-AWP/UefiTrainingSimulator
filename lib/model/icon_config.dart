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
    'Serial Port Setup': Icons.settings_input_component ,
    'Parallel Port Setup': Icons.paragliding_outlined,
    'USB Setup': Icons.usb,
    'Advanced': Icons.build_circle ,
    'Dust Shield Alert': Icons.warning_amber_rounded  ,
    'AMD Secure Virtual Machine': Icons.security ,
    'IOMMU': Icons.memory ,
    'CPB Mode': Icons.speed ,
    'C State Support': Icons.power_settings_new ,
    'Power': Icons.power ,
    'After Power Loss': Icons.restore ,
    'Intelligent Cooling': Icons.ac_unit ,
    'Security': Icons.security ,
    'Automatic Power On': Icons.schedule ,
    'Hard Disk Password': Icons.disc_full ,
    'Security Erase HDD Data': Icons.security ,
    'TCG Feature Setup': Icons.security ,
    'System Event Log': Icons.event,
    'Secure Boot': Icons.security,
    'Key Management': Icons.key,
    'Startup': Icons.start,
    'Exit': Icons.exit_to_app,
  };
}