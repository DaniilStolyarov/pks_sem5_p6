import 'package:flutter/material.dart';
import 'package:shop_catalog/components/card_preview.dart';
import 'package:shop_catalog/main.dart';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/item_view.dart';
import 'package:sqflite/sqflite.dart';


class Favourite extends StatefulWidget {
  const Favourite({super.key});
  @override
  createState() => FavouriteState();
}

class FavouriteState extends State<Favourite>
{
  @override
  void initState() {
    super.initState();
    appData.favouriteState = this;
  }

  List<ShopItem> favouriteItems = appData.favouriteItems;
  void forceUpdateState()
  {
    if (mounted)
    {
      setState(() {
        
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: 
        favouriteItems.isEmpty ? Center(child: Text("Вы пока ничего не добавили в Избранное.")) :
        GridView.builder(
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 21/20),
          padding: const EdgeInsets.symmetric(vertical: 0),
          itemCount: favouriteItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: CardPreview(shopItem: favouriteItems[index]),
              onTap: () {
                debugPrint('tapped ${favouriteItems[index].Name}');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemView(shopItem: favouriteItems[index]))
                );
              },
            );
          },
        ),
      ),
    );
  }
}
