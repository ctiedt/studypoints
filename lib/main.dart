import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/avatar/data/repository.dart';
import 'package:studypoints/avatar/widgets/avatar_screen.dart';
import 'package:studypoints/avatar/widgets/avatar_view.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/tasks/widgets/new_task_dialog.dart';
import 'package:studypoints/tasks/widgets/task_dashboard_view.dart';
import 'package:studypoints/tasks/widgets/tasks_screen.dart';

import 'tasks/data/task.dart';

/// The heart of the operation.
/// Instead of conventional navigation,
/// the app uses the [BottomNavigationBar]
/// to set the [Scaffold]'s body.
/// All children have a parent attribute which accepts a [State]
/// in order to alert the root [Scaffold] if shared data has changed.

void main() => runApp(StudyPointsApp());

class StudyPointsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserService>(
          builder: (_) => UserService(),
        ),
        Provider<HairRepository>(
          builder: (_) => HairRepository(),
        ),
        Provider<FaceRepository>(
          builder: (_) => FaceRepository(),
        ),
        Provider<BodyRepository>(
          builder: (_) => BodyRepository(),
        ),
      ],
      child: MaterialApp(
          title: 'StudyPoints',
          theme: ThemeData(
            primarySwatch: Colors.lime,
          ),
          home: HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

class DashboardView extends StatefulWidget {
  /// This is most of what you see when opening the app.
  /// It is mostly justt a [Column] coontaining the
  /// dashboard elements. Other modules should provide a
  /// widget [ModuleNameView] that can be included here.

  final State parent;

  const DashboardView({Key key, this.parent}) : super(key: key);
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: AvatarView(
            avatar: Provider.of<UserService>(context).avatar,
            height: 400,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO: Add study/no distractions mode
            FlatButton(
              color: Theme.of(context).backgroundColor,
              child: Text('I want to study now'),
            ),
            FlatButton(
              child: Text('I did some work'),
              color: Theme.of(context).backgroundColor,
              onPressed: () {
                setState(() {
                  Provider.of<UserService>(context).hcCount += 20;
                });
                widget.parent.setState(() {});
              },
            )
          ],
        ),
        TaskDashboardView(),
      ],
    );
  }
}
