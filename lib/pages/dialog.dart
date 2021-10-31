import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DialogEvent extends StatelessWidget {
  @required
  String imageAsset;
  @required
  String eventText;
  @required
  int amountBut;
  @required
  bool showImageText;
  @required
  String imageText;
  String butOneText;
  String butTwoText;
  String butThreeText;

  DialogEvent(
      this.imageAsset, this.eventText, this.amountBut, this.showImageText,
      [this.imageText, this.butOneText, this.butTwoText, this.butThreeText]);

  int grey = 0xFF434343; //Graue Farbe vom Textinhalt
  int blue = 0xFF00255B; //Blaue Farbe für Buttons
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 210),
      child: Expanded(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    imageAsset,
                    width: 100,
                    height: 100,
                  )),
              Padding(
                padding: EdgeInsets.all(5),
                child: (showImageText == true)
                    ? AutoSizeText(
                        imageText,
                        maxLines: 1,
                        maxFontSize: 15,
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Berlin Sans",
                        ),
                      )
                    : Container(),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: AutoSizeText(
                  eventText,
                  maxLines: 5,
                  maxFontSize: 20,
                  style: TextStyle(
                    color: Color(grey),
                    fontFamily: "Berlin Sans",
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: (amountBut == 1)
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: AutoSizeText("Verstanden!",
                            maxLines: 1,
                            minFontSize: 5,
                            style: TextStyle(color: Color(blue), fontSize: 15)),
                      )
                    : Container(),
              ),
              (amountBut == 2)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(1);
                          },
                          child: AutoSizeText(
                            butOneText,
                            maxLines: 1,
                            minFontSize: 5,
                            style: TextStyle(color: Color(blue), fontSize: 15),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(2);
                          },
                          child: AutoSizeText(
                            butTwoText,
                            maxLines: 1,
                            minFontSize: 5,
                            style: TextStyle(color: Color(blue), fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              (amountBut == 3)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(1);
                          },
                          child: AutoSizeText(
                            butOneText,
                            maxLines: 1,
                            minFontSize: 5,
                            style: TextStyle(color: Color(blue), fontSize: 15),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(2);
                          },
                          child: AutoSizeText(
                            butTwoText,
                            maxLines: 1,
                            minFontSize: 5,
                            style: TextStyle(color: Color(blue), fontSize: 15),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(3);
                          },
                          child: AutoSizeText(
                            butThreeText,
                            maxLines: 1,
                            minFontSize: 5,
                            style: TextStyle(color: Color(blue), fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
