import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:oued_kniss1/pages/HomePage.dart';
import '../imageSlider.dart';

class OfferImage extends StatefulWidget {
  int id;
  OfferImage(this.id);
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
        margin: const EdgeInsets.only(top: 20),
        height: 350,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: SizedBox.fromSize(
            size: const Size.fromRadius(50), // Image radius
            child: Stack(
              children: [
                imageSlider(widget.id),
                Positioned(
                  right: 10,
                  top: 10,
                  child: LikeButton(
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
