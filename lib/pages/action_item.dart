import 'package:flutter/material.dart';

class ActionItem extends StatelessWidget {
  @required
  String title;
  @required
  int costs;
  @required
  Map<String, String> outcome;
  @required
  int index;
  bool isActivity;
  final Function(int) submit;

  ActionItem(
      {this.title,
      this.costs,
      this.outcome,
      this.index,
      this.submit,
      this.isActivity});

  int grey = 0xFF434343;
  int green = 0xFF079102;

  String positiveOutcome() {
    String endSentence = "";
    if (outcome["happiness"] == "+") {
      if (endSentence == "") {
        endSentence += "Glücklichkeit";
      } else {
        endSentence += ", Glücklichkeit";
      }
    }
    if (outcome["popularity"] == "+") {
      if (endSentence == "") {
        endSentence += "Beliebtheit";
      } else {
        endSentence += ", Beliebtheit";
      }
    }
    if (outcome["freetime"] == "+") {
      if (endSentence == "") {
        endSentence += "Freizeit";
      } else {
        endSentence += ", Freizeit";
      }
    }
    if (outcome["sustainibility"] == "+") {
      if (endSentence == "") {
        endSentence += "Nachhaltigkeit";
      } else {
        endSentence += ", Nachhaltigkeit";
      }
    }
    return endSentence;
  }

  String negativeOutcome() {
    String endSentence = "";
    if (outcome["happiness"] == "-") {
      endSentence += ", Glücklichkeit";
    }
    if (outcome["popularity"] == "-") {
      endSentence += ", Beliebtheit";
    }
    if (outcome["freetime"] == "-") {
      endSentence += ", Freizeit";
    }
    if (outcome["sustainibility"] == "-") {
      endSentence += ", Nachhaltigkeit";
    }
    return endSentence;
  }

  @override
  Widget build(BuildContext context) {
    String verb;
    if (isActivity == true) {
      verb = "machen";
    } else {
      verb = "erwerben";
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(grey), width: 0.5),
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontFamily: "Berlin Sans",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(grey)),
                    ),
                    Text(costs.toString() + "€",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontFamily: "Berlin Sans",
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal,
                            color: Color(green)))
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: RichText(
                    overflow: TextOverflow.fade,
                    text: TextSpan(
                        text: positiveOutcome(),
                        style: TextStyle(
                            fontFamily: "Berlin Sans",
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Color(green)),
                        children: [
                          (negativeOutcome() != "")
                              ? TextSpan(
                                  text: negativeOutcome(),
                                  style: TextStyle(
                                      fontFamily: "Berlin Sans",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))
                              : TextSpan(text: "")
                        ]),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(grey),
                  size: 30,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => Expanded(
                            child: Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                insetPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 250),
                                child: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "Bist du sicher, dass du " +
                                              title +
                                              " " +
                                              verb +
                                              " möchtest?",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(1);
                                                },
                                                child: Text(
                                                  "Ja",
                                                  style: TextStyle(
                                                      color: Color(0xFF00255B),
                                                      fontSize: 15),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(2);
                                                },
                                                child: Text(
                                                  "Nein",
                                                  style: TextStyle(
                                                      color: Color(0xFF00255B),
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ]))),
                          )).then((confirm) {
                    if (confirm == 1) {
                      submit(index);
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
