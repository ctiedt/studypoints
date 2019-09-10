import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/services/user.dart';
import 'package:studypoints/avatar/data/avatar.dart';
import 'package:flutter/painting.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:studypoints/avatar/data/repository.dart';
import 'dart:io';

import 'dart:ui' as ui;
import 'dart:async';

class AvatarViewState extends State<AvatarView> {
  bool hasGlitterHair = false;

  ScreenshotController screenshotController = ScreenshotController();

  String getRessource(String id) =>
      Provider.of<ShopItemRepository>(context).fetch(id)?.resource;

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
                Image.asset(getRessource(avatar.skin)),
                Image.asset(getRessource(avatar.face)),
                Image.asset("assets/head1.png"),
                hasGlitterHair
                    ? ImageMerger(
                        image: 'assets/galaxy.png',
                        blendedWidget: Image.asset(
                          getRessource(avatar.hair),
                          color: Provider.of<UserService>(context)
                              .avatar
                              .hairColor,
                          colorBlendMode: BlendMode.modulate,
                        ),
                      )
                    : Image.asset(
                        getRessource(avatar.hair),
                        color:
                            Provider.of<UserService>(context).avatar.hairColor,
                        colorBlendMode: BlendMode.modulate,
                      ),
                Image.asset("assets/ears1.png"),
                Image.asset(getRessource(avatar.body)),
                ...Provider.of<UserService>(context)
                    .avatar
                    .accessoires
                    .map((extra) => Image.asset(getRessource(extra))),
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

class ImageMerger extends StatelessWidget {
  BlendMode blendMode = BlendMode.saturation;
  String image = 'assets/galaxy.png';
  Widget blendedWidget;

  ImageMerger(
      {this.image, this.blendedWidget, this.blendMode = BlendMode.modulate});

  Future<ui.Image> _getImage() {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    new AssetImage(image).resolve(new ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImage(),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasData) {
          return ShaderMask(
            blendMode: blendMode,
            child: Container(
                child:
                    blendedWidget //Text('DFG', style: TextStyle(fontSize: 100)),
                ),
            shaderCallback: (Rect bounds) {
              return ImageShader(snapshot.data, TileMode.clamp, TileMode.clamp,
                  Matrix4.identity().storage);
            },
          );
        } else {
          return new Text('Loading...');
        }
      },
    );
  }
}
