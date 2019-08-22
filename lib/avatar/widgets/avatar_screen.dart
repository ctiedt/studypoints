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
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserService>(context);
    return ListView(
      children: <Widget>[
        Center(
            child: AvatarView(
          avatar: user.avatar,
          height: 300,
        )),
        PropertyCarousel<ShopItem>(
          caption: 'Faces',
          current: Provider.of<FaceRepository>(context).first,
          options: Provider.of<FaceRepository>(context).fetchAll(),
          selectable: (face) => user.ownsItem(face),
          builder: (face) => ShopItemView(
            face,
            parent: this,
          ),
          callback: (selected) {
            setState(() {
              if (user.ownsItem(selected)) user.avatar.face = selected.resource;
            });
          },
        ),
        PropertyCarousel<ShopItem>(
            caption: 'Hair Styles',
            current: Provider.of<HairRepository>(context).first,
            options: Provider.of<HairRepository>(context).fetchAll(),
            selectable: (hair) => user.ownsItem(hair),
            builder: (hair) => ShopItemView(
                  hair,
                  parent: this,
                ),
            callback: (selected) {
              setState(() {
                if (user.ownsItem(selected))
                  user.avatar.hair = selected.resource;
              });
            }),
        PropertyCarousel<ShopItem>(
          caption: 'Clothing',
          current: Provider.of<BodyRepository>(context).first,
          options: Provider.of<BodyRepository>(context).fetchAll(),
          selectable: (body) => user.ownsItem(body),
          builder: (body) => ShopItemView(
            body,
            parent: this,
          ),
          callback: (selected) {
            setState(() {
              if (user.ownsItem(selected)) user.avatar.body = selected.resource;
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
    var user = Provider.of<UserService>(context);
    return GestureDetector(
      onLongPress: () {
        if (!user.ownsItem(shopItem)) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(shopItem.name),
              content: Column(
                children: <Widget>[
                  Image.asset(shopItem.resource),
                  Text('${shopItem.cost} HC'),
                  RaisedButton(
                    child: Text(
                        user.ownsItem(shopItem) ? 'You own this item' : 'Buy'),
                    onPressed: (user.hcCount >= shopItem.cost &&
                            !user.ownsItem(shopItem))
                        ? () {
                            user.buy(shopItem);
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
          );
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            shopItem.thumbnail,
            color: (!user.ownsItem(shopItem)) ? Colors.grey : null,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: (user.ownsItem(shopItem))
                      ? Theme.of(context).backgroundColor
                      : Color(0xffe0e0e0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  )),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
            ),
          )
        ],
      ),
    );
  }
}
