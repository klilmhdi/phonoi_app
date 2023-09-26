import 'dart:developer';
import '../../../../core/utils/consts/extractor.dart';
import '../models/video_downloaded_model.dart';

class VideoDownloaderRepository {
  Future<VideoDownloadModel?> getAvailableVideos(String url) async {
    try {
      dynamic response = await Extractor.getDirectLink(link: url);
      if (response != null && response.links != null && response.links!.isNotEmpty) {
        print("###########***********############${response.links.toString()}");
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
        );
      } else {
        return null;
      }
    } catch (e) {
      log("Exception occurred: $e");
      return null;
    }
  }
}
