import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:provider/provider.dart';

class BookMarkButton extends StatefulWidget {
  const BookMarkButton({super.key, this.movie, required this.width});

  final MovieDetails? movie;
  final double width;

  @override
  State<BookMarkButton> createState() => _BookMarkButtonState();
}

class _BookMarkButtonState extends State<BookMarkButton> {
  bool isVisible = false;
  bool isbookmarked = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        isVisible = true;
        if (!context.authProvider.isGuestUser) {
          isbookmarked = await context.userProvider
              .checkIfMovieBookmarked(widget.movie!.id);
          if (mounted) {
            setState(() {});
          }
        } else {
          if (mounted) {
            setState(() {});
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, authProvider, __) {
        return Padding(
          padding: const EdgeInsets.only(right: 25),
          child: isVisible
              ? SizedBox(
                  width: widget.width,
                  child: authProvider.isGuestUser
                      ? CommonButton(
                          callback: () {
                            context.showErrorToast('Login to Bookmark !');
                          },
                          title: 'Bookmark ')
                      : !isbookmarked
                          ? CommonButton(
                              callback: () {
                                context.userProvider.addMovieToBookmarks(
                                    widget.movie!, context);
                              },
                                  title: 'Add to Bookmarks ')
                              .addMousePointer
                          : CommonButton(
                              callback: () {
                                context.userProvider.removeMovieFromBookmarks(
                                    widget.movie!, context);
                              },
                                  title: 'Remove from Bookmarks ')
                              .addMousePointer,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
