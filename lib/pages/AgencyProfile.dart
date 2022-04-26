import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AgencyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Stack(
                 overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/home.jpg"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -15,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        color: Colors.white,
                        child: Icon(Icons.camera_alt_outlined),
                        onPressed: (){},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text("thamer agency",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 20),
              ProfileMenu(
                text: "Edit Account",
                firstIcon: Icon(Icons.map),
                press: () => {},
              ),
              ProfileMenu(
                text: "likes",
                firstIcon: Icon(Icons.map),
                press: () {},
              ),
              ProfileMenu(
                text: "comments",
                firstIcon: Icon(Icons.map),
                press: () {},
              ),
              ProfileMenu(
                text: "My Offers",
                firstIcon: Icon(Icons.map),
                press: () {},
              ),
              ProfileMenu(
                text: "Log Out",
                firstIcon: Icon(Icons.map),
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.firstIcon,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text ;
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
