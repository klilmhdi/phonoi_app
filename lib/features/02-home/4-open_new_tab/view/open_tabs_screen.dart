import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class OpenTabsScreen extends StatelessWidget {
  const OpenTabsScreen({super.key});

  void _openPopupWindow(BuildContext context) async {
    try {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_LAYOUT_IN_SCREEN);

      // Open a popup window using showDialog()
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Popup Window'),
            content: Text('This is a popup window.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error opening popup window: $e");
    } finally {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_LAYOUT_IN_SCREEN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () => _openPopupWindow(context),
            child: Text('Open Popup Window'),
          ),
        ),
      ),
    );
  }
}
