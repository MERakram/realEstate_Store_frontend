import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:map_location_picker/generated/l10n.dart' as location_picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../server/api.dart';

class editAccountPage extends StatefulWidget {
  @override
  _editAccountPageState createState() {
    return _editAccountPageState();
  }
}


class _editAccountPageState extends State<editAccountPage> {
  var _accountData;
  var username,email,last_name,first_name;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        location_picker.S.delegate,
      ],
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: _accountData==null?Center(child: CircularProgressIndicator(),):Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ADD OFFER',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      initialValue:_accountData['username'],
                      maxLength: 35,
                      decoration: InputDecoration(
                          counterText:'',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Username',
                          fillColor: Colors.grey[200],
                          filled: true),
                      onChanged: (value) {
                        username = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      initialValue: _accountData['email'],
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
                          fillColor: Colors.grey[200],
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
                    child: TextFormField(
                      initialValue: _accountData['first_name'],
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'First name',
                          fillColor: Colors.grey[200],
                          filled: true),
                      onChanged: (value) {
                        first_name = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      initialValue: _accountData['last_name'],
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCDB889)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'last_name',
                          fillColor: Colors.grey[200],
                          filled: true),
                      onChanged: (value) {
                        last_name = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: _patchoffer,
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFFCDB889),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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

  _loadData() async {
    var response = await Api().getData('/auth/users/me/');
    if (response.statusCode == 200) {
      setState(() {
        _accountData = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }

  void _patchoffer() async {
    // setState(() {
    //   _isLoading = true;
    // });
    var data = new Map<String, String>();
    data['email'] = email==null?_accountData['email']:email;
    data['first_name'] = first_name==null?_accountData['first_name']:first_name;
    //data['user_id'] = user_id.toString();

    data['last_name'] = last_name==null?_accountData['last_name']:last_name;

    // data['image'] = _image.path;

    //var response = await Api().postDataWithImage(data, '/offers', _image.path);
    var response = await Api().patchData(data,'/auth/users/me/');
    if (response.statusCode == 200) {
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