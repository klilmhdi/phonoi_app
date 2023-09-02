import 'package:phonoi_app/features/02-home/1-home_webview/models/video_quality_model.dart';

//
// class VideoDownloadModel {
//   String? _title;
//   String? _source;
//   String? _thumbnail;
//   List<VideoQualityModel>? _videos;
//
//   VideoDownloadModel(
//       {String? title, String? source, String? duration, String? thumbnail, List<VideoQualityModel>? videos}) {
//     if (title != null) {
//       _title = title;
//     }
//     if (source != null) {
//       _source = source;
//     }
//
//     if (thumbnail != null) {
//       _thumbnail = thumbnail;
//     }
//     if (videos != null) {
//       _videos = videos;
//     }
//   }
//
//   String? get title => _title;
//
//   set title(String? title) => _title = title;
//
//   String? get source => _source;
//
//   set source(String? source) => _source = source;
//
//   String? get thumbnail => _thumbnail;
//
//   set thumbnail(String? thumbnail) => _thumbnail = thumbnail;
//
//   List<VideoQualityModel>? get videos => _videos;
//
//   set videos(List<VideoQualityModel>? videos) => _videos = videos;
//
//   VideoDownloadModel.fromJson(Map<String, dynamic> json) {
//     _title = json['title'];
//     _source = json['source'];
//
//     _thumbnail = json['thumbnail'];
//     _videos = json['videos'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = _title;
//     data['source'] = _source;
//
//     data['thumbnail'] = _thumbnail;
//     data['videos'] = _videos;
//
//     return data;
//   }
// }

import 'package:phonoi_app/features/02-home/1-home_webview/models/video_quality_model.dart';

class VideoDownloadModel {
  final String? title;
  final String? source;
  final String? thumbnail;
  final List<VideoQualityModel>? videos;

  VideoDownloadModel({
    this.title,
    this.source,
    this.thumbnail,
    this.videos,
  });

  factory VideoDownloadModel.fromJson(Map<String, dynamic> json) {
    return VideoDownloadModel(
      title: json['title'],
      source: json['source'],
      thumbnail: json['thumbnail'],
      videos: (json['videos'] as List<dynamic>?)?.map((video) => VideoQualityModel.fromJson(video)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'source': source,
      'thumbnail': thumbnail,
      'videos': videos?.map((video) => video.toJson()).toList(),
    };
  }
}
