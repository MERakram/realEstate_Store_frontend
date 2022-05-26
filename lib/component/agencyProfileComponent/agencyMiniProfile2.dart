import 'dart:convert';

import 'package:flutter/material.dart';

import '../../server/api.dart';
import '../SmallHouseImage.dart';

class agencyMiniProfile2 extends StatefulWidget {
  int id;
  agencyMiniProfile2(this.id);
  @override
  State<agencyMiniProfile2> createState() => _agencyMiniProfile2State();
}

class _agencyMiniProfile2State extends State<agencyMiniProfile2> {
  var _OwnerDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadOwnerDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Container(
        // color: Colors.pink,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 11,
              child: SizedBox(
                child: SmallHouseImage(widget.id),
                width: 100,
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _OwnerDetails==null?'...':_OwnerDetails['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
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
          ],
        ),
        height: 120,
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
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
