import 'package:flutter/material.dart';

class DownloadSettingsScreen extends StatelessWidget {
  const DownloadSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اعدادات التنزيلات"),
        centerTitle: true,
      ),
    );
  }
}
