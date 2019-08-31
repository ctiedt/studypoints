import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/avatar/widgets/avatar_screen.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/tasks/data/task.dart';
import 'package:studypoints/tasks/widgets/new_task_dialog.dart';
import 'package:studypoints/tasks/widgets/tasks_screen.dart';

import 'dashboard_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _children;

  @override
  initState() {
    _children = [
      DashboardView(
        parent: this,
      ),
      TasksScreen(
        parent: this,
      ),
      AvatarScreen(
        parent: this,
      ),
      Center(
        child: FlutterLogo(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('${Provider.of<UserService>(context).hcCount} HC'),
            Spacer(),
            Text('StudyPoints'),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text('Dashboard')),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Tasks')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Avatar')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute<Task>(
              builder: (context) => NewTaskDialog(),
            ))
            .then((val) => val != null
                ? Provider.of<UserService>(context).tasks.add(val)
                : null),
      ),
      body: _children[_currentIndex],
    );
  }
}
