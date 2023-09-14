import 'dart:io';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class Thumbnail extends StatefulWidget {
  final String path;
  final VideoData data;
  final VoidCallback onVideoDeleted;

  const Thumbnail({
    Key? key,
    required this.path,
    required this.data,
    required this.onVideoDeleted,
  }) : super(key: key);

  @override
  State<Thumbnail> createState() => _ThumbnailState();
}

class _ThumbnailState extends State<Thumbnail> {
  VideoPlayerController? _controller;
  String? _timeago;

  @override
  void initState() {
    var date = (widget.data.title!.split("-"))[1].substring(0, 8);
    var time = (widget.data.title!.split("-"))[1].substring(8);
    _timeago = timeago.format(DateTime.parse("${date}T$time"));
    var file = File(widget.path);
    _controller = VideoPlayerController.file(file)
      ..addListener(() {})
      ..setLooping(false)
      ..initialize().then((value) {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        children: [
          SizedBox(
            width: 110.w,
            height: 95.h,
            child: ClipRRect(
              child: (_controller != null && _controller!.value.isInitialized)
                  ? VideoPlayer(_controller!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _timeago!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "From ${widget.data.title!.substring(0, widget.data.title!.indexOf('-'))}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  FileSize.getSize((widget.data.filesize as int)),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () async {
                  await Share.shareFiles([widget.path]);
                },
                icon: Icon(
                  FontAwesome5.share,
                  color: Colors.white,
                  size: 16.w,
                ),
              ),
              IconButton(
                onPressed: () => widget.onVideoDeleted(),
                icon: Icon(
                  FontAwesome5.trash,
                  color: Colors.white,
                  size: 16.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
