import 'dart:ffi';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/main.dart';
class CartItem {
  CartItem(this.id, this.item, this.serviceTime, this.count);
  int id;
  ShopItem item;
  DateTime serviceTime;
  int count;

  Map<String, Object?> toMap() {
        return {
          'shop_item_id': item.Id,
          'service_time': serviceTime.toIso8601String(),
          'count': count
        };
      }
  static Future<CartItem> fromMap(Map<String, Object?> objectMap)
  async {
    int shop_item_id = objectMap['shop_item_id'] as int;
    final List<Map<String, dynamic>> result = await appData.appDatabase!.query(
    'shop_items',
    where: 'id = ?',
    whereArgs: [shop_item_id],
  );
    ShopItem shopItem = ShopItem.fromMap(result.first);
    return CartItem(objectMap['id'] as int, shopItem, DateTime.parse(objectMap['service_time'] as String), objectMap['count'] as int);
  }
}