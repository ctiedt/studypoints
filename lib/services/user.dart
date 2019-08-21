import 'package:flutter/material.dart';
import 'package:studypoints/avatar/data/avatar.dart';
import 'package:studypoints/avatar/data/repository.dart';
import 'package:studypoints/tasks/data/task.dart';

class UserService {
  int hcCount = 0;
  Avatar avatar = Avatar();
  List<Task> tasks = [];
  List<String> boughtItems = [
    FaceRepository().first.id,
    HairRepository().first.id,
    BodyRepository().first.id,
  ];

  void clearTask(Task task, BuildContext context) {
    tasks.removeWhere((t) => t.id == task.id);
    var reward =
        task.subtasks.values.fold(10, (sum, val) => val ? sum + 10 : sum);
    hcCount += reward;
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('You earned $reward HC for completing a task!'),
    ));
  }

  bool ownsItem(String id) => boughtItems.contains(id);
}
