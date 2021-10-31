import 'package:flutter/material.dart';
import 'work_item.dart';

class Work extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  int green = 0xFF079102; //Grüne Farbe der AppBars
  int universityExtra;

  void selectJob(String jobVal) {
    Navigator.of(context).pop({"job": jobVal, "isWorking": true});
  }

  @override
  Widget build(BuildContext context) {
    final Map userInfo = ModalRoute.of(context).settings.arguments;
    if (userInfo["university"] == true) {
      universityExtra = 0;
      universityExtra += 500;
    } else {
      universityExtra = 0;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(green),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 40,
            ),
            onPressed: () {
              if (userInfo["canLeave"] == true ||
                  userInfo["isWorking"] == true) {
                Navigator.of(context).pop();
              }
            },
          ),
          title: Center(
            child: Text(
              "Arbeit",
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
        body: ((userInfo["alter"] >= 18 && userInfo["university"] == false) ||
                (userInfo["alter"] >= 21 && userInfo["university"] == true))
            ? ListView(
                children: [
                  WorkItem(
                    title: "Ingenieur/in ",
                    income: (9000 + universityExtra).toString() + "€/Jahr",
                    job: "engineer",
                    submit: (String val) => selectJob(val),
                    isWorking: userInfo["isWorking"],
                  ),
                  WorkItem(
                    title: "Anwalt/in",
                    income: (8400 + universityExtra).toString() + "€/Jahr",
                    job: "lawyer",
                    submit: (String val) => selectJob(val),
                    isWorking: userInfo["isWorking"],
                  ),
                  WorkItem(
                    title: "Botaniker/in",
                    income: (5200 + universityExtra).toString() + "€/Jahr",
                    job: "botanist",
                    submit: (String val) => selectJob(val),
                    isWorking: userInfo["isWorking"],
                  ),
                  WorkItem(
                    title: "IT-Support  ",
                    income: (6300 + universityExtra).toString() + "€/Jahr",
                    job: "it_worker",
                    submit: (String val) => selectJob(val),
                    isWorking: userInfo["isWorking"],
                  ),
                  WorkItem(
                    title: "Kellner/in     ",
                    income: (2200 + universityExtra).toString() + "€/Jahr",
                    job: "waiter",
                    submit: (String val) => selectJob(val),
                    isWorking: userInfo["isWorking"],
                  ),
                ],
              )
            : (userInfo["alter"] >= 18)
                ? Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: Text(
                            "Du studierst gerade, überarbeite dich lieber nicht!",
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Berlin Sans",
                                color: Colors.white,
                                fontSize: 30),
                          ),
                        ),
                      )
                    ],
                  )
                : Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: Text(
                            "Du kannst mit " +
                                userInfo["alter"].toString() +
                                " Jahr/en noch nicht arbeiten!",
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Berlin Sans",
                                color: Colors.white,
                                fontSize: 30),
                          ),
                        ),
                      )
                    ],
                  ));
  }
}
