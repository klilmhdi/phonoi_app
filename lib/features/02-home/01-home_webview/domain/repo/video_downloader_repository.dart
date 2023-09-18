import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/consts/extractor.dart';
import '../../data/models/video_downloaded_model.dart';

class VideoDownloaderRepository {
  Future<VideoDownloadModel> call(String url) async {
    dynamic response = await Extractor.getDirectLink(link: url);
    if (response != null &&
        response.links != null &&
        response.links!.isNotEmpty &&
        response.title != null &&
        response.thumbnail!.isNotEmpty) {
      print("###############################Come on here");
      print("###############################response.title = ${response.title}");
      return VideoDownloadModel(
        title: response.title ?? response.title,
        source: response.links!.first.href ?? response.links!.first.href,
        thumbnail: response.thumbnail ?? response.thumbnail,
        createdAt: Timestamp.now(),
        videos: [
          VideoQualityModel(
            url: response.links!.first.href,
            quality: "720",
          ),
        ],
      );
    } else {
      print("###############################Emptyyyyyyyyyy!!!!!!");
      return VideoDownloadModel.empty();
    }
  }
}
