import 'dart:io';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/avatar/data/avatar.dart';
import 'package:studypoints/avatar/data/repository.dart';
import 'package:studypoints/login/widgets/login_screen.dart';
import 'package:studypoints/services/user.dart';

import 'homescreen/homescreen.dart';

/// The heart of the operation.
/// Instead of conventional navigation,
/// the app uses the [BottomNavigationBar]
/// to set the [Scaffold]'s body.
/// All children have a parent attribute which accepts a [State]
/// in order to alert the root [Scaffold] if shared data has changed.

void main() {
  TargetPlatform targetPlatform;
  if (Platform.isLinux) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
  runApp(StudyPointsApp());
}

class StudyPointsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ShopItemRepository>(
          builder: (_) => ShopItemRepository(),
        ),
        ProxyProvider<ShopItemRepository, UserService>(
          builder: (_, items, __) => UserService(
              avatar: Avatar(
            body: items.firstOfType('body').resource,
            face: items.firstOfType('face').resource,
            hair: items.firstOfType('hair').resource,
          )),
        ),
      ],
      child: MaterialApp(
          title: 'StudyPoints',
          theme: ThemeData(
            primarySwatch: Colors.lime,
          ),
          home: HomeScreen()),
    );
  }
}
