import 'package:flutter/material.dart';
import 'action_item.dart';

class Property extends StatefulWidget {
  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  int green = 0xFF079102;
  int grey = 0xFF434343;
  int money;

  void submitOrder(int index) {
    switch (index) {
      case 1:
        if (money < 350000) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 2:
        if (money < 180000) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 3:
        if (money < 300000) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 4:
        if (money < 200000) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 5:
        if (money < 300000) {
          notEnoughMoney();
        } else {
          Navigator.of(context).pop(index);
        }
        break;
      case 6:
        if (money < 185000) {
          notEnoughMoney();
        } else {
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
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "Kaufen",
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
            index: 1,
            title: "E-Auto",
            costs: 350000,
            outcome: {
              "happiness": "/",
              "popularity": "/",
              "freetime": "+",
              "sustainibility": "+"
            },
            submit: (int val) => submitOrder(val),
          ),
          ActionItem(
            index: 2,
            title: "Benzin-Auto",
            costs: 180000,
            outcome: {
              "happiness": "/",
              "popularity": "/",
              "freetime": "+",
              "sustainibility": "-"
            },
            submit: (int val) => submitOrder(val),
          ),
          ActionItem(
            index: 3,
            title: "Haus",
            costs: 300000,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "/",
              "sustainibility": "/"
            },
            submit: (int val) => submitOrder(val),
          ),
          ActionItem(
            index: 4,
            title: "Wohnung",
            costs: 200000,
            outcome: {
              "happiness": "+",
              "popularity": "/",
              "freetime": "/",
              "sustainibility": "/"
            },
            submit: (int val) => submitOrder(val),
          ),
          ActionItem(
            index: 5,
            title: "Solaranlage",
            costs: 300000,
            outcome: {
              "happiness": "/",
              "popularity": "/",
              "freetime": "/",
              "sustainibility": "+"
            },
            submit: (int val) => submitOrder(val),
          ),
          ActionItem(
            index: 6,
            title: "Rolex",
            costs: 185000,
            outcome: {
              "happiness": "/",
              "popularity": "+",
              "freetime": "/",
              "sustainibility": "/"
            },
            submit: (int val) => submitOrder(val),
          ),
        ],
      ),
    );
  }
}
