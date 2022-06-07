import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:like_button/like_button.dart';

import '../server/api.dart';

class BigHouseImage extends StatefulWidget {
  int id;
  BigHouseImage(this.id);
  @override
  State<BigHouseImage> createState() => _BigHouseImageState();
}

class _BigHouseImageState extends State<BigHouseImage> {
  var _offers, _LikedList;
  bool isliked = false;
  @override
  void initState() {
    super.initState();
    _loadOffer();

  }

  @override
  Widget build(BuildContext context) {
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
                  // image: const AssetImage("assets/images/home.jpg"),
                  image: NetworkImage(_offers == null
                      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1g7H2Qcse7nhXqoLTx7STDxh5dPIcArxZqQ&usqp=CAU'
                      : _offers['images'][0]['images']),
                  onChanged: () {
                    setState(() {
                      // isliked = true;
                    });
                  },
                ),
                Positioned(
                  right: 7,
                  top: -5,
                  child: Stack(
                    children: [
                      // LikeButton(
                      //   circleColor: const CircleColor(
                      //       start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      //   bubblesColor: const BubblesColor(
                      //     dotPrimaryColor: Color(0xff33b5e5),
                      //     dotSecondaryColor: Color(0xff0099cc),
                      //   ),
                      //   likeBuilder: (islike) {
                      //     return Icon(
                      //       islike ? Icons.favorite : Icons.favorite,
                      //       color: islike ? Colors.red : Colors.white,
                      //       size: 30,
                      //     );
                      //   },
                      //   onTap: onLikeButtonTapped,
                      // ),
                      IconButton(
                        icon: isliked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40,
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 40,
                              ),
                        onPressed: () {
                          setState(() {
                            isliked = !isliked;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadOffer() async {
    // setState(() {
    //   _isLoading = true;
    // });
    var response = await Api().getData('/API/offers/${widget.id}/', 'JWT');
    if (response.statusCode == 200) {
      setState(() {
        // _isLoading = false;
        _offers = json.decode(response.body);
        _loadLiked();
      });
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }

  _loadLiked() async {
    var response = await Api().getData('/API/bookmark/', 'JWT');
    if (response.statusCode == 200) {
      setState(() {
        _LikedList = json.decode(response.body);
        print(_LikedList);
        for (int i = 0; i < _LikedList.length; i++) {
          print(_LikedList[i]['Offer']);
          if (_LikedList[i]['Offer']== widget.id)
            setState(() {
              isliked = true;
            });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Error ' + response.statusCode.toString() + ': ' + response.body),
        ),
      );
    }
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}
