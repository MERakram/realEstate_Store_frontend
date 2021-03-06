import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../server/api.dart';

class Comments extends StatefulWidget {
  int id;
  Comments(this.id);
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var _offerReviews=[],_ReviewOwner,ownersList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(18, 1, 12, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFFCDB889),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  _offerReviews.isEmpty
                      ? Text('no comments yet be the first')
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 0, 20, 0),
                          physics: const BouncingScrollPhysics(parent: null),
                          shrinkWrap: true,
                          itemCount: _offerReviews.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ownersList==null?'...':ownersList[index],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Center(
                                  child: Text(
                                    _offerReviews[index]['description'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            );
                          },
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
              color: const Color(0xFF605F5F).withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(2, 1),
            ),
          ],
        ),
        width: 300,
        // height: 300,
      ),
    );
  }
  _loadCommentOwner() async {
    for(int i=0;i<_offerReviews.length;i++){
      var response = await Api().getData('/auth/users/${_offerReviews[i]['owner_id']}','JWT');
      if (response.statusCode == 200) {
        setState(() {
          _ReviewOwner = json.decode(response.body);
          ownersList.add(_ReviewOwner['username']);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Error ' + response.statusCode.toString() + ': ' + response.body),
        ));
      }
    }
  }
  _loadComments() async {
    var response = await Api().getData('/API/offers/${widget.id}/comments','JWT');
    if (response.statusCode == 200) {
      setState(() {
        _offerReviews = json.decode(response.body);
        _loadCommentOwner();
      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
