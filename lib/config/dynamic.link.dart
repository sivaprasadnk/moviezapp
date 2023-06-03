// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:moviezapp/utils/string.constants.dart';

// class DynamicLinks {
//   static Future<String> generateLink() async {
//     final dynamicLinkParams = DynamicLinkParameters(
//       link: Uri.parse("https://www.sivaprasadnk.dev/"),
//       uriPrefix: "https://spverse.page.link",
//       androidParameters: const AndroidParameters(packageName: kPackageName),
//     );
//     final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//     final ShortDynamicLink shortDynamicLink =
//         await dynamicLinks.buildShortLink(dynamicLinkParams);

//     return shortDynamicLink.shortUrl.toString();
//   }
// }
