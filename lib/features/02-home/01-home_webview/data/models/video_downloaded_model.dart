import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VideoDownloadModel extends Equatable {
  final String title;
  final String source;
  final String thumbnail;
  final List<VideoQualityModel> videos;
  final Timestamp ?createdAt;

  const VideoDownloadModel({
    required this.title,
    required this.source,
    required this.thumbnail,
    required this.videos,
    required this.createdAt,
  });

  factory VideoDownloadModel.fromJson(Map<String, dynamic> json) {
    return VideoDownloadModel(
      title: json['title'],
      source: json['source'],
      thumbnail: json['thumbnail'],
      videos: List.from(json['videos'].map((e) => VideoQualityModel.fromJson(e))),
      createdAt: json['createdAt'],
    );
  }


  factory VideoDownloadModel.empty() {
    return VideoDownloadModel(
      createdAt: Timestamp.now(),
      title: "",
      source: "",
      thumbnail: "",
      videos: [],
    );
  }

  @override
  List<Object?> get props => [title, source, thumbnail, videos, createdAt];

  @override
  bool? get stringify => true;
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

  factory VideoQualityModel.empty() {
    return VideoQualityModel(
      url: "",
      quality: "",
    );
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
      links: (json['links'] as List<dynamic>?)?.map((e) => Link.fromJson(e as Map<String, dynamic>)).toList(),
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
