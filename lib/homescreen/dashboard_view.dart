import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/avatar/widgets/avatar_view.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/studytime/widgets/studytime_screen.dart';
import 'package:studypoints/tasks/widgets/task_dashboard_view.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // TODO: Add study/no distractions mode
            FlatButton(
              color: Theme.of(context).backgroundColor,
              child: Text('I want to study now'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudytimeScreen(),
                      fullscreenDialog: true,
                    ));
              },
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
