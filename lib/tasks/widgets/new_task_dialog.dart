import 'package:flutter/material.dart';
import 'package:studypoints/tasks/data/task.dart';

class NewTaskDialog extends StatefulWidget {
  final Task task;
  NewTaskDialog({this.task});

  @override
  _NewTaskDialogState createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  int priority;
  DateTime dueDate;
  TextEditingController titleController;
  Map<TextEditingController, bool> subtaskControllers;
  List<Widget> subtaskInputs = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    titleController ??= TextEditingController(text: widget.task?.title);
    priority ??= widget.task?.priority ?? 0;
    dueDate ??= widget.task?.dueDate;

    if (subtaskControllers == null) {
      subtaskControllers = Map();
      widget.task?.subtasks?.forEach((String s, bool b) {
        var controller = TextEditingController(text: s);
        var subtaskKey = UniqueKey();
        subtaskInputs.add(Column(key: subtaskKey, children: [
          TextFormField(
            decoration: InputDecoration(hintText: '...'),
            controller: controller,
            validator: (subtask) =>
                subtask.isEmpty ? 'Subtasks need to have a description' : null,
          ),
          FlatButton.icon(
            icon: Icon(Icons.cancel),
            label: Text('Remove subtask'),
            onPressed: () {
              setState(() {
                subtaskInputs.removeWhere((i) => i.key == subtaskKey);
                subtaskControllers.removeWhere((c, b) => c == controller);
              });
            },
          )
        ]));
        subtaskControllers[controller] = b;
      });
    }
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async => dueDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                initialDate: dueDate ?? DateTime.now().add(Duration(days: 1)),
                lastDate: DateTime.now().add(Duration(days: 365)),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            Map<String, bool> subtasks = Map();
            subtaskControllers.forEach((c, b) {
              subtasks[c.value.text] = b;
            });
            Task task = Task(
              title: titleController.value.text,
              subtasks: subtasks,
              dueDate: dueDate,
              priority: priority,
            );
            if (_formKey.currentState.validate()) Navigator.pop(context, task);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Task title'),
                style: Theme.of(context).textTheme.headline,
                validator: (value) =>
                    value.isEmpty ? 'Tasks need to have a title' : null,
              ),
              SizedBox(
                height: 16,
              ),
              Column(children: subtaskInputs),
              FlatButton(
                child: Text('Add subtask'),
                onPressed: () {
                  var subtaskKey = UniqueKey();
                  setState(() {
                    var controller = TextEditingController();
                    subtaskInputs.add(Column(key: subtaskKey, children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: '...'),
                        controller: controller,
                        validator: (subtask) => subtask.isEmpty
                            ? 'Subtasks need to have a description'
                            : null,
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.cancel),
                        label: Text('Remove subtask'),
                        onPressed: () {
                          setState(() {
                            subtaskInputs
                                .removeWhere((i) => i.key == subtaskKey);
                            subtaskControllers
                                .removeWhere((c, b) => c == controller);
                          });
                        },
                      )
                    ]));
                    subtaskControllers[controller] = false;
                  });
                },
              ),
              DropdownButtonFormField(
                value: priority,
                onChanged: (v) => setState(() {
                  priority = v;
                }),
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Row(children: [
                      Icon(Icons.bookmark, color: Colors.green),
                      Text('Low')
                    ]),
                  ),
                  DropdownMenuItem(
                      value: 1,
                      child: Row(children: [
                        Icon(Icons.bookmark, color: Colors.yellow),
                        Text('Medium')
                      ])),
                  DropdownMenuItem(
                      value: 2,
                      child: Row(children: [
                        Icon(Icons.bookmark, color: Colors.red),
                        Text('High')
                      ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
