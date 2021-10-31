import 'package:flutter/material.dart';

class WorkItem extends StatelessWidget {
  @required
  String title;
  @required
  String income;
  @required
  String job;
  @required
  bool isWorking;
  int grey = 0xFF434343;
  @required
  final Function(String) submit;

  WorkItem({this.title, this.income, this.job, this.isWorking, this.submit});

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
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (isWorking == false)
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(grey),
                      ),
                      iconSize: 30,
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => Expanded(
                                  child: Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
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
                                                "Bist du sicher, dass du zukünftig als " +
                                                    title +
                                                    " arbeiten möchtest? Die Entscheidung ist nicht rückgängig!",
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
                                                        Navigator.of(context)
                                                            .pop(1);
                                                      },
                                                      child: Text(
                                                        "Ja",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00255B),
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(2);
                                                      },
                                                      child: Text(
                                                        "Nein",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF00255B),
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ]))),
                                )).then((confirm) {
                          if (confirm == 1) {
                            submit(job);
                          }
                        });
                      },
                    )
                  : Icon(
                      Icons.block,
                      color: Color(grey),
                      size: 30,
                    ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Berlin Sans",
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Color(grey)),
                ),
              ),
              SizedBox(width: 0),
              SizedBox(width: 0),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  income,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontFamily: "Berlin Sans",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF079102)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
