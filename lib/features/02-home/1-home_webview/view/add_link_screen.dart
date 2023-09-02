import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';
import '../../../../core/enums/video_types.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/widgets/snackbars_widgets.dart';
import '../models/video_downloaded_model.dart';
import '../models/video_quality_model.dart';
import '../repo/video_downloader_repository.dart';

class AddUrlScreen extends StatefulWidget {
  AddUrlScreen({super.key, required this.onDownloadCompleted});

  final VoidCallback onDownloadCompleted;

  @override
  State<AddUrlScreen> createState() => _AddUrlScreenState();
}

class _AddUrlScreenState extends State<AddUrlScreen> {
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
  String sharedUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      _handleLink(initialLink!);
    } catch (e) {
      print('Error initializing UniLinks: $e');
    }

    getLinksStream().listen((String? link) {
      if (link != null) {
        _handleLink(link);
      }
    });
  }

  void _handleLink(String link) {
    setState(() {
      sharedUrl = link;
    });
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
            TextFormField(
              controller: _controller,
              onTap: () {},
              readOnly: true,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 80.h, maxWidth: 347.w),
                fillColor: const Color(0xffEBEBEB),
                filled: true,
                hintText: "قم بوضع الرابط المراد تنزيله هنا",
                hintStyle: TextStyle(
                  color: const Color(0xff5D5D5D),
                  fontSize: 13.sp,
                ),
                prefixIcon: Icon(
                  _getBrandIcon,
                  color: CustomColors.primary,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isSearching) {
                        showErrorSnackBar("Try again later! Searching in progress", 2, context);
                      } else if (_isDownloading) {
                        showErrorSnackBar("Try again later! Downloading in progress", 2, context);
                      } else {
                        Clipboard.getData(Clipboard.kTextPlain).then((value) async {
                          bool _hasString = await Clipboard.hasStrings();
                          if (_hasString) {
                            if (_controller.text == value!.text) {
                              showBottomModel(context);
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
                                showErrorSnackBar("Please Enter Video URl", 2, context);
                              } else {
                                _setVideoType(value.text!);
                                print("#################${value.text!}");
                                setState(() => _isSearching = true);
                                await _onLinkPasted(value.text!);
                              }
                            }
                          } else {
                            showErrorSnackBar("Empty Content pasted! Please try again", 2, context);
                          }
                          setState(() => _isLoading = false);
                        });
                      }
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          "اضغط للصق الرابط ",
                          style: TextStyle(
                            fontSize: 14,
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
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_isDownloading) {
                        showErrorSnackBar("Try again later! Downloading in progress", 2, context);
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
                            fontSize: 14,
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
                                      "يتم الان التنزيل",
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
            Text("shared url: ${sharedUrl}")
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
        return "فيسبوك";
      case VideoType.twitter:
        return "تويتر";
      case VideoType.youtube:
        return "يوتيوب";
      case VideoType.instagram:
        return "انستجرام";
      case VideoType.tiktok:
        return "تيكتوك";
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

  Future<void> _performDownloading(String url, context) async {
    Dio dio = Dio();
    var permission = await [Permission.storage].request();

    if (permission[Permission.storage]!.isGranted) {
      setState(() {
        _fileName = "/$_getFilePrefix-${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}$fileType";
      });
      var pathVideo = "/storage/emulated/0/Download/$_fileName";
      print(pathVideo);
      try {
        setState(() => _isDownloading = true);
        await dio.download(
          url,
          pathVideo,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() => _progressVale = (received / total * 100));
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
          showSnackBar("تم تنزيل الفيديو بنجاح", 2, context);
        });
      } on DioException catch (e) {
        setState(() {
          _videoType = VideoType.non;
          _isDownloading = false;
          _qualities = [];
          _video = null;
        });
        showErrorSnackBar("Ooops! ${e.message}", 2, context);
      }
    } else {
      showErrorSnackBar("No permission to read and write", 2, context);
    }
  }

  Future<void> _onLinkPasted(String url) async {
    var _response = await VideoDownloaderRepository().getAvailableVideos(url);
    setState(() => _video = _response);
    if (_video != null) {
      print("************${_video}");
      for (var _quality in _video!.videos!) {
        _qualities!.add(_quality);
      }
      showBottomModel(context);
    } else {
      _qualities = null;
    }
    setState(
      () => _isSearching = false,
    );
  }

  showBottomModel(context) => showModalBottomSheet(
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
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getBrandIcon,
                              color: CustomColors.white,
                              size: 26.w,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "التنزيل من: ${_getFilePrefix}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: CustomColors.white,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close_rounded,
                            color: CustomColors.primary,
                            size: 26.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        _video?.thumbnail == null
                            ? Icon(
                                Icons.video_library,
                                size: 30.0,
                              )
                            : Image.network(_video!.thumbnail!, height: 150.0, width: 150.0),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AutoSizeText(
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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_isDownloading) {
                                showErrorSnackBar("حاول مرة آخرى, عند انتهاء التحميل", 2, context);
                              } else {
                                Navigator.pop(context);
                                await _performDownloading(_qualities![_selectedQualityIndex].url!, context)
                                    .then((value) {});
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  "تنزيل الرابط كصوت",
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
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
                        ),
                        SizedBox(width: 10.h),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_isDownloading) {
                                showErrorSnackBar("حاول مرة آخرى, عند انتهاء التحميل", 2, context);
                              } else {
                                Navigator.pop(context);
                                await _performDownloading(_qualities![_selectedQualityIndex].url!, context)
                                    .then((value) {});
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  "تنزيل الرابط كفيديو",
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
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
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
