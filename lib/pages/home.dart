import 'dart:ui';
import 'package:eco_life/pages/dialog.dart';
import 'package:eco_life/pages/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bottomNavItem.dart';
import 'indicatorItem.dart';
import 'dart:math';
import 'friend.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isGameOver = false; //Prüft, ob das Spiel zuende ist
  int whichBut; //Dafür zuständig, einzusehen, welcher Knopf beim Dialog gedrückt wurde
  double popularity = 1.0; //Beliebtheit
  double freetime = 1.0; //Ruf
  double sustainibility = 1.0; //Nachhalitgkeit
  double happiness = 1.0; //Glücklichkeit
  int money = 0; //Kontostand
  int income = 0; //Jährliches Einkommen
  int previousEvent; //1 für Job, 2 für Freundschaft, 3 für Casual, 4 für Quizfrage, 5 für Nichts
  int currentEvent; //Berechnet Zufallszahl in Event um, Werte dieselbe wie oben
  String gender; //Geschlecht des Freunds
  String surname; //Zufällig ausgewählter Vorname
  String name; //Zufällig ausgewählter Nachname
  bool isWorking = false; //Prüft, ob der Spieler arbeitet
  bool alreadyEnteredActivity =
      false; //Dafür zuständig, dass Aktivitäten nicht zweimal hintereinander ausgeführt werden können (und nicht unter 12 ausgeführt werden können)
  List<Friend> friends = []; //Liste aller Kontakte

  void calculateIncome() {
    int universityExtra = 0;
    if (university == true) {
      universityExtra += 500;
    }
    setState(() {
      switch (job) {
        case "engineer":
          income = 9000 + universityExtra;
          freetime -= 0.5;
          break;
        case "lawyer":
          income = 8400 + universityExtra;
          freetime -= 0.4;
          break;
        case "botanist":
          income = 5200 + universityExtra;
          freetime -= 0.3;
          break;
        case "it_worker":
          income = 6300 + universityExtra;
          freetime -= 0.35;
          break;
        case "waiter":
          income = 2200 + universityExtra;
          freetime -= 0.2;
          break;
      }
    });
  }

  void restartGame() {
    setState(() {
      age = 0;
      popularity = 1.0;
      freetime = 1.0;
      sustainibility = 1.0;
      happiness = 1.0;
      money = 0;
      income = 0;
      isWorking = false;
      alreadyEnteredActivity = true;
      friends = [];
      random = new Random();
      gymnasium = false;
      university = false;
      job = "";
      textWidgets = [];
      isGameOver = false;
    });
  }

  void gameOver() {
    setState(() {
      if (age < 100) {
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
                                "Einer deiner Bedürfnisse war zu niedrig, Game Over. Möchtest du ein neues Spiel starten oder das Spiel beenden?",
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
                                        Navigator.of(context).pop(1);
                                      },
                                      child: Text(
                                        "Neustarten.",
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
                                        "Beenden.",
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
            restartGame();
          } else if (confirm == 2) {
            SystemNavigator.pop();
          }
        });
      } else {
        double score = (happiness + popularity + (sustainibility * 2) + freetime) * 10;
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
                                "Glückwunsch, du hast das Spiel mit einer Punktzahl von " + score.toString() + " durchgespielt. Möchtest du das Spiel neustarten oder beenden?",
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
                                        Navigator.of(context).pop(1);
                                      },
                                      child: Text(
                                        "Neustarten.",
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
                                        "Beenden.",
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
            restartGame();
          } else if (confirm == 2) {
            SystemNavigator.pop();
          }
        });
      }
    });
  }

  void calculateEvent() {
    occasionChance = random.nextInt(99);
    if (occasionChance < 15) {
      currentEvent = 1;
    } else if (occasionChance >= 15 && occasionChance < 35) {
      currentEvent = 2;
    } else if (occasionChance >= 35 && occasionChance < 70) {
      currentEvent = 3;
    } else if (occasionChance >= 70 && occasionChance < 85) {
      currentEvent = 4;
    } else {
      currentEvent = 5;
    }
  }

  void getEvent() {
    if (eventCounter == 5) {
      while (previousEvent == currentEvent) {
        calculateEvent();
      }
      eventCounter = 0;
    } else {
      calculateEvent();
    }
    if (currentEvent == 1) {
      //Job
      if (previousEvent == 1) {
        eventCounter += 1;
      } else {
        eventCounter = 0;
      }
      previousEvent = 1;
      switch (occasionChance) {
        case 0:
          eventText =
              "Dein Boss fragt dich, wie zufrieden du mit deinen aktuellen Arbeitsverhältnissen bist. Was sagst du?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Zufrieden.";
          butTwoText = "Unzufrieden.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 1:
          eventText =
              "Dir wird eine Beförderung angeboten, wenn du diese Antwort richtig beantwortest! Was ergibt 9(21-12)*4+3?";
          isDialog = true;
          amountBut = 3;
          butOneText = "123";
          butTwoText = "537";
          butThreeText = "321";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 2:
          eventText =
              "Dein Boss ist mit deiner Arbeitseinstellung unzufrieden. Dein Gehalt wird verringert!";
          isDialog = true;
          amountBut = 1;
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 3:
          eventText =
              "Deine Arbeitskollegen wollen am Wochenende feiern gehen. Gehst du mit?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Klar!";
          butTwoText = "Nein.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 4:
          eventText =
              "Du siehst einen Arbeitskollegen dabei, wie er seine Aufgabe absichtlich ignoriert. Was tust du?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Ihn warnen.";
          butTwoText = "Ignorieren.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 5:
          eventText =
              "Ein Arbeitskollege öffnet das Fenster bei -8 Grad, wodurch alle frieren. Was tust du?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Das Fenster schließen.";
          butTwoText = "Nichts.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 6:
          eventText =
              "Deine Arbeitskollegen wollen am Wochenende tanzen gehen. Willst du auch tanzen gehen?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Klar!";
          butTwoText = "Nein.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 7:
          eventText = "Glückwunsch, du wurdest befördert!";
          isDialog = true;
          amountBut = 1;
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 8:
          eventText =
              "Deine Arbeitskollegen gehen zum Oktoberfest. Gehst du mit?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Klar!";
          butTwoText = "Nein.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 9:
          eventText = "Ein Kollege beleidigt dich ohne Grund. Was tust du?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Beschweren.";
          butTwoText = "Kontern.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 10:
          eventText =
              "Du rutschst auf einer Banane aus. Deine Arbeitskollegen lachen dich aus! Wie reagierst du?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Mitlachen.";
          butTwoText = "Schämen.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 11:
          eventText =
              "Dein Boss verringert dein Lohn, wenn du folgende Frage nicht beantworten kannst: Was ist die Hauptstadt vom Land unseres Handelspartners, nämlich die Italiens?";
          isDialog = true;
          amountBut = 3;
          butOneText = "Rom.";
          butTwoText = "Neapel.";
          butThreeText = "Venedig.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 12:
          eventText =
              "Dein Boss fragt dich, ob du mehr Stunden arbeiten, aber dafür einen höheren Lohn erhalten möchtest.";
          isDialog = true;
          amountBut = 2;
          butOneText = "Ja.";
          butTwoText = "Nein.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 13:
          eventText =
              "Bei einem neuen Projekt, an dem du arbeitest, kannst du entweder effizient, dafür aber nicht umweltfreundlich oder ineffizient, aber dafür umweltfreundlich arbeiten. Welche Methode nimmst du?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Ersteres.";
          butTwoText = "Zweiteres.";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
        case 14:
          eventText =
              "Es wird aktuell abgestimmt, ob eine Kaffeemaschine für jeden einzelnen Arbeiter angeschafft werden soll. Dies würde die Arbeiter zwar glücklich machen, die dafür verwendeten Ressourcen würden jedoch nicht umweltfreundlich erwirtschaftet werden. Für was stimmst du?";
          isDialog = true;
          amountBut = 2;
          butOneText = "Für Kaffeemaschine!";
          butTwoText = "Gegen Kaffeemaschine!";
          eventImage = "assets/images/job.png";
          showImageText = false;
          break;
      }
    } else if (currentEvent == 2) {
      //Freundschaft
      if (previousEvent == 2) {
        eventCounter += 1;
      } else {
        eventCounter = 0;
      }
      previousEvent = 2;
      isDialog = true;
      showImageText = true;
      amountBut = 2;
      butOneText = "Befreunden!";
      butTwoText = "Nicht befreunden!";
      //Liste der Vornamen
      List surnames = [
        "Noah",
        "Leon",
        "Paul",
        "Matteo",
        "Ben",
        "Elias",
        "Finn",
        "Felix",
        "Henry",
        "Luis",
        "Emilia",
        "Hannah",
        "Emma",
        "Sophia",
        "Mia",
        "Lina",
        "Mila",
        "Ella",
        "Lea",
        "Clara"
      ];
      List names = [
        "Müller",
        "Schmidt",
        "Schneider",
        "Fischer",
        "Weber",
        "Meyer",
        "Wagner",
        "Becker",
        "Schulz",
        "Hoffmann",
        "Schäfer",
        "Koch",
        "Bauer",
        "Richter",
        "Klein",
        "Wolf",
        "Schröder",
        "Neumann",
        "Schwarz",
        "Zimmermann"
      ];
      randomFriend =
          random.nextInt(19); //Zufällige Zahl, um Vornamen zu bestimmen
      if (randomFriend <= 9) {
        gender =
            "männlich"; //Wenn Vorname 1-10 (alle männliche Namen), dann Geschlecht männlich
      } else {
        gender =
            "weiblich"; //Wenn Vorname 11-20 (alle weibliche Namen), dann Geschlecht weiblich
      }
      surname = surnames[
          randomFriend]; //zufälliger Vorname aus Liste wird der Vorname String zugewiesen
      randomFriend = random.nextInt(19); //neue zufällige Zahl für Nachname
      name = names[
          randomFriend]; //zufälliger Nachname aus Liste wird der Nachname String zugewiesen
      imageText = surname + " " + name;
      randomFriend = random.nextInt(15);
      while (randomFriend == 0) {
        randomFriend = random.nextInt(15);
      }
      if (gender == "männlich") {
        eventImage = "assets/images/male" + randomFriend.toString() + ".png";
      } else if (gender == "weiblich") {
        eventImage = "assets/images/female" + randomFriend.toString() + ".png";
      } else {
        eventImage = "assets/images/plant.png";
      }
      eventText = surname +
          " " +
          name +
          " würde gerne mit dir befreundet sein, was hälst du davon?";
    } else if (currentEvent == 3) {
      //Casual
      if (previousEvent == 3) {
        eventCounter += 1;
      } else {
        eventCounter = 0;
      }
      previousEvent = 3;
      switch (occasionChance) {
        case 35:
          eventText =
              "Auf dem Weg nach Hause siehst du weggeworfene Plastikflaschen. Was machst du?";
          amountBut = 2;
          butOneText = "Sie entsorgen.";
          butTwoText = "Ignorieren.";
          break;
        case 36:
          eventText = "Du bist auf einer Feier, was willst du tun?";
          amountBut = 3;
          butOneText = "TANZEN.";
          butTwoText = "Unterhalten.";
          butThreeText = "Verlassen.";
          break;
        case 37:
          eventText = "Willst du Sport machen?";
          amountBut = 2;
          butOneText = "Gerne.";
          butTwoText = "Nein.";
          break;
        case 38:
          eventText =
              "Du machst mal wieder einen deiner schönen Spaziergänge durch die Innenstadt Lippstadts, als dir plötzlich eine verlassene Katze auffällt. Was tust du?";
          amountBut = 2;
          butOneText = "Aufnehmen.";
          butTwoText = "Ignorieren.";
          break;
        case 39:
          eventText =
              "Einer deiner Freunde fragt dich, wen du besser findest: Queen oder David Bowie?";
          amountBut = 2;
          butOneText = "Queen.";
          butTwoText = "David Bowie.";
          break;
        case 40:
          eventText =
              "Einer deiner Freunde möchte mit dir in den neuen James Bond gehen, was hälst du davon?";
          amountBut = 2;
          butOneText = "Hingehen.";
          butTwoText = "Zuhause bleiben.";
          break;
        case 41:
          eventText =
              "Du wolltest ganz normal nach Hause gehen, als dir ein Obdachloser auffällt. Was machst du?";
          amountBut = 2;
          butOneText = "Spenden.";
          butTwoText = "Ignorieren.";
          break;
        case 42:
          eventText =
              "Hey, du hast 1€ auf dem Boden gefunden. Heute ist wohl dein Glückstag!";
          amountBut = 1;
          break;
        case 43:
          eventText =
              "Du hast bei einem Gewinnspiel gewonnen! Du kannst entweder eine Reise in die Vereinigten Staat oder eine Reise nach Australien veranstalten. Wofür entscheidest du dich?";
          amountBut = 2;
          butOneText = "USA.";
          butTwoText = "Australien.";
          break;
        case 44:
          eventText =
              "Während eines Ausfluges in Berlin triffst du auf Bruno Mars, welcher aktuell Deutschland besucht! Was machst du?";
          amountBut = 3;
          butOneText = "Autogramm!";
          butTwoText = "Selfie!";
          butThreeText = "Nichts.";
          break;
        case 45:
          eventText = "Einige Rüpel überfallen dich. Du verlierst 1000€!";
          amountBut = 1;
          break;
        case 46:
          eventText =
              "Als du nach Hause kommst, bemerkst du, dass du deine Geldtasche mit 950€ in Bar verloren hast! Blöd gelaufen.";
          amountBut = 1;
          break;
        case 47:
          eventText = "Du kannst nicht einschlafen, was machst du?";
          amountBut = 2;
          butOneText = "Lesen.";
          butTwoText = "FEIERN!";
          break;
        case 48:
          eventText =
              "Oh nein, dein Ofen ist kaputt gegangen. Steigst du lieber auf die nachhaltigere Variante um, welche 5000€ kostet, oder lässt du den aktuellen Ofen einfach reparieren (200€)?";
          amountBut = 2;
          butOneText = "Neuer Ofen.";
          butTwoText = "Reparieren.";
          break;
        case 49:
          eventText =
              "Eine nette fremde Person schenkt dir aus dem Nichts 100€. Nimmst du das Geld an?";
          amountBut = 2;
          butOneText = "Ja.";
          butTwoText = "Nein.";
          break;
        case 50:
          eventText =
              "Demnächst findet ein Tanzwettbewerb statt. Da du ja so ein guter Tänzer bist, überlegst du, ob es wohl lohnenswert wäre, daran teilzunehmen. Schließlich sammelt man so neue Erfahrungen!";
          amountBut = 2;
          butOneText = "Teilnehmen.";
          butTwoText = "Nicht teilnehmen.";
          break;
        case 51:
          eventText =
              "Im Supermarkt musst du entscheiden, ob du lieber das günstigere Fleisch aus Massentierzuchthaltung kaufst oder doch lieber das teure aber aus glücklichen Farmen stammende Fleisch kaufst.";
          amountBut = 2;
          butOneText = "Günstig.";
          butTwoText = "Teuer.";
          break;
        case 52:
          eventText =
              "Du hast dich dazu entschlossen, ein Instrument zu lernen! Welches möchtest du lernen?";
          amountBut = 2;
          butOneText = "Klavier.";
          butTwoText = "Klarinette.";
          break;
        case 53:
          eventText =
              "Du merkst, dass plötzlich alle deine Freunde die Plattform Discord verwenden. Möchtest du auch umsteigen?";
          amountBut = 2;
          butOneText = "Gerne.";
          butTwoText = "Nein.";
          break;
        case 54:
          eventText =
              "Vor Kurzem wurden die neuen Konsolen von xBox und Playstation vorgestellt. Kaufst du dir lieber die leistungsstärkere xBox, oder die Playstation mit besseren Exclusives?";
          amountBut = 2;
          butOneText = "Playstation.";
          butTwoText = "xBox.";
          break;
        case 55:
          eventText =
              "Deine Freunde laden dich zum Karaoke ein. Wirst du zusagen?";
          amountBut = 2;
          butOneText = "Ja";
          butTwoText = "Nein";
          break;
        case 56:
          eventText =
              "Deine Stadt eröffnet einen neuen Park, in dem jeder Bürger einen Baum einpflanzen darf. Möchtest du ein Baum einpflanzen?";
          amountBut = 2;
          butOneText = "Ja.";
          butTwoText = "Nein.";
          break;
        case 57:
          eventText = "Dein Opa hat Geburtstag! Gratulierst du ihm?";
          amountBut = 2;
          butOneText = "Selbstverständlich!";
          butTwoText = "Nein.";
          break;
        case 58:
          eventText = "Du verlässt das Haus, worauf achtest du?";
          amountBut = 3;
          butOneText = "Snacks dabei?";
          butTwoText = "Geräte aus?";
          butThreeText = "Fahrzeit?";
          break;
        case 59:
          eventText =
              "Du musst wegen eines Schlussverkaufs schnell in die nächste Stadt, wie kommst du dahin?";
          amountBut = 2;
          butOneText = "Zug.";
          butTwoText = "Auto.";
          break;
        case 60:
          eventText =
              "Du möchtest gerne München besichtigen, die Züge sind dir jedoch zu teuer. Wie kommst du dahin?";
          amountBut = 3;
          butOneText = "Schöne Fahrradtour!";
          butTwoText = "Flugzeug.";
          butThreeText = "Gar nicht.";
          break;
        case 61:
          eventText = "Hier sind 50€ zu deinem Geburtstag!";
          amountBut = 1;
          break;
        case 62:
          eventText =
              "Bei einer Diskussion mit einem Freund von dir geht es darum, ob man beim Kopfstand wohl essen kann. Was glaubst du?";
          amountBut = 2;
          butOneText = "Möglich.";
          butTwoText = "Nicht möglich.";
          break;
        case 63:
          eventText =
              "Du hast dich dazu entschieden, dich gesünder zu ernähren. Was kannst du dann wohl zu Mittag essen?";
          amountBut = 3;
          butOneText = "Mageres Fleisch.";
          butTwoText = "Salat.";
          butThreeText = "Süppchen.";
          break;
        case 64:
          eventText =
              "Wie jedes Jahr schaust du dir die Eurovision an. Dabei fällt dir auf, dass du mal selbst das Singen ausprobieren könntest. Willst du mit deinen Freunden mal ein Karaokeabend machen?";
          amountBut = 2;
          butOneText = "Ja klar!";
          butTwoText = "Nein.";
          break;
        case 65:
          eventText =
              "Du zockst wie immer mal wieder EcoLife auf deinem Handy, als es dir plötzlich in den Fluss reinfällt. Zum Glück ist dein Handy wasserfest, springst du nun also rein, um dein Handy zu retten, oder kaufst du dir lieber ein Neues?";
          amountBut = 2;
          butOneText = "Retten.";
          butTwoText = "Neues.";
          break;
        case 66:
          eventText =
              "Du bist wieder mal in der Stadt und kriegst langsam Hunger. Was kaufst du dir zum Essen?";
          amountBut = 3;
          butOneText = "Döner.";
          butTwoText = "Pizza.";
          butThreeText = "Sushi";
          break;
        case 67:
          eventText =
              "Du versuchst dir das Kochen beizubrigen, indem du Tikka Masala zubereitest. Dabei vergisst du, welches Fleisch benutzt wird, welches war es gleich nochmal?";
          amountBut = 3;
          butOneText = "Schwein";
          butTwoText = "Rind";
          butThreeText = "Huhn";
          break;
        case 68:
          eventText =
              "Du lernst gerade Französisch, als dir auffällt, wie schwer die Sprache eigentlich ist. Investierst du mehr Zeit, um die Sprache zu lernen, oder gibst du auf?";
          amountBut = 2;
          butOneText = "Weitermachen.";
          butTwoText = "Aufgeben.";
          break;
        case 69:
          eventText =
              "Auf einer Reise durch London fragst du dich, was du zuerst besuchen solltest.";
          amountBut = 3;
          butOneText = "Shard.";
          butTwoText = "London Eye.";
          butThreeText = "Buckingham Palace.";
          break;
      }
      isDialog = true;
      showImageText = false;
      eventImage = "assets/images/tree.png";
    } else if (currentEvent == 4) {
      //Quiz
      if (previousEvent == 4) {
        eventCounter += 1;
      } else {
        eventCounter = 0;
      }
      previousEvent = 4;

      switch (occasionChance) {
        case 70:
          eventText =
              "Quiz: Welche dieser Tierarten ist vom Aussterben bedroht?";
          amountBut = 3;
          butOneText = "Seehunde";
          butTwoText = "Haie";
          butThreeText = "Erdmännchen";
          break;
        case 71:
          eventText = "Quiz: Wo ist Feinstaub enthalten?";
          amountBut = 2;
          butOneText = "Fahrzeugauswurf.";
          butTwoText = "Atomkraftwerke.";
          break;
        case 72:
          eventText =
              "Quiz: Bringt das Runterdrehen der Heizung etwas für die Umwelt?";
          amountBut = 3;
          butOneText = "Ja.";
          butTwoText = "Nein.";
          butThreeText = "Manchmal.";
          break;
        case 73:
          eventText = "Quiz: Was ist umweltfreundlicher, Glühbirnen oder LEDs?";
          amountBut = 2;
          butOneText = "Glühbirnen.";
          butTwoText = "LEDs.";
          break;
        case 74:
          eventText =
              "Quiz: In welcher Form findet man Plastik am häufigsten in den Ozeanen?";
          amountBut = 2;
          butOneText = "Verpackungen.";
          butTwoText = "Zigarettenfilter.";
          break;
        case 75:
          eventText =
              "Quiz: Wo liegt die größte Fläche zusammenhängenden Regenwalds?";
          amountBut = 3;
          butOneText = "Asien.";
          butTwoText = "Südamerika.";
          butThreeText = "Afrika.";
          break;
        case 76:
          eventText = "Quiz: Was macht den größten Anteil von Luft aus?";
          amountBut = 3;
          butOneText = "Sauerstoff.";
          butTwoText = "Wasserstoff.";
          butThreeText = "Stickstoff.";
          break;
        case 77:
          eventText = "Quiz: Wie wird der topische Wirbelsturm auch genannt?";
          amountBut = 3;
          butOneText = "Hurrikan.";
          butTwoText = "Blizzard.";
          butThreeText = "Windböe.";
          break;
        case 78:
          eventText =
              "Quiz: Wie lautet der Name einer großen Organisation, welche sich für Umweltschutz einsetzt?";
          amountBut = 2;
          butOneText = "Greenpeace.";
          butTwoText = "Greentree.";
          break;
        case 79:
          eventText =
              "Quiz: Wenn wir in Europa Sommer haben, welche Jahreszeit herrscht dann in Australien?";
          amountBut = 2;
          butOneText = "Frühling.";
          butTwoText = "Winter.";
          break;
        case 80:
          eventText =
              "Quiz: Wie viel Prozent der Erdoberfläche sind von Meer bedeckt?";
          amountBut = 2;
          butOneText = "71%";
          butTwoText = "50%";
          break;
        case 81:
          eventText =
              "Quiz: Welches Kennzeichen haben Verpackungen, die nach Gebrauch wiederverwertet werden können?";
          amountBut = 2;
          butOneText = "Gelber Engel.";
          butTwoText = "Grüner Punkt.";
          break;
        case 82:
          eventText =
              "Quiz: Wie nennt man schmutzige Luft, welche vorallem durch Autoabgabse verursacht wird?";
          amountBut = 2;
          butOneText = "Smog.";
          butTwoText = "Rauch.";
          break;
        case 83:
          eventText =
              "Quiz: Was sollte man beim Kauf neuer elektronischen Produkte beachten, wenn man die Umwelt schützen will?";
          amountBut = 2;
          butOneText = "Woher es kommt.";
          butTwoText = "Energieeffizienz.";
          break;
        case 84:
          eventText = "Quiz: Wie wird folgendes Wort korrekt geschrieben?";
          amountBut = 3;
          butOneText = "Fotosyntese.";
          butTwoText = "Photosynthese.";
          butThreeText = "Fotosynthese.";
          break;
      }
      isDialog = true;
      showImageText = false;
      eventImage = "assets/images/question.png";
    } else if (currentEvent == 5) {
      //Nichts
      if (previousEvent == 5) {
        eventCounter += 1;
      } else {
        eventCounter = 0;
      }
      previousEvent = 5;
      amountBut = 1;
      isDialog = true;
      showImageText = false;
      eventText = "Dieses Jahr ist nichts Besonderes passiert.";
      eventImage = "assets/images/plant.png";
    }
  }

  void underageEvents() {
    switch (age) {
      case 1:
        isDialog = true;
        showImageText = false;
        eventText =
            "Deine Eltern wollen dir ein Hamburger Royal TS zum Essen geben, was tust du?";
        eventImage = "assets/images/food.png";
        amountBut = 2;
        butOneText = "Lecker!";
        butTwoText = "Ekelhaft, nein!";
        break;
      case 2:
        isDialog = true;
        showImageText = false;
        eventText =
            "Während du im Wartezimmer des Kinderarztes wartest, siehst du mehrere Spielzeuge. Womit möchtest du spielen?";
        eventImage = "assets/images/toy.png";
        amountBut = 3;
        butOneText = "Spielzeug-Roboter";
        butTwoText = "Bauklötze";
        butThreeText = "Puzzle";
        break;
      case 3:
        isDialog = true;
        showImageText = false;
        eventText =
            "Im Kindergarten siehst du, wie mehrere Kinder im Sandkasten spielen. Willst du mit ihnen spielen?";
        eventImage = "assets/images/sandbox.png";
        amountBut = 2;
        butOneText = "Ja!";
        butTwoText = "Nein!";
        break;
      case 4:
        isDialog = true;
        showImageText = false;
        eventText =
            "Du bist auf einem Spaziergang um die wunderschöne Möhnesee und siehst Enten. Was tust du?";
        eventImage = "assets/images/duck.png";
        amountBut = 2;
        butOneText = "Langsam ranschleichen.";
        butTwoText = "Steine werfen!";
        break;
      case 5:
        isDialog = true;
        showImageText = false;
        eventText =
            "Deine Mutter versucht dir das Addieren beizubringen. Was ergibt 5+3?";
        eventImage = "assets/images/maths.png";
        amountBut = 3;
        butOneText = "12";
        butTwoText = "8";
        butThreeText = "21";
        break;
      case 6:
        isDialog = true;
        showImageText = false;
        eventText = "Du wirst eingeschult, was machst du als Erstes?";
        eventImage = "assets/images/school.png";
        amountBut = 2;
        butOneText = "Hausaufgaben.";
        butTwoText = "Freunde finden.";
        break;
      case 7:
        isDialog = true;
        showImageText = false;
        eventText =
            "Deine Lehrerin kontrolliert gerade eure Hausaufgaben, als dir einfällt, dass du deine nicht gemacht hast. Was tust du?";
        eventImage = "assets/images/teacher.png";
        amountBut = 3;
        butOneText = "Ehrlich sein.";
        butTwoText = "Ausrede finden.";
        butThreeText = "Abschreiben.";
        break;
      case 8:
        isDialog = true;
        showImageText = false;
        eventText =
            "Alle auf dem Schulhof reden über den neuen Film Matrix Revolutions, den du noch nicht geguckt hast. Was machst du?";
        eventImage = "assets/images/movie.png";
        amountBut = 2;
        butOneText = "Den Film nachholen.";
        butTwoText = "Nicht nachholen.";
        break;
      case 9:
        isDialog = true;
        showImageText = false;
        eventText =
            "Du hast dich mit deinen Freunden zum Fußball spielen verabredet, worin du eigentlich richtig schlecht bist. Was wirst du tun?";
        eventImage = "assets/images/football.png";
        amountBut = 2;
        butOneText = "Mein Bestes geben!";
        butTwoText = "So wenig wie möglich.";
        break;
      case 10:
        isDialog = true;
        showImageText = false;
        eventText =
            "Auf dem Weg nach Hause beleidigen zwei Kinder deine Schuhe. Wie reagierst du?";
        eventImage = "assets/images/bully.png";
        amountBut = 2;
        butOneText = "Ignorieren.";
        butTwoText = "Schlagen!";
        break;
      case 11:
        isDialog = true;
        showImageText = false;
        eventText =
            "In der Schule steht die Abschlussprüfung an. Wie sehr bereitest du dich vor?";
        eventImage = "assets/images/maths.png";
        amountBut = 2;
        butOneText = "Bisschen.";
        butTwoText = "Viel!";
        break;
      case 12:
        isDialog = true;
        showImageText = false;
        if (gymnasium == true) {
          eventText =
              "Durch deine harte Arbeit gehst du nun auf das Gymnasium, gute Arbeit! Außerdem kannst du jetzt auch Aktivitäten durchführen, probier es doch aus!";
        } else {
          eventText =
              "Die Abschlussprüfung war ein Desaster, auf's Gymnasium kommst du so nicht. Dennoch kannst du jetzt auch Aktivitäten durchführen, probier es doch aus!";
        }
        eventImage = "assets/images/book.png";
        amountBut = 1;
        break;
      case 13:
        isDialog = true;
        showImageText = false;
        eventText =
            "Glückwunsch, du hast jetzt ein Girokonto! Bis zu deinem 18. Lebensjahr kriegst du von deinen Eltern 100€ Taschengeld pro Jahr!";
        eventImage = "assets/images/money.png";
        amountBut = 1;
        break;
      case 14:
        isDialog = true;
        showImageText = false;
        eventText =
            "Bei einem Ausflug in den Wald hast du eine Tüte mit Snacks dabei. Nachdem du alles aufgegessen hast, willst du die Tüte entsorgen, gehst du den langen Weg zum Müll oder wirfst du die Tüte so weg?";
        eventImage = "assets/images/trash.png";
        amountBut = 2;
        butOneText = "Mülleimer.";
        butTwoText = "So weg.";
        money += 100;
        break;
      case 15:
        isDialog = true;
        showImageText = false;
        eventText = "Willst du der Nachhaltigkeits-AG beitreten?";
        eventImage = "assets/images/plant.png";
        amountBut = 2;
        butOneText = "Gerne.";
        butTwoText = "Kein Bock, nein.";
        money += 100;
        break;
      case 16:
        isDialog = true;
        showImageText = false;
        eventText =
            "Jetzt wo du 16 bist, machst du dein Führerschein, Glückwunsch!";
        eventImage = "assets/images/car.png";
        amountBut = 1;
        money += 100;
        break;
      case 17:
        isDialog = true;
        showImageText = false;
        eventText =
            "Deine Freunde veranstalten eine große Feier, möchtest du dazukommen?";
        eventImage = "assets/images/party1.png";
        amountBut = 2;
        butOneText = "Jo.";
        butTwoText = "Ne.";
        money += 100;
        break;
      case 18:
        isDialog = true;
        showImageText = false;
        eventText =
            "Glückwunsch, du bist nun 18! Möchtest du lieber direkt arbeiten gehen oder 3 weitere Jahre studieren?";
        eventImage = "assets/images/party2.png";
        butOneText = "Studieren.";
        butTwoText = "Arbeiten.";
        amountBut = 2;
        money += 100;
        break;
      case 19:
        isDialog = true;
        showImageText = false;
        eventText =
            "Willkommen an der Uni! Kaum fängt das Uni-Leben an, verirrst du dich im Gebäude. Was machst du?";
        eventImage = "assets/images/university.png";
        butOneText = "Rumfragen.";
        butTwoText = "Nichts.";
        amountBut = 2;
        break;
      case 20:
        isDialog = true;
        showImageText = false;
        eventText =
            "In einem Seminar über Nachhaltigkeit in der Automobilindustrie fragt dich der Dozent, welche Antriebsmöglichkeit wohl am nachhaltigsten ist.";
        eventImage = "assets/images/car.png";
        butOneText = "E-Auto.";
        butTwoText = "Benzin.";
        butThreeText = "Diesel";
        amountBut = 3;
        break;
      case 21:
        isDialog = true;
        showImageText = false;
        eventText =
            "Glückwunsch, du hast erfolgreich die Uni abgeschlossen. Zeit zum Arbeiten, such dir ein Job aus!";
        eventImage = "assets/images/university_end.png";
        amountBut = 1;
        break;
    }
  }

  void decision() {
    setState(() {
      if (age <= 18) {
        switch (age) {
          case 1:
            if (whichBut == 1) {
              sustainibility -= 0.1;
              happiness += 0.1;
              eventText = eventText + " --> Du hast den Burger gegessen";
            } else {
              sustainibility += 0.1;
              happiness -= 0.1;
              eventText = eventText + " --> Du hast den Burger nicht gegessen";
            }
            break;
          case 2:
            if (whichBut == 1) {
              happiness += 0.05;
              eventText = eventText + " --> Du hast mit dem Roboter gespielt.";
            } else if (whichBut == 2) {
              happiness += 0.05;
              eventText =
                  eventText + " --> Du hast mit den Bauklötzen gespielt.";
            } else {
              happiness += 0.05;
              eventText = eventText + " --> Du hast mit dem Puzzle gespielt.";
            }
            break;
          case 3:
            if (whichBut == 1) {
              popularity += 0.15;
              freetime -= 0.15;
              eventText = eventText + " --> Du hast mit den Kindern gespielt.";
            } else {
              popularity -= 0.15;
              freetime += 0.15;
              eventText =
                  eventText + " --> Du hast nicht mit den Kindern gespielt.";
            }
            break;
          case 4:
            if (whichBut == 1) {
              eventText = eventText +
                  " --> Du hast dich an die Enten rangeschlichen. Sie sind weggeflogen.";
            } else if (whichBut == 2) {
              sustainibility -= 0.1;
              eventText = eventText +
                  " --> Du hast die Enten mit Steinen abgeworfen. Deine Eltern wurden daraufhin wütend.";
            }
            break;
          case 5:
            if (whichBut == 1 || whichBut == 3) {
              eventText = eventText +
                  " --> Du hast falsch geantwortet. Scheint, als müsstest du die 1. Klasse wiederholen.";
              freetime += 0.05;
              happiness -= 0.05;
            } else if (whichBut == 2) {
              eventText =
                  eventText + " --> Super, das war die richtige Antwort!";
              freetime -= 0.05;
              happiness += 0.05;
            }
            break;
          case 6:
            if (whichBut == 1) {
              eventText = eventText +
                  " --> Statt mit den Kindern zu reden, hast du für die Schule gebüffelt. Die Anderen lachen dich deswegen zwar aus, dafür bist du besser für die Schule vorbereitet!";
              popularity -= 0.15;
              freetime -= 0.1;
              sustainibility += 0.1;
              happiness += 0.05;
            } else if (whichBut == 2) {
              eventText = eventText +
                  " --> Du hast dich mit den anderen Kindern angefreundet, jetzt kennen dich die Leute!";
              popularity += 0.15;
              freetime += 0.05;
            }
            break;
          case 7:
            if (whichBut == 1) {
              happiness -= 0.1;
              freetime += 0.05;
              eventText = eventText +
                  " --> Wegen deiner Ehrlichkeit musst du keine Strafarbeit machen! Trotzdem hat dir die Situation echt Angst gemacht.";
            } else if (whichBut == 2) {
              happiness -= 0.05;
              eventText = eventText +
                  " --> Die Lehrerin glaubt dir nicht, dass dein Hund die Hausaufgaben gegessen hat! Jetzt musst du eine Strafarbeit erledigen, schlecht gelaufen.";
            } else if (whichBut == 3) {
              eventText = eventText +
                  " --> Du hast schnell bei deinem Nachbarn abgeschrieben. Die Hausaufgaben hast du jetzt zwar, die dafür aufgebrachte Zeit kommt aber nicht zurück!";
              happiness += 0.05;
              freetime -= 0.05;
            }
            break;
          case 8:
            if (whichBut == 1) {
              eventText = eventText +
                  " --> Du hast den Film nachgeholt. Er war zwar nicht so gut, wenigstens kannst du jetzt aber mit den Anderen mitreden.";
              popularity += 0.1;
              freetime -= 0.1;
            } else if (whichBut == 2) {
              eventText = eventText +
                  " --> Du bleibst bei deiner Meinung, der erste Teil war besser. Du kannst zwar nicht mitreden, aber dafür hast du Zeit irgendwas anderes zu gucken.";
              popularity -= 0.05;
              freetime += 0.1;
            }
            break;
          case 9:
            if (whichBut == 1) {
              popularity -= 0.05;
              happiness += 0.1;
              eventText = eventText +
                  " --> Du hast dein Bestes gegeben! Schlecht hast du trotzdem gespielt, aus einer Fußballkarriere wird wohl nichts...";
            } else if (whichBut == 2) {
              eventText = eventText +
                  " --> Lieber gar nicht spielen als schlecht. Den Anderen dabei zuschauen, wie sie Spaß haben, ist aber auch nicht gerade toll.";
              happiness -= 0.05;
            }
            break;
          case 10:
            if (whichBut == 1) {
              popularity -= 0.05;
              happiness += 0.05;
              eventText = eventText +
                  " --> Du gehst lieber an ihnen vorbei, als dich in eine Prügelei zu stürzen. Dir selbst geht's damit gut, die anderen halten dich jetzt aber für ein Weichei.";
            } else if (whichBut == 2) {
              eventText = eventText +
                  " --> Der Kampf war schnell vorbei... Wenigstens halten dich die Anderen jetzt für mutig.";
              popularity += 0.05;
              happiness -= 0.05;
            }
            break;
          case 11:
            if (whichBut == 1) {
              gymnasium = false;
              eventText = eventText +
                  " --> Du hast dich kaum vorbereitet. Das Ergebnis wirst du bald erfahren...";
            } else if (whichBut == 2) {
              gymnasium = true;
              eventText = eventText +
                  " --> Du hast dich gut vorbereitet! Das Ergebnis wirst du bald erfahren...";
            }
            break;
          case 14:
            if (whichBut == 1) {
              happiness -= 0.01;
              sustainibility += 0.15;
              eventText = eventText +
                  " --> Du musstest zwar ein bisschen laufen, aber am Ende hast du die Tüte nachhaltig entsorgt.";
            } else if (whichBut == 2) {
              happiness += 0.01;
              sustainibility -= 0.15;
              eventText = eventText +
                  " --> Einfach wegwerfen ist bequem, aber nicht nachhaltig.";
            }
            break;
          case 15:
            if (whichBut == 1) {
              freetime -= 0.2;
              popularity += 0.1;
              sustainibility += 0.2;
              eventText = eventText +
                  " --> Es nimmt zwar Zeit ein, dafür bist du nun aber ein Stück bekannter und tust was für die Umwelt!";
            } else if (whichBut == 2) {
              popularity -= 0.1;
              sustainibility -= 0.1;
              freetime += 0.2;
              eventText = eventText + " --> Dann halt nicht.";
            }
            break;
          case 17:
            if (whichBut == 1) {
              freetime -= 0.1;
              popularity += 0.2;
              happiness -= 0.15;
              eventText = eventText +
                  " --> Besoffen nach Hause zu kommen war wohl keine gute Idee...";
            } else if (whichBut == 2) {
              popularity -= 0.1;
              freetime += 0.1;
              eventText = eventText +
                  " --> Du binge-watchst lieber Stranger Things, schon ok.";
            }
            break;
          case 18:
            if (whichBut == 1) {
              university = true;
              eventText =
                  eventText + " --> 3 weitere Jahre studieren also, viel Spaß!";
            } else {
              university = false;
              eventText = eventText +
                  " --> Direkt Arbeiten also, willkommen im Erwachsenenleben!";
              Navigator.pushNamed(context, "/work", arguments: {
                "alter": age,
                "university": university,
                "canLeave": false,
                "isWorking": isWorking
              }).then((value) {
                Map workInfoForced = value;
                isWorking = workInfoForced["isWorking"];
                job = workInfoForced["job"];
                calculateIncome();
              });
            }
            break;
        }
      }
      if (university == true) {
        switch (age) {
          case 19:
            if (whichBut == 1) {
              happiness += 0.1;
              freetime -= 0.1;
              eventText = eventText +
                  " --> Hey, jemand wusste wohin du musst! Du bist hingegangen.";
            } else {
              freetime += 0.1;
              happiness -= 0.1;
              eventText =
                  eventText + " --> Nichts machen war keine so gute Idee...";
            }
            break;
          case 20:
            if (whichBut == 2 || whichBut == 3) {
              sustainibility -= 0.1;
              eventText = eventText + " --> Deine Antwort war nicht richtig.";
            } else {
              sustainibility += 0.1;
              eventText = eventText + " --> Deine Antwort war richtig.";
            }
            break;
          case 21:
            Navigator.pushNamed(context, "/work", arguments: {
              "alter": age,
              "university": university,
              "canLeave": false,
              "isWorking": isWorking
            }).then((value) {
              Map workInfoForced = value;
              isWorking = workInfoForced["isWorking"];
              job = workInfoForced["job"];
              calculateIncome();
            });
            break;
        }
      }
      if ((university == false && age > 18) ||
          (university == true && age > 21)) {
        switch (occasionChance) {
          case 0:
            if (whichBut == 1) {
              happiness += 0.1;
              eventText = eventText +
                  " --> Ein glücklicher Arbeiter, was will man mehr?";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              eventText = eventText +
                  " --> Das ist ja schade... Der Boss tut trotzdem nichts dagegen.";
            }
            break;
          case 1:
            if (whichBut == 1 || whichBut == 2) {
              happiness -= 0.1;
              eventText = eventText +
                  " --> Das war leider die falsche Antwort, keine Beförderung für dich!";
            } else if (whichBut == 3) {
              happiness += 0.1;
              income += 200;
              eventText = eventText +
                  " --> Das war die richtige Antwort, glückwunsch! Dein Gehalt wird um 200€ erhöht.";
            }
            break;
          case 2:
            income -= 100;
            happiness -= 0.1;
            break;
          case 3:
            if (whichBut == 1) {
              happiness -= 0.1;
              popularity += 0.2;
              eventText = eventText +
                  " --> Ihr hattet alle viel Spaß, der Kater am nächsten Tag macht aber nicht so viel Spaß!";
            } else if (whichBut == 2) {
              popularity -= 0.1;
              eventText = eventText +
                  " --> Deine Kollegen gingen ohne dich feiern. Am nächsten Tag kamen alle verkatert zurück, vielleicht war das ja die bessere Entscheidung.";
            }
            break;
          case 4:
            if (whichBut == 1) {
              popularity -= 0.1;
              income += 50;
              eventText = eventText +
                  " --> Du hast deinen Kollegen ermahnt. Dein Boss erhöht als Belohnung dein Gehalt um 50€, beliebt hat dich diese Aktion aber nicht gemacht...";
            } else if (whichBut == 2) {
              eventText = eventText +
                  " --> Du hast deinen Kollegen ignoriert, schließlich sind es ja seine Probleme, nicht wahr?";
            }
            break;
          case 5:
            if (whichBut == 1) {
              happiness += 0.1;
              popularity += 0.05;
              eventText = eventText +
                  " --> Innerlich ist dir jeder dankbar, dass du das Fenster geschlossen hast. Komischerweise will sich jedoch keiner bedanken...";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              eventText = eventText +
                  " --> Irgendjemand wird das Fenster schon schließen... Hoffentlich.";
            }
            break;
          case 6:
            if (whichBut == 1) {
              happiness += 0.1;
              popularity += 0.2;
              eventText = eventText +
                  " --> Es ist schon mutig, in der Öffentlichkeit zu tanzen, doch kaum stehst du auf der Tanzfläche, bewegt sich dein Körper von automatisch und du tanzt wie ein geborener Star. OLÉ";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              popularity -= 0.1;
              eventText = eventText +
                  " --> Schon verständlich, du willst nicht tanzen gehen. Etwas schade jedoch, wer weiß was für Talente in dir drin stecken...";
            }
            break;
          case 7:
            income += 200;
            eventText = eventText + " --> Dein Gehalt wird um 200€ erhöht!";
            break;
          case 8:
            if (whichBut == 1) {
              happiness -= 0.2;
              popularity += 0.1;
              eventText = eventText +
                  " --> So ein Kater hattest du noch nie! Wenigstens hattet ihr ne gute Zeit.";
            } else if (whichBut == 2) {
              happiness += 0.1;
              popularity -= 0.1;
              eventText = eventText +
                  " --> Wenn man sieht, was die Anderen für Kater haben, kann man nur noch Mitleid verspüren... Besser so, dass du nicht gekommen bist!";
            }
            break;
          case 9:
            if (whichBut == 1) {
              popularity -= 0.1;
              happiness += 0.1;
              eventText = eventText +
                  " --> Der Mitarbeiter wurde ermahnt, die Anderen halten dich jetzt aber für eine Petze.";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              popularity += 0.1;
              eventText = eventText +
                  " --> Ein Wortduell auf dem Arbeitsplatz, dass bringt dir Respekt ein! Dein Boss ist aber nicht gerade erfreut darüber...";
            }
            break;
          case 10:
            if (whichBut == 1) {
              happiness += 0.1;
              eventText = eventText +
                  " --> Ach man kann doch auch mal mitlachen, nicht?";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              eventText = eventText +
                  " --> Boah ist das peinlich, am Liebsten würdest du kündigen!";
            }
            break;
          case 11:
            if (whichBut == 1) {
              happiness += 0.1;
              eventText = eventText +
                  " --> Grad noch so gerettet! Dein Boss gibt dir noch ne Chance und dein Lohn bleibt unverändert.";
            } else if (whichBut == 2 || whichBut == 3) {
              happiness -= 0.1;
              income -= 100;
              eventText = eventText +
                  " --> Neiiin, das war die falsche Antwort. Die Hauptstadt Italiens ist natürlich Rom! Dein Lohn wird um 100€ verringert.";
            }
            break;
          case 12:
            if (whichBut == 1) {
              freetime -= 0.3;
              income += 400;
              eventText = eventText +
                  " --> Harte Arbeit zahlt sich aus! Dein Lohn wird um 400€ erhöht.";
            } else if (whichBut == 2) {
              freetime += 0.1;
              eventText = eventText +
                  " --> Na dann halt nicht, man muss sich auch mal bisschen Freizeit gönnen.";
            }
            break;
          case 13:
            if (whichBut == 1) {
              happiness += 0.2;
              freetime += 0.1;
              sustainibility -= 0.4;
              eventText = eventText +
                  " --> Nachhaltigkeit  ist nicht alles, dein Projekt ist wichtiger!";
            } else if (whichBut == 2) {
              happiness -= 0.2;
              freetime -= 0.2;
              sustainibility += 0.4;
              eventText = eventText +
                  " --> Die Umwelt zu retten ist wichtiger, als das Projekt effizient zu erledigen!";
            }
            break;
          case 14:
            if (whichBut == 1) {
              happiness += 0.5;
              sustainibility -= 0.3;
              eventText = eventText +
                  " --> Eine persönliche Kaffeemaschine?! Da bin ich dabei!";
            } else if (whichBut == 2) {
              happiness -= 0.3;
              sustainibility += 0.3;
              eventText = eventText +
                  " --> Die Umwelt ist wichtiger! Keine Kaffeemaschine für mich.";
            }
            break;
          case 35:
            if (whichBut == 1) {
              freetime -= 0.05;
              sustainibility += 0.1;
              eventText = eventText +
                  " --> Du hast die Flaschen entsorgt, vorbildlich!";
            } else if (whichBut == 2) {
              freetime += 0.05;
              sustainibility -= 0.1;
              eventText = eventText +
                  " --> Soll jemand Anders das machen, ist ja schließlich nicht dein Problem, richtig?";
            }
            break;
          case 36:
            if (whichBut == 1) {
              happiness += 0.2;
              popularity += 0.15;
              eventText = eventText +
                  " --> Wie immer rockst du die Bühne mit deinen Moves, da können alle Blicke nur auf dich gerichtet sein!";
            } else if (whichBut == 2) {
              happiness += 0.15;
              popularity += 0.1;
              eventText = eventText +
                  " --> Sich unter die Leute mischen und bisschen reden war noch nie eine schlechte Idee!";
            } else {
              freetime += 0.1;
              popularity -= 0.1;
              eventText = eventText +
                  " --> Laaaangweiler, so eine coole Party zu verlassen, warum sollte man sowas tun?!";
            }
            break;
          case 37:
            if (whichBut == 1) {
              freetime -= 0.1;
              happiness += 0.2;
              eventText = eventText +
                  " --> Bisschen Sport kann nie schaden! Das war aber wahrscheinlich auch das letzte mal...";
            } else if (whichBut == 2) {
              happiness -= 0.2;
              eventText =
                  eventText + " --> Zu Hause rumhocken, na viel Spaß dabei.";
            }
            break;
          case 38:
            if (whichBut == 1) {
              freetime -= 0.15;
              sustainibility += 0.1;
              eventText = eventText +
                  " --> Glückwunsch, jetzt hast du eine Katze. Versorgen musst du die aber auch, und das frisst Zeit ein.";
            } else if (whichBut == 2) {
              sustainibility -= 0.05;
              freetime += 0.05;
              eventText = eventText +
                  " --> Etwas kaltblütig, aber eine Katze bedarf viel Pflege und Versorgung, diese Zeit hast du nicht!";
            }
            break;
          case 39:
            if (whichBut == 1) {
              eventText = eventText + " --> Du bist eher der Queen Fan.";
            } else if (whichBut == 2) {
              eventText = eventText + " --> Du bist eher der Bowie Fan";
            }
            break;
          case 40:
            if (whichBut == 1) {
              freetime -= 0.05;
              happiness += 0.1;
              eventText =
                  eventText + " --> Toller Film war das, du bereust es nicht!";
            } else if (whichBut == 2) {
              popularity -= 0.05;
              eventText = eventText +
                  " --> Dann halt nicht, dieser Freund wird dich aber wahrscheinlich nicht mehr ins Kino einladen.";
            }
            break;
          case 41:
            if (whichBut == 1) {
              happiness += 0.2;
              money -= 20;
              eventText = eventText + " --> Mensch du bist ja nett!";
            } else if (whichBut == 2) {
              happiness -= 0.2;
              eventText =
                  eventText + " --> Man muss ja auchg nicht immer spenden...";
            }
            break;
          case 42:
            money += 1;
            happiness += 0.1;
            break;
          case 43:
            if (whichBut == 1) {
              eventText =
                  eventText + " --> LA, New York, Washington... Gute Wahl!";
            } else if (whichBut == 2) {
              eventText = eventText +
                  " --> Kängurus, Riesenspinnen und tolle Landschaften... Gute Wahl!";
            }
            happiness += 0.2;
            break;
          case 44:
            if (whichBut == 1) {
              happiness += 0.1;
              eventText =
                  eventText + " --> Bruno Mars gibt dir ein Autogramm, nett.";
            } else if (whichBut == 2) {
              happiness += 0.1;
              popularity += 0.1;
              eventText = eventText +
                  " --> Einmal lächeln bitte - Erstmal auf Instagram hochladen und vor den Leuten angeben.";
            } else {
              if (whichBut == 1) {
                happiness += 0.5;
                sustainibility -= 0.3;
                eventText = eventText +
                    " --> Eine persönliche Kaffeemaschine?! Da bin ich dabei!";
              } else if (whichBut == 2) {
                happiness -= 0.1;
                eventText = eventText +
                    " --> Warum du nichts gemacht hast wird wohl für immer ein Rätsel bleiben.";
              }
            }
            break;
          case 45:
            money -= 1000;
            break;
          case 46:
            money -= 950;
            break;
          case 47:
            if (whichBut == 1) {
              happiness += 0.1;
              eventText = eventText +
                  " --> Bisschen Lesen und schon ist man wieder müde!";
            } else if (whichBut == 2) {
              happiness += 0.2;
              popularity += 0.1;
              eventText = eventText +
                  " --> Du kannst nicht schlafen? ERSTMAL FEIERN JAAAAA!!!";
            }
            break;
          case 48:
            if (whichBut == 1) {
              money -= 5000;
              happiness -= 0.1;
              sustainibility += 0.25;
              eventText = eventText +
                  " --> Umwelt ist wichtig, so wie dieser neue Ofen!";
            } else if (whichBut == 2) {
              sustainibility -= 0.15;
              eventText = eventText +
                  " --> Ach bla, ich brauche nur mein Ofen und das war's!";
            }
            break;
          case 49:
            if (whichBut == 2) {
              popularity += 0.1;
              eventText = eventText +
                  " --> Du bist schon so reich, du brauchst nicht noch mehr Geld.";
            } else if (whichBut == 1) {
              happiness += 0.1;
              eventText =
                  eventText + " --> Ein bisschen Geld kann nie schaden.";
            }
            break;
          case 50:
            if (whichBut == 1) {
              happiness += 0.2;
              popularity += 0.1;
              money += 300;
              eventText = eventText +
                  " --> Tanzen? JA! Mit deinen tollen Skills hast du den 2. Platz erreicht und 300€ erhalten!";
            } else if (whichBut == 2) {
              popularity -= 0.1;
              happiness -= 0.1;
              eventText = eventText +
                  " --> Mensch du bist ja langweilig, wäre sicher spaßig gewesen.";
            }
            break;
          case 51:
            if (whichBut == 1) {
              happiness += 0.1;
              eventText =
                  eventText + " --> Du brauchst nur Fleisch, welches ist egal.";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              sustainibility += 1;
              eventText = eventText +
                  " --> Die Kühe sind glücklich aufgewachsen, also wirst du glücklich dein Fleisch genießen!";
            }
            break;
          case 52:
            if (whichBut == 1) {
              eventText = eventText + " --> Klavier, tolle Entscheidung!";
            } else if (whichBut == 2) {
              happiness -= 0.3;
              sustainibility += 0.3;
              eventText =
                  eventText + " --> Klarinette, exzellente Entscheidung!";
            }
            break;
          case 53:
            if (whichBut == 1) {
              popularity += 0.1;
              eventText = eventText + " --> Klar, wieso nicht?";
            } else if (whichBut == 2) {
              popularity -= 0.15;
              eventText = eventText + " --> Skype ist wie immer besser!";
            }
            break;
          case 54:
            if (whichBut == 1) {
              eventText = eventText +
                  " --> Jetzt kannst du auch die Spiderman Spiele spielen!";
            } else if (whichBut == 2) {
              eventText = eventText +
                  " --> Leistung ist wichtiger als Spiele! Zeit Halo zu zocken.";
            }
            break;
          case 55:
            if (whichBut == 1) {
              popularity += 0.1;
              freetime -= 0.1;
              eventText = eventText +
                  " --> Singen ist immer lustig, klar bist du dabei!";
            } else if (whichBut == 2) {
              popularity -= 0.1;
              eventText = eventText +
                  " --> Du bist schon damit beschäftigt, Deutschland Sucht Den Superstar zu gucken.";
            }
            break;
          case 56:
            if (whichBut == 1) {
              freetime -= 0.05;
              sustainibility += 0.1;
              eventText = eventText +
                  " --> Dein eigener Baum steht bald in der Stadt, wie toll!";
            } else if (whichBut == 2) {
              sustainibility -= 0.05;
              eventText = eventText +
                  " --> Da sind schon genug Bäume, deiner wäre schon zu viel!";
            }
            break;
          case 57:
            if (whichBut == 1) {
              happiness += 1;
              eventText = eventText + " --> Warum auch nicht?";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              sustainibility -= 0.1;
              freetime -= 0.1;
              popularity -= 0.1;
              eventText = eventText +
                  " --> So, das ist die Strafe, Abzug aus jeder Kategorie. Warum solltest du ihm auch nicht gratulieren?";
            }
            break;
          case 58:
            if (whichBut == 1 || whichBut == 3) {
              eventText =
                  eventText + " --> Deine Stickers hast du doch immer dabei!";
            } else if (whichBut == 2) {
              sustainibility += 0.05;
              eventText = eventText + " --> Jap, alles aus!";
            }
            break;
          case 59:
            if (whichBut == 1) {
              sustainibility += 0.1;
              happiness -= 0.1;
              eventText = eventText +
                  " --> Züge sind zwar teuer, aber umweltfreundlich!";
            } else if (whichBut == 2) {
              happiness += 0.1;
              sustainibility -= 0.05;
              eventText = eventText + " --> Brum brum.";
            }
            break;
          case 60:
            if (whichBut == 1) {
              freetime -= 0.2;
              happiness += 0.1;
              sustainibility += 0.1;
              eventText = eventText +
                  " --> Da hast du dir aber ein großes Projekt ausgesucht. Na dann viel Spaß noch!";
            } else if (whichBut == 2) {
              happiness += 0.1;
              freetime += 0.1;
              sustainibility -= 0.2;
              eventText = eventText +
                  " --> Schnell, aber nicht umweltfreundlich. Deine Entscheidung!";
            } else {
              if (whichBut == 1) {
                happiness += 0.5;
                sustainibility -= 0.3;
                eventText = eventText +
                    " --> Eine persönliche Kaffeemaschine?! Da bin ich dabei!";
              } else if (whichBut == 2) {
                happiness -= 0.2;
                eventText = eventText + " --> Dann halt nicht.";
              }
            }
            break;
          case 61:
            money += 50;
            happiness += 0.1;
            break;
          case 62:
            if (whichBut == 1) {
              popularity += 0.05;
              eventText = eventText + " --> Korrekt!";
            } else if (whichBut == 2) {
              eventText = eventText + " --> Ist möglich.";
            }
            break;
          case 63:
            if (whichBut == 1) {
              happiness += 0.1;
              eventText = eventText + " --> Langweilig, aber macht satt.";
            } else if (whichBut == 2) {
              happiness += 0.1;
              sustainibility += 0.1;
              eventText = eventText + " --> Ein Salat geht immer.";
            } else {
              happiness += 0.1;
              eventText = eventText + " --> Süppchen ist das Beste!";
            }
            break;
          case 64:
            if (whichBut == 1) {
              happiness += 0.1;
              freetime -= 0.1;
              popularity += 0.1;
              eventText = eventText +
                  " --> LALALALALLA. Die Ohren der Anderen bluten schon, wenigstens hattet ihr Spaß.";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              popularity -= 0.1;
              eventText = eventText + " --> Mensch, ja dann halt nicht.";
            }
            break;
          case 65:
            if (whichBut == 1) {
              happiness += 0.1;
              popularity += 0.1;
              eventText = eventText +
                  " --> Was eine Heldenaktion! Jetzt kannst du weiter EcoLife zocken.";
            } else if (whichBut == 2) {
              happiness -= 0.1;
              eventText = eventText +
                  " --> Neues Handy, neue Einrichtung. Ach ist das nervig.";
            }
            break;
          case 66:
            if (whichBut == 1) {
              eventText = eventText + " --> Lecker Döner!";
            } else if (whichBut == 2) {
              eventText = eventText + " --> Lecker Pizza!";
            } else {
              eventText = eventText + " --> Lecker Sushi!";
            }
            break;
          case 67:
            if (whichBut == 1 || whichBut == 2) {
              happiness -= 0.1;
              eventText = eventText + " --> Nein, es ist Huhn!";
            } else if (whichBut == 3) {
              happiness -= 0.1;
              eventText = eventText + " --> Genau, na dann guten Appetit!";
            }
            break;
          case 68:
            if (whichBut == 1) {
              freetime -= 0.2;
              happiness += 0.2;
              eventText = eventText +
                  " --> Bon decision, maintenant tu peux parler francais!";
            } else if (whichBut == 2) {
              happiness -= 0.2;
              eventText = eventText + " --> C'est tres triste.";
            }
            break;
          case 69:
            if (whichBut == 1 || whichBut == 2 || whichBut == 3) {
              eventText = eventText +
                  " --> Gute Entscheidung, viel Spaß noch bei deinem Ausflug!";
            }
            break;
          case 70:
            if (whichBut == 1 || whichBut == 3) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, es sind die Haie. Besonders gefährdet sind die Weißspitzen-Hochseehaie, der Bogenstirn-Hammerhai und der Große Hammerhai!";
            } else if (whichBut == 3) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Besonders gefährdet sind die Weißspitzen-Hochseehaie, der Bogenstirn-Hammerhai und der Große Hammerhai!";
            }
            break;
          case 71:
            if (whichBut == 1) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau, Feinstaub kann sogar kleiner als 1 Mikrometer werden, was noch kleiner als der Durchmessers eines Haares ist.";
            } else if (whichBut == 2) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch! Atomkraftwerke scheiden nur Wasserstoff aus, was nicht schädlich für die Luft ist.";
            }
            break;
          case 72:
            if (whichBut == 2 || whichBut == 3) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, dreht man die Heizung auch nur um einen Grad runter, sinkt die CO2-Emmision eines Vier-Personen-Haushalts pro Jahr um ungefähr 350kg!";
            } else if (whichBut == 3) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Dreht man die Heizung auch nur um einen Grad runter, sinkt die CO2-Emmision eines Vier-Personen-Haushalts pro Jahr um ungefähr 350kg!";
            }
            break;
          case 73:
            if (whichBut == 1) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, die LED verbraucht rund 80% weniger Energie als die Glüchbirne!";
            } else if (whichBut == 2) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Die LED verbraucht rund 80% weniger Energie als die Glüchbirne!";
            }
            break;
          case 74:
            if (whichBut == 2) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, es sind die Verpackungen, wie z.B. Tüten, die am meisten gefunden werden.";
            } else if (whichBut == 1) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Verpackungen wie Tüten werden am häufigsten gefunden.";
            }
            break;
          case 75:
            if (whichBut == 1 || whichBut == 3) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, es ist der Amazonasregenwald in Südamerika.";
            } else if (whichBut == 2) {
              sustainibility += 0.1;
              money += 1000;
              eventText =
                  eventText + " --> Genau, es ist der Amzonasregenwald.";
            }
            break;
          case 76:
            if (whichBut == 1 || whichBut == 2) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, mit 78% macht Stickstoff den größten Anteil von Luft aus!";
            } else if (whichBut == 1) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Mit 78% macht Stickstoff den größten Anteil von Luft aus.";
            }
            break;
          case 77:
            if (whichBut == 2 || whichBut == 3) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText =
                  eventText + " --> Falsch, sie werden Hurrikan genannt!";
            } else if (whichBut == 1) {
              sustainibility += 0.1;
              money += 1000;
              eventText =
                  eventText + " --> Genau. Hurrikans werden sie genannt.";
            }
            break;
          case 78:
            if (whichBut == 2) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, es ist Greenpeace. Die Organisation wurde 1971 gegründet und setzt sich für viele Sachen, darunter auch Umwelt- und Klimaschutz, ein.";
            } else if (whichBut == 1) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Die Organisation wurde 1971 gegründet und setzt sich für viele Sachen, darunter auch Umwelt- und Klimaschutz, ein.";
            }
            break;
          case 79:
            if (whichBut == 1) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, denn wenn wir die Sonne genießen, haben die Leute in Australien Winter.";
            } else if (whichBut == 2) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Wenn wir die Sonne genießen, haben die Leute in Australien Winter.";
            }
            break;
          case 80:
            if (whichBut == 2) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText + " --> Falsch, es sind 71% Wasser!";
            } else if (whichBut == 1) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText + " --> Genau. 71% Wasser!";
            }
            break;
          case 81:
            if (whichBut == 1) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText + " --> Falsch, es ist der grüne Punkt!";
            } else if (whichBut == 2) {
              sustainibility += 0.1;
              money += 1000;
              eventText =
                  eventText + " --> Genau, der grüne Punkt. Sehr kreativ!";
            }
            break;
          case 82:
            if (whichBut == 2) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, es wird Smog genannt und kommt besonders in Großstädten vor!";
            } else if (whichBut == 2) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Besonders in Großstädten kommt duch den Verkehr viel Smog vor.";
            }
            break;
          case 83:
            if (whichBut == 1) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, man sollte auf die Energieeffizienz achten!";
            } else if (whichBut == 2) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau, da kann man dann auch paar Euro mehr ausgeben.";
            }
            break;
          case 84:
            if (whichBut == 1) {
              sustainibility -= 0.15;
              money -= 1000;
              eventText = eventText +
                  " --> Falsch, Synthese wird nämlich mit einem h geschrieben.";
            } else if (whichBut == 2 || whichBut == 3) {
              sustainibility += 0.1;
              money += 1000;
              eventText = eventText +
                  " --> Genau. Man kann es sowohl mit Ph, als auch mit einem F schreiben!";
            }
            break;
        }
        if (currentEvent == 2) {
          if (whichBut == 1) {
            popularity += 0.05;
            friends.add(Friend(surname, name, gender, eventImage));
            eventText =
                eventText + " --> Du bist nun mit " + surname + " befreundet!";
          } else if (whichBut == 2) {
            eventText = eventText +
                " --> Du hast " +
                surname +
                "s Freundschaftsanfrage abgelehnt.";
          }
        }
      }
      if (sustainibility > 1.0) {
        sustainibility = 1.0;
      }
      if (happiness > 1.0) {
        happiness = 1.0;
      }
      if (freetime > 1.0) {
        freetime = 1.0;
      }
      if (popularity > 1.0) {
        popularity = 1.0;
      }

      if (sustainibility < 0) {
        sustainibility = 0;
      }
      if (happiness < 0) {
        happiness = 0;
      }
      if (freetime < 0) {
        freetime = 0;
      }
      if (popularity < 0) {
        popularity = 0;
      }
      textWidgets.add(TextWidget(age, eventText));
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  Random random = new Random();
  int occasionChance; //Zufällige Zahl, zuständig zur Bestimmung der Ketegorie des nächsten Ereignisses
  int randomFriend; //Zufällige Zahl, um Namen für Freund/in zu generieren
  int green = 0xFF079102; //Grüne Farbe der AppBars
  int blue = 0xFF00255B; //Blaue Farbe der Textüberschriften und des Buttons
  int grey = 0xFF434343; //Graue Farbe vom Textinhalt
  int age = 0; //Alter
  bool gymnasium; //Ermittelt, ob Spieler auf's Gymnasium geht/gegangen ist
  bool university; //Ermittelt, ob Spieler auf die Uni gehen will
  String job; //Ermittelt Beruf
  int eventCounter =
      0; //Zählt, wie oft dieselbe Kategorie hintereinander drankam
  List<Widget> textWidgets = [];
  final _controller = ScrollController();

  int amountBut;
  bool isDialog = false;
  bool showImageText;
  String imageText;
  String eventText; //Der zu erscheinende Text
  String eventImage;
  String butOneText;
  String butTwoText;
  String butThreeText;

  @override
  Widget build(BuildContext context) {
    if (sustainibility <= 0 ||
        happiness <= 0 ||
        popularity <= 0 ||
        freetime <= 0 ||
        age >= 100) {
      isGameOver = true;
    }
    if (age < 12) {
      alreadyEnteredActivity = true;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Stack(children: [
            Expanded(
                child: Container(
              color: Color(green),
            )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Opacity(
                      child: Image.asset(
                        "assets/images/plant.png",
                        color: Colors.black,
                        height: 60,
                        width: 60,
                      ),
                      opacity: 0.4,
                    ),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Image.asset(
                          "assets/images/plant.png",
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "EcoLife",
                      style: TextStyle(
                        fontFamily: "Berlin Sans",
                        fontSize: 40.0,
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
                  )
                ],
              ),
            )
          ]),
        ),
        floatingActionButton: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Color(blue), width: 5),
            color: Colors.yellow,
            shape: BoxShape.circle,
          ),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Color(blue),
                child: Center(
                    child: (isGameOver == false)
                        ? Icon(
                            Icons.add,
                            size: 40,
                          )
                        : Icon(
                            Icons.stop_rounded,
                            size: 40,
                          )),
                onPressed: () {
                  setState(() {
                    if (isGameOver == false) {
                      alreadyEnteredActivity = false;
                      age += 1;
                      if ((age > 18 && age < 22 && university == true) ||
                          (age <= 18)) {
                        underageEvents();
                      } else if ((age > 18 && university == false) ||
                          (age > 21)) {
                        money += income;
                        getEvent();
                      } else {}
                      if (isDialog == true) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => DialogEvent(
                                eventImage,
                                eventText,
                                amountBut,
                                showImageText,
                                imageText,
                                butOneText,
                                butTwoText,
                                butThreeText)).then((value) {
                          whichBut = value;
                          decision();
                        });
                      }
                    } else {
                      gameOver();
                    }
                  });
                },
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
          color: Color(green),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BottomNavItem(
                  icon: Icons.work,
                  color: Colors.brown,
                  type: "work",
                  age: this.age,
                  university: this.university,
                  submitWork: (Map workInfo) {
                    isWorking = workInfo["isWorking"];
                    job = workInfo["job"];
                    calculateIncome();
                  },
                  isWorking: this.isWorking,
                ),
                BottomNavItem(
                  icon: Icons.shopping_cart,
                  color: Colors.green,
                  type: "property",
                  money: this.money,
                  submitProperty: (int propertyIndex) {
                    setState(() {
                      switch (propertyIndex) {
                        case 1:
                          money -= 350000;
                          freetime += 0.5;
                          sustainibility += 0.3;
                          break;
                        case 2:
                          money -= 180000;
                          freetime += 0.5;
                          sustainibility -= 0.3;
                          break;
                        case 3:
                          money -= 300000;
                          happiness += 0.7;
                          break;
                        case 4:
                          money -= 200000;
                          happiness += 0.4;
                          break;
                        case 5:
                          money -= 300000;
                          sustainibility += 0.5;
                          break;
                        case 6:
                          money -= 185000;
                          popularity += 0.4;
                          break;
                      }

                      if (sustainibility > 1.0) {
                        sustainibility = 1.0;
                      }
                      if (happiness > 1.0) {
                        happiness = 1.0;
                      }
                      if (freetime > 1.0) {
                        freetime = 1.0;
                      }
                      if (popularity > 1.0) {
                        popularity = 1.0;
                      }

                      if (sustainibility < 0) {
                        sustainibility = 0;
                      }
                      if (happiness < 0) {
                        happiness = 0;
                      }
                      if (freetime < 0) {
                        freetime = 0;
                      }
                      if (popularity < 0) {
                        popularity = 0;
                      }
                    });
                  },
                ),
                BottomNavItem(
                  icon: Icons.contacts,
                  color: Colors.red,
                  type: "contacts",
                  friends: friends,
                ),
                BottomNavItem(
                  icon: Icons.sports_basketball,
                  color: Colors.orange,
                  type: "activities",
                  money: money,
                  alreadyEnteredActivity: alreadyEnteredActivity,
                  submitActivity: (int activityIndex) {
                    if (activityIndex != 0) {
                      setState(() {
                        alreadyEnteredActivity = true;
                        switch (activityIndex) {
                          case 1:
                            happiness += 0.01;
                            freetime -= 0.01;
                            break;
                          case 2:
                            happiness += 0.01;
                            freetime -= 0.01;
                            break;
                          case 3:
                            money -= 10;
                            popularity += 0.01;
                            freetime -= 0.01;
                            break;
                          case 4:
                            popularity += 0.01;
                            freetime -= 0.01;
                            break;
                          case 5:
                            popularity += 0.01;
                            freetime -= 0.01;
                            break;
                          case 6:
                            money -= 50000;
                            sustainibility += 0.02;
                            break;
                          case 7:
                            freetime -= 0.01;
                            sustainibility += 0.01;
                            break;
                          case 8:
                            happiness -= 0.01;
                            sustainibility += 0.01;
                            break;
                          case 9:
                            money -= 300;
                            freetime += 0.01;
                            popularity -= 0.01;
                            sustainibility -= 0.01;
                            break;
                          case 10:
                            money -= 10;
                            sustainibility += 0.01;
                            freetime -= 0.01;
                            break;
                          case 11:
                            happiness += 0.01;
                            freetime -= 0.01;
                            break;
                          case 12:
                            popularity += 0.01;
                            freetime -= 0.01;
                            break;
                          case 13:
                            money -= 20;
                            happiness += 0.015;
                            freetime -= 0.01;
                            break;
                          case 14:
                            happiness += 0.01;
                            freetime -= 0.01;
                            break;
                          case 15:
                            money -= 20;
                            happiness += 0.1;
                            freetime -= 0.1;
                            break;
                        }
                        if (sustainibility > 1.0) {
                          sustainibility = 1.0;
                        }
                        if (happiness > 1.0) {
                          happiness = 1.0;
                        }
                        if (freetime > 1.0) {
                          freetime = 1.0;
                        }
                        if (popularity > 1.0) {
                          popularity = 1.0;
                        }

                        if (sustainibility < 0) {
                          sustainibility = 0;
                        }
                        if (happiness < 0) {
                          happiness = 0;
                        }
                        if (freetime < 0) {
                          freetime = 0;
                        }
                        if (popularity < 0) {
                          popularity = 0;
                        }
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ]),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: IndicatorItem(
                            indicated: "Beliebtheit",
                            icon: Icons.people,
                            percentage: popularity,
                          ),
                        ),
                        Expanded(
                          child: IndicatorItem(
                              indicated: "Freizeit",
                              icon: Icons.accessibility_new,
                              percentage: freetime),
                        ),
                        Expanded(
                          child: IndicatorItem(
                              indicated: "Nachhaltigkeit",
                              icon: Icons.nature,
                              percentage: sustainibility),
                        ),
                        Expanded(
                          child: IndicatorItem(
                              indicated: "Glücklichkeit",
                              icon: Icons.mood,
                              percentage: happiness),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Alter: " + age.toString(),
                                style: TextStyle(
                                    fontFamily: "Berlin Sans",
                                    color: Color(blue),
                                    fontSize: 13),
                              ),
                              Text(
                                money.toString() + "€",
                                style: TextStyle(
                                    fontFamily: "Berlin Sans",
                                    color: Color(green),
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Color(grey), width: 0.2),
                    )),
                child: ListView.builder(
                  controller: _controller,
                  reverse: true,
                  itemCount: textWidgets.length,
                  itemBuilder: (_, index) => textWidgets[index],
                  addAutomaticKeepAlives: false,
                  scrollDirection: Axis.vertical,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
