import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviezapp/utils/string.constants.dart';

class AppRepo {
  static Future<String> getVersionFromDb() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('version')
        .doc(kVersionDocId)
        .get();

    return snapshot['web'];
    // return "helo";
  }
}
