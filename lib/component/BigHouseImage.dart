import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:like_button/like_button.dart';

class BigHouseImage extends StatefulWidget {
  @override
  State<BigHouseImage> createState() => _BigHouseImageState();
}

class _BigHouseImageState extends State<BigHouseImage> {
  @override
  Widget build(BuildContext context) {
    bool isliked;
    final borderRadius = BorderRadius.circular(25);
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 290,
      height: 240,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 5, 6), // Border width
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: borderRadius),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: SizedBox.fromSize(
            size: const Size.fromRadius(50), // Image radius
            child: Stack(
              children: [
                InstaLikeButton(
                  icon: Icons.favorite_border,
                  iconColor: Colors.red,
                  imageBoxfit: BoxFit.cover,
                  image: AssetImage("assets/images/home.jpg"),
                  onChanged: () {
                    setState(() {
                      isliked = true;
                    });
                  },
                ),
                Positioned(
                  right: 10,
                  top: 5,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
