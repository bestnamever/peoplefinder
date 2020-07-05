import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/intro_screen.dart';
import 'package:flutter_chat_ui_starter/screens/log_page.dart';
import 'package:flutter_chat_ui_starter/widgets/splash_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    setValue();
  }

  void setValue() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      new Timer(
        new Duration(seconds: 2),
        introPress,
      );
    } else {
      new Timer(
        new Duration(seconds: 2),
        logPress,
      );
    }
  }

  void logPress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LogScreen(),
      ),
    );
  }

  void introPress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => IntroScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainSplash();
  }
}
