import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../server/api.dart';

class offerDescription extends StatefulWidget {
  int id;
  offerDescription(this.id);

  @override
  State<offerDescription> createState() => _offerDescriptionState();
}

class _offerDescriptionState extends State<offerDescription> {
  var _offerData;
  String text = lorem(paragraphs: 4, words: 70);
  @override
  void initState() {
    super.initState();
    _loadData();
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
                  // EdgeInsets.fromLTRB(left, top, right, bottom)
                  const EdgeInsets.fromLTRB(18, 1, 12, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Title:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFFCDB889),
                    ),
                  ),
                  Text(
                    _offerData == null ? '...' : _offerData['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Location:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFFCDB889),
                    ),
                  ),
                  Text(
                    _offerData == null ? '...' : _offerData['Location'],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Descreption:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFFCDB889),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      _offerData == null ? '...' : '${_offerData['description']}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
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

  _loadData() async {
    var response = await Api().getData('/API/products/${widget.id}/', 'JWT');
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
}
