import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English';

  void handleLanguageChange(String language) => setState(() {
      selectedLanguage = language;
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحديد اللغة'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('الإنجليزية'),
            leading: Radio(
              value: 'English',
              groupValue: selectedLanguage,
              onChanged: (value)=> handleLanguageChange,
            ),
          ),
          ListTile(
            title: Text('العربية'),
            leading: Radio(
              value: 'Arabic',
              groupValue: selectedLanguage,
              onChanged: (value)=> handleLanguageChange,
            ),
          ),
        ],
      ),
    );
  }
}
