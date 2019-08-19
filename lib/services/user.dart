import 'package:flutter/material.dart';
import 'package:studypoints/avatar/data/avatar.dart';
import 'package:studypoints/tasks/data/task.dart';

class UserService {
  int hcCount = 0;
  Avatar avatar = Avatar();
  List<Task> tasks = [];

  void clearTask(Task task, BuildContext context) {
    tasks.removeWhere((t) => t.id == task.id);
    var reward =
        task.subtasks.values.fold(10, (sum, val) => val ? sum + 10 : sum);
    hcCount += reward;
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('You earned $reward HC for completing a task!'),
    ));
  }
}
