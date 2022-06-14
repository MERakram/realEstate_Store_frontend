import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oued_kniss1/pages/HomePage.dart';

import '../server/SharedPreferencesManager.dart';
import '../server/api.dart';
import 'editAgencyAccount.dart';
import 'editCustomerAccount.dart';
import 'loginPage.dart';
import 'myLikedOffers.dart';
import 'myOffersPage.dart';

class CostumerProfile extends StatefulWidget {
  @override
  State<CostumerProfile> createState() => _CostumerProfileState();
}

class _CostumerProfileState extends State<CostumerProfile> {
  var _profileData;
  @override
  void initState() {
    super.initState();
    _loadData();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                        ),
                        height: 45,
                        width: 45,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 27,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
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
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width:width*0.2,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Stack(
                // overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _profileData == null
                        ? NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
                        : NetworkImage(_profileData['avatar']),
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned(
                    bottom: 0,
                    right: -15,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Colors.white,
                        child: Icon(Icons.camera_alt_outlined),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(_profileData==null?'...':_profileData['username']
                ,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ProfileMenu(
                text: "Edit Account",
                firstIcon: Icon(Icons.edit),
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => editCustomerAccount()),
                  );
                },
              ),
              // ProfileMenu(
              //   text: "likes",
              //   firstIcon: Icon(Icons.favorite),
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => myLikedOffers(_profileData['id'])),
              //     );
              //   },
              // ),
              ProfileMenu(
                text: "Log Out",
                firstIcon: Icon(Icons.logout),
                press: () async {
                  await SharedPreferencesManager().clearAuthToken();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => loginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  _loadData() async {
    var response = await Api().getData('/auth/users/me/','JWT');
    if (response.statusCode == 200) {
      setState(() {
        _profileData = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.firstIcon,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon firstIcon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
        ),
        onPressed: press,
        child: Row(
          children: [
            firstIcon,
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

}