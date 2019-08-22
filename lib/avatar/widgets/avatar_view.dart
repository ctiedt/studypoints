import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/avatar/data/avatar.dart';
import 'package:flutter/painting.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';

class AvatarViewState extends State<AvatarView> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var avatar = widget.avatar;
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
        Screenshot(
            controller: screenshotController,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Image.asset(avatar.feet),
                Image.asset(avatar.skin),
                Image.asset(avatar.face),
                Image.asset("assets/head1.png"),
                Image.asset(
                  avatar.hair,
                  color: Provider.of<UserService>(context).avatar.hairColor,
                  colorBlendMode: BlendMode.modulate,
                ),
                Image.asset("assets/ears1.png"),
                Image.asset(avatar.body),
              ],
            )),
        Container(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              screenshotController
                  .capture(pixelRatio: 3)
                  .then((File image) async {
                await Share.file(
                    'image', 'name.png', image.readAsBytesSync(), 'image/png');
              }).catchError((onError) {
                print(onError);
              });
            },
          ),
        )
      ]),
    );
  }
}

class AvatarView extends StatefulWidget {
  final Avatar avatar;
  final double width;
  final double height;

  AvatarView({Key key, this.avatar, this.width, this.height}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AvatarViewState();
}
