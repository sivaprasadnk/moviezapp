class SocialMediaModel {
  String imdbId;
  String wikipediaId;
  String fbId;
  String instaId;
  String twitterId;
  bool isLoading;
  SocialMediaModel({
    required this.imdbId,
    required this.wikipediaId,
    required this.fbId,
    required this.instaId,
    required this.twitterId,
    this.isLoading = true,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      imdbId: json['imdb_id'] ?? "",
      fbId: json['facebook_id'] ?? "",
      instaId: json['instagram_id'] ?? "",
      twitterId: json['twitter_id'] ?? "",
      wikipediaId: json['wikidata_id'] ?? "",
      isLoading: false,
    );
  }
}
