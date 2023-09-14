import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phonoi_app/features/02-home/3-files/manage/files_screen/files_cubit.dart';

import '../../../../core/utils/functions/functions.dart';
import '../../../../core/utils/widgets/icon_column_sidgets.dart';
import '../../../../generated/l10n.dart';
import '../widgets/compressed_files/CompressedFiles.dart';
import '../widgets/document_viewer/document_viewer.dart';
import '../widgets/gallery/Image_viewer_screen.dart';
import '../widgets/get_app/get_app.dart';
import '../widgets/instagram_media/instagram_image.dart';
import '../widgets/music_player/music_list_screen.dart';
import '../widgets/video/video_list.dart';
import '../widgets/whatsapp_media/whatsapp_image.dart';
import 'file_manager_screen.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilesCubit()
        ..fetchAssets()
        ..fetchAssetsVideo()
        ..fetchMusic()
        ..fetchAssetsWhatsapp()
        ..fetchAssetsInsta(),
      child: BlocBuilder<FilesCubit, FilesState>(builder: (context, state) {
        final cubit = FilesCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).files,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      S.of(context).downloads,
                                      style: TextStyle(color: Color(0xff8C52FF), fontSize: 18),
                                    ),
                                    Icon(Icons.download, size: 30),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      S.of(context).storage,
                                      style: TextStyle(color: Color(0xff00124D), fontSize: 18),
                                    ),
                                    Icon(Icons.phone_iphone, size: 30),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 17),
                      // مربع فيه ايقونات
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: .5,
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 17, end: 17),
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(top: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconColumnWidgets(
                                      icon: FaIcon(
                                        FontAwesomeIcons.solidCirclePlay,
                                        color: Colors.purple,
                                      ),
                                      onPressed: () async {
                                        var perm = await Permission.storage.request();
                                        if (perm.isGranted) {
                                          Get.to(
                                            () => VideoView(),
                                            // transition: Transition.downToUp,
                                          );
                                        } else {
                                          cubit.checkPermission();
                                        }
                                      },
                                      nameIcon: S.of(context).videos,
                                      count: "${cubit.assetsVideo.length}",
                                    ),
                                    IconColumnWidgets(
                                      onPressed: () async {
                                        var perm = await Permission.storage.request();
                                        if (perm.isGranted) {
                                          Get.to(
                                            () => MusicPlayerListScreen(),
                                            // transition: Transition.rightToLeft,
                                          );
                                        } else {
                                          cubit.checkPermission();
                                        }
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.music,
                                        color: Colors.pink.shade400,
                                      ),
                                      nameIcon: S.of(context).musics,
                                      count: "${cubit.musicLength}",
                                    ),
                                    IconColumnWidgets(
                                        onPressed: () async {
                                          var perm = await Permission.storage.request();
                                          if (perm.isGranted) {
                                            cubit.pickFile();
                                            Get.to(
                                              () => DocumentViewer(),
                                              // transition: Transition.rightToLeft,
                                            );
                                          } else {
                                            cubit.checkPermission();
                                          }
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.solidFileLines,
                                          color: Colors.yellow.shade600,
                                        ),
                                        nameIcon: S.of(context).documents,
                                        count: "0"),
                                    IconColumnWidgets(
                                        onPressed: () async {
                                          var perm = await Permission.storage.request();
                                          if (perm.isGranted) {
                                            Get.to(
                                              () => GalleryViewerScreen(),
                                              // transition: Transition.leftToRight,
                                            );
                                          } else {
                                            cubit.checkPermission();
                                          }
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.solidImage,
                                          color: Colors.blue.shade400,
                                        ),
                                        nameIcon: S.of(context).pictures,
                                        count: "${cubit.assetsImage.length}"),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 17, end: 17, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconColumnWidgets(
                                      onPressed: () async {
                                        var perm = await Permission.storage.request();
                                        if (perm.isGranted) {
                                          cubit.pickFileApk();
                                          Get.to(
                                            () => GetApp(),
                                            // transition: Transition.leftToRight,
                                          );
                                        } else {
                                          cubit.checkPermission();
                                        }
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.android,
                                        color: Colors.greenAccent.shade400,
                                      ),
                                      nameIcon: S.of(context).apps,
                                      count: "0"),
                                  IconColumnWidgets(
                                    onPressed: () async {
                                      var perm = await Permission.storage.request();
                                      if (perm.isGranted) {
                                        Get.to(
                                          () => WhatsappImage(),
                                          // transition: Transition.downToUp,
                                        );
                                      } else {
                                        cubit.checkPermission();
                                      }
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                    ),
                                    nameIcon: S.of(context).whatsapp,
                                    count: "${cubit.assetsByDateWhatsapp.length}",
                                  ),
                                  IconColumnWidgets(
                                      onPressed: () async {
                                        var perm = await Permission.storage.request();
                                        if (perm.isGranted) {
                                          Get.to(
                                            () => InstagramImage(),
                                            // transition: Transition.downToUp,
                                          );
                                        } else {
                                          cubit.checkPermission();
                                        }
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.pink,
                                      ),
                                      nameIcon: S.of(context).instegram,
                                      count: "${cubit.assetsByDateInsta.length}"),
                                  IconColumnWidgets(
                                      onPressed: () async {
                                        var perm = await Permission.storage.request();
                                        if (perm.isGranted) {
                                          Get.to(
                                            () => CompressedFiles(),
                                            // transition: Transition.leftToRight,
                                          );
                                        } else {
                                          cubit.checkPermission();
                                        }
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.tableList,
                                        color: Colors.purpleAccent,
                                      ),
                                      nameIcon: S.of(context).compreseds,
                                      count: "0"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
