class Game {
  final String id;
  final String name;
  final String googlePlayLink;
  final String appStoreLink;
  final String thumbnail;
  final String createdAt;
  final String updatedAt;

  Game({
    required this.id,
    required this.name,
    required this.googlePlayLink,
    required this.appStoreLink,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      googlePlayLink: json['google_play_link'] ?? '',
      appStoreLink: json['app_store_link'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
