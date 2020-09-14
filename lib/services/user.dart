import 'package:flutter/material.dart';
import 'package:studypoints/avatar/data/avatar.dart';
import 'package:studypoints/avatar/data/repository.dart';
import 'package:studypoints/avatar/data/shop_item.dart';
import 'package:studypoints/tasks/data/task.dart';

class UserService {
  int hcCount = 0;
  Avatar avatar;
  List<Task> tasks = [];
  List<String> boughtItems = [
    ShopItemRepository().firstOfType(ShopItemType.Face).id,
    ShopItemRepository().firstOfType(ShopItemType.Hair).id,
    ShopItemRepository().firstOfType(ShopItemType.Body).id,
    ...ShopItemRepository().fetchType(ShopItemType.Skin).map((item) => item.id),
  ];

  UserService({Avatar avatar}) : this.avatar = avatar ?? Avatar();

  void clearTask(Task task, BuildContext context) {
    tasks.removeWhere((t) => t.id == task.id);
    var reward =
        task.subtasks.values.fold(10, (sum, val) => val ? sum + 10 : sum);
    hcCount += reward;
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('You earned $reward HC for completing a task!'),
    ));
  }

  bool ownsItem(ShopItem item) => boughtItems.contains(item.id);

  bool canBuy(ShopItem item) =>
      hcCount >= item.cost && !boughtItems.contains(item.id);

  void buy(ShopItem item) {
    if (canBuy(item)) {
      hcCount -= item.cost;
      boughtItems.add(item.id);
    }
  }
}
