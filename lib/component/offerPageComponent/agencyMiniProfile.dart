import 'dart:convert';
import 'package:flutter/material.dart';
import '../../pages/agencyDescription.dart';
import '../../server/api.dart';
import '../SmallAgencyImage.dart';
import '../SmallHouseImage.dart';

class agencyMiniProfile extends StatefulWidget {
  int id;
  agencyMiniProfile(this.id);

  @override
  State<agencyMiniProfile> createState() => _agencyMiniProfileState();
}

class _agencyMiniProfileState extends State<agencyMiniProfile> {
  var _offerOwner, _OwnerDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadOwner();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                agencyDescriptionPage(_offerOwner['owner_id']),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: SizedBox(
                  child: _offerOwner==null ? Icon(Icons.downloading) : SmallAgencyImage(_offerOwner['owner_id']),
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _OwnerDetails == null
                            ? '...'
                            : _OwnerDetails['username'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 12,
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
              const SizedBox(
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
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF605F5F).withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(2, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadOwnerDetails() async {
    var response =
        await Api().getData('/auth/users/${_offerOwner['owner_id']}', 'JWT');
    if (response.statusCode == 200) {
      setState(() {
        _OwnerDetails = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }

  _loadOwner() async {
    var response = await Api().getData('/API/products/${widget.id}', 'JWT');
    if (response.statusCode == 200) {
      setState(() {
        _offerOwner = json.decode(response.body);
        _loadOwnerDetails();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
