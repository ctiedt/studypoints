import 'dart:ui';

import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  Map<String, bool> subtasks;
  DateTime dueDate;
  int priority;

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

  Task({this.title, this.subtasks, this.dueDate, this.priority}) {
    id = hashValues(title, subtasks, dueDate, priority);
  }

  void updateProperties(Task t) {
    title = t.title;
    subtasks = t.subtasks;
    dueDate = t.dueDate;
    priority = t.priority;
  }
}
