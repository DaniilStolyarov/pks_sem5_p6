import 'package:shop_catalog/models/shop_item.dart';

class CartItem {
  CartItem(this.item, this.serviceTime);
  ShopItem item;
  DateTime serviceTime;
}