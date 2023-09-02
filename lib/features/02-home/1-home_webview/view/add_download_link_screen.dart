import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/core/utils/notification/download_notification.dart';
import 'package:phonoi_app/features/02-home/1-home_webview/manage/add_link/add_link_cubit.dart';

import '../../../../core/enums/video_types.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/widgets/snackbars_widgets.dart';

class AddLinkDownloadedScreen extends StatefulWidget {
  const AddLinkDownloadedScreen({super.key});

  @override
  State<AddLinkDownloadedScreen> createState() => _AddLinkDownloadedScreenState();
}

class _AddLinkDownloadedScreenState extends State<AddLinkDownloadedScreen> {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    DownloadNotification.init(plugin);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddLinkCubit(),
      child: BlocConsumer<AddLinkCubit, AddLinkState>(
        builder: (context, state) {
          AddLinkCubit linkCubit = AddLinkCubit.get(context);
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
                    controller: linkCubit.state.controller,
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
                      prefix: Icon(
                        linkCubit.getBrandIcon(linkCubit.state.videoType),
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
                            if (linkCubit.state.isSearching) {
                              showErrorSnackBar("Try again later! Searching in progress", 2, context);
                            } else if (linkCubit.state.isDownloading) {
                              showErrorSnackBar("Try again later! Downloading in progress", 2, context);
                            } else {
                              Clipboard.getData(Clipboard.kTextPlain).then((value) async {
                                bool _hasString = await Clipboard.hasStrings();
                                if (_hasString) {
                                  if (linkCubit.state.controller.text == value!.text) {
                                    linkCubit.showBottomModel(context);
                                  } else {
                                    linkCubit.state.copyWith(
                                      selectedQualityIndex: 0,
                                      videoType: VideoType.non,
                                      isLoading: false,
                                      qualities: [],
                                      video: null,
                                    );
                                    linkCubit.state.copyWith(isLoading: true);
                                    linkCubit.state.controller.text = "";
                                    linkCubit.state.controller.text = value.text!;
                                    if (value.text!.isEmpty || linkCubit.state.controller.text.isEmpty) {
                                      showErrorSnackBar("Please Enter Video URl", 2, context);
                                    } else {
                                      linkCubit.setVideoType(value.text!);
                                      print("#################${value.text!}");
                                      linkCubit.state.copyWith(isSearching: true);
                                      await linkCubit.onLinkPasted(value.text!, context);
                                    }
                                  }
                                } else {
                                  showErrorSnackBar("Empty Content pasted! Please try again", 2, context);
                                }
                                linkCubit.state.copyWith(isLoading: false);
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
                          onPressed: () => DownloadNotification().showNotification(title: "title", body: "body", plugin: plugin),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                "اعرض الاشعار ",
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
                            if (linkCubit.state.isDownloading) {
                              showErrorSnackBar("يتم الان عملية تنزيل آخرى , حاول فيما بعد", 2, context);
                            } else {
                              linkCubit.state.copyWith(
                                selectedQualityIndex: 0,
                                videoType: VideoType.non,
                                isLoading: false,
                                qualities: [],
                                video: null,
                              );
                              linkCubit.state.controller.text = "";
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
                  state.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : !linkCubit.state.isDownloading
                          ? (linkCubit.state.qualities != null && linkCubit.state.qualities!.isNotEmpty)
                              ? SizedBox.shrink()
                              : linkCubit.state.qualities == null
                                  ? Text(
                                      "hmm, this link look too complicated for me or either i dont supported i yet.... can you try another one? ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: CustomColors.white,
                                      ),
                                    )
                                  : SizedBox.shrink()
                          : SizedBox.shrink(),
                  linkCubit.state.isDownloading ? SizedBox(height: 20.h) : SizedBox(height: 10.h),
                  linkCubit.state.isDownloading
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
                                            "يتم الآن التنزيل",
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
                                        // linkCubit.state.fileName.substring(1),
                                        linkCubit.state?.fileName.toString() ?? "",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: CustomColors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${linkCubit.state.progressValue.toStringAsFixed(0)}%",
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
                                value: (linkCubit.state.progressValue / 100),
                                minHeight: 6.h,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: CustomColors.appBar,
                          ),
                        )
                      : SizedBox.shrink(),
                  linkCubit.state.isDownloading ? SizedBox(height: 20.h) : SizedBox.shrink(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
