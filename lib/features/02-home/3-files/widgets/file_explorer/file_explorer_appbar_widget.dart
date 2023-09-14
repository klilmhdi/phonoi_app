import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppBar buildFileExplorerAppBar(BuildContext context, controller) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () => createFolder(context, controller),
        icon: Icon(Icons.create_new_folder_outlined),
      ),
      IconButton(
        onPressed: () => sort(context, controller),
        icon: Icon(Icons.sort_rounded),
      ),
      IconButton(
        onPressed: () => selectStorage(context, controller),
        icon: Icon(Icons.sd_storage_rounded),
      )
    ],
    title: ValueListenableBuilder<String>(
      valueListenable: controller.titleNotifier,
      builder: (context, title, _) => title.toString() == "0" ? Text("التخزين") : Text(title),
    ),
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () async {
        await controller.goToParentDirectory();
      },
    ),
  );
}

Future<void> selectStorage(BuildContext context, controller) async {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: FutureBuilder<List<Directory>>(
        future: FileManager.getStorageList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<FileSystemEntity> storageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: storageList
                      .map((e) => ListTile(
                            title: Text(
                              "${FileManager.basename(e)}",
                            ),
                            onTap: () {
                              controller.openDirectory(e);
                              Navigator.pop(context);
                            },
                          ))
                      .toList()),
            );
          }
          return Dialog(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
  );
}

sort(BuildContext context, controller) async {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                title: Text("الإسم"),
                onTap: () {
                  controller.sortBy(SortBy.name);
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("حجم الملف"),
                onTap: () {
                  controller.sortBy(SortBy.size);
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("تاريخ الإنشاء"),
                onTap: () {
                  controller.sortBy(SortBy.date);
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("النوع"),
                onTap: () {
                  controller.sortBy(SortBy.type);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    ),
  );
}

createFolder(BuildContext context, controller) async {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController folderName = TextEditingController();
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("قم بإدخال اسم المجلد"),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: folderName,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "الرجاء ملء الحقل كاملاً";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Create Folder
                      await FileManager.createFolder(controller.getCurrentPath, folderName.text);
                      // Open Created Folder
                      controller.setCurrentPath = controller.getCurrentPath + "/" + folderName.text;
                    } catch (e) {}

                    Navigator.pop(context);
                  },
                  child: Text('إنشاء المجلد'),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
