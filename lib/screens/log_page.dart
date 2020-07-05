import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/login_screen.dart';
import 'package:flutter_chat_ui_starter/screens/registration_screen.dart';
import 'package:flutter_chat_ui_starter/widgets/custom_button.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.purple[200],
    //   ),
    //   child: Column(
    //     children: <Widget>[
    //       Expanded(
    //         child: Container(
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(30.0),
    //               topRight: Radius.circular(30.0),
    //             ),
    //             color: Colors.white,
    //           ),
    //           padding: EdgeInsets.only(top: 0),
    //           margin: EdgeInsets.only(top: height * 0.25),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Container(
    //                 height: height * 0.5,
    //                 width: width * 0.8,
    //                 padding: EdgeInsets.only(
    //                   bottom: height * 0.1,
    //                 ),
    //                 decoration: BoxDecoration(
    //                   image: new DecorationImage(
    //                     image: new AssetImage('assets/images/Flogo.png'),
    //                   ),
    //                 ),
    //               ),
    //               RichText(
    //                 text: TextSpan(
    //                   text: "People ",
    //                   style: TextStyle(
    //                     fontSize: 40.0,
    //                     color: Colors.black,
    //                   ),
    //                   children: <TextSpan>[
    //                     TextSpan(
    //                       text: "Find",
    //                       style: TextStyle(
    //                         fontSize: 40.0,
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                     TextSpan(
    //                       text: "er",
    //                       style: TextStyle(
    //                         fontSize: 40.0,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.purple[300],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset("assets/images/logo.jpg"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: "People ",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Find",
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "er",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Custombutton(
            text: "Log In",
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                ),
              );
            },
          ),
          Custombutton(
            text: "Register",
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Registration(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
