import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/favourite.dart';
import 'cart_item.dart';

class GlobalData
{
  List<ShopItem> shopItems = [];
  List<ShopItem> favouriteItems = [];
  List<CartItem> cartItems = [];
  FavouriteState? favouriteState; 
  Database? appDatabase;
  int indexOfFavouriteItem(ShopItem itemToCheck)
  {
    for (int i = 0; i < favouriteItems.length; i++)
    {
      if (favouriteItems[i].Id == itemToCheck.Id)
      {
        return i;
      }
    }
    return -1;
  }

  void initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    appDatabase = await openDatabase(

    join(await getDatabasesPath(), 'app_database.db'),
    onCreate: (db, version) {

      db.execute(
        'CREATE TABLE shop_items(id INTEGER PRIMARY KEY, name TEXT, category TEXT, price_rubles INTEGER, image_href TEXT, description TEXT)',
      );
      db.execute(
        'CREATE TABLE favourite_items(id INTEGER PRIMARY KEY, name TEXT, category TEXT, price_rubles INTEGER, image_href TEXT, description TEXT)',
      );
      db.execute(
        'CREATE TABLE cart_items(id INTEGER PRIMARY KEY), shop_item_id INTEGER, service_time TIMESTAMP'
      );
      
    },
    version: 1
  );    
}}