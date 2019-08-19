import 'package:flutter/material.dart';
import 'package:studypoints/avatar/data/avatar.dart';

class AvatarView extends StatelessWidget {
  final Avatar avatar;
  final double width;
  final double height;

  const AvatarView({Key key, this.avatar, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Image.asset(avatar.body),
          Image.asset(avatar.face),
          Image.asset(avatar.hair),
        ],
      ),
    );
  }
}
