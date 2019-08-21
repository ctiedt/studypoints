import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studypoints/avatar/data/repository.dart';
import 'package:studypoints/avatar/data/shop_item.dart';
import 'package:studypoints/avatar/widgets/avatar_view.dart';
import 'package:studypoints/services/user.dart';

import 'property_carousel.dart';

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
  ];
  final List<String> bodyOptions = [
    'assets/body1.png',
    'assets/body2.png',
    'assets/body3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
            child: AvatarView(
          avatar: Provider.of<UserService>(context).avatar,
          height: 300,
        )),
        PropertyCarousel<ShopItem>(
          caption: 'Faces',
          current: Provider.of<FaceRepository>(context).first,
          options: Provider.of<FaceRepository>(context).fetchAll(),
          builder: (face) => ShopItemView(
            face,
            parent: this,
          ),
          callback: (selected) {
            setState(() {
              if (Provider.of<UserService>(context).ownsItem(selected.id))
                Provider.of<UserService>(context).avatar.face =
                    selected.resource;
            });
          },
        ),
        PropertyCarousel<ShopItem>(
            caption: 'Hair Styles',
            current: Provider.of<HairRepository>(context).first,
            options: Provider.of<HairRepository>(context).fetchAll(),
            builder: (hair) => ShopItemView(
                  hair,
                  parent: this,
                ),
            callback: (selected) {
              setState(() {
                if (Provider.of<UserService>(context).ownsItem(selected.id))
                  Provider.of<UserService>(context).avatar.hair =
                      selected.resource;
              });
            }),
        PropertyCarousel<ShopItem>(
          caption: 'Clothing',
          current: Provider.of<BodyRepository>(context).first,
          options: Provider.of<BodyRepository>(context).fetchAll(),
          builder: (body) => ShopItemView(
            body,
            parent: this,
          ),
          callback: (selected) {
            setState(() {
              if (Provider.of<UserService>(context).ownsItem(selected.id))
                Provider.of<UserService>(context).avatar.body =
                    selected.resource;
            });
          },
        )
      ],
    );
  }
}

class ShopItemView extends StatelessWidget {
  final _AvatarScreenState parent;
  final ShopItem shopItem;

  const ShopItemView(
    this.shopItem, {
    Key key,
    this.parent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(shopItem.name),
          content: Column(
            children: <Widget>[
              Image.asset(shopItem.resource),
              Text('${shopItem.cost} HC'),
              RaisedButton(
                child: Text(
                    Provider.of<UserService>(context).ownsItem(shopItem.id)
                        ? 'You own this item'
                        : 'Buy'),
                onPressed: (Provider.of<UserService>(context).hcCount >=
                            shopItem.cost &&
                        !Provider.of<UserService>(context)
                            .ownsItem(shopItem.id))
                    ? () {
                        Provider.of<UserService>(context).hcCount -=
                            shopItem.cost;
                        Provider.of<UserService>(context)
                            .boughtItems
                            .add(shopItem.id);
                        parent.setState(() {
                          parent.widget.parent.setState(() {});
                        });
                      }
                    : null,
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(shopItem.thumbnail),
          if (!Provider.of<UserService>(context).ownsItem(shopItem.id))
            Icon(
              Icons.lock,
              size: 64,
              color: Colors.black45,
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  shopItem.name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Text(
                  '${shopItem.cost} HC',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 8)
              ],
            ),
          )
        ],
      ),
    );
  }
}
