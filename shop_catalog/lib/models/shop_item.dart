import 'package:json_annotation/json_annotation.dart';

part 'shop_item.g.dart';

@JsonSerializable()
class ShopItem {
  ShopItem(this.Id, this.Name, this.Category, this.PriceRubles, this.ImageHref,
      this.Description);
  int Id;
  String Name;
  String Category;
  int PriceRubles;
  String ImageHref;
  String Description;
  bool isImageUrl = false;

  factory ShopItem.fromJson(Map<String, dynamic> json) =>
      _$ShopItemFromJson(json);
  Map<String, dynamic> toJson() => _$ShopItemToJson(this);
}
