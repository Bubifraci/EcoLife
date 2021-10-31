import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BottomNavItem extends StatelessWidget {
  @required
  final IconData icon;
  @required
  final Color color;
  @required
  final String type;
  List friends;
  int age;
  bool university;
  bool isWorking;
  int money;
  bool alreadyEnteredActivity;
  final int grey = 0xFF434343; //Graue Farbe vom Textinhalt
  final Function(Map) submitWork;
  final Function(int) submitProperty;
  final Function(int) submitActivity;

  BottomNavItem(
      {this.icon,
      this.color,
      this.type,
      this.age,
      this.university,
      this.submitWork,
      this.submitProperty,
      this.isWorking,
      this.friends,
      this.money,
      this.submitActivity,
      this.alreadyEnteredActivity});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: () async {
          switch (type) {
            case "work":
              Navigator.pushNamed(context, "/work", arguments: {
                "alter": age,
                "university": university,
                "canLeave": true,
                "isWorking": isWorking
              }).then((value) {
                submitWork(value);
              });

              break;
            case "activities":
              if (alreadyEnteredActivity == false) {
                Navigator.pushNamed(context, "/activities", arguments: money)
                    .then((value) => submitActivity(value));
              }
              break;
            case "contacts":
              Navigator.pushNamed(context, "/contacts", arguments: friends);
              break;
            case "property":
              Navigator.pushNamed(context, "/property", arguments: money)
                  .then((value) => submitProperty(value));
              break;
          }
        },
        elevation: 2.0,
        fillColor: Colors.white,
        child: Icon(
          icon,
          color: color,
          size: 30,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(side: BorderSide(color: Color(grey), width: 1)),
      ),
    );
  }
}
