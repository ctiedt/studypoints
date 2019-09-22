import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';

class ImageMerger extends StatelessWidget {
  final BlendMode blendMode;
  String image = 'assets/galaxy.png';
  Widget blendedWidget;

  ImageMerger(
      {this.image, this.blendedWidget, this.blendMode = BlendMode.modulate});

  Future<ui.Image> _getImage() {
    Completer<ui.Image> completer = Completer<ui.Image>();
    AssetImage(image).resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _getImage(),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasData) {
          return ShaderMask(
            blendMode: blendMode,
            child: Container(child: blendedWidget),
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
