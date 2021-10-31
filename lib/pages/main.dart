import 'package:eco_life/pages/activities.dart';
import 'package:eco_life/pages/contacts.dart';
import 'package:eco_life/pages/home.dart';
import 'package:eco_life/pages/property.dart';
import 'package:eco_life/pages/work.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => Home(),
        "/work": (context) => Work(),
        "/property": (context) => Property(),
        "/contacts": (context) => Contacts(),
        "/activities": (context) => Activities(),
      },
      initialRoute: "/home",
    ));

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
