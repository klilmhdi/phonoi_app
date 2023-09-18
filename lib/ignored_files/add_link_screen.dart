import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/enums/video_types.dart';
import '../core/utils/colors/colors.dart';
import '../core/utils/notification/download_notification.dart';
import '../features/02-home/01-home_webview/data/models/video_downloaded_model.dart';
import '../features/02-home/01-home_webview/domain/repo/video_downloader_repository.dart';
import '../features/02-home/01-home_webview/presentation/widgets/video_type_quality_widget.dart';

class AddDownloadUrlScreen extends StatefulWidget {
  AddDownloadUrlScreen({super.key, required this.onDownloadCompleted});

  final VoidCallback onDownloadCompleted;

  @override
  State<AddDownloadUrlScreen> createState() => _AddDownloadUrlScreenState();
}

class _AddDownloadUrlScreenState extends State<AddDownloadUrlScreen> {
  final _controller = TextEditingController();
  var _progressVale = 0.0;
  var _isDownloading = false;
  List<VideoQualityModel>? _qualities = [];
  VideoDownloadModel? _video;
  bool _isLoading = false;
  int _selectedQualityIndex = 0;
  String _fileName = '';
  bool _isSearching = false;
  VideoType _videoType = VideoType.non;
  String fileType = ".mp4";

  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    DownloadNotification.init();
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
          'اضافة رابط التنزيل',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 15, end: 15, top: 46),
        child: Column(
          children: [
            SizedBox(
              height: 140,
              // width: 345,
              child: TextField(
                textAlign: TextAlign.end,
                controller: _controller,
                onTap: () {},
                minLines: null,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    _getBrandIcon,
                    color: CustomColors.primary,
                  ),
                  fillColor: const Color(0xffEBEBEB),
                  filled: true,
                  hintText: "لصق رابط التنزيل من المصدر",
                  hintStyle: TextStyle(
                    color: const Color(0xff5D5D5D),
                    // fontSize: 13.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_isSearching) {
                      _showSnackBar("Try again later! Searching in progress", 2);
                    } else if (_isDownloading) {
                      _showSnackBar("Try again later! Downloading in progress", 2);
                    } else {
                      Clipboard.getData(Clipboard.kTextPlain).then((value) async {
                        bool _hasString = await Clipboard.hasStrings();
                        if (_hasString) {
                          if (_controller.text == value!.text) {
                            _showBottomModel();
                          } else {
                            setState(() {
                              _selectedQualityIndex == 0;
                              _videoType = VideoType.non;
                              _isLoading = false;
                              _qualities = [];
                              _video = null;
                              _isLoading = true;
                            });
                            _controller.text = "";
                            _controller.text = value.text!;
                            if (value.text!.isEmpty || _controller.text.isEmpty) {
                              _showSnackBar("Please Enter Video URl", 2);
                            } else {
                              _setVideoType(value.text!);
                              print("#################${value.text!}");
                              setState(() => _isSearching = true);
                              await _onLinkPasted(value.text!);
                            }
                          }
                        } else {
                          _showSnackBar("Empty Content pasted! Please try again", 2);
                        }
                        setState(() => _isLoading = false);
                      });
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        "اضغظ للصق الرابط ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff8C52FF)),
                    minimumSize: MaterialStateProperty.all(Size(170, 45)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.w),
                ElevatedButton(
                  onPressed: () async {
                    if (_isDownloading) {
                      _showSnackBar("Try again later! Downloading in progress", 2);
                    } else {
                      setState(() {
                        _selectedQualityIndex = 0;
                        _videoType = VideoType.non;
                        _isLoading = false;
                        _qualities = [];
                        _video = null;
                      });
                      _controller.text = "";
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        "حذف الرابط",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff8C52FF)),
                    minimumSize: MaterialStateProperty.all(Size(170, 45)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : !_isDownloading
                    ? (_qualities != null && _qualities!.isNotEmpty)
                        ? Container()
                        : _qualities == null
                            ? Text(
                                "hmm, this link look too complicated for me or either i dont supported i yet.... can you try another one? ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.white,
                                ),
                              )
                            : Container()
                    : Container(),
            _isDownloading ? SizedBox(height: 20.h) : SizedBox(height: 10.h),
            _isDownloading
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.downloading,
                                      color: CustomColors.primary,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Downloading",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: CustomColors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  _fileName.substring(1),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${_progressVale.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 20,
                                color: CustomColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        LinearProgressIndicator(
                          value: (_progressVale / 100),
                          minHeight: 6.h,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: CustomColors.appBar,
                    ),
                  )
                : Container(),
            _isDownloading ? SizedBox(height: 20.h) : Container(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  IconData? get _getBrandIcon {
    switch (_videoType) {
      case VideoType.facebook:
        return FontAwesome.facebook;
      case VideoType.twitter:
        return FontAwesome.twitter;
      case VideoType.youtube:
        return FontAwesome.youtube_play;
      case VideoType.instagram:
        return FontAwesome.instagram;
      case VideoType.tiktok:
        return const IconData(0xf058c, fontFamily: 'MaterialIcons');
      default:
        return null;
    }
  }

  String? get _getFilePrefix {
    switch (_videoType) {
      case VideoType.facebook:
        return "Facebook";
      case VideoType.twitter:
        return "Twitter";
      case VideoType.youtube:
        return "Youtube";
      case VideoType.instagram:
        return "Instagram";
      case VideoType.tiktok:
        return "Tiktok";
      default:
        return null;
    }
  }

  void _setVideoType(String url) {
    if (url.isEmpty) {
      setState(() => _videoType = VideoType.non);
    } else if (url.contains("facebook.com") || url.contains("fb.watch") || url.contains("book")) {
      setState(() => _videoType = VideoType.facebook);
    } else if (url.contains("youtube.com") || url.contains("youtu.be")) {
      setState(() => _videoType = VideoType.youtube);
    } else if (url.contains("twitter.com")) {
      setState(() => _videoType = VideoType.twitter);
    } else if (url.contains("instagram.com")) {
      setState(() => _videoType = VideoType.instagram);
    } else if (url.contains("tiktok.com")) {
      setState(() => _videoType = VideoType.tiktok);
    } else {
      setState(() => _videoType = VideoType.non);
    }
  }

  _showSnackBar(String title, int duration) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        margin: EdgeInsets.all(15.w),
        backgroundColor: CustomColors.primary,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: CustomColors.white,
              size: 30.w,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performDownloading(String url) async {
    Dio dio = Dio();
    var permission = await [Permission.storage].request();

    if (permission[Permission.storage]!.isGranted) {
      var dir = await getExternalStorageDirectory();
      // if (fileType == ".mp3") {
      //   pathVideo = "/storage/emulated/0/Download/Phonoi_Music/$_fileName";
      // } else {
      //   pathVideo = "/storage/emulated/0/Download/Phonoi_Video/$_fileName";
      // }
      setState(() {
        _fileName = "/$_getFilePrefix-${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}$fileType";
      });
      var pathVideo = "/storage/emulated/0/Download/Phonoi/$_fileName";
      print(pathVideo);
      try {
        setState(() => _isDownloading = true);
        await dio.download(
          url,
          pathVideo,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() async {
                _progressVale = (received / total * 100);
                DownloadNotification.showProgressNotification(
                  progress: _progressVale.toInt(),
                  maxProgress: 100,
                  title: "Downlaoding...",
                  body: "Phonoi App",
                );
                Future.delayed(Duration(milliseconds: 1500));
                await DownloadNotification.cancelAllNotifications();
              });
            }
          },
          deleteOnError: true,
        ).then((_) {
          widget.onDownloadCompleted();
          setState(() {
            _isDownloading = false;
            _progressVale = 0.0;
            _videoType = VideoType.non;
            _isLoading = false;
            _qualities = [];
            _video = null;
          });
          _controller.text = "";
          _showSnackBar("Video downloading successfully", 2);
        });
      } on DioError catch (e) {
        setState(() {
          _videoType = VideoType.non;
          _isDownloading = false;
          _qualities = [];
          _video = null;
        });
        _showSnackBar("Ooops! ${e.message}", 2);
      }
    } else {
      _showSnackBar("No permission to read and write", 2);
    }
  }

  Future<void> _onLinkPasted(String url) async {
    var _response = await VideoDownloaderRepository().call(url);
    setState(() => _video = _response);
    if (_video != null) {
      print("************${_video}");
      for (var _quality in _video!.videos!) {
        _qualities!.add(_quality);
      }
      _showBottomModel();
    } else {
      _qualities = null;
    }
    setState(
      () => _isSearching = false,
    );
  }

  _showBottomModel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColors.appBar,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.w),
          topRight: Radius.circular(15.w),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "اختر نوع الملف الذي تود تنزيل الرابط به ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: CustomColors.primary,
                      size: 26.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ListTile(
                title: Text(
                  "أغنية (بأعلى جودة)",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                leading: Radio(
                  value: ".mp3",
                  groupValue: fileType,
                  onChanged: (String? value) {
                    setState(() {
                      fileType = value!;
                    });
                  },
                  activeColor: CustomColors.primary,
                ),
              ),
              ListTile(
                title: Text(
                  "فيديو (أعلى جودة)",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                leading: Radio(
                  value: ".mp4",
                  groupValue: fileType,
                  onChanged: (String? value) {
                    setState(() {
                      fileType = value!;
                    });
                  },
                  activeColor: CustomColors.primary,
                ),
              ),
              Row(
                children: [
                  Icon(
                    _getBrandIcon,
                    color: CustomColors.primary,
                    size: 26.w,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Downloading from ${_getFilePrefix!}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: CustomColors.white,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(
                    FontAwesome.video,
                    color: CustomColors.primary,
                    size: 26.w,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      _video?.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Wrap(
                children: List.generate(
                  _qualities?.length ?? 0,
                  (index) => VideoQualityCard(
                      type: _videoType,
                      isSelected: _selectedQualityIndex == index,
                      model: _qualities![index],
                      onTap: () async {
                        setState(() => _selectedQualityIndex = index);
                      }),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () async {
                  if (_isDownloading) {
                    _showSnackBar("Try again later! Downloading in progress.", 2);
                  } else {
                    Navigator.pop(context);
                    await _performDownloading(_qualities![_selectedQualityIndex].url!).then((value) {});
                    DownloadNotification.showNotification(title: "title", body: "body");
                  }
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      "Download This Video",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: CustomColors.appBar,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomColors.primary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

// enum FileType { mp3, mp4 }
// FileType _selectedFileType = FileType.mp4; // افتراضيًا تحميل mp4
