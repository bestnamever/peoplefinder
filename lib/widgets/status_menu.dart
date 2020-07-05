import 'package:flutter/material.dart';

class StatusMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String status = "Free";
    return PopupMenuButton(
      icon: Icon(Icons.arrow_drop_down),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      offset: Offset(100,100),
      color: Colors.white,
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              status == "Free"
                  ? Icon(
                      Icons.check,
                      color: Colors.purple[200],
                    )
                  : SizedBox(
                      width: 25.0,
                    ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Free",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          value: "Free",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              status == "Busy"
                  ? Icon(
                      Icons.check,
                      color: Colors.purple[200],
                    )
                  : SizedBox(
                      width: 25.0,
                    ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Busy",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          value: "Busy",
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              status == "Away"
                  ? Icon(
                      Icons.check,
                      color: Colors.purple[200],
                    )
                  : SizedBox(
                      width: 25.0,
                    ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Away",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          value: "Away",
        ),
      ],
      onSelected: (value) {
        status = "$value";
      },
    );
  }
}
