import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/chat_screen.dart';
import 'package:flutter_chat_ui_starter/screens/log_page.dart';
import 'package:flutter_chat_ui_starter/screens/search.dart';
import 'package:flutter_chat_ui_starter/service/auth.dart';
import 'package:flutter_chat_ui_starter/service/constants.dart';
import 'package:flutter_chat_ui_starter/service/database.dart';
import 'package:flutter_chat_ui_starter/service/helper.dart';
import 'package:flutter_chat_ui_starter/widgets/favorite_contacts.dart';
import 'package:flutter_chat_ui_starter/widgets/location.dart';

import 'package:flutter_chat_ui_starter/widgets/single_location.dart';
import 'package:flutter_chat_ui_starter/widgets/status_menu.dart';

class HomeScreen extends StatefulWidget {
  final int selectedindex;
  final String currentuser;
  HomeScreen({
    this.currentuser,
    this.selectedindex,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  AuthMethods _authMethods = new AuthMethods();
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: chatRoomStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return ChatRoomTile(
                  userName:
                      snapshot.data.documents[index].data["users"].first !=
                              Constants.myName
                          ? snapshot.data.documents[index].data["users"].first
                          : snapshot.data.documents[index].data["users"].last,
                  chatRoomId: snapshot.data.documents[index].data["chatroomId"],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.selectedindex == null ? 0 : widget.selectedindex,
    );
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    _databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
          StatusMenu(),
        ],
        bottom: new TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.contacts,
                size: 20.0,
              ),
              text: "CONTACTS",
            ),
            Tab(
              icon: Icon(
                Icons.map,
                size: 20.0,
              ),
              text: "LOCATIONS",
            ),
            Tab(
              icon: Icon(
                Icons.people,
                size: 20.0,
              ),
              text: "TARGET USER",
            )
          ],
          controller: tabController,
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(Constants.myName),
              accountEmail: new Text(Constants.myEmail),
              currentAccountPicture: new GestureDetector(
                onTap: () => print('current user'),
                child: new CircleAvatar(
                  backgroundImage: AssetImage('assets/images/greg.jpg'),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.purple[100],
              ),
            ),
            new ListTile(
              title: new Text('Home page'),
              trailing: new Icon(Icons.add_to_home_screen),
              onTap: () {
                tabController.index = 0;
                Navigator.of(context).pop();
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text('Log out'),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () {
                _authMethods.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          new Column(
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                height: 40.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Contacts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              chatRoomList(),
            ],
          ),
          new Column(
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              //Location(),
              LocationPage(),
            ],
          ),
          new Column(
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              SingleLocationPage(widget.currentuser),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  const ChatRoomTile({Key key, this.userName, this.chatRoomId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.45,
                    //   child: Text(
                    //     Constants.myEmail,
                    //     style: TextStyle(
                    //       color: Colors.blueGrey,
                    //       fontSize: 15.0,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
