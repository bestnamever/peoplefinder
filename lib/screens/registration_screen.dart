import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/home_screen.dart';
import 'package:flutter_chat_ui_starter/service/auth.dart';
import 'package:flutter_chat_ui_starter/service/database.dart';
import 'package:flutter_chat_ui_starter/service/helper.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isloading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  register() {
    if (formKey.currentState.validate()) {
      Map<String, String> userMap = {
        "name": userName.text,
        "email": email.text,
      };
      Random random = new Random();
      int xymax = 200;
      int xymin = 100;
      int zmin = 0;
      int zmax = 5;
      int randomx = xymin + random.nextInt(xymax - xymin);
      int randomy = xymin + random.nextInt(xymax - xymin);
      int randomz = zmin + random.nextInt(zmax);
      Map<String, int> locationMap = {
        "x": randomx,
        "y": randomy,
        "z": randomz,
      };

      HelperFunctions.saveUserEmailSharedPreference(email.text);
      HelperFunctions.saveUserNameSharedPreference(userName.text);

      setState(
        () {
          isloading = true;
        },
      );

      authMethods.signUp(email.text, password.text).then(
        (value) {
          _databaseMethods.uploadUserInfo(userName.text, userMap);
          _databaseMethods.setLocation(userName.text, locationMap);
          _databaseMethods.updateLocation(userName.text, locationMap);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("People Finder"),
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(
                  FocusNode(),
                );
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(200, 148, 251, 0.3),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[100]),
                                  ),
                                ),
                                child: TextFormField(
                                  validator: (val) {
                                    return val.isEmpty
                                        ? "Please provide username"
                                        : null;
                                  },
                                  controller: userName,
                                  decoration: InputDecoration(
                                    hintText: "Enter Your UserName...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[100]),
                                  ),
                                ),
                                child: TextFormField(
                                  validator: (val) {
                                    return RegExp(
                                                "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$")
                                            .hasMatch(val)
                                        ? null
                                        : "Please provide a valid email";
                                  },
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Enter Your Email...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[100]),
                                  ),
                                ),
                                child: TextFormField(
                                  validator: (val) {
                                    return val.length > 6
                                        ? null
                                        : "Please provide password";
                                  },
                                  autocorrect: false,
                                  obscureText: true,
                                  controller: password,
                                  decoration: InputDecoration(
                                    hintText: "Enter Your Password...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 6.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                          child: MaterialButton(
                            minWidth: 200.0,
                            height: 40.0,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
