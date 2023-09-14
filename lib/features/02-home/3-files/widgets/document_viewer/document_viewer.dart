import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DocumentViewer extends StatefulWidget {
   DocumentViewer({super.key});

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  List<File> files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    print("asffffffffffff");
    List<String> allowedExtensions = ['.pdf', '.doc', '.xml'];
    print("asfdfdsffffffffffff");
    try {
      // Directory? appDir = await getExternalStorageDirectory();
      // String? appDir = '/storage/emulated/0/Android/media/com.whatsApp/WhatsApp/Media/WhatsApp Documents/';
      Directory directory = Directory('/storage/emulated/0/Android/media/com.whatsApp/WhatsApp/Media/WhatsApp Documents/');
      if (await directory.exists()) {
        List<FileSystemEntity> entities = directory.listSync();

        for (FileSystemEntity entity in entities) {
          if (entity is File) {
            String fileExtension = entity.path.split('.').last.toLowerCase();
            if (allowedExtensions.contains('.$fileExtension')) {
              setState(() {
                files.add(entity);
              });
            }
          }
          print(files);
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 36,
            ),
          ),
        ],
        title: Text(
          ' المستندات',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(files[index].path.split('/').last),
            onTap: () {
              // قم بتنفيذ الإجراء المناسب هنا (مثل فتح الملف أو إجراء آخر)
            },
          );
        },
      ),
    );
  }
}
