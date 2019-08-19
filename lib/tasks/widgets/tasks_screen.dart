import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/tasks/data/task.dart';
import 'package:studypoints/tasks/widgets/new_task_dialog.dart';

/// This screen displays all the current tasks.
/// It shows them as dismissible [ExpansionTile]s.
/// Each [ExpansionTile] has a [Column] as its child
/// displaying [CheckboxListTile]s with the subtaskss.

// TODO: Add task reordering

class TasksScreen extends StatefulWidget {
  final State parent;

  const TasksScreen({Key key, this.parent}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  Map<int, bool> opened;
  Function(Task, Task) taskSorter;

  int sortByDate(Task t1, Task t2) {
    if (t1.dueDate != null && t2.dueDate != null) {
      return t1.dueDate.compareTo(t2.dueDate);
    } else if (t1.dueDate == null && t2.dueDate == null)
      return t1.title.toLowerCase().compareTo(t2.title.toLowerCase());
    else if (t1.dueDate == null) {
      return 1;
    } else {
      return -1;
    }
  }

  int sortByPriority(Task t1, Task t2) {
    int result = t2.priority.compareTo(t1.priority);
    return result == 0 ? sortByDate(t1, t2) : result;
  }

  @override
  void initState() {
    taskSorter = sortByDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    opened ??= {
      for (var task in Provider.of<UserService>(context).tasks) task.id: false
    };
    var tasks = Provider.of<UserService>(context).tasks;
    tasks.sort(taskSorter ?? sortByDate);
    return ListView(children: [
      ListTile(
          title: Text('My tasks'),
          //TODO: Add task sorting
          trailing: PopupMenuButton(
            icon: Icon(Icons.sort),
            onSelected: (selected) => setState(() => taskSorter = selected),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                    children: [Icon(Icons.calendar_today), Text('Due Date')]),
                value: sortByDate,
              ),
              PopupMenuItem(
                child:
                    Row(children: [Icon(Icons.sort_by_alpha), Text('Title')]),
                value: (Task t1, Task t2) =>
                    t1.title.toLowerCase().compareTo(t2.title.toLowerCase()),
              ),
              PopupMenuItem(
                child: Row(
                    children: [Icon(Icons.priority_high), Text('Priority')]),
                value: sortByPriority,
              )
            ],
          )),
      Divider(),
      ...tasks.map((t) => Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              Provider.of<UserService>(context).clearTask(t, context);
              print(widget.parent);
              widget.parent.setState(() {});
            },
            child: Card(
              child: (t.subtasks.isEmpty)

                  /// Task without subtasks
                  ? ListTile(
                      title: Row(
                        children: <Widget>[
                          Text(t.title),
                          Spacer(),
                          if (t.dueDate != null)
                            Chip(
                              label: Text(
                                  '${t.dueDate.year}-${t.dueDate.month}-${t.dueDate.day}'),
                            ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              var confirmed = await _showDeleteDialog();
                              setState(() {
                                if (confirmed) {
                                  Provider.of<UserService>(context)
                                      .tasks
                                      .removeWhere((task) => task.id == t.id);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Deleted task "${t.title}"'),
                                  ));
                                }
                              });
                            },
                          )
                        ],
                      ),
                      onLongPress: () => Navigator.of(context)
                          .push(MaterialPageRoute<Task>(
                        builder: (context) => NewTaskDialog(task: t),
                      ))
                          .then((val) {
                        if (val == null) return;
                        Provider.of<UserService>(context)
                            .tasks
                            .singleWhere((task) => task.id == t.id)
                            .updateProperties(val);
                      }),
                      trailing: Icon(
                        Icons.bookmark,
                        color: t.color,
                      ),
                    )

                  ///Task with subtasks
                  : ExpansionTile(
                      title: Row(children: [
                        Text(
                            '${t.title} (${t.subtasks.values.where((v) => v).length}/${t.subtasks.values.length})'),
                        Spacer(),
                        if (t.dueDate != null)
                          Chip(
                              label: Text(
                                  '${t.dueDate.year}-${t.dueDate.month}-${t.dueDate.day}')),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            var confirmed = await _showDeleteDialog();
                            setState(() {
                              if (confirmed) {
                                Provider.of<UserService>(context)
                                    .tasks
                                    .removeWhere((task) => task.id == t.id);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Deleted task "${t.title}"'),
                                ));
                              }
                            });
                          },
                        ),
                        Icon(
                          Icons.bookmark,
                          color: t.color,
                        )
                      ]),
                      initiallyExpanded: opened[t.id] ?? false,
                      onExpansionChanged: (open) {
                        setState(() {
                          opened[t.id] = open;
                        });
                      },
                      children: t.subtasks.keys
                          .map((s) => CheckboxListTile(
                                title: Text(s),
                                value: t.subtasks[s],
                                onChanged: (checked) {
                                  Provider.of<UserService>(context)
                                      .tasks
                                      .firstWhere((task) => t.id == task.id)
                                      .subtasks[s] = checked;
                                  setState(() {});
                                },
                              ))
                          .toList(),
                    ),
            ),
          ))
    ]);
  }

  Future<bool> _showDeleteDialog() async {
    var confirmed = false;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete task?'),
              content: Text(
                  'Are you sure you want to delete this Task? You will receive no HC reward for a deleted task.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    confirmed = true;
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    return confirmed;
  }
}
