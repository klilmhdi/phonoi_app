import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../../../generated/l10n.dart';
import 'instagram_video.dart';

class InstagramImage extends StatefulWidget {
  @override
  _InstagramImageState createState() => _InstagramImageState();
}

class _InstagramImageState extends State<InstagramImage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<AssetEntity> assets = [];
  Map<DateTime, List<AssetEntity>> assetsByDate = {};
  Set<AssetEntity> selectedImages = Set<AssetEntity>();

  @override
  void initState() {
    super.initState();
    _fetchAssets();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  Future<void> _shareSelectedImages(List<AssetEntity> selectedAssets) async {
    List<XFile> xFiles = [];

    for (var asset in selectedAssets) {
      final file = await asset.file;
      if (file != null) {
        xFiles.add(XFile(file.path));
      } else {
        print('Failed to get file for asset: ${asset.title}');
      }
    }

    if (xFiles.isNotEmpty) {
      await Share.shareXFiles(xFiles);
    } else {
      print('No valid files to share');
    }
    setState(() {
      selectedImages.clear();
    });
  }


  Future<void> _deleteSelectedImages() async {
    List<String> deletedImageIds = [];

    for (var asset in selectedImages) {
      try {
        final result = await PhotoManager.editor.deleteWithIds([asset.id]);
        deletedImageIds.addAll(result);
        print("تم حذف الصورة بنجاح: ${asset.title}");
        for (var dateAssets in assetsByDate.values) {
          dateAssets.removeWhere((element) => element == asset);
        }
      } catch (e) {
        print("فشل في حذف الصورة: $e");
      }
    }
    // قم بإعادة تعيين القائمة المحددة بعد الحذف
    setState(() {
      selectedImages.clear();
    });
  }

  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(
      onlyAll: false,
      type: RequestType.image,
    );
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 100000,
    );

    final Map<DateTime, List<AssetEntity>> sortedAssets = {};

    for (final asset in recentAssets) {
      final dateTime = asset.createDateTime;
      final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

      // تحقق مما إذا كان اسم الصورة يحتوي على كلمة "whatsapp"
      if (asset.relativePath!.toLowerCase().contains('instagram')) {
        if (!sortedAssets.containsKey(dateOnly)) {
          sortedAssets[dateOnly] = [];
        }
        sortedAssets[dateOnly]!.add(asset);
      }
    }

    if (mounted) {
      setState(() {
        assetsByDate = sortedAssets;
      });
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
          title: Text(
            S.of(context).instegram,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            if (selectedImages.isNotEmpty)
              IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  // تنفيذ الحذف للصور المحددة
                  _deleteSelectedImages();
                },
              ),
            if (selectedImages.isNotEmpty)
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  // تنفيذ الحذف للصور المحددة
                  _shareSelectedImages(selectedImages.toList());
                },
              ),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.indigo,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              controller: _tabController,
              tabs: [
                Tab(
                  text: S.of(context).pic,
                ),
                Tab(
                  text: S.of(context).videos,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 5),
                    child: ListView.builder(
                      itemCount: assetsByDate.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dates = assetsByDate.keys.toList()
                          ..sort((a, b) => b.compareTo(a));
                        final date = dates[index];
                        final dateAssets = assetsByDate[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // عرض تاريخ الصور
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat.yMMMMd().format(date),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // عرض الصور لهذا التاريخ
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3,
                              ),
                              itemCount: dateAssets.length,
                              itemBuilder: (BuildContext context, int index) {
                                AssetEntity asset = dateAssets[index];
                                return FutureBuilder<Uint8List?>(
                                  future:
                                  asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
                                  builder: (_, snapshot) {
                                    final bytes = snapshot.data;
                                    if (bytes == null)
                                      return Center(
                                        child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    return GestureDetector(
                                      onLongPress: () {
                                        setState(() {
                                          if (selectedImages.contains(asset)) {
                                            selectedImages.remove(asset);
                                          } else {
                                            selectedImages.add(asset);
                                          }
                                        });
                                      },
                                      onTap: () {
                                        if (selectedImages.isNotEmpty) {
                                          setState(() {
                                            if (selectedImages.contains(asset)) {
                                              selectedImages.remove(asset);
                                            } else {
                                              selectedImages.add(asset);
                                            }
                                          });
                                        } else {
                                          _previewAsset(asset, assetsByDate);
                                        }
                                      },
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.memory(bytes, fit: BoxFit.cover),
                                          if (selectedImages.contains(asset))
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              // left: 0,
                                              child: Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue,
                                                  ),
                                                  // padding: EdgeInsets.all(8),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  InstagramVideo(),
                ],
              ),
            ),
          ],
        ));
  }

  _previewAsset(AssetEntity asset, assetsByDate) async {
    final deleted =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      if (asset.type == AssetType.video) {
        return VideoScreen(asset: asset);
      }
      return ImageScreen(asset: asset, assetsByDate: assetsByDate);
    }));

    if (deleted != null && deleted) {
      // تحديث واجهة الـ GridView عند العودة من شاشة العرض
      setState(() {});
    }
  }
}
//################################################################################################

