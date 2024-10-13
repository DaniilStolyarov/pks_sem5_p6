import 'package:flutter/material.dart';
import 'package:shop_catalog/components/card_preview.dart';
import 'package:shop_catalog/main.dart';
import 'package:shop_catalog/models/cart_item.dart';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/item_view.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  createState() => CartState();
}

class CartState extends State<Cart>
{
  @override
  void initState() {
    super.initState();
    if (cartItems.isEmpty)
      cartItems.add(CartItem(ShopItem(1, "Боб", "Стрижка и укладка", 666, "static/Bob.jpg", "Боб — это классическая и универсальная стрижка, которая подходит для любого типа волос и формы лица. Она может быть выполнена различной длины и формы, от короткого, доходящего до подбородка боба до длинного, доходящего до плеч боба. Боб идеально подходит для тех, кто хочет добавить объем и текстуру своим волосам, а также скрыть недостатки лица и подчеркнуть скулы."), DateTime.now()));
  }

  List<CartItem> cartItems = appData.cartItems;
  void addItem(CartItem item) {
    setState(() {
      cartItems.add(item);
    });
  }
  void removeItem(int index)
  {
    setState(() {
      cartItems.removeAt(index);
    });
  }
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
        cartItems.isEmpty ? Center(child: Text("Вы пока ничего не добавили в Корзину.")) :
        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 0),
          itemCount: cartItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: cart_item_preview(cartItem: cartItems[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemView(shopItem: cartItems[index].item))
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class cart_item_preview extends StatefulWidget
{
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: widget.cartItem.item.isImageUrl
                    ? Image.network(widget.cartItem.item.ImageHref,
                        height: 150,
                        fit: BoxFit.cover)
                    : Image.asset(widget.cartItem.item.ImageHref,
                        height: 150,
                        fit: BoxFit.cover)),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.4,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.cartItem.item.Name, style: TextStyle(fontSize: 19)),
                Text(widget.cartItem.item.Category, style: TextStyle(fontSize: 15)),
                Text(widget.cartItem.serviceTime.toString().substring(0, 16), style: TextStyle(fontSize: 15)),
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.add))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}