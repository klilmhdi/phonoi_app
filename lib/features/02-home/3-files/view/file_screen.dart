import 'package:flutter/material.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';
import 'package:phonoi_app/features/02-home/3-files/view/file_manager_screen.dart';

import '../../../../core/utils/widgets/icon_column_sidgets.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الملفات',
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 19),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/downloads_screen"),
                    child: Container(
                      height: 62,
                      width: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'التنزيلات',
                                  style: TextStyle(color: Color(0xff8C52FF), fontSize: 18),
                                ),
                                Text(
                                  ' سرعة وسهولة',
                                  style: TextStyle(color: Color(0xff7E7E7E), fontSize: 12),
                                ),
                              ],
                            ),
                            Icon(Icons.download, size: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => navTo(context, FileManagerScreen()),
                    child: Container(
                      height: 62,
                      width: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' التخزين',
                                    style: TextStyle(color: Color(0xff00124D), fontSize: 18),
                                  ),
                                  Text(
                                    ' قم بمنح الاذن',
                                    style: TextStyle(color: Color(0xff7E7E7E), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.phone_iphone, size: 40),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 17),
              Container(
                height: 135,
                width: 347,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xff9B9B9B),
                      width: 1,
                    )),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.only(start: 17, end: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconColumnWidgets(
                              icon: Icon(
                                Icons.play_circle,
                                color: Colors.purple,
                              ),
                              nameIcon: "الفيديوهات",
                              count: "0"),
                          IconColumnWidgets(
                              icon: Icon(
                                Icons.music_note,
                                color: Colors.red,
                              ),
                              nameIcon: "الموسيقى",
                              count: "0"),
                          IconColumnWidgets(
                              icon: Icon(
                                Icons.description,
                                color: Colors.yellow,
                              ),
                              nameIcon: "المستندات",
                              count: "0"),
                          IconColumnWidgets(
                              icon: Icon(
                                Icons.photo,
                                color: Colors.indigo,
                              ),
                              nameIcon: "الصور",
                              count: "0"),
                          IconColumnWidgets(
                              icon: Icon(
                                Icons.window_rounded,
                                color: Colors.green,
                              ),
                              nameIcon: "الملفات المضغوطة",
                              count: "0"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 17, end: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const IconColumnWidgets(
                              icon: Icon(
                                Icons.android,
                                color: Colors.green,
                              ),
                              nameIcon: "التطبيقات",
                              count: "0"),
                          const IconColumnWidgets(
                              icon: Icon(
                                Icons.language,
                                color: Colors.purple,
                              ),
                              nameIcon: "الصفحات",
                              count: "0"),
                          const IconColumnWidgets(
                              icon: Icon(
                                Icons.whatshot,
                                color: Colors.green,
                              ),
                              nameIcon: "whatsApp",
                              count: "0"),
                          IconColumnWidgets(
                              icon: Icon(
                                Icons.description,
                                color: Colors.grey.shade700,
                              ),
                              nameIcon: "أخرى",
                              count: "0"),
                          IconColumnWidgets(
                              icon: Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.indigo.shade900,
                              ),
                              nameIcon: " المزيد",
                              count: "0"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 112,
                width: 347,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xff9B9B9B),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'الأخيرة',
                            style: TextStyle(fontSize: 19, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () => print("clicked"),
                            child: const Text(
                              "المزيد >",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.picture_as_pdf,
                              color: Color(0xffD13F00),
                            ),
                            iconSize: 56,
                          ),
                          const Column(
                            children: [
                              Text(
                                "Question1.pdf",
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                "تم الفتح أمس 13:04",
                                style: TextStyle(fontSize: 9, color: Color(0xff909090)),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 21),
            ],
          ),
        ),
      ),
    );
  }
}
