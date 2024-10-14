import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:shop_catalog/pages/cart.dart';
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
  CartState? cartState;
 
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
  int indexOfCartItem(ShopItem itemToCheck)
  {
    for (int i = 0; i < cartItems.length; i++)
    {
      if (cartItems[i].item.Id== itemToCheck.Id)
      {
        return i;
      }
    }
    return -1;
  }
  Future<void> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    appDatabase = await openDatabase(

    join(await getDatabasesPath(), 'app_database.db'),
    onCreate: (db, version) async {

      await db.execute(
        'CREATE TABLE shop_items(id INTEGER PRIMARY KEY, name TEXT, category TEXT, price_rubles INTEGER, image_href TEXT, description TEXT)',
      );
      await db.execute(
        'CREATE TABLE favourite_items(id INTEGER PRIMARY KEY, name TEXT UNIQUE, category TEXT, price_rubles INTEGER, image_href TEXT, description TEXT)',
      );
      await db.execute(
        'CREATE TABLE cart_items(id INTEGER PRIMARY KEY, shop_item_id INTEGER, service_time TIMESTAMP, count INTEGER)'
      );
      await db.insert('shop_items', ShopItem(-1, "Боб", "Стрижка и укладка", 799, "https://i.imgur.com/pLhAUHv.jpeg", "Боб — это классическая и универсальная стрижка, которая подходит для любого типа волос и формы лица. Она может быть выполнена различной длины и формы, от короткого, доходящего до подбородка боба до длинного, доходящего до плеч боба. Боб идеально подходит для тех, кто хочет добавить объем и текстуру своим волосам, а также скрыть недостатки лица и подчеркнуть скулы.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Цезарь", "Стрижка и укладка", 699, "https://i.imgur.com/G8eOfAE.jpeg", "Цезарь — это короткая мужская стрижка с ровной челкой и короткими, одинаковой длины волосами по бокам и сзади. Она идеально подходит для мужчин с прямыми или волнистыми волосами и квадратной или круглой формой лица. Стрижка Цезарь — это стильный и универсальный вариант, который легко укладывать и поддерживать.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Гарсон", "Стрижка и укладка", 599, "https://i.imgur.com/Atfpw5S.jpeg", "Гарсон — это короткая, женственная стрижка, которая добавляет образу дерзости и стиля. Она характеризуется короткими, филированными волосами, часто с челкой или асимметрией. Гарсон идеально подходит для тех, кто хочет добавить объем и текстуру тонким волосам, а также скрыть недостатки лица и подчеркнуть скулы.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Полубокс", "Стрижка и укладка", 499, "https://i.imgur.com/rpKjovf.jpeg", "Полубокс — это короткая, практичная и универсальная мужская стрижка, которая подходит для любого типа волос и формы лица. Она характеризуется короткими волосами на висках и затылке, переходящими в более длинные волосы на макушке. Полубокс — это стильный и неприхотливый вариант, который легко укладывать и поддерживать.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Шапочка", "Стрижка и укладка", 599, "https://i.imgur.com/MiLOdAO.jpeg", "Шапочка — это женственная и элегантная стрижка, которая подходит для любого типа волос и формы лица. Она характеризуется короткими, округлыми волосами, которые плавно обрамляют лицо, создавая эффект шапочки. Шапочка — это универсальный вариант, который легко укладывать и поддерживать, придавая образу утонченность и шарм.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Маллет", "Стрижка и укладка", 699, "https://i.imgur.com/oAlIgc2.jpeg", "Маллет — это дерзкая и экстравагантная стрижка, которая характеризуется короткими волосами на макушке и длинными волосами на затылке. Маллет — это стильный и необычный вариант, который подходит для тех, кто хочет выделиться и подчеркнуть свой индивидуальный стиль. Она требует особого ухода и укладки, придавая образу неповторимость и притягательность.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Милитари", "Стрижка и укладка", 799, "https://i.imgur.com/RHjZ63I.jpeg", "Милитари — это мужественная и практичная стрижка, которая характеризуется короткими волосами по всей голове. Милитари — это универсальный и неприхотливый вариант, который подходит для любого типа волос и формы лица. Она не требует сложной укладки и идеально подходит для тех, кто ценит удобство и аккуратный внешний вид.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Пикси", "Стрижка и укладка", 999, "https://i.imgur.com/01Z9Sga.jpeg", "Пикси -  это дерзкая и стильная стрижка, которая характеризуется короткими волосами на висках и затылке, переходящими в более длинные волосы на макушке. Пикси — это женственный и многогранный вариант, который подходит для любого типа волос и формы лица. Она позволяет создавать различные укладки, от гладких и элегантных до текстурных и небрежных.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Короткое Каре", "Стрижка и укладка", 899, "https://i.imgur.com/HroeZo2.jpeg", "Короткое Каре — это элегантная и стильная стрижка, которая характеризуется прямыми волосами, подстриженными до уровня подбородка или чуть выше. Короткое каре — это универсальный и практичный вариант, который подходит для любого типа волос и формы лица. Оно легко укладывается и позволяет создавать различные образы, от классических и сдержанных до современных и авангардных.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Звезда", "Стрижка и укладка", 1199, "https://i.imgur.com/dOnl5Vz.jpeg", "Звезда — это смелая и дерзкая стрижка, которая характеризуется выбритыми висками и затылком в форме звезды. Звезда — это авангардный и экстравагантный вариант, который подходит для тех, кто не боится выделяться из толпы. Она требует особого ухода и укладки, но придает образу неповторимый и притягательный вид.").toMap());
      await db.insert('shop_items', ShopItem(-1, "Теннис", "Стрижка и укладка", 599, "https://i.imgur.com/1uNHwbK.jpeg", "Теннис — это спортивная и практичная стрижка, которая характеризуется короткими волосами по всей голове, подстриженными машинкой. Теннис — это универсальный и неприхотливый вариант, который подходит для любого типа волос и формы лица. Она не требует сложной укладки и идеально подходит для тех, кто ценит удобство и аккуратный внешний вид.").toMap());

    },
    version: 1
  );    
  
}
Future<void> fetchAllItems() async {
    final shopItemMap = await (appDatabase?.query('shop_items'));
    shopItems = shopItemMap!.map((map) => ShopItem.fromMap(map)).toList();

    final favouriteItemMap = await (appDatabase?.query('favourite_items'));
    favouriteItems = favouriteItemMap!.map((map) => ShopItem.fromMap(map)).toList();

    final cartItemMap = await (appDatabase?.query('cart_items'));
    cartItems = await Future.wait(cartItemMap!.map((map) async {
    return await CartItem.fromMap(map);
     }));
  }
}