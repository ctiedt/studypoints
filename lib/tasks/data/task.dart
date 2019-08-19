import 'dart:ui';

import 'package:flutter/material.dart';

class Task {
  static int counter = 0;
  final int id = counter++;
  final String title;
  Map<String, bool> subtasks;
  final DateTime dueDate;
  final int priority;

  Color get color {
    switch (priority) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Task({this.title, this.subtasks, this.dueDate, this.priority});
}
