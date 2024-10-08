import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/favourite.dart';

class GlobalData
{
  List<ShopItem> shopItems = [];
  List<ShopItem> favouriteItems = [];
  FavouriteState? favouriteState; 
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
}