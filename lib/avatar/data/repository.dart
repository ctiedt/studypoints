import 'package:studypoints/avatar/data/shop_item.dart';

abstract class Repository<T> {
  T fetch(String id);
  T get first;
  List<T> fetchAll();
}

class HairRepository extends Repository<ShopItem> {
  final List<ShopItem> _items = [
    ShopItem(
      id: 'hair1',
      name: 'Hair 1',
      resource: 'assets/hair1.png',
      thumbnail: 'assets/hair1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair2',
      name: 'Hair 2',
      resource: 'assets/hair2.png',
      thumbnail: 'assets/hair2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair3',
      name: 'Hair 3',
      resource: 'assets/hair3.png',
      thumbnail: 'assets/hair3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hair4',
      name: 'Hair 4',
      resource: 'assets/hair4.png',
      thumbnail: 'assets/hair4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hairX',
      name: 'Hair X',
      resource: 'assets/hairX.png',
      thumbnail: 'assets/hairX.png',
      cost: 100,
    )
  ];

  ShopItem get first => _items[0];

  ShopItem fetch(String id) => _items.firstWhere((h) => h.id == id);

  List<ShopItem> fetchAll() => _items;
}

class FaceRepository extends Repository<ShopItem> {
  final List<ShopItem> _items = [
    ShopItem(
      id: 'face1',
      name: 'Face 1',
      resource: 'assets/face.png',
      thumbnail: 'assets/face.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face2',
      name: 'Face 2',
      resource: 'assets/face2.png',
      thumbnail: 'assets/face2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face3',
      name: 'Face 3',
      resource: 'assets/face3.png',
      thumbnail: 'assets/face3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face4',
      name: 'Face 4',
      resource: 'assets/face4.png',
      thumbnail: 'assets/face4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face5',
      name: 'Face 5',
      resource: 'assets/face5.png',
      thumbnail: 'assets/face5.png',
      cost: 100,
    ),
    ShopItem(
      id: 'face6',
      name: 'Face 6',
      resource: 'assets/face6.png',
      thumbnail: 'assets/face6.png',
      cost: 100,
    ),
  ];

  ShopItem fetch(String id) => _items.firstWhere((h) => h.id == id);

  List<ShopItem> fetchAll() => _items;

  ShopItem get first => _items[0];
}

class BodyRepository extends Repository<ShopItem> {
  final List<ShopItem> _items = [
    ShopItem(
      id: 'body1',
      name: 'Outfit 1',
      resource: 'assets/body1.png',
      thumbnail: 'assets/body1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body',
      name: 'Outfit 2',
      resource: 'assets/body2.png',
      thumbnail: 'assets/body2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'body3',
      name: 'Outfit 3',
      resource: 'assets/body3.png',
      thumbnail: 'assets/body3.png',
      cost: 100,
    ),
  ];

  ShopItem fetch(String id) => _items.firstWhere((h) => h.id == id);

  List<ShopItem> fetchAll() => _items;

  ShopItem get first => _items[0];
}
