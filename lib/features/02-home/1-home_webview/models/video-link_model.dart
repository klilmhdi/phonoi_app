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
}
