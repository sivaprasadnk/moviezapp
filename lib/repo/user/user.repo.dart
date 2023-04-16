import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/utils/string.constants.dart';

var userColllection = FirebaseFirestore.instance.collection(kUsersCollection);

enum AccountType {
  emailPassword,
  googleSignIn,
}

extension AccountTypeExt on AccountType {
  String get value {
    switch (this) {
      case AccountType.emailPassword:
        return "email-Password";
      case AccountType.googleSignIn:
        return "google-signIn";
    }
  }
}

class UserRepo {
  static Future addUserDetails() async {
    var user = FirebaseAuth.instance.currentUser!;

    userColllection.doc(user.uid).set({
      kEmail: user.email,
      kRating: 0,
      kDisplayName: user.displayName,
      kBookMarkedMovieIdList: [],
      kBookMarkedShowIdList: [],
      kAccountType: AccountType.emailPassword.value,
      kCreatedDateTime: DateTime.now(),
    });
  }

  static Future addMovieToBookmarks(MovieDetails movie) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    userColllection
        .doc(userId)
        .collection(kMoviesCollection)
        .add(movie.toMap());

    List list = await getBookmarkMovieIds();

    list.add(movie.id);

    userColllection.doc(userId).update({
      kBookMarkedMovieIdList: list,
    });
  }

  static Future removeMovieFromBookmarks(MovieDetails movie) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> snapshot = await userColllection
        .doc(userId)
        .collection(kMoviesCollection)
        .where('id', isEqualTo: movie.id)
        .get();

    await snapshot.docs[0].reference.delete();

    List list = await getBookmarkMovieIds();

    list.remove(movie.id);

    userColllection.doc(userId).update({
      kBookMarkedMovieIdList: list,
    });
  }

  static Future removeTvShowFromBookmarks(TvShowDetails show) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> snapshot = await userColllection
        .doc(userId)
        .collection(kTvShowsCollection)
        .where('id', isEqualTo: show.id)
        .get();

    await snapshot.docs[0].reference.delete();

    List list = await getBookmarkShowIds();

    list.remove(show.id);

    userColllection.doc(userId).update({
      kBookMarkedShowIdList: list,
    });
  }

  static Future addShowToBookmarks(TvShowDetails show) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    userColllection
        .doc(userId)
        .collection(kTvShowsCollection)
        .add(show.toMap());

    List list = await getBookmarkShowIds();

    list.add(show.id);

    userColllection.doc(userId).update({
      kBookMarkedShowIdList: list,
    });
  }

  static Future<List<int>> getBookmarkMovieIds() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    var docSnapshot = await userColllection.doc(userId).get();
    var list = docSnapshot[kBookMarkedMovieIdList] as List;
    return list.isEmpty ? [] : list.map((e) => e as int).toList();
  }

  static Future<List<int>> getBookmarkShowIds() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    var docSnapshot = await userColllection.doc(userId).get();
    if (!docSnapshot.data()!.containsKey(kBookMarkedShowIdList)) {
      return [];
    }
    var list = docSnapshot[kBookMarkedShowIdList] as List;
    return list.isEmpty ? [] : list.map((e) => e as int).toList();
  }

  static Future<List<MovieDetails>> getBookmarkedMovies() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    List<MovieDetails> list = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list1 =
        (await userColllection.doc(userId).collection(kMoviesCollection).get())
            .docs;
    for (var i in list1) {
      list.add(MovieDetails.fromDoc(i));
    }
    // list.sort(((a, b) =>a. ));
    return list;
  }

  static Future<List<TvShowDetails>> getBookmarkedShows() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    List<TvShowDetails> list = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list1 =
        (await userColllection.doc(userId).collection(kTvShowsCollection).get())
            .docs;
    for (var i in list1) {
      list.add(TvShowDetails.fromDoc(i));
    }
    return list;
  }

  static Future<int> getRating() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await userColllection.doc(userId).get();

    return snapshot[kRating] ?? 0;
  }

  static Future<void> updateRating(int rating) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    await userColllection.doc(userId).update({
      kRating: rating,
    });
  }
}
