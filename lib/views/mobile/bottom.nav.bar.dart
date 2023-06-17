import 'package:flutter/material.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/mobile/bottom.nav.bar.item.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (_, provider, __) {
      return Container(
        width: double.infinity,
        color: context.bgColor,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavBarItem(
              icon: Icons.home,
              name: 'Home',
              isSelected: provider.selectedIndex == 0,
              onTap: () {
                provider.updatedSelectedIndex(0);
              },
            ),
            BottomNavBarItem(
              icon: Icons.search,
              name: 'Search',
              isSelected: provider.selectedIndex == 1,
              onTap: () {
                context.moviesProvider.updateQuery('');
                provider.updatedSelectedIndex(1);
              },
            ),
            BottomNavBarItem(
              icon: Icons.favorite,
              name: 'Favourites',
              isSelected: provider.selectedIndex == 2,
              onTap: () async {
                provider.updatedSelectedIndex(2);
                if (!context.isGuestUser) {
                  getBookmarks(context);
                } else {
                  context.userProvider.clearList();
                }
              },
            ),
            BottomNavBarItem(
              icon: Icons.person,
              name: 'Profile',
              isSelected: provider.selectedIndex == 3,
              onTap: () {
                provider.updatedSelectedIndex(3);
              },
            ),
          ],
        ),
      );
    });
  }

  getBookmarks(BuildContext context) async {
    Dialogs.showLoader(context: context);
    await context.userProvider.getBookmarkedMovies(context).then((value) async {
      debugPrint("bookmarked data fetched");
      await context.userProvider.getBookmarkedShows(context).then((value) {
        context.pop();
      });
    });
  }
}
