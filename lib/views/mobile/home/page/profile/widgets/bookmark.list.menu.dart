import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/mobile/home/page/profile/bookmark.list.screen.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';

class BookmarkListMenu extends StatefulWidget {
  const BookmarkListMenu({super.key, required this.isGuest});
  final bool isGuest;

  @override
  State<BookmarkListMenu> createState() => _BookmarkListMenuState();
}

class _BookmarkListMenuState extends State<BookmarkListMenu> {
  int count = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!widget.isGuest) {
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
      count: widget.isGuest ? 0 : count,
      isImplemented: true,
      onTap: () {
        if (!widget.isGuest) {
          context.userProvider.clearList();
          Navigator.pushNamed(context, BookmarkListScreen.routeName);
        } else {
          context.scaffoldMessenger.showSnackBar(const SnackBar(
              content: Text("Login to add and view bookmarks !")));
        }
      },
    );
  }
}
