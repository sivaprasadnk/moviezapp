// import 'package:cloud_firestore/cloud_firestore.dart';


class AppRepo {
  static Future<String> getVersionFromDb() async {
    // DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
    //     .instance
    //     .collection('version')
    //     .doc(kVersionDocId)
    //     .get();

    // return snapshot['web'];
    return "1";
    // return "helo";
  }
}
