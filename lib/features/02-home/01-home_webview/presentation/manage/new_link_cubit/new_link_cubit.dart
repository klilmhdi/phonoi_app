import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/enums/music_types.dart';
import '../../../../../../core/enums/video_types.dart';
import '../../../../../../core/helpers/request_state/enum-request-state.dart';
import '../../../../../../core/utils/colors/colors.dart';
import '../../../../../../core/utils/widgets/snackbars_widgets.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../01-auth/models/user_model.dart';
import '../../../data/models/video_downloaded_model.dart';
import '../../../domain/repo/video_downloader_repository.dart';
import 'new_link_cubit.dart';

part 'new_link_state.dart';

class NewLinkCubit extends Cubit<NewLinkState> {
  NewLinkCubit() : super(NewLinkState());
  late TextEditingController linkController;

  // variables
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  VideoDownloadModel? videoDownloadModel;

  Future<void> init() async {
    linkController = TextEditingController();
  }

  @override
  Future<void> close() {
    linkController.dispose();
    return super.close();
  }

  ///==========================================> Getter Methods
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

  ///============================================> Setter Methods
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // for getBrandIcon function but it in void function
  void updateVideoTypeSetter(VideoType videoType) {
    emit(state.copyWith(videoType: videoType));
  }

//========================================> set Video Type
  void setVideoType({required String url}) {
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
    emit(state.copyWith(videoLoadingState: RequestState.loading));
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
      // print("path video: ${pathVideo}");
      // print("file name: ${state.fileName}");
      try {
        emit(state.copyWith(
          videoLoadingState: RequestState.loading,
        ));
        await dio.download(
          url,
          pathVideo,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              emit(state.copyWith(progressValue: (received / total * 100), fileName: pathVideo));
            }
          },
          deleteOnError: true,
        ).then((_) async {
          emit(state.copyWith(
            downloadingState: RequestState.done,
            progressValue: 0.0,
            videoType: VideoType.non,
            videoLoadingState: RequestState.done,
            videoDownloadModel: VideoDownloadModel.empty(),
          ));
          emit(state.copyWith(linkContent: ""));
          await Future.delayed(Duration(milliseconds: 500));
          uploadToFirebaseStorage(url);
        });
      } on DioException catch (e) {
        emit(
          state.copyWith(
              videoType: VideoType.non,
              downloadingState: RequestState.done,
              videoDownloadModel: VideoDownloadModel.empty()),
        );
        showErrorSnackBar("Ooops! ${e.message}", 2, context);
      }
    } else {
      showErrorSnackBar("No permission to read and write", 2, context);
    }
  }

  ///==========================================>>  download bottom model
  showBottomModel(BuildContext context) {
    return showModalBottomSheet(
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
        builder: (context) {
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
                            getBrandIcon(state.videoType),
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
                      // state.videoDownloadModel?.thumbnail != null
                      //     ? CachedNetworkImage(
                      //         imageUrl: videoDownloadModel!.thumbnail!,
                      //         height: 150.0,
                      //         width: 150.0,
                      //         placeholder: (context, url) =>
                      //             Padding(padding: EdgeInsets.all(34), child: CircularProgressIndicator()),
                      //         errorWidget: (context, url, error) => Icon(Icons.video_library),
                      //       )
                      //     : Icon(Icons.error, size: 50, color: Colors.red),

                      CachedNetworkImage(
                        imageUrl: state.videoDownloadModel.thumbnail,
                        height: 150.0,
                        width: 150.0,
                        placeholder: (context, url) =>
                            Padding(padding: EdgeInsets.all(34), child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.video_library),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: AutoSizeText(
                          state.videoDownloadModel.title,
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
                      NewLinkCubit newLinkCubit = BlocProvider.of(context);
                      return Column(
                        children: [
                          RadioListTile<String>(
                            title: Text(
                              S.of(context).music_option,
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            onChanged: (String? value) {
                              if(value=="mp3"){
                                newLinkCubit.setFileType(fileType: FileType.mp3);
                              }

                            },
                            value: "mp3",
                            groupValue: state.fileType.name,
                            /* onChanged: (String? value) {
                              emit(state.copyWith(fileType: value!)));
                            },*/
                          ),
                          RadioListTile<String>(
                            title: Text(
                              S.of(context).video_option,
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            onChanged: (String? value) {
                              // print(value);
                              if(value=="mp4"){
                                newLinkCubit.setFileType(fileType: FileType.mp4);
                              }


                            },
                            value: "mp4",
                            groupValue: state.fileType.name,
                            /* onChanged: (String? value) {
                              setState(() => emit(state.copyWith(fileType: value!)));
                            },*/
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
                      if (state.downloadingState == RequestState.loading) {
                        showErrorSnackBar(S.of(context).download_failed, 2, context);
                      } else {
                        Navigator.pop(context);
                        await performDownloading(state.qualities[state.selectedQualityIndex].url!, context)
                            .then((value) {
                          // DownloadNotification.showNotification(title: "title", body: "body");
                          showSuccessSnackBar(S.of(context).downloading_completed, 3, context);
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
        });
  }

  Future<void> setFileType({
    required FileType fileType,
  }) async {
    emit(state.copyWith(
      fileType: fileType,
    ));
  }

  ///========================================> Helpers
  Future<void> uploadToFirebaseStorage(String link) async {
    // print("upload to UID: ${user?.uid}");
    try {
      final ref = FirebaseStorage.instance.ref().child("links").child('${link}');
      final linkId = const Uuid().v4();

      final video = state.videoDownloadModel;
      await ref.putFile(File(video?.source ?? ""));

      await FirebaseFirestore.instance
          .collection("video_links")
          .doc(linkId)
          .set({
            'id': linkId,
            'title': state.videoDownloadModel?.title ?? state.videoDownloadModel!.title,
            'thumbnail': state.videoDownloadModel?.thumbnail ?? state.videoDownloadModel!.thumbnail,
            'source': state.videoDownloadModel?.source ?? state.videoDownloadModel?.source,
            'video': ref.getDownloadURL(),
            'createdAt': Timestamp.now(),
          })
          .then((value) => print("Upload is successfull!!"))
          .catchError((onError) => print("Upload is Failed!! $onError"));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> onLinkPasted({required String url, required BuildContext context}) async {
    setVideoType(url: url);
    emit(state.copyWith(
      videoLoadingState: RequestState.loading,
      searchState: RequestState.loading,
    ));

    // print(url);
    await VideoDownloaderRepository().call(url).then((value) {
      // print(value.title);
      // print("======================================> ");
      final updatedQualities = List<VideoQualityModel>.from(value?.videos ?? []);
      emit(state.copyWith(videoDownloadModel: value));
      for (var quality in value.videos) {
        updatedQualities.add(quality);
      }
      emit(state.copyWith(
        videoDownloadModel: value,
        qualities: updatedQualities,
        videoLoadingState: RequestState.done,
        searchState: RequestState.done,
      ));
      showBottomModel(context);
    }).catchError((error) {
      emit(state.copyWith(
        videoLoadingState: RequestState.error,
        searchState: RequestState.error,
      ));
      showErrorSnackBar(S.of(context).check_link, 4, context);
      emit(state.copyWith(qualities: null));
    });
  }

  Future<void> setDonDownload({
    required int selectedQualityIndex,
    required VideoType videoType,
    required RequestState videoLoadingState,
    required List<VideoQualityModel> qualities,
    required VideoDownloadModel videoDownloadModel,
  }) async {
    emit(state.copyWith(
      selectedQualityIndex: selectedQualityIndex,
      videoType: videoType,
      videoLoadingState: videoLoadingState,
      qualities: List.from(qualities),
      videoDownloadModel: videoDownloadModel,
    ));
  }

  Future<void> setLoadingState({required RequestState loadingState}) async {
    emit(state.copyWith(videoLoadingState: loadingState));
  }
}
