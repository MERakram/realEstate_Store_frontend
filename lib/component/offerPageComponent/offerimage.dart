import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../imageSlider.dart';

class OfferImage extends StatefulWidget {
  @override
  State<OfferImage> createState() => _OfferImageState();
}

class _OfferImageState extends State<OfferImage> {
  late bool isliked;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // color: const Color(0xFFE3E3E3),
        // color: Colors.white,
        margin: EdgeInsets.only(top: 20),
        height: 300,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: SizedBox.fromSize(
            size: const Size.fromRadius(50), // Image radius
            child: Stack(
              children: [
                imageSlider(),
                Positioned(
                  right: 10,
                  top: 10,
                  child: LikeButton(
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (isliked) {
                      return Icon(
                        Icons.favorite,
                        color: isliked ? Colors.deepPurpleAccent : Colors.black,
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 2,
                  child: BlurryContainer(
                    blur: 50,
                    borderRadius: BorderRadius.circular(10),
                    bgColor: Color(0xEEE1CF),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: 45,
                    width: 45,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
