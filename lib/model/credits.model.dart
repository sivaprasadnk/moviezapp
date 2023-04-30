import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/crew.model.dart';

class CreditsModel {
  List<Actor> actors;
  List<Crew> crew;
  CreditsModel({
    required this.actors,
    required this.crew,
  });
}
