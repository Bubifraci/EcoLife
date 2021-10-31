import 'package:flutter/material.dart';
import 'action_item.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  int green = 0xFF079102;
  int grey = 0xFF434343;
  int money;

  void submitActivity(int index) {
    switch (index) {
      case 1:
        Navigator.of(context).pop(index);
        break;
      case 2:
        Navigator.of(context).pop(index);
        break;
      case 3:
        if (money < 10) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 4:
        Navigator.of(context).pop(index);
        break;
      case 5:
        Navigator.of(context).pop(index);
        break;
      case 6:
        if (money < 50000) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 7:
        Navigator.of(context).pop(index);
        break;
      case 8:
        Navigator.of(context).pop(index);
        break;
      case 9:
        if (money < 300) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 10:
        if (money < 10) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 11:
        Navigator.of(context).pop(index);
        break;
      case 12:
        Navigator.of(context).pop(index);
        break;
      case 13:
        if (money < 20) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 14:
        Navigator.of(context).pop(index);
        break;
      case 15:
        if (money < 20) {
          Navigator.of(context).pop(index);
        }
        break;
    }
  }

  void notEnoughMoney() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Expanded(
              child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  insetPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 250),
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Du hast nicht genug Geld!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(grey),
                              fontFamily: "Berlin Sans",
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Verstanden.",
                                    style: TextStyle(
                                        color: Color(0xFF00255B), fontSize: 15),
                                  ),
                                ),
                              ],
                            )),
                      ]))),
            ));
  }

  @override
  Widget build(BuildContext context) {
    money = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(green),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop(0);
          },
        ),
        title: Center(
          child: Text(
            "Aktivitäten",
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
      body: ListView(
        children: [
          ActionItem(
            isActivity: true,
            index: 1,
            title: "Buch lesen",
            costs: 0,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 2,
            title: "Spaziergang",
            costs: 0,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 3,
            title: "Feiern",
            costs: 10,
            outcome: {
              "happiness": "/",
              "popularity": "+",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 4,
            title: "YouTube Video",
            costs: 0,
            outcome: {
              "happiness": "/",
              "popularity": "+",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 5,
            title: "Foto hochladen",
            costs: 0,
            outcome: {
              "happiness": "/",
              "popularity": "+",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 6,
            title: "Spenden",
            costs: 50000,
            outcome: {
              "happiness": "/",
              "popularity": "/",
              "freetime": "/",
              "sustainibility": "+"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 7,
            title: "Müll sammeln",
            costs: 0,
            outcome: {
              "happiness": "/",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "+"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 8,
            title: "Heizung runterdrehen",
            costs: 0,
            outcome: {
              "happiness": "-",
              "popularity": "/",
              "freetime": "/",
              "sustainibility": "+"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 9,
            title: "Frei nehmen",
            costs: 300,
            outcome: {
              "happiness": "/",
              "popularity": "-",
              "freetime": "+",
              "sustainibility": "-"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 10,
            title: "Bäume anpflanzen",
            costs: 10,
            outcome: {
              "happiness": "/",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "+"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 11,
            title: "Aufräumen",
            costs: 0,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 12,
            title: "Freunde treffen",
            costs: 0,
            outcome: {
              "happiness": "/",
              "popularity": "+",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 13,
            title: "Kino besuchen",
            costs: 20,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 14,
            title: "Workout",
            costs: 0,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
          ActionItem(
            isActivity: true,
            index: 15,
            title: "Fallschirm springen",
            costs: 20,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "-",
              "sustainibility": "/"
            },
            submit: (int val) => submitActivity(val),
          ),
        ],
      ),
    );
  }
}
