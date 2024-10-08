import 'package:flutter/material.dart';
import 'package:shop_catalog/main.dart';
import 'package:shop_catalog/models/shop_item.dart';

class ItemView extends StatefulWidget {
  final ShopItem shopItem;
  const ItemView({super.key, required this.shopItem});
  @override
  createState() => ItemViewState();
}

class ItemViewState extends State<ItemView> {
  bool recorded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.shopItem.Name)),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.6, right: 16.0, bottom: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.shopItem.isImageUrl
                        ? Image.network(widget.shopItem.ImageHref,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover)
                        : Image.asset(widget.shopItem.ImageHref,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Описание",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.shopItem.Description,
                      style: TextStyle(fontSize: 22)),
                  SizedBox(
                    height: 220,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 60,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appData.indexOfFavouriteItem(widget.shopItem) == -1
                          ? Color.fromARGB(255, 83, 10, 69) : Color.fromARGB(255, 43, 4, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Установить радиус закругления
                      ),
                      padding: EdgeInsets.all(10.0)),
                  child: Text(
                      appData.indexOfFavouriteItem(widget.shopItem) == -1
                          ? "Добавить в Избранное"
                          : "В Избранном",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      int indexInFavourites = appData.indexOfFavouriteItem(widget.shopItem);
                      if (indexInFavourites == -1)
                      {
                        // добавить, если нет
                        appData.favouriteItems.add(widget.shopItem);
                      }
                      else
                      {
                        // удалить, если есть
                        appData.favouriteItems.removeAt(indexInFavourites);
                        appData.favouriteState?.forceUpdateState();
                      }
                    });
                  },
                ),
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: recorded
                          ? Color.fromARGB(255, 0, 64, 3)
                          : Color.fromARGB(255, 0, 25, 64),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Установить радиус закругления
                      ),
                      padding: EdgeInsets.all(10.0)),
                  child: Text(
                      recorded
                          ? "Записано - ${widget.shopItem.PriceRubles} руб."
                          : "Записаться - ${widget.shopItem.PriceRubles} руб.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      recorded = !recorded;
                    });
                  },
                ),
              ))
        ]));
  }
}
