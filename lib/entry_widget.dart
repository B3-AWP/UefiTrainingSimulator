// mainPage.dart
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uefi_simulator/controller/storage.dart';
import 'package:uefi_simulator/model/navigation_entry.dart';

class EntryWidget extends StatefulWidget {
  final NavigationEntry entry;
  final Future<void> Function(String key, String value) onSaveSelectedOption;
  final Future<String?> Function(String key) getSavedOption;

  EntryWidget(
      {required this.entry,
      required this.onSaveSelectedOption,
      required this.getSavedOption});

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialization logic here, if necessary
  }

  @override
  Widget build(BuildContext context) {
    // Using Provider to fetch the value that might be updated
    return FutureBuilder<String?>(
      future: widget.getSavedOption(widget.entry.key), // Asynchronous operation call
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while data is being loaded
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error handling if something goes wrong
          return Text('Error: ${snapshot.error}');
        } else {
          // When data is loaded, display the value in a DropdownButton
          String? currentValue = snapshot.data;
          bool isSelectable = widget.entry.type == EntryType.selectable;
          bool isClickable = widget.entry.type == EntryType.clickable;

          return widget.entry.isLeaf
              ? ListTile(
                  title: Text(widget.entry.key),
                  subtitle: Text(widget.entry.description),
                  leading: widget.entry.icon != null ? Icon(widget.entry.icon) : null,
                  onTap: isClickable ? _handleClick : null,
                  trailing: isSelectable
                      ? _buildDropdown(currentValue) 
                      : (isClickable ? Icon(Icons.touch_app) : Text(currentValue ?? widget.entry.value ?? "")),
                )
              : ExpansionTile(
                  title: Text(widget.entry.key),
                  leading: widget.entry.icon != null ? Icon(widget.entry.icon) : null,
                  subtitle: Text(widget.entry.description),
                  children: widget.entry.children.map((child) => EntryWidget(
                    entry: child,
                    onSaveSelectedOption: widget.onSaveSelectedOption,
                    getSavedOption: widget.getSavedOption,
                  )).toList(),
                );
        }
      },
    );
  }

  void _handleClick() {
    if (widget.entry.type == EntryType.clickable && widget.entry.onTap != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(widget.entry.key), // The headline
            content: Text(widget.entry.description), // Descriptive text
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Abrrechen'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  widget.entry.onTap!(); // Perform the onTap action if available
                },
                child: Text('Bestätigen'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildDropdown(String? currentValue) {
    return DropdownButton<String>(
      value: currentValue ?? (widget.entry.value.isNotEmpty ? widget.entry.value.first : null),
      items: widget.entry.value.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          widget.onSaveSelectedOption(widget.entry.key, newValue).then((_) {
            Provider.of<SettingsModel>(context, listen: false).updateSetting(widget.entry.key, newValue);
          });
          setState(() {
            currentValue = newValue;
          });
        }
      },
    );
  }
}
