import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/enums/video_types.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/notification/download_notification.dart';
import '../../../../../core/utils/widgets/snackbars_widgets.dart';
import '../../../../../generated/l10n.dart';
import '../../models/video_downloaded_model.dart';
import '../../repo/video_downloader_repository.dart';
import '../../widgets/video_type_quality_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'add_link_state.dart';

class AddLinkCubit extends Cubit<AddLinkState> {
  AddLinkCubit()
      : super(AddLinkState.initial().copyWith(
          controller: TextEditingController(),
          progressValue: 0.0,
          isDownloading: false,
          qualities: [],
          video: null,
          isLoading: false,
          selectedQualityIndex: 0,
          fileName: '',
          isSearching: false,
          videoType: VideoType.non,
          fileType: ".mp4",
        ));

  static AddLinkCubit get(context) => BlocProvider.of(context, listen: false);

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

  Future<void> uploadToFirebaseStorage(String filePath) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("links")
          .child(state.video?.title.toString() ?? ""); // Replace with your desired storage path and filename

      await storageRef.putFile(File(filePath));

      // Now, you can access the uploaded video's URL if needed
      final String downloadURL = await storageRef.getDownloadURL();
      print("Uploaded video URL: $downloadURL");

      // You can save the URL to Firestore or perform other actions as needed.
      // For example, if you have a Firestore document representing the video metadata:
      // firestore.collection('videos').doc('your_document_id').update({
      //   'videoURL': downloadURL,
      // });
    } catch (e) {
      print("Error uploading video: $e");
    }
  }

  // when I get download
  Future<void> performDownloading(String url, context) async {
    emit(state.copyWith(isLoading: true));
    Dio dio = Dio();
    var permission = await [Permission.storage].request();

    if (permission[Permission.storage]!.isGranted) {
      var pathVideo =
          "/storage/emulated/0/Phonoi/PVideos/${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}${state.fileType}";
      print(pathVideo);
      try {
        emit(state.copyWith(isDownloading: true));
        await dio.download(
          url,
          pathVideo,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              emit(state.copyWith(progressValue: (received / total * 100)));
            }
          },
          deleteOnError: true,
        ).then((_) {
          emit(state.copyWith(
            isDownloading: false,
            progressValue: 0.0,
            videoType: VideoType.non,
            isLoading: false,
            qualities: [],
            video: null,
          ));
          state.controller.text = "";
          showSuccessSnackBar("تم تنزيل الفيديو بنجاح", 2, context);
        });
      } on DioException catch (e) {
        emit(state.copyWith(videoType: VideoType.non, isDownloading: false, qualities: [], video: null));
        showErrorSnackBar("Ooops! ${e.message}", 2, context);
      }
    } else {
      showErrorSnackBar("No permission to read and write", 2, context);
    }
  }

  // when I pasted the link to show bottom model
  Future<void> onLinkPasted(String url, BuildContext context) async {
    // emit(state.copyWith(isLoading: true, isSearching: true));
    try {
      emit(state.copyWith(isSearching: true, isLoading: true));

      final response = await VideoDownloaderRepository().getAvailableVideos(url);
      final updatedQualities = List<VideoQualityModel>.from(state.qualities ?? []);
      emit(state.copyWith(video: response));
      if (response != null) {
        for (var quality in response.videos!) {
          updatedQualities.add(quality);
        }
        emit(state.copyWith(video: response, qualities: updatedQualities));
        showBottomModel(context);
      } else {
        emit(state.copyWith(qualities: null));
      }

      emit(state.copyWith(isSearching: false, isLoading: false));
    } catch (error) {
      print("Error occurred: $error");
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
                                imageUrl: video!.thumbnail!,
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
                            video?.title! ?? S.of(context).download_failed,
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
                    // Wrap(
                    //   children: List.generate(
                    //     state.qualities?.length ?? 0,
                    //     (index) => VideoQualityCard(
                    //         type: state.videoType,
                    //         isSelected: state.selectedQualityIndex == index,
                    //         model: state.qualities![index],
                    //         onTap: () async {
                    //           state.copyWith(selectedQualityIndex: index);
                    //         }),
                    //   ),
                    // ),
                    // SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (state.isDownloading) {
                          showErrorSnackBar("Try again later! Downloading in progress.", 2, context);
                        } else {
                          Navigator.pop(context);
                          await performDownloading(state.qualities![state.selectedQualityIndex].url!, context)
                              .then((value) {
                            DownloadNotification.showNotification(title: "title", body: "body");
                          });
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
