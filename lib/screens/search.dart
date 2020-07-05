import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_ui_starter/screens/chat_screen.dart';
import 'package:flutter_chat_ui_starter/service/constants.dart';
import 'package:flutter_chat_ui_starter/service/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  TextEditingController search = new TextEditingController();

  QuerySnapshot _querySnapshot;

  bool first = true;

  _search() {
    _databaseMethods.getUser(search.text).then(
      (val) {
        setState(() {
          _querySnapshot = val;
          first = false;
        });
      },
    );
  }

  getChatRoomId(String a, String b) {
    if (b.length < a.length) {
      return "$b\_$a";
    } else if (a.length < b.length) {
      return "$a\_$b";
    } else {
      for (int i = 0; i < a.length; i++) {
        if (a.substring(i, (i+1)).codeUnitAt(0) >
            b.substring(i, (i+1)).codeUnitAt(0)) {
          return "$b\_$a";
        } else if (a.substring(i, (i+1)).codeUnitAt(0) <
            b.substring(i, (i+1)).codeUnitAt(0)) {
          return "$a\_$b";
        }
      }
      // if (a.substring(0, 1).codeUnitAt(0) >= b.substring(0, 1).codeUnitAt(0)) {
      //   return "$b\_$a";
      // } else {
      //   return "$a\_$b";
      // }
    }
  }

  createChatRoom(String userName) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      _databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatRoomId: chatRoomId,
            targetUserName: userName,
            currentUserName: Constants.myName,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Can not chat with yourself',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 8),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(_);
                          },
                          child: Text(
                            'sure',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget searchList() {
    return _querySnapshot != null && _querySnapshot.documents.length != 0
        ? Expanded(
            child: ListView.builder(
              itemCount: _querySnapshot.documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SearchTile(
                  userName: _querySnapshot.documents[index].data["name"],
                  userEmail: _querySnapshot.documents[index].data["email"],
                );
              },
            ),
          )
        : !first
            ? _querySnapshot.documents.length == 0
                ? Center(
                    child: Text(
                      "No user found",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container()
            : Container();
  }

  Widget SearchTile({String userName, String userEmail}) {
    return GestureDetector(
      onTap: () {
        createChatRoom(userName);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 10.0,
          top: 10.0,
          right: 10.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(150, 0, 151, 0.2),
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage("assets/images/questionmark.jpg"),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        userEmail,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'People Finder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple[200],
        elevation: 0.0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(100, 100, 251, 0.3),
                              blurRadius: 20.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: search,
                          decoration: InputDecoration(
                            hintText: "search username...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    IconButton(
                      padding: EdgeInsets.all(10),
                      icon: Icon(Icons.search),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () {
                        _search();
                      },
                    ),
                  ],
                ),
              ),
              searchList(),
            ],
          ),
        ),
      ),
    );
  }
}
