import 'package:flutter/material.dart';

class GooglePlaystoreButton extends StatefulWidget {
  const GooglePlaystoreButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<GooglePlaystoreButton> createState() => _GooglePlaystoreButtonState();
}

class _GooglePlaystoreButtonState extends State<GooglePlaystoreButton> {
  late Image image1;

  @override
  void initState() {
    super.initState();
    image1 = Image.asset(
      "assets/google-play.png",
      height: 40,
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap.call();
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            image1,
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "GET IT ON",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "Google Play",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
