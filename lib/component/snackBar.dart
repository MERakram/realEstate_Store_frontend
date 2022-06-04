import 'package:flutter/material.dart';

void showWarningSnackBar(BuildContext context, String message) {
// Find the Scaffold in the widget tree and use it to show a SnackBar.
  ScaffoldFeatureController<Widget, dynamic> _scaffold;

  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  _scaffold = Scaffold.of(context).showSnackBar(SnackBar(
    content: InkWell(
      onTap: () {
        // _scaffold.close();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // AppImage.asset(
          //     assetName: "/assets/images/batata.jpg",
          //     fit: BoxFit.contain,
          //     width: 20,
          //     color:Colors.red),
          const SizedBox(
            width: 10,
          ),
          Text(
            '$message',
            maxLines: 2,
          ),
        ],
      ),
    ),
    duration: const Duration(seconds: 10),
    backgroundColor: Colors.black,
  ));
}