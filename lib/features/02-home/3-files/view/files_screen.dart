import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:phonoi_app/features/02-home/3-files/widgets/document_viewer/document_viewer.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../core/utils/functions/functions.dart';
import '../../../../core/utils/widgets/icon_column_sidgets.dart';
import '../../../../generated/l10n.dart';
import '../widgets/compressed_files/CompressedFiles.dart';
import '../widgets/gallery/Image_viewer_screen.dart';
import '../widgets/get_app/get_app.dart';
import '../widgets/instagram_media/instagram_image.dart';
import '../widgets/music_player/music_list_screen.dart';
import '../widgets/video/video_list.dart';
import '../widgets/whatsapp_media/whatsapp_image.dart';
import 'file_manager_screen.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? filePath;

  OnAudioQuery onAudioQuery = OnAudioQuery();
  late var musicLength = 0;

  void fetchMusic() async {
    final audioFiles = await onAudioQuery.querySongs();
    final numberOfAudioFiles = audioFiles.length;
    musicLength = numberOfAudioFiles;
    print('Number of audio files: $numberOfAudioFiles');
  }

  List<AssetEntity> assetsImage = [];
  List<AssetEntity> assetsVideo = [];
  Map<DateTime, List<AssetEntity>> assetsByDateInsta = {};
  Map<DateTime, List<AssetEntity>> assetsByDateWhatsapp = {};

  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: false, type: RequestType.image);
    final recentAlbum = albums.first;
    final recentAssets =
        await recentAlbum.getAssetListRange(start: 0, end: 100000); // Get 100 assets, increase the end for more.
    if (mounted) {
      setState(() {
        assetsImage = recentAssets;
      });
    }
  }

  _fetchAssetsVideo() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: false, type: RequestType.video);
    final recentAlbum = albums.first;
    final recentAssets =
        await recentAlbum.getAssetListRange(start: 0, end: 100000); // Get 100 assets, increase the end for more.
    if (mounted) {
      setState(() {
        assetsVideo = recentAssets;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAssetsVideo();
    fetchMusic();
    _fetchAssetsInsta();
    _fetchAssetsWhatsapp();
    _fetchAssets();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                                      // Get.to(
                                      //   () => VideoView(),
                                      //   transition: Transition.downToUp,
                                      // );
                                      navTo(context, VideoView());
                                    } else {
                                      checkPermission();
                                    }
                                  },
                                  nameIcon: S.of(context).videos,
                                  count: "${assetsVideo.length}",
                                ),
                                IconColumnWidgets(
                                  onPressed: () async {
                                    var perm = await Permission.storage.request();
                                    if (perm.isGranted) {
                                      // Get.to(
                                      //   () => MusicPlayerListScreen(),
                                      //   transition: Transition.rightToLeft,
                                      // );
                                      navTo(context, MusicPlayerListScreen());
                                    } else {
                                      checkPermission();
                                    }
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.music,
                                    color: Colors.pink.shade400,
                                  ),
                                  nameIcon: S.of(context).musics,
                                  count: "$musicLength",
                                ),
                                IconColumnWidgets(
                                    onPressed: () async {
                                      var perm = await Permission.storage.request();
                                      if (perm.isGranted) {
                                        pickFile();
                                        // Get.to(
                                        //   () => DocumentViewer(),
                                        //   transition: Transition.rightToLeft,
                                        // );
                                        navTo(context, navTo(context, VideoView()));
                                      } else {
                                        checkPermission();
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
                                        // Get.to(
                                        //   () => GalleryViewerScreen(),
                                        //   transition: Transition.leftToRight,
                                        // );
                                        navTo(context, GalleryViewerScreen());
                                      } else {
                                        checkPermission();
                                      }
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.solidImage,
                                      color: Colors.blue.shade400,
                                    ),
                                    nameIcon: S.of(context).pictures,
                                    count: "${assetsImage.length}"),
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
                                      pickFileApk();
                                      // Get.to(
                                      //   () => GetApp(),
                                      //   transition: Transition.leftToRight,
                                      // );
                                      navTo(context, GetApp());
                                    } else {
                                      checkPermission();
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
                                    // Get.to(
                                    //   () => WhatsappImage(),
                                    //   transition: Transition.downToUp,
                                    // );
                                    navTo(context, WhatsappImage());
                                  } else {
                                    checkPermission();
                                  }
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                ),
                                nameIcon: S.of(context).whatsapp,
                                count: "${assetsByDateWhatsapp.length}",
                              ),
                              IconColumnWidgets(
                                  onPressed: () async {
                                    var perm = await Permission.storage.request();
                                    if (perm.isGranted) {
                                      // Get.to(
                                      //   () => InstagramImage(),
                                      //   transition: Transition.downToUp,
                                      // );
                                      navTo(context, InstagramImage());
                                    } else {
                                      checkPermission();
                                    }
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: Colors.pink,
                                  ),
                                  nameIcon: S.of(context).instegram,
                                  count: "${assetsByDateInsta.length}"),
                              IconColumnWidgets(
                                  onPressed: () async {
                                    var perm = await Permission.storage.request();
                                    if (perm.isGranted) {
                                      // Get.to(
                                      //   () => CompressedFiles(),
                                      //   transition: Transition.leftToRight,
                                      // );
                                      navTo(context, CompressedFiles());
                                    } else {
                                      checkPermission();
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
  }

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }

  _fetchAssetsInsta() async {
    final albums = await PhotoManager.getAssetPathList(
      onlyAll: false,
      type: RequestType.image,
    );

    Map<DateTime, List<AssetEntity>> tempAssetsByDate = {};

    for (var album in albums) {
      final assets = await album.getAssetListRange(
        start: 0,
        end: 100000,
      );

      for (var asset in assets) {
        // تحقق مما إذا كانت الصورة من Instagram
        if (asset.relativePath!.toLowerCase().contains('instagram')) {
          final dateTime = asset.createDateTime ?? DateTime.now();
          final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

          // Check if the date is already in the map, if not, create a new list
          if (!tempAssetsByDate.containsKey(dateOnly)) {
            tempAssetsByDate[dateOnly] = [];
          }

          // Add the asset to the list corresponding to its capture date
          tempAssetsByDate[dateOnly]!.add(asset);
        }
      }
    }

    if (mounted) {
      setState(() {
        assetsByDateInsta = tempAssetsByDate;
      });
    }
  }

  _fetchAssetsWhatsapp() async {
    final albums = await PhotoManager.getAssetPathList(
      onlyAll: false,
      type: RequestType.image,
    );

    Map<DateTime, List<AssetEntity>> tempAssetsByDate = {};

    for (var album in albums) {
      final assets = await album.getAssetListRange(
        start: 0,
        end: 100000,
      );

      for (var asset in assets) {
        // تحقق مما إذا كانت الصورة من Instagram
        if (asset.relativePath!.toLowerCase().contains('whatsapp')) {
          final dateTime = asset.createDateTime ?? DateTime.now();
          final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

          // Check if the date is already in the map, if not, create a new list
          if (!tempAssetsByDate.containsKey(dateOnly)) {
            tempAssetsByDate[dateOnly] = [];
          }

          // Add the asset to the list corresponding to its capture date
          tempAssetsByDate[dateOnly]!.add(asset);
        }
      }
    }

    if (mounted) {
      setState(() {
        assetsByDateWhatsapp = tempAssetsByDate;
      });
    }
  }

  @override
  void dispose() {
    _fetchAssetsVideo();
    _fetchAssetsInsta();
    _fetchAssetsWhatsapp();
    _fetchAssets();
    fetchMusic();
    super.dispose();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'xls', 'ppt', 'txt', 'epub', 'xlsx'],
    );

    if (result != null) {
      print("&*&&&&&&&&&&&&***************${result}");
      setState(() {
        filePath = result.files.single.path;
      });

      if (filePath != null) {
        OpenFile.open(filePath!);
      }
    }
  }

  void pickFileApk() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });

      if (filePath != null) {
        OpenFile.open(filePath!);
      }
    }
  }
}
