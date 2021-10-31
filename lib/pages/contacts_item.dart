import 'package:flutter/material.dart';

class ContactsItem extends StatelessWidget {
  @required
  String surname;
  @required
  String name;
  @required
  String gender;
  @required
  String image;

  ContactsItem(this.surname, this.name, this.gender, this.image);

  int grey = 0xFF434343;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(grey), width: 0.5),
          )),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              text: TextSpan(
                  text: surname + " " + name,
                  style: TextStyle(
                      fontFamily: "Berlin Sans",
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color(grey)),
                  children: [
                    TextSpan(
                        text: " " + gender,
                        style: TextStyle(
                            fontFamily: "Berlin Sans",
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Color(grey)))
                  ]),
            ),
            Image.asset(
              image,
              height: 80,
              width: 80,
            )
          ],
        ),
      ),
    ));
  }
}
