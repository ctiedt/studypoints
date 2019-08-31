import 'package:flutter/material.dart';
import 'package:studypoints/studytime/widgets/stopwatch.dart';

class StudytimeScreen extends StatefulWidget {
  @override
  _StudytimeScreenState createState() => _StudytimeScreenState();
}

class _StudytimeScreenState extends State<StudytimeScreen> {
  bool _leftStudyTime = false;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    backgroundColor ??= Theme.of(context).backgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StopwatchWidget(
            goalCallback: () => setState(() {
              backgroundColor = Colors.white;
            }),
            resetCallback: () => setState(() {
              backgroundColor = Theme.of(context).backgroundColor;
            }),
            leftAppCallback: () => setState(() {
              _leftStudyTime = true;
            }),
          ),
          if (_leftStudyTime)
            Card(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You left the app during studytime',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
