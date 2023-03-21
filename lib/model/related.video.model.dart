class RelatedVideoModel {
  String id;
  String publishedAtTime;
  String type;
  String site;
  String key;
  String name;
  String thumbnail;
  RelatedVideoModel({
    required this.id,
    required this.publishedAtTime,
    required this.type,
    required this.site,
    required this.key,
    required this.name,
    required this.thumbnail,
  });

  factory RelatedVideoModel.fromJson(Map<String, dynamic> json) {
    String videoKey = json['key'] ?? "";
    var thumbnail = "";
    if (videoKey.isNotEmpty) {
      thumbnail = "https://img.youtube.com/vi/$videoKey/0.jpg";
    }
    return RelatedVideoModel(
      id: json['id'] ?? "",
      key: videoKey,
      name: json['name'] ?? "",
      publishedAtTime: json['published_at'] ?? "",
      site: json['site'] ?? "",
      type: json['type'] ?? "",
      thumbnail: thumbnail,
    );
  }
}

extension Videoext on List<RelatedVideoModel> {
  String get trailer {
    for (var video in this) {
      if (video.type == "Trailer") {
        return video.key;
      }
    }

    return "";
  }
}
