import 'package:flutter/material.dart';

class Avatar {
  String name = 'Nina';
  String body;
  String face;
  String hair;
  String skin;
  String feet = 'assets/feet1.png';
  Color hairColor = Colors.red;
  List<String> accessoires = [];

  Avatar({
    this.name,
    this.body,
    this.face,
    this.hair,
    this.skin,
  });

  operator [](String type) {
    switch (type) {
      case 'name':
        return name;
      case 'body':
        return body;
      case 'face':
        return face;
      case 'hair':
        return hair;
      case 'skin':
        return skin;
      case 'extra':
        return accessoires;
    }
  }

  operator []=(String key, String value) {
    switch (key) {
      case 'name':
        name = value;
        break;
      case 'body':
        body = value;
        break;
      case 'face':
        face = value;
        break;
      case 'hair':
        hair = value;
        break;
      case 'skin':
        skin = value;
        break;
    }
  }
}
