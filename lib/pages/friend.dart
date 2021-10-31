import 'package:flutter/material.dart';

class Friend {
  @required
  String surname;
  @required
  String name;
  @required
  String gender;
  @required
  String image;

  Friend(String surname, String name, String gender, String image) {
    this.surname = surname;
    this.name = name;
    this.gender = gender;
    this.image = image;
  }
}
