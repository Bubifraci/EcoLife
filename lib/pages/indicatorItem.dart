import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IndicatorItem extends StatefulWidget {
  @required
  String indicated;
  @required
  IconData icon;
  @required
  double percentage;

  IndicatorItem({Key key, this.indicated, this.icon, this.percentage})
      : super(key: key);

  int barColor() {
    if (percentage > 0.5) {
      return 0xFF079102;
    } else if (percentage <= 0.5 && percentage > 0.25) {
      return 0xFFFFE800;
    } else if (percentage <= 0.5 && percentage > 0) {
      return 0xFFFF0000;
    } else {
      return 0xFFC4C4C4;
    }
  }

  @override
  _IndicatorItemState createState() => _IndicatorItemState();
}

class _IndicatorItemState extends State<IndicatorItem> {
  final int grey = 0xFF434343; //Graue Farbe vom Textinhalt
  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width; //Breite des Handys
    double phoneHeight = MediaQuery.of(context).size.height; //Höhe des Handys
    return Stack(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(
            phoneWidth / 50, 0, phoneWidth / 2 + phoneWidth / 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.indicated,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Berlin Sans",
                  color: Color(grey)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Icon(
                widget.icon,
                color: Color(grey),
              ),
            ),
          ],
        ),
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(
              phoneWidth / 2.5, phoneHeight / 90, phoneWidth / 80, 0),
          child: LinearPercentIndicator(
              lineHeight: 10,
              percent: widget.percentage,
              backgroundColor: Colors.grey,
              progressColor: Color(widget.barColor())))
    ]);
  }
}
