import 'package:flutter/material.dart';
import 'package:shop_catalog/components/card_preview.dart';
import 'package:shop_catalog/main.dart';
import 'package:shop_catalog/models/cart_item.dart';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/item_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  createState() => CartState();
}

class CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    appData.cartState = this;
    if (cartItems.isEmpty) {
      cartItems.add(CartItem(
          1,
          ShopItem(
              1,
              "Боб",
              "Стрижка и укладка",
              666,
              "https://i.imgur.com/pLhAUHv.jpeg",
              "Боб — это классическая и универсальная стрижка, которая подходит для любого типа волос и формы лица. Она может быть выполнена различной длины и формы, от короткого, доходящего до подбородка боба до длинного, доходящего до плеч боба. Боб идеально подходит для тех, кто хочет добавить объем и текстуру своим волосам, а также скрыть недостатки лица и подчеркнуть скулы."),
          DateTime.now(),
          1));
    }
  }

  List<CartItem> cartItems = appData.cartItems;

  void forceUpdateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: cartItems.isEmpty
            ? Center(child: Text("Вы пока ничего не добавили в Корзину."))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 0),
                itemCount: cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    key: Key(index.toString()),
                    endActionPane: ActionPane(
                        motion: StretchMotion(),
                        extentRatio: 0.3,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Удалить запись'),
                                    content: Text(
                                        'Вы действительно хотите удалить "${cartItems[index].item.Name}"?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Отмена'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); 
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Удалить'),
                                        onPressed: () {
                                          setState(() {
                                            cartItems.removeAt(
                                                index); 
                                          });
                                          Navigator.of(context)
                                              .pop(); 
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            backgroundColor: Theme.of(context).canvasColor,
                            foregroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Удалить',
                          )
                        ]),
                    child: GestureDetector(
                      child: cart_item_preview(cartItem: cartItems[index]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ItemView(shopItem: cartItems[index].item)));
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class cart_item_preview extends StatefulWidget {
  cart_item_preview({super.key, required this.cartItem});
  CartItem cartItem;
  @override
  State<cart_item_preview> createState() => cart_item_previewState();
}

class cart_item_previewState extends State<cart_item_preview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(widget.cartItem.item.ImageHref,
                      width: MediaQuery.of(context).size.width * 0.45,
                      fit: BoxFit.cover)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${(widget.cartItem.item.PriceRubles * 1.5 / 100).round() * 100}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 18,
                                  decorationThickness: 2),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${widget.cartItem.item.PriceRubles.toString()} руб.",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                        Text(widget.cartItem.item.Name,
                            style: TextStyle(fontSize: 16)),
                        Text(
                            widget.cartItem.serviceTime
                                .toString()
                                .substring(0, 13),
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (widget.cartItem.count > 1) {
                              await appData.appDatabase!.update('cart_items',
                                  {'count': widget.cartItem.count - 1},
                                  where: 'id = ?',
                                  whereArgs: [widget.cartItem.id]);
                              setState(() {
                                widget.cartItem.count -= 1;
                              });
                            }
                          },
                          icon: Icon(Icons.remove),
                          iconSize: 30,
                        ),
                        Text(
                          "${widget.cartItem.count}",
                          style: TextStyle(fontSize: 24),
                        ),
                        IconButton(
                          onPressed: () async {
                            await appData.appDatabase!.update('cart_items',
                                {'count': widget.cartItem.count + 1},
                                where: 'id = ?',
                                whereArgs: [widget.cartItem.id]);
                            setState(() {
                              widget.cartItem.count += 1;
                            });
                          },
                          icon: Icon(Icons.add),
                          iconSize: 30,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
