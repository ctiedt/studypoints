import 'package:studypoints/avatar/data/shop_item.dart';

import 'shop_item.dart';

abstract class Repository<T> {
  T fetch(String id);

  List<T> fetchAll();
}

class ShopItemRepository extends Repository<ShopItem> {
  final List<ShopItem> _items = [
    ShopItem(
      id: 'face1',
      type: ShopItemType.Face,
      name: 'Face 1',
      resource: 'assets/face1.png',
      thumbnail: 'assets/face1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face2',
      type: ShopItemType.Face,
      name: 'Face 2',
      resource: 'assets/face2.png',
      thumbnail: 'assets/face2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face3',
      type: ShopItemType.Face,
      name: 'Face 3',
      resource: 'assets/face3.png',
      thumbnail: 'assets/face3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face4',
      type: ShopItemType.Face,
      name: 'Face 4',
      resource: 'assets/face4.png',
      thumbnail: 'assets/face4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face5',
      type: ShopItemType.Face,
      name: 'Face 5',
      resource: 'assets/face5.png',
      thumbnail: 'assets/face5.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face6',
      type: ShopItemType.Face,
      name: 'Face 6',
      resource: 'assets/face6.png',
      thumbnail: 'assets/face6.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face7',
      type: ShopItemType.Face,
      name: 'Face 7',
      resource: 'assets/face7.png',
      thumbnail: 'assets/face7.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair1',
      type: ShopItemType.Hair,
      name: 'Hair 1',
      resource: 'assets/hair1.png',
      thumbnail: 'assets/hair1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair2',
      type: ShopItemType.Hair,
      name: 'Hair 2',
      resource: 'assets/hair2.png',
      thumbnail: 'assets/hair2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair3',
      type: ShopItemType.Hair,
      name: 'Hair 3',
      resource: 'assets/hair3.png',
      thumbnail: 'assets/hair3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair4',
      type: ShopItemType.Hair,
      name: 'Hair 4',
      resource: 'assets/hair4.png',
      thumbnail: 'assets/hair4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair5',
      type: ShopItemType.Hair,
      name: 'Hair 5',
      resource: 'assets/hair5.png',
      thumbnail: 'assets/hair5.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body1',
      type: ShopItemType.Body,
      name: 'Outfit 1',
      resource: 'assets/body1.png',
      thumbnail: 'assets/body1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body2',
      type: ShopItemType.Body,
      name: 'Outfit 2',
      resource: 'assets/body2.png',
      thumbnail: 'assets/body2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body3',
      type: ShopItemType.Body,
      name: 'Outfit 3',
      resource: 'assets/body3.png',
      thumbnail: 'assets/body3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body4',
      type: ShopItemType.Body,
      name: 'Outfit 4',
      resource: 'assets/body4.png',
      thumbnail: 'assets/body4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'skin1',
      type: ShopItemType.Skin,
      name: 'Skin 1',
      resource: 'assets/skin1.png',
      thumbnail: 'assets/skin1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'skin2',
      type: ShopItemType.Skin,
      name: 'Skin 2',
      resource: 'assets/skin2.png',
      thumbnail: 'assets/skin2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'skin3',
      type: ShopItemType.Skin,
      name: 'Skin 3',
      resource: 'assets/skin3.png',
      thumbnail: 'assets/skin3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'extra1',
      type: ShopItemType.Extra,
      name: 'Accessoir 1',
      resource: 'assets/extra1.png',
      thumbnail: 'assets/extra1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'extra2',
      type: ShopItemType.Extra,
      name: 'Accessoir 2',
      resource: 'assets/extra2.png',
      thumbnail: 'assets/extra2.png',
      cost: 100,
    ),
  ];

  ShopItem fetch(String id) =>
      _items.firstWhere((h) => h.id == id, orElse: () => null);

  List<ShopItem> fetchAll() => _items;

  List<ShopItem> fetchType(ShopItemType type) =>
      _items.where((i) => i.type == type).toList();

  ShopItem firstOfType(ShopItemType type) =>
      _items.firstWhere((i) => i.type == type);
}
