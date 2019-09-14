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
  _showColorDialog(BuildContext context) {
    var user = Provider.of<UserService>(context);
    var selectedColor = user.avatar.hairColor;
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (selected) {
              selectedColor = selected;
            },
            enableLabel: false,
            enableAlpha: false,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('Done'),
            onPressed: () {
              this.setState(() {
                user.avatar.hairColor = selectedColor;
              });
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserService>(context);
    var shopItemRepository = Provider.of<ShopItemRepository>(context);
    return Column(children: <Widget>[
      Stack(children: <Widget>[
        Center(
            child: AvatarView(
          avatar: user.avatar,
          height: 300,
        )),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              _showColorDialog(context);
            },
          ),
        )
      ]),
      Expanded(
          child: ListView(children: <Widget>[
        ...collection
            .groupBy(shopItemRepository.fetchAll(), (v) => v.type)
            .keys
            .map((type) => PropertyCarousel<ShopItem>(
                  isMultiSelect: type == 'extra',
                  caption: _typeToString(type),
                  currentList: type == 'extra'
                      ? List<ShopItem>.from(user.avatar[type].map(
                          (String extraId) =>
                              shopItemRepository.fetch(extraId)))
                      : <ShopItem>[
                          shopItemRepository.fetch(user.avatar[type]) ??
                              shopItemRepository.firstOfType(type)
                        ],
                  options: shopItemRepository.fetchType(type),
                  selectable: (item) => user.ownsItem(item),
                  builder: (item) => ShopItemView(
                    item,
                    parent: this,
                  ),
                  callbackSelected: (selected) {
                    setState(() {
                      if (user.ownsItem(selected)) {
                        if (type == 'extra')
                          user.avatar[type].add(selected.id);
                        else
                          user.avatar[type] = selected.id;
                      }
                    });
                  },
                  callbackUnselected: type == 'extra'
                      ? (unselected) {
                          setState(() {
                            if (user.ownsItem(unselected)) {
                              user.avatar[type].remove(unselected.id);
                            }
                          });
                        }
                      : null,
                  disabledCallback: (shopItem, Function purchaseCallback) {
                    if (!user.ownsItem(shopItem)) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(shopItem.name),
                          content: Column(
                            children: <Widget>[
                              Image.asset(
                                shopItem.resource,
                                color: type == 'hair'
                                    ? user.avatar.hairColor
                                    : null,
                                colorBlendMode:
                                    type == 'hair' ? BlendMode.modulate : null,
                              ),
                              Text('${shopItem.cost} HC'),
                              RaisedButton(
                                child: Text('Buy'),
                                onPressed: user.canBuy(shopItem)
                                    ? () {
                                        user.buy(shopItem);
                                        setState(() {
                                          if (type == 'extra')
                                            widget.parent.setState(() {
                                              user.avatar[type]
                                                  .add(shopItem.id);
                                            });
                                          else
                                            widget.parent.setState(() {
                                              user.avatar[type] = shopItem.id;
                                            });
                                        });
                                        purchaseCallback();
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
                ))
      ]))
    ]);
  }

  String _typeToString(String type) {
    switch (type) {
      case 'body':
        return 'Clothing';
      case 'face':
        return 'Faces';
      case 'hair':
        return 'Hair Styles';
      case 'skin':
        return 'Skin';
      case 'extra':
        return 'Accessoires';
    }
  }
}

class ShopItemView extends StatelessWidget {
  final _AvatarScreenState parent;
  final ShopItem shopItem;
  Color get color {
    var user = Provider.of<UserService>(parent.context);
    if (!user.ownsItem(shopItem)) return Colors.grey;
    if (shopItem.type == 'hair') return user.avatar.hairColor;
    return null;
  }

  const ShopItemView(
    this.shopItem, {
    Key key,
    this.parent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserService>(context);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          shopItem.thumbnail,
          color: color,
          colorBlendMode: user.ownsItem(shopItem) && shopItem.type == 'hair'
              ? BlendMode.modulate
              : null,
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
    );
  }
}
