import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/tasks/data/task.dart';

class TaskDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<UserService>(context).tasks;
    if (tasks.isEmpty)
      return Center(
        child: Text('There are no tasks currently saved'),
      );
    tasks.sort(sortByDate);
    return Column(
      children: ListTile.divideTiles(
          color: Theme.of(context).dividerColor,
          tiles: tasks.sublist(0, min(2, tasks.length)).map(
                (t) => ListTile(
                  title: Text(t.subtasks.isEmpty
                      ? t.title
                      : '${t.title} (${t.subtasks.values.where((v) => v).length}/${t.subtasks.values.length})'),
                  subtitle: t.dueDate != null
                      ? Text(
                          'Due ${t.dueDate.year}-${t.dueDate.month}-${t.dueDate.day}')
                      : null,
                  leading: Icon(
                    Icons.bookmark,
                    color: t.color,
                  ),
                ),
              )).toList(),
    );
  }

  int sortByDate(Task t1, Task t2) {
    if (t1.dueDate != null && t2.dueDate != null) {
      return t1.dueDate.compareTo(t2.dueDate);
    } else if (t1.dueDate == null) {
      return 1;
    } else {
      return -1;
    }
  }
}
