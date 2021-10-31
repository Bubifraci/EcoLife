import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  @required
  int age;
  @required
  String content;
  int blue = 0xFF00255B; //Blaue Farbe der Textüberschrift
  int grey = 0xFF434343; //Graue Farbe vom Textinhalt
  TextWidget(this.age, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Alter: " + age.toString(),
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Berlin Sans",
                    color: Color(blue)),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                content,
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Berlin Sans",
                    color: Color(grey)),
              ))
            ],
          )
        ],
      ),
    );
  }
}
