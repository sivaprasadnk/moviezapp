import 'package:flutter/material.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/mobile/home/page/profile/bookmark.list.screen.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';
import 'package:moviezapp/views/web/bookmark/bookmark.screen.web.dart';

class BookmarkListMenu extends StatefulWidget {
  const BookmarkListMenu({super.key});

  @override
  State<BookmarkListMenu> createState() => _BookmarkListMenuState();
}

class _BookmarkListMenuState extends State<BookmarkListMenu> {
  int count = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!context.isGuestUser) {
        count = (await context.userProvider.getBookmarksCount());
      }
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileMenuCard(
      title: 'Bookmark List',
      icon: Icons.bookmark,
      isCountItem: true,
      count: context.isGuestUser ? 0 : count,
      isImplemented: true,
      onTap: () async {
        if (!context.isGuestUser) {
          context.userProvider.clearList();
          Dialogs.showLoader(context: context);
          await context.userProvider
              .getBookmarkedMovies(context)
              .then((value) async {
            await context.userProvider
                .getBookmarkedShows(context)
                .then((value) {
              context.pop();
              if (context.isMobileApp) {
                Navigator.pushNamed(context, BookmarkListScreen.routeName);
              } else {
                Navigator.pushNamed(context, BookmarkScreenWeb.routeName);
              }
            });
          });
        } else {
          context.showErrorToast('Login to add / view bookmarks !');
        }
      },
    );
  }
}
