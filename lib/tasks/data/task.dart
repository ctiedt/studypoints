import 'dart:ui';

import 'package:flutter/material.dart';

class Task {
  final String id;
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

  Task({this.title, this.subtasks, this.dueDate, this.priority, this.id});
}
