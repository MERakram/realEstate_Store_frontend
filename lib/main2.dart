import 'dart:ui';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:like_button/like_button.dart';

import 'component/SmallHouseImage.dart';

class OfferPage extends StatefulWidget {
  @override
  _OfferPageState createState() {
    return _OfferPageState();
  }
}

class _OfferPageState extends State<OfferPage> {
  String text = lorem(paragraphs: 4, words: 70);
  late bool isliked;
  final borderRadius = BorderRadius.circular(25);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 300,
                width: 390,
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
                          image: AssetImage("assets/images/batata.jpg"),
                          onChanged: () {
                            setState(() {
                              isliked = true;
                            });
                          },
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: LikeButton(
                            circleColor: CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            likeBuilder: (isliked) {
                              return Icon(
                                Icons.favorite,
                                color: isliked
                                    ? Colors.deepPurpleAccent
                                    : Colors.black,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: BlurryContainer(
                            blur: 2,
                            borderRadius: BorderRadius.circular(10),
                            bgColor: Colors.white,
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
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 07, 10, 7),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 10,
                      child: SizedBox(
                        child: SmallHouseImage(),
                        width: 80,
                      ),
                    ),
                    Flexible(
                      flex: 25,
                      child: Container(
                        width: 300,
                        color: Colors.white,
                        padding:
                            // EdgeInsets.fromLTRB(left, top, right, bottom)
                            const EdgeInsets.fromLTRB(10, 1, 0, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'house mda5en in cuoertino',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text(
                              'house mda5en in cupertino',
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 23,
                      ),
                      width: 20,
                    ),
                  ],
                ),
                height: 90,
                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF605F5F).withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),

                    Padding(
                      padding:
                      // EdgeInsets.fromLTRB(left, top, right, bottom)
                      const EdgeInsets.fromLTRB(18, 1, 12, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            'house mda5en in cupirtino ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          const Text(
                            'house mda5en in cupirtino hello wo ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          ExpandText(
                            text,style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF605F5F).withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: 300,
                // height: 300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
