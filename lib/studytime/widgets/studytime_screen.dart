import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudytimeScreen extends StatefulWidget {
  @override
  _StudytimeScreenState createState() => _StudytimeScreenState();
}

class _StudytimeScreenState extends State<StudytimeScreen>
    with WidgetsBindingObserver {
  MethodChannel _methodChannel = MethodChannel('screenState');
  bool _leftStudyTime = false;
  Color backgroundColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// This method checks if the app is running in foreground.
  /// Since flutter only allows us to check if the app is paused,
  /// we need a native android call to check if the screen was simply
  /// shut off or the app was closed.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state);
    var screenState = "";
    try {
      screenState = await _methodChannel.invokeMethod<String>("getScreenState");
      print(screenState);
    } on PlatformException catch (e) {
      print(e.message);
    }
    if (state == AppLifecycleState.paused && screenState == "ON") {
      setState(() {
        _leftStudyTime = true;
      });
    }
  }
}

class StopwatchWidget extends StatefulWidget {
  final VoidCallback goalCallback;
  final VoidCallback resetCallback;

  const StopwatchWidget({Key key, this.goalCallback, this.resetCallback})
      : super(key: key);

  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  int _repeats = 0;
  Timer _timer;
  Icon _timerIcon = Icon(Icons.play_arrow);
  bool _timerPaused = true;
  int _goal;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _repeats.toString(),
          style: Theme.of(context).textTheme.headline.copyWith(fontSize: 100),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.restore),
              onPressed: () => setState(() {
                _timer.cancel();
                _timerIcon = Icon(Icons.play_arrow);
                _timer = null;
                _repeats = 0;
                widget.resetCallback();
              }),
            ),
            IconButton(
              icon: _timerIcon,
              onPressed: () => _startTimer(),
            ),
          ],
        ),
        FlatButton(
            child:
                Text(_goal == null ? 'Set a goal' : 'Current goal: $_goal min'),
            onPressed: () => _showGoalSelector(context)),
      ],
    );
  }

  void _startTimer() {
    _timer ??= Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (!_timerPaused) _repeats++;
        if (_goal != null && _repeats >= _goal) {
          widget.goalCallback();
        }
      });
    });
    setState(() {
      _timerPaused = !_timerPaused;
      if (_timerPaused) {
        _timerIcon = Icon(Icons.play_arrow);
      } else {
        _timerIcon = Icon(Icons.pause);
      }
    });
  }

  void _showGoalSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      isScrollControlled: true,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          ...List.generate(
              4,
              (i) => ListTile(
                    title: Text('${30 * (i + 1)} min'),
                    onTap: () {
                      setState(() {
                        _goal = 30 * (i + 1);
                      });
                      Navigator.pop(context);
                    },
                  )),
          ListTile(
            title: Text('Custom goal'),
            onTap: () => _showGoalSelectionDialog(context),
          ),
          ListTile(
            title: Text('Remove goal'),
            onTap: () {
              setState(() {
                _goal = null;
              });
              widget.resetCallback();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _showGoalSelectionDialog(BuildContext context) {
    var hoursController = TextEditingController(text: '0');
    var minutesController = TextEditingController(text: '30');
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Set a studytime goal (h:m)'),
              content: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: hoursController,
                      keyboardType: TextInputType.number,
                    ),
                    width: 32,
                  ),
                  Text(':'),
                  Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: minutesController,
                      keyboardType: TextInputType.number,
                    ),
                    width: 32,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.cancel),
                  label: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.check_circle),
                  label: Text('Accept'),
                  onPressed: () {
                    setState(() {
                      var hours = int.tryParse(hoursController.value.text);
                      var minutes = int.tryParse(minutesController.value.text);
                      _goal = 60 * (hours ?? 0) + (minutes ?? 30);
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
