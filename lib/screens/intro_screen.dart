import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/log_page.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreeneState createState() => _IntroScreeneState();
}

class _IntroScreeneState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Chats",
        description:
            "Don't know whether is he/she available? Search with name and start chating!",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "Find them",
        description:
            "Wanna know where are the people? Slide to the location page and Find where they are",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "Go for him/her",
        description:
            "Have to talk to him/she face by face? Don't hesitate, click the button and see where is he/she",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
