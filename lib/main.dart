// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uefi_simulator/bios_page.dart';
import 'package:uefi_simulator/controller/storage_service.dart';
import 'package:uefi_simulator/controller/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>(
          create: (_) => StorageService(),
        ),
         ChangeNotifierProvider<SettingsModel>(
            create: (context) => SettingsModel(),
         ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIOS Setup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BIOSPage(),
    );
  }
}