import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorDetailsWidget extends StatelessWidget {
  const ErrorDetailsWidget(
      {super.key, required this.errorDetails, required this.widget});

  final FlutterErrorDetails errorDetails;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    String message =
        kDebugMode ? "${errorDetails.summary}" : "Something went wrong !";

    Widget error = Text(message);
    return widget is Scaffold
        ? MaterialApp(
            builder: (context, child) {
              return Material(
                child: Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outlined, size: 50),
                          error,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
