enum ShopItemType { Face, Hair, Body, Skin, Extra, HairEffect }

class ShopItem {
  final String id;
  final String name;
  final ShopItemType type;
  final String resource;
  final String thumbnail;
  final int cost;

  ShopItem({
    this.id,
    this.type,
    this.name,
    this.resource,
    this.thumbnail,
    this.cost,
  });
}