class VideoScreen extends StatefulWidget {
  final AssetEntity asset;

  const VideoScreen({Key? key, required this.asset}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  _initVideoPlayer() async {
    final file = await widget.asset.file;
    _controller = VideoPlayerController.file(file!)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video')),
      body: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class ImageScreen extends StatefulWidget {
  final AssetEntity asset;
  final Map<DateTime, List<AssetEntity>> assetsByDate;

  const ImageScreen({Key? key, required this.asset, required this.assetsByDate})
      : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  double maxScale = 5.0;
  double scale = 1.0;
  Offset position = Offset(0, 0);
  Offset startPosition = Offset(0, 0);
  Size imageSize = Size(0, 0);
  bool showBars = false;
  double appBarPosition = -kToolbarHeight;
  bool _imageDeleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: showBars ? Colors.black : Colors.white,
        appBar: null,
        body: Stack(
          children: [
            FutureBuilder<File?>(
              future: widget.asset.file,
              builder: (_, snapshot) {
                final file = snapshot.data;
                if (file == null)
                  return CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  );
                return PhotoView(
                  imageProvider: FileImage(file),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  enableRotation: false,
                  // initialScale: 1.0,
                  onTapUp: (context, details, controllerValue) {
                    // تبديل إظهار الشرائط عند الضغط على الصورة
                    toggleBars();
                  },
                  backgroundDecoration: BoxDecoration(
                    color: showBars ? Colors.black : Colors.white,
                  ),
                );
              },
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: showBars ? 0 : appBarPosition,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "${widget.asset.title}",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                centerTitle: true,
              ),
            ),
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                bottom: showBars ? 0 : appBarPosition,
                left: 0,
                right: 0,
                child: BottomAppBar(
                  color: Colors.white, // لون الشريط السفلي
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _deleteImage();
                          },
                          icon: Icon(Icons.delete,size: 32,),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            // يمكنك إضافة إجراءات أخرى هنا
                            _shareImage(widget.asset);
                          },
                          icon: Icon(Icons.share,size: 32,),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }

  Future<void> _deleteImage() async {
    try {
      final result = await PhotoManager.editor.deleteWithIds([widget.asset.id]);
      if (result.isNotEmpty) {
        // تم حذف الصورة بنجاح
        print('تم حذف الصورة بنجاح: ${widget.asset.title}');
        widget.assetsByDate.forEach((date, assetsList) {
          assetsList.removeWhere((asset) => asset.id == widget.asset.id);
        });
        setState(() {
          _imageDeleted = true;
        });
        Navigator.pop(context, true);
      } else {
        // فشل في حذف الصورة
        print('فشل في حذف الصورة');
      }
    } catch (e) {
      print('فشل في حذف الصورة: $e');
    }
  }

  void toggleBars() {
    setState(() {
      showBars = !showBars;
      appBarPosition = showBars ? 0 : -kToolbarHeight;
    });
  }
  Future<void> _shareImage(AssetEntity asset) async {
    final file = await asset.file;
    if (file != null) {
      final xFile = XFile(file.path); // Convert File to XFile
      await Share.shareXFiles([xFile]); // Share list of XFiles
    } else {
      print('Failed to share the image');
    }
  }
}
