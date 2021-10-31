import 'package:flutter/material.dart';
import 'contacts_item.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  int green = 0xFF079102; //Grüne Farbe der AppBars
  int grey = 0xFF434343; //Graue Farbe vom Textinhalt

  @override
  Widget build(BuildContext context) {
    final List friends = ModalRoute.of(context).settings.arguments;
    print(friends);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(green),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(
              "Kontakte",
              style: TextStyle(
                fontFamily: "Berlin Sans",
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.black54,
                    offset: Offset(1.0, 3.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: (friends.isEmpty == true)
            ? Center(
                child: Text(
                  "Du hast bisher keine Freunde!",
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Berlin Sans",
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Color(grey),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: friends.length,
                itemBuilder: (BuildContext context, int index) {
                  return ContactsItem(friends[index].surname, friends[index].name, friends[index].gender, friends[index].image);
                },
              ));
  }
}
