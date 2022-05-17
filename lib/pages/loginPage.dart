import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oued_kniss1/pages/pagesFrame.dart';
import 'package:oued_kniss1/pages/registerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../server/SharedPreferencesManager.dart';
import '../server/api.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() {
    return _loginPageState();
  }
}

class _loginPageState extends State<loginPage> {
  bool obscurepass=true;
   bool _passwordVisible=false;
  final usernamefieldText = TextEditingController();
  final passwordfieldText = TextEditingController();
  late SharedPreferences preferences;
  var username, password;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    init();

  }
Future init()async{
    preferences = await SharedPreferences.getInstance();
}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Icon(
                    Icons.star,
                    size: 100,
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Text(
                    'Hello Again!',
                    style: GoogleFonts.bebasNeue(fontSize: 52),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome back, you\'ve been missed',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      controller: usernamefieldText,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_outlined),
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
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      controller: passwordfieldText,
                      obscureText: obscurepass,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              obscurepass=!obscurepass;
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
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
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFCDB889),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _isLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  'Sign in',
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          ' Register now',
                          style: TextStyle(
                            color: Color(0xFFCDB889),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => registerPage()),
                          );
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
    });
    if (username == null || password == null) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please enter your username/password'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change!
            },
          ),
        ),
      );
    } else {
      startTimer();
    }

    var data = new Map<String, String>();
    data['username'] = username;
    data['password'] = password;
    //data['user_id'] = user_id.toString();

    // data['image'] = _image.path;

    //var response = await Api().postDataWithImage(data, '/offers', _image.path);
    var response = await Api().postData(data, '/auth/jwt/create/');
    if (response.statusCode == 200) {
       var body= json.decode(response.body);
       String? accessToken=body['access'];
        preferences.setString('accessToken', '$accessToken');
       clearUsername();clearPassword();FocusScopeNode currentFocus = FocusScope.of(context);
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pagesFrame()),
      );
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('check your login/connection'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change!
            },
          ),
        ),
      );
    } else {
      _showMsg('Error ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
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

  void startTimer() {
    Timer.periodic(const Duration(seconds: 3), (t) {
      setState(() {
        _isLoading = false; //set loading to false
      });
      t.cancel(); //stops the timer
    });
  }
  void clearUsername() {
    usernamefieldText.clear();
  }
  void clearPassword() {
    passwordfieldText.clear();
  }
  void showPassword() {
    passwordfieldText;
  }
}
