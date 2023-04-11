import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:moviezapp/utils/string.constants.dart';

class DynamicLinks {
  static Future<String> generateLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.sivaprasadnk.dev/"),
      uriPrefix: "https://spverse.page.link",
      androidParameters: const AndroidParameters(packageName: kPackageName),
    );
    // final dynamicLink =
    // //     await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    // final unguessableDynamicLink =
    //     await FirebaseDynamicLinks.instance.buildShortLink(
    //   dynamicLinkParams,
    //   shortLinkType: ShortDynamicLinkType.unguessable,
    // );
    final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final ShortDynamicLink shortDynamicLink =
        await dynamicLinks.buildShortLink(dynamicLinkParams);

    return shortDynamicLink.shortUrl.toString();

    // return unguessableDynamicLink.;
  }
}
