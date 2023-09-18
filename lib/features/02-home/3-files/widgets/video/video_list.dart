import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoView extends StatefulWidget {
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  Map<String, List<AssetEntity>> assetsByDate = {};
  Set<AssetEntity> selectedImages = Set<AssetEntity>();

  @override
  void initState() {
    super.initState();
    _fetchAssets();
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
      type: RequestType.video,
    );
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 100000,
    );

    final Map<String, List<AssetEntity>> sortedAssets = {};

    for (final asset in recentAssets) {
      final dateTime = asset.createDateTime;
      final dateKey = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
      if (!sortedAssets.containsKey(dateKey)) {
        sortedAssets[dateKey] = [];
      }
      sortedAssets[dateKey]!.add(asset);
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
            color: Colors.black,
          ),
        ),
        title: Text(
          'مقاطع الفيديو',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          if (selectedImages.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
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
              ),
              onPressed: () {
                // تنفيذ الحذف للصور المحددة
                _shareSelectedImages(selectedImages.toList());
              },
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: assetsByDate.length,
        itemBuilder: (BuildContext context, int index) {
          final dateKey = assetsByDate.keys.elementAt(index);
          final dateAssets = assetsByDate[dateKey]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  dateKey, // عرض التاريخ فوق كل حزمة
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemCount: dateAssets.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  AssetEntity asset = dateAssets[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      FutureBuilder<Uint8List?>(
                        future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
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
                                  _previewAsset(asset);
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
                              ));
                        },
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            _formatDuration(asset.videoDuration),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  _previewAsset(AssetEntity asset) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      if (asset.type == AssetType.video) {
        return VideoScreen(asset: asset);
      }
      // return ImageScreen(asset: asset);
      return CircularProgressIndicator();
    }));
  }
}

//###########################################################################

class VideoScreen extends StatefulWidget {
  final AssetEntity asset;

  const VideoScreen({Key? key, required this.asset}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  bool _showScaffold = false;

  double _volume = 1.0;
  bool _isMuted = false;
  double _currentPosition = 0.0;
  bool _isFullScreen = false;
  bool _videoEnded = false;
  double appBarPosition = -kToolbarHeight;
  bool showBars = false;

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        if (!_videoEnded) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        }
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : _volume);
    });
  }

  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _initVideoPlayer();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _showScaffold = true;
        _currentPosition = 0.0;
      });
      _controller.addListener(() {
        setState(() {
          _currentPosition = _controller.value.position.inSeconds.toDouble();
        });
        if (_controller.value.position >= _controller.value.duration) {
          setState(() {
            _videoEnded = true;

            // قم بتغيير توجيه الشاشة إلى الوضع الرأسي (Portrait)
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
          });
        }
      });
    });
  }

  _initVideoPlayer() async {
    final file = await widget.asset.file;
    _controller = VideoPlayerController.file(file!)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  void toggleBars() {
    setState(() {
      showBars = !showBars;
      appBarPosition = showBars ? 0 : -kToolbarHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showScaffold
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: _controller.value.isInitialized
                  ? Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            toggleBars();
                          },
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: MediaQuery.of(context).orientation == Orientation.portrait
                                  ? _controller.value.aspectRatio
                                  : _controller.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Positioned.fill(
                                    child: VideoPlayer(_controller),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          top: showBars ? 0 : appBarPosition,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            _videoEnded = true;
                                            // قم بتغيير توجيه الشاشة إلى الوضع الرأسي (Portrait)
                                            SystemChrome.setPreferredOrientations([
                                              DeviceOrientation.portraitUp,
                                            ]);
                                          });

                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${widget.asset.title}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: _toggleFullScreen,
                                  icon: Icon(
                                    _isFullScreen ? Icons.rotate_90_degrees_ccw : Icons.rotate_90_degrees_cw,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          bottom: showBars ? 0 : appBarPosition,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_formatDuration(Duration(seconds: _currentPosition.toInt()))}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Expanded(
                                      child: Slider(
                                        thumbColor: Colors.white,
                                        inactiveColor: Colors.white54,
                                        activeColor: Colors.white,
                                        value: _currentPosition,
                                        min: 0,
                                        max: _controller.value.duration.inSeconds.toDouble(),
                                        onChanged: (value) {
                                          setState(() {
                                            _currentPosition = value;
                                            _controller.seekTo(Duration(seconds: value.toInt()));
                                          });
                                        },
                                      ),
                                    ),
                                    Text(
                                      ' ${_formatDuration(_controller.value.duration)}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: _togglePlayPause,
                                      icon: Icon(
                                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 38,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _toggleMute,
                                      icon: Icon(
                                        _isMuted ? Icons.volume_off : Icons.volume_up,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(),
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    WakelockPlus.disable();
  }
}
