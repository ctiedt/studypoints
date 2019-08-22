import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart' as collection;
import 'package:studypoints/avatar/data/repository.dart';
import 'package:studypoints/avatar/data/shop_item.dart';
import 'package:studypoints/avatar/widgets/avatar_view.dart';
import 'package:studypoints/avatar/widgets/property_carousel.dart';
import 'package:studypoints/services/user.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
        ...collection
            .groupBy(Provider.of<ShopItemRepository>(context).fetchAll(),
                (v) => v.type)
            .keys
            .map((type) => PropertyCarousel<ShopItem>(
                  caption: _typeToString(type),
                  current: Provider.of<ShopItemRepository>(context)
                      .firstOfType(type),
                  options:
                      Provider.of<ShopItemRepository>(context).fetchType(type),
                  selectable: (item) => user.ownsItem(item),
                  builder: (item) => ShopItemView(
                    item,
                    parent: this,
                  ),
                  callback: (selected) {
                    setState(() {
                      if (user.ownsItem(selected)) {
                        user.avatar[type] = selected.resource;
                      }
                    });
                  },
                )),
      ],
    );
  }

  String _typeToString(String type) {
    switch (type) {
      case 'body':
        return 'Clothing';
      case 'face':
        return 'Faces';
      case 'hair':
        return 'Hair Styles';
    }
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
                    child: Text('Buy'),
                    onPressed: user.canBuy(shopItem)
                        ? () {
                            user.buy(shopItem);
                            parent.setState(() {
                              parent.widget.parent.setState(() {});
                            });
                            Navigator.pop(context);
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
                    !user.ownsItem(shopItem) ? '${shopItem.cost} HC' : '',
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
