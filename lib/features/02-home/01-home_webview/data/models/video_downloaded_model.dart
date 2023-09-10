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

class VideoQualityModel {
  final String? url;
  final String? quality;

  VideoQualityModel({
    this.url,
    this.quality,
  });

  factory VideoQualityModel.fromJson(Map<String, dynamic> json) {
    return VideoQualityModel(
      url: json['url'],
      quality: json['quality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'quality': quality,
    };
  }
}

class VideoData {
  VideoData({
    this.status,
    this.message,
    this.title,
    this.thumbnail,
    this.duration,
    this.links,
  });

  bool? status;
  String? message;
  String? title;
  String? thumbnail;
  String? duration;
  List<Link>? links;

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] as String?,
      duration: json['duration'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Link {
  Link({
    this.videoFormat,
    this.href,
    this.text,
  });

  String? videoFormat;
  String? href;
  String? text;

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      videoFormat: json['videoFormat'] as String?,
      href: json['href'] as String?,
      text: json['text'] as String?,
    );
  }
}
