// class VideoQualityModel {
//   String? _url;
//   String? _quality;
//
//   VideoQualityModel({String? url, String? quality}) {
//     if (url != null) {
//       _url = url;
//     }
//     if (quality != null) {
//       _quality = quality;
//       // print("99999999999993222222222222222222222$_quality");
//     }
//   }
//
//   String? get url => _url;
//
//   set url(String? url) => _url = url;
//
//   String? get quality => _quality;
//
//   set quality(String? quality) => _quality = quality;
//
//   VideoQualityModel.fromJson(Map<String, dynamic> json) {
//     _url = json['url'];
//     _quality = json['quality'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['url'] = _url;
//     data['quality'] = _quality;
//     return data;
//   }
// }

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
