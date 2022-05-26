import 'dart:convert';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../server/api.dart';
import 'agencyMiniProfile2.dart';



class agencyDesc extends StatefulWidget {
  int id;
  agencyDesc(this.id);
  @override
  State<agencyDesc> createState() => _agencyDescState();
}

class _agencyDescState extends State<agencyDesc> {
  var _OwnerDetails;
  String text = lorem(paragraphs: 4, words: 70);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadOwnerDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            agencyMiniProfile2(widget.id),
            const SizedBox(
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
                   Text(
                     'Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    //agency location
                    'house mda5en in cupirtino hello wo ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  ExpandText(
                    //agency desc
                    text,
                    style: const TextStyle(fontSize: 20),
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
              color: const Color(0xFF605F5F).withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 300,
        // height: 300,
      ),
    );
  }
  _loadOwnerDetails() async {
    var response = await Api().getData('/auth/users/${widget.id}','JWT');
    if (response.statusCode == 200) {
      setState(() {
        _OwnerDetails = json.decode(response.body);
        print(_OwnerDetails);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
