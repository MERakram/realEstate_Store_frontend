import 'dart:convert';

import 'package:flutter/material.dart';

import '../server/api.dart';

class SmallHouseImage extends StatefulWidget {
  int id;
  SmallHouseImage(this.id);

  @override
  State<SmallHouseImage> createState() => _SmallHouseImageState();
}

class _SmallHouseImageState extends State<SmallHouseImage> {
  var _offers;
  @override
  void initState() {
    super.initState();
    _loadOffer();
  }
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 290,
      height: 290,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 5, 5, 6), // Border width
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: borderRadius),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: SizedBox.fromSize(
            size: const Size.fromRadius(50), // Image radius
            child: Image(fit: BoxFit.cover,
              image: NetworkImage(
                  _offers == null
                  ?
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1g7H2Qcse7nhXqoLTx7STDxh5dPIcArxZqQ&usqp=CAU'
                  :_offers['images'][0]['images']),
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
}
