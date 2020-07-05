import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/home_screen.dart';
import 'package:flutter_chat_ui_starter/service/constants.dart';
import 'package:flutter_chat_ui_starter/service/database.dart';
import 'package:flutter_chat_ui_starter/widgets/status_menu.dart';

class ChatScreen extends StatefulWidget {
  final String targetUserName;
  final String currentUserName;
  final String chatRoomId;

  ChatScreen({
    this.targetUserName,
    this.chatRoomId,
    this.currentUserName,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  TextEditingController _textEditingController = new TextEditingController();
  ScrollController _controller = new ScrollController();
  Stream chatMessageStream;
  bool first = true;

  sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": _textEditingController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      _databaseMethods.addMessages(widget.chatRoomId, messageMap);
      _textEditingController.text = "";
    }
  }

  @override
  void initState() {
    _databaseMethods.getMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    super.initState();
  }

  _buildMessage(String message, bool isMe) {
    first
        ? Timer(Duration(milliseconds: 10),
            () => _controller.jumpTo(_controller.position.maxScrollExtent))
        : Text("");
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 7.0,
              bottom: 8.0,
              left: 60.0,
            )
          : EdgeInsets.only(
              top: 7.0,
              bottom: 8.0,
              right: 60.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   message.time,
          //   style: TextStyle(
          //     color: Colors.blueGrey,
          //     fontSize: 16.0,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          SizedBox(height: 8.0),
          Text(
            message,
            //message.text,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
    //   else {
    //     Column(
    //       children: <Widget>[
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Text(
    //                 "No user has been selected",
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     );
    //   }
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            iconSize: 25.0,
            onPressed: widget.targetUserName != null
                ? () {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(
                              currentuser: widget.targetUserName,
                              selectedindex: 2,
                            ),
                          ),
                        );
                      },
                    );
                  }
                : () {},
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              onPressed: () {
                sendMessage();
                _controller.jumpTo(_controller.position.maxScrollExtent);
                first = false;
                FocusScope.of(context).unfocus();
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: Text(
          widget.targetUserName,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple[200],
        elevation: 0.0,
        actions: <Widget>[
          StatusMenu(),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: StreamBuilder(
                    stream: chatMessageStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null)
                        return Center(child: Text("empty"));
                      return ListView.builder(
                        controller: _controller,
                        reverse: false,
                        padding: EdgeInsets.only(top: 15.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String message =
                              snapshot.data.documents[index].data["message"];
                          final bool isMe =
                              snapshot.data.documents[index].data["sendBy"] ==
                                  Constants.myName;
                          return _buildMessage(message, isMe);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer()
          ],
        ),
      ),
    );
  }
}
