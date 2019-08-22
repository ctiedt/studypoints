import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/avatar/data/avatar.dart';
import 'package:flutter/painting.dart';

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
          Image.asset(avatar.skin),
          Image.asset(avatar.body),
          Image.asset(avatar.face),
          Image.asset(
            avatar.hair,
            color: Provider.of<UserService>(context).avatar.hairColor,
            colorBlendMode: BlendMode.modulate,
          ),
        ],
      ),
    );
  }
}
