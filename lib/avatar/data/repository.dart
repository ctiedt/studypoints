import 'package:studypoints/avatar/data/shop_item.dart';

abstract class Repository<T> {
  T fetch(String id);

  List<T> fetchAll();
}

class ShopItemRepository extends Repository<ShopItem> {
  final List<ShopItem> _items = [
    ShopItem(
      id: 'face1',
      type: 'face',
      name: 'Face 1',
      resource: 'assets/face.png',
      thumbnail: 'assets/face.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face2',
      type: 'face',
      name: 'Face 2',
      resource: 'assets/face2.png',
      thumbnail: 'assets/face2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face3',
      type: 'face',
      name: 'Face 3',
      resource: 'assets/face3.png',
      thumbnail: 'assets/face3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face4',
      type: 'face',
      name: 'Face 4',
      resource: 'assets/face4.png',
      thumbnail: 'assets/face4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face5',
      type: 'face',
      name: 'Face 5',
      resource: 'assets/face5.png',
      thumbnail: 'assets/face5.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face6',
      type: 'face',
      name: 'Face 6',
      resource: 'assets/face6.png',
      thumbnail: 'assets/face6.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair1',
      type: 'hair',
      name: 'Hair 1',
      resource: 'assets/hair1.png',
      thumbnail: 'assets/hair1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair2',
      type: 'hair',
      name: 'Hair 2',
      resource: 'assets/hair2.png',
      thumbnail: 'assets/hair2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair3',
      type: 'hair',
      name: 'Hair 3',
      resource: 'assets/hair3.png',
      thumbnail: 'assets/hair3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair4',
      type: 'hair',
      name: 'Hair 4',
      resource: 'assets/hair4.png',
      thumbnail: 'assets/hair4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hairX',
      type: 'hair',
      name: 'Hair X',
      resource: 'assets/hairX.png',
      thumbnail: 'assets/hairX.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body1',
      type: 'body',
      name: 'Outfit 1',
      resource: 'assets/body1.png',
      thumbnail: 'assets/body1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body2',
      type: 'body',
      name: 'Outfit 2',
      resource: 'assets/body2.png',
      thumbnail: 'assets/body2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body3',
      type: 'body',
      name: 'Outfit 3',
      resource: 'assets/body3.png',
      thumbnail: 'assets/body3.png',
      cost: 100,
    ),
  ];

  ShopItem fetch(String id) => _items.firstWhere((h) => h.id == id);

  List<ShopItem> fetchAll() => _items;

  List<ShopItem> fetchType(String type) =>
      _items.where((i) => i.type == type).toList();

  ShopItem firstOfType(String type) => _items.firstWhere((i) => i.type == type);
}
