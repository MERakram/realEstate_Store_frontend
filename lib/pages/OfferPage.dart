import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oued_kniss1/component/Comments.dart';
import 'package:oued_kniss1/component/offerPageComponent/offerMap.dart';
import 'package:oued_kniss1/component/offerPageComponent/offerimage.dart';
import 'package:oued_kniss1/pages/agencyDescription.dart';
import '../component/offerPageComponent/agencyMiniProfile.dart';
import '../component/offerPageComponent/offerDescription.dart';
import '../server/api.dart';

class OfferPage extends StatefulWidget {
  int id;
  OfferPage(this.id);

  @override
  _OfferPageState createState() {
    return _OfferPageState();
  }
}

class _OfferPageState extends State<OfferPage> {
  var _offerData;
  var comment;

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void Unfocus(){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      // GestureDetector(
      //   onTap: () {
      //     Unfocus();
      //   },
      //   child:
        Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.grey[300],
          backgroundColor: const Color(0xFFF5F7F9),
          body: ListView(
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  OfferImage(widget.id),
                  Positioned(
                    left: 13,
                    top: 18,
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF605F5F).withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: Offset(2, 1),
                              ),
                            ],
                          ),
                          height: 45,
                          width: 45,
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 27,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              agencyMiniProfile(widget.id),
              offerDescription(widget.id),
              offerMap(widget.id),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: TextField(
                  maxLength: 50,
                  maxLines: 2,
                  decoration: InputDecoration(
                      counterText: '',
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _submitComment();
                          },
                          child: Icon(
                            Icons.send,
                            color: Color(0xFFCDB889),
                          )),
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFCDB889)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'what do you think?',
                      fillColor: Colors.grey[100],
                      filled: true),
                  onChanged: (value) {
                    comment = value;
                  },
                ),
              ),
              Comments(widget.id),
            ],
          ),
        ),
      // ),
    );
  }

  _loadData() async {
    var response = await Api().getData('/API/offers/${widget.id}/','JWT');
    if (response.statusCode == 200) {
      setState(() {
        _offerData = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }

  void _submitComment() async {
    var data = new Map<String, String>();
    data['description'] = comment;
    var response = await Api().postData(data, '/API/offers/${widget.id}/comments/','JWT');
    if (response.statusCode == 201) {
      Unfocus();
      Navigator.pop(context);
    } else {
      _showMsg('Error ${response.statusCode}');
    }
  }

  _showMsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    ));
  }
}
