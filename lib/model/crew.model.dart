import 'package:moviezapp/repo/movie/end.points.dart';

class Crew {
  int id;
  String name;
  String profilePath;
  String profileUrl;
  String job;
  int order;
  Crew({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.profileUrl,
    required this.job,
    this.order = 9,
  });
  factory Crew.fromJson(Map<String, dynamic> json) {
    var job = json['job'] ?? "";
    int order = 9;
    switch (job) {
      case "Director":
        order = 1;
        break;
      case "Producer":
        order = 2;
        break;
      case "Executive Producer":
        order = 3;
        break;
      case "Screenplay":
        order = 4;
        break;
      case "Art Direction":
        order = 5;
        break;
      case "First Assistant Director":
        order = 6;
        break;
      default:
        order = 9;
    }

    return Crew(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      profileUrl: json['profile_path'] ?? "",
      job: job,
      order: order,
      profilePath: kImageBaseUrl + (json['profile_path'] ?? ""),
    );
  }
}

extension CrewExt on List<Crew> {
  List<Crew> get getList {
    List<Crew> list = [];

    for (var actor in this) {
      list.add(actor);
    }

    return list;
  }
}
