import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/enums/video_types.dart';
import '../../../../../../core/utils/colors/colors.dart';
import '../../../../../../core/utils/notification/download_notification.dart';
import '../../../../../../core/utils/widgets/snackbars_widgets.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../01-auth/models/user_model.dart';
import '../../../data/models/video_downloaded_model.dart';
import '../../../domain/repo/video_downloader_repository.dart';

part 'add_link_state.dart';

class AddLinkCubit extends Cubit<AddLinkState> {
  AddLinkCubit() : super(AddLinkState.initial());

  static AddLinkCubit get(context) => BlocProvider.of(context, listen: false);

  // variables
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  VideoDownloadModel? videoDownloadModel;
  DownloadNotification flutterLocalNotificationsPlugin = DownloadNotification();

  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // for getBrandIcon function but it in void function
  void updateVideoType(VideoType videoType) {
    emit(getBrandIcon(videoType) as AddLinkState);
  }

  // get the type of link
  dynamic getBrandIcon(VideoType videoType) {
    switch (state.videoType) {
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

  // get the name of link
  String getFilePrefix(context) {
    switch (state.videoType) {
      case VideoType.facebook:
        return S.of(context).facebook;
      case VideoType.twitter:
        return S.of(context).twitter;
      case VideoType.youtube:
        return S.of(context).youtube;
      case VideoType.instagram:
        return S.of(context).insta;
      case VideoType.tiktok:
        return S.of(context).tictok;
      default:
        return S.of(context).unknown;
    }
  }

  void setVideoType(String url) {
    switch (url) {
      case String _ when url.contains("facebook.com") || url.contains("fb.watch") || url.contains("book"):
        emit(state.copyWith(videoType: VideoType.facebook));
        break;
      case String _ when url.contains("youtube.com") || url.contains("youtu.be"):
        emit(state.copyWith(videoType: VideoType.youtube));
        break;
      case String _ when url.contains("instagram.com"):
        emit(state.copyWith(videoType: VideoType.instagram));
        break;
      case String _ when url.contains("tiktok.com"):
        emit(state.copyWith(videoType: VideoType.tiktok));
        break;
      case String _ when url.contains("twitter.com"):
        emit(state.copyWith(videoType: VideoType.twitter));
        break;
      default:
        emit(state.copyWith(videoType: VideoType.non));
    }
  }

  // when I get download
  Future<void> performDownloading(String url, BuildContext context) async {
    emit(state.copyWith(isLoading: false));
    Dio dio = Dio();
    var permission = await [Permission.storage].request();

    if (permission[Permission.storage]!.isGranted) {
      var pathVideo;
      if (state.fileType.toString() == ".mp3") {
        pathVideo =
            "/storage/emulated/0/Download/Phonoi/PMusics/${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}${state.fileType}";
        state?.fileName ?? pathVideo;
      } else {
        pathVideo =
            "/storage/emulated/0/Download/Phonoi/PVideos/${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}${state.fileType}";
        state?.fileName ?? pathVideo;
      }
      print("path video: ${pathVideo}");
      print("file name: ${state.fileName}");
      try {
        emit(state.copyWith(isDownloading: true));
        await dio.download(
          url,
          pathVideo,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              // DownloadNotification.showProgressNotification(
              //   maxProgress: 100,
              //   title: "Downlaoding your video link...",
              //   body: pathVideo,
              //   progress: state.progressValue.toInt(),
              // );
              emit(state.copyWith(progressValue: (received / total * 100), fileName: pathVideo));
            }
          },
          deleteOnError: true,
        ).then((_) async {
          emit(state.copyWith(
            isDownloading: false,
            progressValue: 0.0,
            videoType: VideoType.non,
            isLoading: false,
            qualities: [],
            video: null,
          ));
          state.controller.text = "";
          // DownloadNotification.showNotification(
          //     title: "Downloading successfull!!", body: "Your video link is completing!!");
          await Future.delayed(Duration(milliseconds: 500));
          // await showSuccessSnackBar(S.of(context).downloading_completed, 2, context);
          await uploadToFirebaseStorage(context, url)
              .then((value) => showSuccessSnackBar(S.of(context).downloading_completed, 2, context));
        });
      } on DioException catch (e) {
        emit(state.copyWith(videoType: VideoType.non, isDownloading: false, qualities: [], video: null));
        showErrorSnackBar("Ooops! ${e.message}", 2, context);
      }
    } else {
      showErrorSnackBar("No permission to read and write", 2, context);
    }
  }

