import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_catalog/components/card_preview.dart';
import 'package:shop_catalog/main.dart';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/add_item.dart';
import 'package:shop_catalog/pages/item_view.dart';


class Catalog extends StatefulWidget {
  const Catalog({super.key});
  @override
  createState() => CatalogState();
}

class CatalogState extends State<Catalog>
{
  List<ShopItem> shopItems = appData.shopItems;
  @override void initState() {
    super.initState();
  }

  void addItem(ShopItem item) {
    setState(() {
      shopItems.add(item);
      appData.appDatabase!.insert('shop_items', item.toMap());
    });
  }

  void removeItem(int index)
  {
    setState(() {
      int id = shopItems[index].Id;
      appData.appDatabase!.delete('shop_items', 
      where: 'id = ?',
      whereArgs: [id]);
      shopItems.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: GridView.builder(
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 21/20),
          padding: const EdgeInsets.symmetric(vertical: 0),
          itemCount: shopItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: CardPreview(shopItem: shopItems[index],),
              onTap: () {
                debugPrint('tapped ${shopItems[index].Name}');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemView(shopItem: shopItems[index]))
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Note',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddItem(catalogState: this,)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
