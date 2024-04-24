// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';

class SystemTimeAndDatePage extends StatefulWidget {
  const SystemTimeAndDatePage({super.key});

  @override
  SystemTimeAndDatePageState createState() {
    return SystemTimeAndDatePageState();
  }
}

class SystemTimeAndDatePageState extends State<SystemTimeAndDatePage> {
  DateTime currentTime = DateTime.now();
  Timer? timeUpdater;

  @override
  void initState() {
    super.initState();
    timeUpdater = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timeUpdater?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('System Time & Date'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('System Time (HH:MM:SS)'),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimeBox('${currentTime.hour}'.padLeft(2, '0')),
                SizedBox(width: 8.0),
                _buildTimeBox('${currentTime.minute}'.padLeft(2, '0')),
                SizedBox(width: 8.0),
                _buildTimeBox('${currentTime.second}'.padLeft(2, '0')),
              ],
            ),
            SizedBox(height: 24.0),
            Text('System Date (MM/DD/YYYY)'),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDateBox('${currentTime.day}'.padLeft(2, '0')),
                SizedBox(width: 8.0),
                _buildDateBox('${currentTime.month}'.padLeft(2, '0')),
                SizedBox(width: 8.0),
                _buildDateBox('${currentTime.year}'),
              ],
            ),
            // Add more content as needed
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDateBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
