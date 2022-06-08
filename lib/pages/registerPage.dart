import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../server/api.dart';

class registerPage extends StatefulWidget {
  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  late String dropdownValue = 'Agency',fileName,filePath;
  var username, first_name, last_name, email, password, password_confirmation;
  bool _isLoading = false;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      fileName=image.path.split('/').last;
      filePath=image.path;
      print(filePath);
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Hello Again!',
                    style: GoogleFonts.bebasNeue(fontSize: 52),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Fill with your informations please',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Username',
                          fillColor: Colors.grey[100],
                          filled: true),
                      onChanged: (value) {
                        username = value;
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 25),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.white),
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Color(0xFFCDB889)),
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         hintText: 'First name',
                  //         fillColor: Colors.grey[100],
                  //         filled: true),
                  //     onChanged: (value) {
                  //       first_name = value;
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 25),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.white),
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Color(0xFFCDB889)),
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         hintText: 'Last name',
                  //         fillColor: Colors.grey[100],
                  //         filled: true),
                  //     onChanged: (value) {
                  //       last_name = value;
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Email',
                          fillColor: Colors.grey[100],
                          filled: true),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFCDB889)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                        fillColor: Colors.grey[100],
                        filled: true,
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFCDB889)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password confirmation',
                        fillColor: Colors.grey[100],
                        filled: true,
                      ),
                      onChanged: (value) {
                        password_confirmation = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: pickImage,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Container(
                        height: 60,
                        width: width*0.35,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Center(
                              child: image != null
                                  ? Image.file(image!)
                                  : Text('Pick image')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 1,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 60,
                        width: width*0.35,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            underline: SizedBox(),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color(0xFF5F5F5F),
                                fontSize: 17
                            ),
                            iconSize: 30,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>[ 'Agency','Customer']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(value),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),

                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            width: width*0.35,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFFCDB889),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: _isLoading == true
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _submit();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          ' Sign in',
                          style: TextStyle(
                            color: Color(0xFFCDB889),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
      Future.delayed(Duration(seconds: 1));
      _isLoading = false;
    });
    // if (username == null ||
    //     first_name == null ||
    //     last_name == null ||
    //     email == null ||
    //     password == null) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('please complete all the fields'),
    //       action: SnackBarAction(
    //         label: 'Close',
    //         onPressed: () {
    //           // Some code to undo the change!
    //         },
    //       ),
    //     ),
    //   );
    // }

    var data = new Map<String, String>();
    data['username'] = username;
    data['account_type']=dropdownValue;
    data['email'] = email;
    // data['firstname'] = first_name;
    // data['lastname'] = last_name;
    if( password_confirmation==password)
    data['password'] = password;
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFFC72C41),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Oh Snap",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Check password confirmation',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }

    // data['password'] = password_confirmation;

    //data['user_id'] = user_id.toString();

    var response = await Api().postDataWithImage(data, '/auth/users/', filePath,'Bearer','avatar');
    //var response = await Api().postData(data, '/auth/users/','Bearer');

    if (response.statusCode == 201) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Great!",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
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
