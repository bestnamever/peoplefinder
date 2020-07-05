import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/service/database.dart';
import 'package:flutter_chat_ui_starter/service/locate.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  Stream userStream;

  @override
  void initState() {
    _databaseMethods.getAllUser().then((value) {
      if (value != null) {
        setState(() {
          userStream = value;
        });
      } else
        print("null");
    });
    super.initState();
  }

  getUser() async {
    _databaseMethods.getAllUser().then((value) {
      if (value != null) {
        setState(() {
          userStream = value;
        });
      } else
        print("nulll");
    });
  }

  // getLocation(userName) async {
  //   _databaseMethods.getSingleLocation(userName).then(
  //     (value) {
  //       setState(() {
  //         _querySnapshot = value;
  //       });
  //     },
  //   );
  //   setState(() {
  //     xcoordinate = _querySnapshot.documents[0].data["x"];
  //     ycoordinate = _querySnapshot.documents[0].data["y"];
  //     zcoordinate = _querySnapshot.documents[0].data["z"];
  //   });
  // }

  Widget userList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return LocationTile(
                  userName: snapshot.data.documents[index].data["name"],
                  xcoordinate: snapshot.data.documents[index].data["x"],
                  ycoordinate: snapshot.data.documents[index].data["y"],
                  zcoordinate: snapshot.data.documents[index].data["z"],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
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
                      'Location',
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
            userList(),
          ],
        ),
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  final String userName;
  final int xcoordinate;
  final int ycoordinate;
  final int zcoordinate;

  const LocationTile(
      {Key key,
      this.userName,
      this.xcoordinate,
      this.ycoordinate,
      this.zcoordinate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
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
                SizedBox(
                  width: 20.0,
                ),
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
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'X-coordinate is: $xcoordinate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Y-coordinate is: $ycoordinate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Z-coordinate is: $zcoordinate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Position',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  //"somethign",
                  Locate().setPosition(xcoordinate, ycoordinate, zcoordinate),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
