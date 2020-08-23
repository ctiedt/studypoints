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
      resource: 'assets/face1.png',
      thumbnail: 'assets/face1.png',
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
      id: 'face7',
      type: 'face',
      name: 'Face 7',
      resource: 'assets/face7.png',
      thumbnail: 'assets/face7.png',
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
      id: 'hair5',
      type: 'hair',
      name: 'Hair 5',
      resource: 'assets/hair5.png',
      thumbnail: 'assets/hair5.png',
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
    ShopItem(
      id: 'body4',
      type: 'body',
      name: 'Outfit 4',
      resource: 'assets/body4.png',
      thumbnail: 'assets/body4.png',
      cost: 100,
    ),
    ShopItem(
      id: 'skin1',
      type: 'skin',
      name: 'Skin 1',
      resource: 'assets/skin1.png',
      thumbnail: 'assets/skin1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'skin2',
      type: 'skin',
      name: 'Skin 2',
      resource: 'assets/skin2.png',
      thumbnail: 'assets/skin2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'skin3',
      type: 'skin',
      name: 'Skin 3',
      resource: 'assets/skin3.png',
      thumbnail: 'assets/skin3.png',
      cost: 100,
    ),
    ShopItem(
      id: 'extra1',
      type: 'extra',
      name: 'Accessoir 1',
      resource: 'assets/extra1.png',
      thumbnail: 'assets/extra1.png',
      cost: 100,
    ),
    ShopItem(
      id: 'extra2',
      type: 'extra',
      name: 'Accessoir 2',
      resource: 'assets/extra2.png',
      thumbnail: 'assets/extra2.png',
      cost: 100,
    ),
    ShopItem(
      id: 'hairEffect1',
      type: 'hairEffect',
      name: 'Normal',
      resource: 'assets/white.png',
      thumbnail: 'assets/white.png',
      cost: 50,
    ),
    ShopItem(
      id: 'hairEffect2',
      type: 'hairEffect',
      name: 'Galaxy',
      resource: 'assets/galaxy.png',
      thumbnail: 'assets/galaxy.png',
      cost: 50,
    ),
    ShopItem(
      id: 'hairEffect3',
      type: 'hairEffect',
      name: 'Rainbow',
      resource: 'assets/rainbow1.png',
      thumbnail: 'assets/rainbow1.png',
      cost: 50,
    ),
    ShopItem(
      id: 'print0',
      type: 'print',
      name: 'None',
      resource: 'assets/none.png',
      thumbnail: 'assets/none.png',
      cost: 50,
    ),
    ShopItem(
      id: 'print1',
      type: 'print',
      name: 'Print 1',
      resource: 'assets/print1.png',
      thumbnail: 'assets/print1.png',
      cost: 50,
    ),
    ShopItem(
      id: 'print2',
      type: 'print',
      name: 'Print 2',
      resource: 'assets/print2.png',
      thumbnail: 'assets/print2.png',
      cost: 50,
    ),
    ShopItem(
      id: 'print3',
      type: 'print',
      name: 'Print 3',
      resource: 'assets/print3.png',
      thumbnail: 'assets/print3.png',
      cost: 50,
    ),
    ShopItem(
      id: 'print4',
      type: 'print',
      name: 'Print 4',
      resource: 'assets/print4.png',
      thumbnail: 'assets/print4.png',
      cost: 50,
    ),
  ];

  ShopItem fetch(String id) =>
      _items.firstWhere((h) => h.id == id, orElse: () => null);

  List<ShopItem> fetchAll() => _items;

  List<ShopItem> fetchType(String type) =>
      _items.where((i) => i.type == type).toList();

  ShopItem firstOfType(String type) => _items.firstWhere((i) => i.type == type);
}
