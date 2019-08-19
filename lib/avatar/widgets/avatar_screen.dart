import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/avatar/widgets/avatar_view.dart';
import 'package:studypoints/services/user.dart';

class AvatarScreen extends StatefulWidget {
  final State parent;

  const AvatarScreen({Key key, this.parent}) : super(key: key);

  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  final List<String> faceOptions = [
    'assets/face.png',
    'assets/face2.png',
    'assets/face_mcgucket.png'
  ];
  final List<String> hairOptions = [
    'assets/hair.png',
    'assets/hair3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          AvatarView(
            avatar: Provider.of<UserService>(context).avatar,
            height: 300,
          ),
          PropertyCarousel(
            caption: 'Faces',
            current: faceOptions[0],
            options: faceOptions,
            callback: (selected) {
              setState(() {
                Provider.of<UserService>(context).avatar.face = selected;
              });
            },
          ),
          PropertyCarousel(
            caption: 'Hair Styles',
            current: hairOptions[0],
            options: hairOptions,
            callback: (selected) {
              setState(() {
                Provider.of<UserService>(context).avatar.hair = selected;
              });
            },
          )
        ],
      ),
    );
  }
}

class PropertyCarousel extends StatefulWidget {
  final String current;
  final List<String> options;
  final String caption;
  final Function(String) callback;

  const PropertyCarousel(
      {Key key, this.current, this.options, this.caption, this.callback})
      : super(key: key);

  @override
  _PropertyCarouselState createState() => _PropertyCarouselState();
}

class _PropertyCarouselState extends State<PropertyCarousel> {
  String current;

  @override
  void initState() {
    current = widget.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.caption),
        Divider(),
        Wrap(
          children: widget.options
              .map((v) => FlatButton(
                    child: Material(
                      elevation: current == v ? 2.0 : 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Container(
                        height: 64,
                        child: AspectRatio(
                            aspectRatio: 1.0, child: Image.asset(v)),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        current = v;
                      });
                      widget.callback(current);
                    },
                  ))
              .toList(),
        )
      ],
    );
  }
}
