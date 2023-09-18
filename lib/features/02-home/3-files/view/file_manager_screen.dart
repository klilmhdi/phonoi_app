import 'dart:io';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import '../widgets/file_explorer/file_explorer_appbar_widget.dart';
import '../widgets/file_explorer/file_explorer_subtitle_widget.dart';

class FileManagerScreen extends StatelessWidget {
  final FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return ControlBackButton(
      controller: controller,
      child: Scaffold(
        appBar: buildFileExplorerAppBar(context, controller),
        body: FileManager(
          controller: controller,
          builder: (context, snapshot) {
            final List<FileSystemEntity> entities = snapshot;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              itemCount: entities.length,
              itemBuilder: (context, index) {
                FileSystemEntity entity = entities[index];
                return Card(
                  child: ListTile(
                    leading: FileManager.isFile(entity) ? Icon(Icons.feed_outlined) : Icon(Icons.folder),
                    title: Text(FileManager.basename(
                      entity,
                      showFileExtension: true,
                    )),
                    subtitle: subtitle(entity),
                    onTap: () async {
                      if (FileManager.isDirectory(entity)) {
                        controller.openDirectory(entity);
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
