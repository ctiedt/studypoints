import 'package:flutter/material.dart';

class Avatar {
  String name = 'Nina';
  String body;
  String face;
  String hair;
  String print;
  String skin;
  String feet = 'assets/feet1.png';
  String hairEffect;
  Color hairColor = Colors.red;
  List<String> accessoires = [];

  Avatar({
    this.name,
    this.body,
    this.face,
    this.hair,
    this.skin,
    this.print,
    this.hairEffect,
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
      case 'print':
        return print;
      case 'extra':
        return accessoires;
      case 'hairEffect':
        return hairEffect;
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
      case 'print':
        print = value;
        break;
      case 'hairEffect':
        hairEffect = value;
        break;
    }
  }
}
