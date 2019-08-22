import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/avatar/widgets/avatar_view.dart';
import 'package:studypoints/services/user.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AvatarScreen extends StatefulWidget {
  final State parent;

  const AvatarScreen({Key key, this.parent}) : super(key: key);

  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  final List<String> faceOptions = [
    'assets/face1.png',
    'assets/face2.png',
    'assets/face3.png',
    'assets/face4.png',
    'assets/face5.png',
    'assets/face6.png',
    'assets/face7.png',
  ];
  final List<String> hairOptions = [
    'assets/hair1.png',
    'assets/hair2.png',
    'assets/hair3.png',
    'assets/hair4.png',
    'assets/hair5.png',
  ];
  final List<String> bodyOptions = [
    'assets/body1.png',
    'assets/body2.png',
    'assets/body3.png',
    'assets/body4.png',
  ];
  final List<String> skinOptions = [
    'assets/skin1.png',
    'assets/skin2.png',
    'assets/skin3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Center(
            child: AvatarView(
          avatar: Provider.of<UserService>(context).avatar,
          height: 300,
        )),
        Expanded(
            child: ListView(
          children: <Widget>[
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
              hasColor: true,
              colorCallback: (selected) {
                setState(() {
                  Provider.of<UserService>(context).avatar.hairColor = selected;
                });
              },
              callback: (selected) {
                setState(() {
                  Provider.of<UserService>(context).avatar.hair = selected;
                });
              },
            ),
            PropertyCarousel(
              caption: 'Clothing',
              current: bodyOptions[0],
              options: bodyOptions,
              callback: (selected) {
                setState(() {
                  Provider.of<UserService>(context).avatar.body = selected;
                });
              },
            ),
            PropertyCarousel(
              caption: 'Skin',
              current: skinOptions[1],
              options: skinOptions,
              callback: (selected) {
                setState(() {
                  Provider.of<UserService>(context).avatar.skin = selected;
                });
              },
            )
          ],
        ))
      ]),
    );
  }
}

class PropertyCarousel extends StatefulWidget {
  final String current;
  final List<String> options;
  final String caption;
  final Function(String) callback;
  final Function(Color) colorCallback;
  final bool hasColor;

  const PropertyCarousel(
      {Key key,
      this.current,
      this.options,
      this.caption,
      this.callback,
      this.colorCallback,
      this.hasColor = false})
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
        widget.hasColor
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text(widget.caption),
                    FlatButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text('Edit Color'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: Provider.of<UserService>(context)
                                    .avatar
                                    .hairColor,
                                onColorChanged: widget.colorCallback,
                                enableLabel: false,
                                enableAlpha: false,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ])
            : Text(widget.caption),
        Divider(),
        Container(
            height: 64,
            child: Center(
                child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: widget.options
                  .map((v) => FlatButton(
                        child: Material(
                          elevation: current == v ? 2.0 : 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Container(
                            height: 64,
                            child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.asset(
                                  v,
                                  color: widget.hasColor
                                      ? Provider.of<UserService>(context)
                                          .avatar
                                          .hairColor
                                      : null,
                                  colorBlendMode: widget.hasColor
                                      ? BlendMode.modulate
                                      : null,
                                )),
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
            )))
      ],
    );
  }
}