  // upload to firebase storage after download
  Future<void> uploadToFirebaseStorage(context, String link) async {
    print("upload to UID: ${user?.uid}");
    final linkId = const Uuid().v4();
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).collection("videos").add({
      'userId': user?.uid,
      'videoId': linkId,
      'title': state.video?.title,
      'thumbnail': state.video?.thumbnail,
      'source': state.video?.source,
      'videoLink': link,
      'video': state.fileType.toString() == ".mp3" ? "Music" : "Video",
      'createdAt': Timestamp.now(),
    }).then((value) {
      print("Upload is successfull!!");
      showSuccessSnackBar(S.of(context).downloading_completed, 2, context);
    }).catchError((onError, snackTrace) => print("Upload is Failed!! $onError"));
  }

  // when I pasted the link to show bottom model
  Future<void> onLinkPasted(String url, BuildContext context) async {
    // emit(state.copyWith(isLoading: true, isSearching: true));
    try {
      emit(state.copyWith(isSearching: true, isLoading: true));

      dynamic response = await VideoDownloaderRepository().call(url);
      final updatedQualities = List<VideoQualityModel>.from(state.qualities ?? []);
      emit(state.copyWith(video: response));
      if (response.title.isNotEmpty && response?.source != null && response?.thumbnail != null) {
        print("#########################################response title:" + response.title);
        for (var quality in response.videos) {
          updatedQualities.add(quality);
        }
        emit(state.copyWith(video: response, qualities: updatedQualities));
        showBottomModel(context);
      } else {
        showErrorSnackBar(S.of(context).check_link, 4, context);
        emit(state.copyWith(qualities: null));
      }
      emit(state.copyWith(isSearching: false, isLoading: false));
    } catch (error, snackTrace) {
      print("Error occurred: $error, $snackTrace");
    }
  }

  // download bottom model
  showBottomModel(BuildContext context) => showModalBottomSheet(
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
            final videoType = state.videoType;
            final video = state.video;

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
                              getBrandIcon(videoType),
                              color: CustomColors.white,
                              size: 26.w,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "${S.of(context).download_from + getFilePrefix(context)}",
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
                    Row(
                      children: [
                        video?.thumbnail != null
                            ? CachedNetworkImage(
                                imageUrl: video!.thumbnail,
                                height: 150.0,
                                width: 150.0,
                                placeholder: (context, url) =>
                                    Padding(padding: EdgeInsets.all(34), child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.video_library),
                              )
                            : Icon(Icons.error, size: 50, color: Colors.red),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AutoSizeText(
                            video?.title ?? S.of(context).download_failed,
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
                    Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            RadioListTile(
                              title: Text(
                                S.of(context).music_option,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              value: ".mp3",
                              groupValue: state.fileType,
                              onChanged: (String? value) {
                                setState(() => emit(state.copyWith(fileType: value!)));
                              },
                            ),
                            RadioListTile(
                              title: Text(
                                S.of(context).video_option,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              value: ".mp4",
                              groupValue: state.fileType,
                              onChanged: (String? value) {
                                setState(() => emit(state.copyWith(fileType: value!)));
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (state.isDownloading) {
                          showErrorSnackBar(S.of(context).download_failed, 2, context);
                        } else {
                          Navigator.pop(context);
                          await performDownloading(state.qualities![state.selectedQualityIndex].url!, context)
                              .then((value) {
                            uploadToFirebaseStorage(context, state.video!.title)
                                .then((value) => showSnackBar("success", 2, context))
                                .catchError((onError) => print(onError.toString()));
                          }).catchError((error) => print(error.toString()));
                        }
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            S.of(context).downloading_now,
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
            );
          },
        ),
      );
}
