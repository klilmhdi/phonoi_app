import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/consts/extractor.dart';
import '../../data/models/video_downloaded_model.dart';

class VideoDownloaderRepository {
  Future<VideoDownloadModel> call(String url) async {
    dynamic response = await Extractor.getDirectLink(link: url);

    return VideoDownloadModel(
      title: response.title,
      source: response.links!.first.href,
      thumbnail: response.thumbnail,
      videos: [
        VideoQualityModel(
          url: response.links!.first.href,
          quality: "720",
        ),
      ],
      createdAt: Timestamp.now(),
    );
  }
}
